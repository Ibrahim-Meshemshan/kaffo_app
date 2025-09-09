import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/app_colors/colors.dart';
import '../../../../../core/models/result.dart';
import '../../../../../core/utils/status.dart';
import '../../data/models/addresses/address_response.dart';
import '../../data/models/cities/cities_model.dart';
import '../../data/models/problems/add_problem_response.dart';
import '../../domain/entities/address/address_request.dart';
import '../../domain/entities/problem/add_problem_request.dart';
import '../cubit/problems_cubit.dart';
import 'full_map_screen.dart';
import 'map_sample.dart';

class AddProblemDialog extends StatefulWidget {
  const AddProblemDialog({super.key});

  @override
  State<AddProblemDialog> createState() => _AddProblemDialogState();
}

class _AddProblemDialogState extends State<AddProblemDialog> {
  final Completer<GoogleMapController> _mapController = Completer();
  final _formKey = GlobalKey<FormState>();

  String? _problemTitle;
  String? _problemDescription;
  String? _selectedCityId;
  String? _addressInput;
  LatLng? _selectedLocation;
  Set<Marker> _markers = {};
  List<File> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ProblemsCubit>().fetchCities();
      final controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          const CameraPosition(
            target: LatLng(36.2118575831676, 37.11135568662432),
            zoom: 14,
          ),
        ),
      );
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('الرجاء تفعيل خدمة الموقع')),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم رفض صلاحيات الموقع')),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('الصلاحيات مرفوضة بشكل دائم، يرجى تمكينها من إعدادات الجهاز')),
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
      });

      final mapController = await _mapController.future;
      await mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_selectedLocation!, 15),
      );

      setState(() {
        _markers = {
          Marker(
            markerId: const MarkerId('current_location'),
            position: _selectedLocation!,
            infoWindow: const InfoWindow(title: 'موقع المشكلة'),
          ),
        };
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في الحصول على الموقع: ${e.toString()}')),
      );
    }
  }

  Future<void> _submitProblem() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء تحديد الموقع على الخريطة')),
      );
      return;
    }

    final cubit = context.read<ProblemsCubit>();

    try {
      // 1. إنشاء العنوان أولًا
      final addressRequest = AddressRequest(
        description: _addressInput!,
        city: _selectedCityId,
        latitude: _selectedLocation!.latitude,
        longitude: _selectedLocation!.longitude,
      );

      final addressResult = await cubit.createAddress(addressRequest);

      if (addressResult is! ApiSuccessResult<AddressResponse>) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل في إنشاء العنوان')),
        );
        return;
      }

      // 2. إنشاء المشكلة بدون صور
      final problemRequest = AddProblemRequest(
        title: _problemTitle!,
        description: _problemDescription!,
        categoryId: 1,
        addressId: addressResult.data!.id,
        photoUrls: [],
      );

      final problemResult = await cubit.addProblem(problemRequest);

      if (problemResult is! ApiSuccessResult<AddProblemResponse>) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل في إنشاء المشكلة')),
        );
        return;
      }

      // 3. رفع الصور إن وجدت
      if (_selectedImages.isNotEmpty) {
        final presignedData = await cubit.getPresignedUrls(
          problemResult.data!.id!.toInt(),
          _selectedImages.length,
          'image/${_selectedImages[0].path.split('.').last}',
        );

        await Future.wait(
          _selectedImages.asMap().entries.map((entry) {
            final index = entry.key;
            final file = entry.value;
            return cubit.uploadFileToS3(presignedData[index].presignedUrl, file);
          }),
        );

        final photoUrls = presignedData.map((item) => item.s3Key).toList();

        // تحديث المشكلة بالصور
        await cubit.updateProblem(
          id: problemResult.data!.id!.toInt(),
          data: AddProblemRequest(
            title: _problemTitle!,
            description: _problemDescription!,
            categoryId: 1,
            addressId: addressResult.data!.id,
            photoUrls: photoUrls,
          ),
        );
      } else {
        // إعلام المستخدم بعدم وجود صور
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم إنشاء الشكوى ولكن لم يتم إرفاق صور')),
        );
      }

      // إعلام المستخدم بالنجاح
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إنشاء الشكوى بنجاح')),
      );

      Navigator.pop(context);
      cubit.fetchProblems();
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل في إنشاء المشكلة')),
      );
      print(err);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: Colors.grey),
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProblemsCubit>();
    final citiesState = cubit.state.citiesState;
    final citiesList = cubit.state.citiesList;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        insetPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          side: BorderSide.none,
        ),
        backgroundColor: AppColors.backgroundColor,
        title: const Text('إنشاء مشكلة جديدة', textAlign: TextAlign.right),
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProblemTitleField(),
                  const SizedBox(height: 16),
                  _buildProblemDescriptionField(),
                  const SizedBox(height: 16),
                  _buildCityDropdown(citiesState, citiesList),
                  const SizedBox(height: 16),
                  _buildAddressField(),
                  const SizedBox(height: 24),
                  _buildImageSection(),
                  const SizedBox(height: 24),
                  const Text('الموقع على الخريطة', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  _buildMapSection(),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'إلغاء',
              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 2,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                side: BorderSide.none,
              ),
              backgroundColor: Colors.black,
            ),
            onPressed: _submitProblem,
            child: const Text('رفع المشكلة', style: TextStyle(color: Colors.white, fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('صورة المشكلة', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        if (_selectedImages.isNotEmpty)
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedImages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: FileImage(_selectedImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              side: BorderSide.none,
            ),
            backgroundColor: Colors.black,
          ),
          onPressed: _pickImage,
          icon: const Icon(Icons.camera_alt, color: Colors.white),
          label: const Text(
            'التقاط صورة',
            style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Cairo'),
          ),
        )
      ],
    );
  }

  Widget _buildProblemTitleField() {
    return TextFormField(
      textAlign: TextAlign.right,
      decoration: _inputDecoration('المشكلة', 'وصف المشكلة'),
      validator: (value) => value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
      onChanged: (value) => _problemTitle = value,
    );
  }

  Widget _buildProblemDescriptionField() {
    return TextFormField(
      textAlign: TextAlign.right,
      maxLines: 3,
      decoration: _inputDecoration('المزيد من التفاصيل', 'تفاصيل المشكلة'),
      validator: (value) => value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
      onChanged: (value) => _problemDescription = value,
    );
  }

  Widget _buildCityDropdown(Status citiesState, List<CitiesModel>? citiesList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('المحافظة', style: TextStyle(fontSize: 12, fontFamily: 'Cairo')),
        const SizedBox(height: 4),
        if (citiesState == Status.loading)
          const CircularProgressIndicator(color: Colors.black)
        else if (citiesState == Status.error)
          const Text('حدث خطأ في جلب البيانات', style: TextStyle(color: Colors.red))
        else
          DropdownButtonFormField<String>(
            dropdownColor: Colors.white,
            decoration: const InputDecoration(
              hintText: 'اختر المحافظة',
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
            ),
            isExpanded: true,
            items: citiesList?.map((city) => DropdownMenuItem(
              value: city.value,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(city.arabic ?? ''),
              ),
            )).toList(),
            onChanged: (value) => _selectedCityId = value,
            validator: (value) => value == null ? 'هذا الحقل مطلوب' : null,
          ),
      ],
    );
  }

  Widget _buildAddressField() {
    return TextFormField(
      textAlign: TextAlign.right,
      decoration: _inputDecoration('عنوان المشكلة', 'ادخل العنوان التفصيلي'),
      validator: (value) => value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
      onChanged: (value) => _addressInput = value,
    );
  }

  Widget _buildMapSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const SizedBox(height: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 2,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                side: BorderSide.none,
              ),
              backgroundColor: Colors.black,
            ),
            onPressed: _getCurrentLocation,
            icon: const Icon(Icons.location_on, color: Colors.white),
            label: const Text(
              'استخدام موقعي الحالي',
              style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Cairo'),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: MapSample(
              controller: _mapController,
              initialPosition: const LatLng(36.2118575831676, 37.11135568662432),
              markers: _markers,
              onTap: (latLng) async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FullMapScreen(
                      initialPosition: latLng,
                    ),
                  ),
                );

                if (result != null && result is LatLng) {
                  setState(() {
                    _selectedLocation = result;
                    _markers = {
                      Marker(
                        markerId: const MarkerId('selected_location'),
                        position: result,
                        infoWindow: const InfoWindow(title: 'موقع المشكلة'),
                      ),
                    };
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
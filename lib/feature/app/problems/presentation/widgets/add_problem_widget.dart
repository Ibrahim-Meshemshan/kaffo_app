import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problem/add_problem_request.dart';
import 'package:kaffo/feature/app/problems/domain/entities/address/address_request.dart';
import 'package:kaffo/feature/app/problems/presentation/cubit/problems_cubit.dart';
import 'package:kaffo/core/app_colors/colors.dart';
import 'package:kaffo/core/app_theme/app_theme.dart';
import 'package:kaffo/core/utils/status.dart';

import '../../../../../core/models/result.dart';
import '../../data/models/addresses/address_response.dart';
import '../../data/models/cities/cities_model.dart';

final Completer<GoogleMapController> _mapController = Completer();

class AddProblemWidget extends StatelessWidget {
  const AddProblemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => _showAddProblemDialog(context),
          child: Container(
            alignment: Alignment.center,
            height: 35,
            width: 100,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              '+ مشكلة جديدة',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'ابحث عن مشكلة...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
            ),
          ),
        ),
      ],
    );
  }
}

void _showAddProblemDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: BlocProvider.of<ProblemsCubit>(context),
        child: const AddProblemDialog(),
      );
    },
  );
}

class AddProblemDialog extends StatefulWidget {
  const AddProblemDialog({super.key});

  @override
  State<AddProblemDialog> createState() => _AddProblemDialogState();
}

class _AddProblemDialogState extends State<AddProblemDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _problemTitle;
  String? _problemDescription;
  String? _selectedCityId;
  String? _addressInput;
  LatLng? _selectedLocation;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProblemsCubit>().fetchCities();
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      // 1. التحقق من صلاحيات الموقع
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('الرجاء تفعيل خدمة الموقع')),
        );
        return;
      }

      // 2. طلب الصلاحيات
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

      // 3. جلب الموقع الحالي
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
      });

      // 4. تحديث الخريطة
      final mapController = await _mapController.future;
      await mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_selectedLocation!, 15),
      );

      // إضافة علامة على الموقع المحدد
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

    // 1. Create Address
    final addressRequest = AddressRequest(
      description: _addressInput!,
      city: _selectedCityId,
      latitude: _selectedLocation!.latitude,
      longitude: _selectedLocation!.longitude,
    );

    final addressResult = await cubit.createAddressUseCase.call(addressRequest);

    if (addressResult is! Success<AddressResponse>) {
      print('Address creation result: $addressResult');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ في إنشاء العنوان')),
      );
      return;
    }

    // 2. Create Problem
    final problemRequest = AddProblemRequest(
      title: _problemTitle!,
      description: _problemDescription!,
      categoryId: 1, // Default valuepa
      addressId: addressResult.data!.id,
    );

    final problemResult = await cubit.addProblem(problemRequest, addressResult.data!);

    if (problemRequest == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إضافة المشكلة بنجاح')),
      );
      Navigator.pop(context);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ProblemsCubit>();
    final citiesState = cubit.state.citiesState;
    final citiesList = cubit.state.citiesList;

    return AlertDialog(
      title: const Text('إنشاء مشكلة جديدة', textAlign: TextAlign.right),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildProblemTitleField(),
                const SizedBox(height: 16),
                _buildProblemDescriptionField(),
                const SizedBox(height: 16),
                _buildCityDropdown(citiesState, citiesList),
                const SizedBox(height: 16),
                _buildAddressField(),
                const SizedBox(height: 24),
                _buildMapSection(),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: _submitProblem,
          child: const Text('رفع المشكلة'),
        ),
      ],
    );
  }

  Widget _buildProblemTitleField() {
    return TextFormField(
      textAlign: TextAlign.right,
      decoration: const InputDecoration(
        labelText: 'المشكلة',
        hintText: 'وصف المشكلة',
        border: OutlineInputBorder(),
      ),
      validator: (value) => value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
      onChanged: (value) => _problemTitle = value,
    );
  }

  Widget _buildProblemDescriptionField() {
    return TextFormField(
      textAlign: TextAlign.right,
      decoration: const InputDecoration(
        labelText: 'المزيد من التفاصيل',
        hintText: 'تفاصيل المشكلة',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      validator: (value) => value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
      onChanged: (value) => _problemDescription = value,
    );
  }

  Widget _buildCityDropdown(Status citiesState, List<CitiesModel>? citiesList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('المحافظة', style: TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        if (citiesState == Status.loading)
          const CircularProgressIndicator()
        else if (citiesState == Status.error)
          const Text('حدث خطأ في جلب البيانات', style: TextStyle(color: Colors.red))
        else
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              hintText: 'اختر المحافظة',
              border: OutlineInputBorder(),
            ),
            isExpanded: true,
            items: citiesList?.map((city) => DropdownMenuItem(
              value: city.value,
              child: Text(city.arabic ?? ''),
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
      decoration: const InputDecoration(
        labelText: 'عنوان المشكلة',
        hintText: 'ادخل العنوان التفصيلي',
        border: OutlineInputBorder(),
      ),
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
          const Text('الموقع على الخريطة', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: _getCurrentLocation,
            icon: const Icon(Icons.location_on),
            label: const Text('استخدام موقعي الحالي'),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(33.5130, 36.2919),
                zoom: 11.0,
              ),
              onMapCreated: (controller) => _mapController.complete(controller),
              onTap: (latLng) {
                setState(() {
                  _selectedLocation = latLng;
                  _markers = {
                    Marker(
                      markerId: const MarkerId('selected_location'),
                      position: latLng,
                      infoWindow: const InfoWindow(title: 'موقع المشكلة'),
                    ),
                  };
                });
              },
              markers: _markers,
            ),
          ),
        ],
      ),
    );
  }
}
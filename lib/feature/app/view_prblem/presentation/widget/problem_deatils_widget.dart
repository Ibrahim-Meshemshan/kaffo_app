import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/api_manager/api_constant.dart';
import '../../../../../core/utils/status.dart';
import '../../../problems/data/models/problems/problem_by_id_model.dart';
import '../../data/model/photo_response_model.dart';
import '../cubit/address/address_cubit.dart';
import '../cubit/category/category_cubit.dart';
import '../cubit/photo/photo_cubit.dart';

class ProblemDetailWidget extends StatefulWidget {
  final ProblemByIdModel problem;

  const ProblemDetailWidget({super.key, required this.problem});

  @override
  State<ProblemDetailWidget> createState() => _ProblemDetailWidgetState();
}

class _ProblemDetailWidgetState extends State<ProblemDetailWidget> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    if (widget.problem.id != null) {
      context.read<PhotoCubit>().getProblemPhotos(widget.problem.id!.toInt());
    }
    if (widget.problem.categoryId != null) {
      context.read<CategoryCubit>().getCategoryById(widget.problem.categoryId!.toInt());
    }
    if (widget.problem.addressId != null) {
      context.read<AddressCubit>().getAddressById(widget.problem.addressId!.toInt());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'تفاصيل المشكلة رقم ${widget.problem.id}',
          style:  TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصور بالسلايدر مع border أسود
            BlocBuilder<PhotoCubit, PhotoState>(
              builder: (context, photoState) {
                return _buildStateContent(
                  state: photoState.photoState,
                  error: photoState.photoError,
                  content: _buildCarousel(photoState.photos),
                );
              },
            ),

            const SizedBox(height: 16),

            // عنوان المشكلة بجانب النص
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 18, color: Colors.black),
                children: [
                  const TextSpan(
                      text: 'عنوان المشكلة: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: widget.problem.title ?? 'لا يوجد عنوان'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // وصف المشكلة
            Text(
              'وصف المشكلة: ${widget.problem.description ?? 'لا يوجد وصف'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),

            // التصنيف
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, categoryState) {
                return _buildStateContent(
                  state: categoryState.categoryState,
                  error: categoryState.categoryError,
                  content: Text(
                    'التصنيف: ${categoryState.category?.name ?? 'غير محدد'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            // العنوان
            BlocBuilder<AddressCubit, AddressState>(
              builder: (context, addressState) {
                if (widget.problem.addressId == null) {
                  return const Text('العنوان: لا يوجد عنوان محدد',
                      style: TextStyle(fontSize: 16));
                }

                return _buildStateContent(
                  state: addressState.addressState,
                  error: addressState.addressError,
                  content: addressState.address != null
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('المدينة: ${addressState.address!.city}',
                          style: const TextStyle(fontSize: 16)),
                      if (addressState.address!.description?.isNotEmpty ?? false)
                        Text('الوصف: ${addressState.address!.description}',
                            style: const TextStyle(fontSize: 16)),
                    ],
                  )
                      : const Text('العنوان: غير محدد', style: TextStyle(fontSize: 16)),
                );
              },
            ),
            const SizedBox(height: 12),

            // معلومات إضافية
            Text('رقم المشكلة: #${widget.problem.id}', style: const TextStyle(fontSize: 16)),
            if (widget.problem.categoryId != null)
              Text('رقم التصنيف: ${widget.problem.categoryId}', style: const TextStyle(fontSize: 16)),
            if (widget.problem.addressId != null)
              Text('رقم العنوان: ${widget.problem.addressId}', style: const TextStyle(fontSize: 16)),
            Text('تاريخ الإنشاء: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _showUploadDialog,
      //   tooltip: 'إضافة صور',
      //   child: const Icon(Icons.add_photo_alternate),
      // ),
    );
  }

  Widget _buildCarousel(List<PhotoResponseModel> photos) {
    if (photos.isEmpty) {
      return Container(
        height: 220,
        color: Colors.grey[200],
        child: const Center(
            child: Text('لا توجد صور متاحة', style: TextStyle(color: Colors.grey))),
      );
    }

    return CarouselSlider.builder(
      itemCount: photos.length,
      options: CarouselOptions(
        height: 250,
        enlargeCenterPage: true,
        autoPlay: true,
        viewportFraction: 0.9,
      ),
      itemBuilder: (context, index, realIndex) {

      final photo = photos[index];
        final imageUrl = '${ApiConstant.baseUrl}photos/https://kafu-bucket.s3.amazonaws.com/problems/2653/photo/4e3fe889-11aa-480d-9968-0e13f77614ca'; //
        return GestureDetector(
          onTap: () => _showPhotoDialog(photo),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStateContent({required Status state, required String? error, required Widget content}) {
    switch (state) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.error:
        return Text('خطأ: $error', style: const TextStyle(color: Colors.red));
      case Status.success:
        return content;
      default:
        return const SizedBox.shrink();
    }
  }

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('رفع الصور'),
        content: const Text('اختر الصور التي تريد رفعها'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          TextButton(
            onPressed: () {
              // TODO: upload logic
              Navigator.pop(context);
            },
            child: const Text('رفع'),
          ),
        ],
      ),
    );
  }

  void _showPhotoDialog(PhotoResponseModel photo) {
    // final imageUrl = '${ApiConstant.baseUrl}photos/problems/2653/photo/4e3fe889-11aa-480d-9968-0e13f77614ca';
    final imageUrl = 'https://kafu-bucket.s3.amazonaws.com/problems/2653/photo/4e3fe889-11aa-480d-9968-0e13f77614ca';
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.contain),
      ),
    );
  }
}

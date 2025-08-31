import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/app_consts/api_constant.dart';
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
    // Load photos
    if (widget.problem.id != null) {
      context.read<PhotoCubit>().getProblemPhotos(widget.problem.id!.toInt());
    }

    // Load category
    if (widget.problem.categoryId != null) {
      context.read<CategoryCubit>().getCategoryById(widget.problem.categoryId!.toInt());
    }

    // Load address
    if (widget.problem.addressId != null) {
      context.read<AddressCubit>().getAddressById(widget.problem.addressId!.toInt());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المشكلة'),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailCard(
              title: 'عنوان المشكلة',
              content: widget.problem.title ?? 'لا يوجد عنوان',
              icon: Icons.title,
            ),

            const SizedBox(height: 16),

            _buildDetailCard(
              title: 'وصف المشكلة',
              content: widget.problem.description ?? 'لا يوجد وصف',
              icon: Icons.description,
            ),

            const SizedBox(height: 16),

            _buildCategorySection(),

            const SizedBox(height: 16),

            _buildAddressSection(),

            const SizedBox(height: 16),

            _buildPhotosSection(),

            const SizedBox(height: 16),

            _buildAdditionalDetails(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUploadDialog(),
        tooltip: 'إضافة صور',
        child: const Icon(Icons.add_photo_alternate),
      ),
    );
  }

  Widget _buildDetailCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue[700], size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, categoryState) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.category, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'التصنيف',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildStateContent(
                  state: categoryState.categoryState,
                  error: categoryState.categoryError,
                  content: Text(categoryState.category?.name ?? 'غير محدد'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddressSection() {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, addressState) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'العنوان',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (widget.problem.addressId == null)
                  const Text(
                    'لا يوجد عنوان محدد',
                    style: TextStyle(color: Colors.grey),
                  )
                else
                  _buildStateContent(
                    state: addressState.addressState,
                    error: addressState.addressError,
                    content: addressState.address != null
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('المدينة: ${addressState.address!.city}'),
                        if (addressState.address!.description != null &&
                            addressState.address!.description!.isNotEmpty)
                          Text('الوصف: ${addressState.address!.description}'),
                      ],
                    )
                        : const Text('غير محدد'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhotosSection() {
    return BlocBuilder<PhotoCubit, PhotoState>(
      builder: (context, photoState) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.photo_library, color: Colors.orange, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'الصور',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildStateContent(
                  state: photoState.photoState,
                  error: photoState.photoError,
                  content: _buildPhotosGrid(photoState.photos),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhotosGrid(List<PhotoResponseModel> photos) {
    if (photos.isEmpty) {
      return const Center(
        child: Text(
          'لا توجد صور متاحة',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        final imageUrl = '${ApiConstant.baseUrl}photos/${photo.s3Key}';

        return GestureDetector(
          onTap: () => _showPhotoDialog(photo),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.photo, size: 30, color: Colors.grey),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 30, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAdditionalDetails() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info, color: Colors.purple, size: 20),
                SizedBox(width: 8),
                Text(
                  'معلومات إضافية',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRow('رقم المشكلة', '#${widget.problem.id}'),
            if (widget.problem.categoryId != null)
              _buildInfoRow('رقم التصنيف', widget.problem.categoryId.toString()),
            if (widget.problem.addressId != null)
              _buildInfoRow('رقم العنوان', widget.problem.addressId.toString()),
            _buildInfoRow(
              'تاريخ الإنشاء',
              DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateContent({
    required Status state,
    required String? error,
    required Widget content,
  }) {
    switch (state) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator());
      case Status.error:
        return Text(
          'خطأ: $error',
          style: const TextStyle(color: Colors.red),
        );
      case Status.success:
        return content;
      case Status.initial:
      default:
        return const Text('جاري التحميل...');
    }
  }

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('رفع الصور'),
        content: const Text('اختر الصور التي تريد رفعها'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement photo upload logic
              Navigator.pop(context);
            },
            child: const Text('رفع'),
          ),
        ],
      ),
    );
  }

  void _showPhotoDialog(PhotoResponseModel photo) {
    final imageUrl = 'https://kafu-bucket.s3.eu-north-1.amazonaws.com/problems/2662/photo/84c4315b-d848-48db-a478-b64615ab9cfb?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20250831T055242Z&X-Amz-SignedHeaders=host&X-Amz-Credential=AKIAQKGGXSKNCPSES4FD%2F20250831%2Feu-north-1%2Fs3%2Faws4_request&X-Amz-Expires=3600&X-Amz-Signature=c711b545f40d94b1e26a84d494e94875164bbdfafae8f159c5f083457d98e2e0';

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.black),
                  ),
                ],
              ),
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error, size: 50, color: Colors.red),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'تاريخ الرفع: ${DateFormat('yyyy-MM-dd').format(photo.photoDate)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<PhotoCubit>().deletePhoto(
                          widget.problem.id!.toInt(),
                          photo.id,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'حذف',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
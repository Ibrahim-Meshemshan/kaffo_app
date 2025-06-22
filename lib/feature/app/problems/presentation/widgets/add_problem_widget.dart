import 'package:flutter/material.dart';

import '../../../../../core/app_colors/colors.dart';
import '../../../../../core/app_theme/app_theme.dart';

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
        

        const SizedBox(width: 10), // مسافة بين العناصر

        // حقل البحث عن مشكلة
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
  // متغيرات لتخزين القيم
  String? problemTitle;
  String? problemDescription;
  String? selectedMinistry;
  int? addressId; // سيتم تعبئته لاحقًا
  int? categoryId; // سيتم تعبئته لاحقًا

  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('إنشاء مشكلة جديدة'),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'المشكلة *'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
                onChanged: (value) => problemTitle = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'التفاصيل *'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
                onChanged: (value) => problemDescription = value,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'الوزارة *'),
                items: ['وزارة النقل', 'وزارة الكهرباء', 'بلدية']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'الرجاء اختيار وزارة';
                  }
                  return null;
                },
                onChanged: (value) {
                  selectedMinistry = value;
                  // يمكنك هنا تعيين categoryId بناء على الاختيار
                  categoryId = _getCategoryId(value);
                },
              ),
              // يمكن إضافة المزيد من الحقول حسب الحاجة
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              // إنشاء كائن الطلب
              final request = AddProblemRequest(
                title: problemTitle,
                description: problemDescription,
                addressId: addressId ?? 0, // سيتم استبدال القيمة الفعلية
                categoryId: categoryId ?? 0, // سيتم استبدال القيمة الفعلية
              );

              // إغلاق النافذة وإرجاع الطلب
              Navigator.pop(context, request);
            }
          },
          child: const Text('رفع المشكلة'),
        ),
      ],
    ),
  ).then((request) {
    if (request != null) {
      // هنا يمكنك استدعاء API أو معالجة الطلب
      _submitProblem(request as AddProblemRequest);
    }
  });
}

// دالة مساعدة للحصول على categoryId
int _getCategoryId(String? ministry) {
  switch (ministry) {
    case 'وزارة النقل':
      return 1;
    case 'وزارة الكهرباء':
      return 2;
    case 'بلدية':
      return 3;
    default:
      return 0;
  }
}

// دالة لإرسال المشكلة
void _submitProblem(AddProblemRequest request) {
  // هنا يمكنك إضافة كود إرسال الطلب إلى الخادم
  print('تم إرسال المشكلة: ${request.title}');
}

class AddProblemRequest {
  final String? title;
  final String? description;
  final int? addressId;
  final int? categoryId;

  AddProblemRequest({
    required this.title,
    required this.description,
    required this.addressId,
    required this.categoryId,
  });
}
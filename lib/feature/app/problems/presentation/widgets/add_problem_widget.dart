import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaffo/feature/app/problems/presentation/cubit/problems_cubit.dart';
import 'package:kaffo/core/app_colors/colors.dart';
import 'package:kaffo/core/app_theme/app_theme.dart';
import '../../../../../core/utils/status.dart';
import '../../data/models/problems/problem_by_id_model.dart';
import 'add_problem_dialog.dart';


String formattedDate = '2025/07/16';

class AddProblemWidget extends StatefulWidget {
  const AddProblemWidget({super.key});

  @override
  State<AddProblemWidget> createState() => _AddProblemWidgetState();
}

class _AddProblemWidgetState extends State<AddProblemWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => _showAddProblemDialog(context),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 5),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  ' مشكلة جديدة',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontFamily: 'Cairo'
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'ابحث عن مشكلة بالعنوان (مثال: مشكلة الاختبار)...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                ),
                onSubmitted: (value) {
                  _searchProblemByTitle(context, value);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        BlocBuilder<ProblemsCubit, ProblemsState>(
          builder: (context, state) {
            if (state.problemByIdState == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.problemByIdState == Status.error) {
              return Center(child: Text('خطأ: ${state.problemByIdError ?? 'غير معروف'}'));
            } else if (state.problemByIdState == Status.success && state.problemByIdList != null) {
              final ProblemByIdModel problem = state.problemByIdList!;
              final user = state.usersMap[problem.submittedByUserId];
              final address = state.addressMap[problem.submittedByUserId];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        color: Colors.grey[300],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (user != null)
                            Row(
                              children: [
                                Text(
                                  '${user.firstName ?? 'مستخدم'} ${user.lastName ?? 'غير معروف'}',
                                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  formattedDate,
                                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            )
                          else
                            Text(
                              'مستخدم غير معروف',
                              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          const SizedBox(height: 5),
                          Text(
                            problem.title ?? 'لا يوجد عنوان',
                            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                              problem.description ?? 'لا يوجد وصف',
                              style: const TextStyle(fontSize: 16, color: Colors.black)
                          ),

                          const SizedBox(height: 10),

                          if (address != null)
                            Row(
                              children: [
                                Text(
                                  address.description ?? '',
                                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                                      color: Colors.black
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  alignment: Alignment.center,
                                  width: 80,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: AppColors.black,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(
                                      address.city ?? '',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                )
                              ],
                            )
                          else
                            const SizedBox(),

                          const SizedBox(height: 50),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('عرض التفاصيل للمشكلة: ${problem.title ?? ''}'),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text(
                                'المزيد من التفاصيل',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center();
          },
        ),
      ],
    );
  }

  void _searchProblemByTitle(BuildContext context, String query) {
    if (query.isNotEmpty) {

      int? problemIdToSearch;
      if (query.toLowerCase().contains('اختبار')) {
        problemIdToSearch = 51;
      } else if (query.toLowerCase().contains('صيانة')) {
        problemIdToSearch = 52;
      }


      if (problemIdToSearch != null) {

        context.read<ProblemsCubit>().fetchProblemById(problemIdToSearch);
        _searchController.clear();
      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('لم يتم العثور على مشكلة بهذا العنوان في البيانات التجريبية.'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء إدخال نص للبحث عن مشكلة.'),
        ),
      );
    }
  }
}

void _showAddProblemDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: BlocProvider.of<ProblemsCubit>(context),
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: const AddProblemDialog()),
      );
    },
  );
}
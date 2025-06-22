import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaffo/core/app_theme/app_theme.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problems_response_entity.dart';
import 'package:kaffo/feature/app/problems/presentation/cubit/problems_cubit.dart';
// لا نحتاج إلى intl هنا

import '../../../../../core/utils/status.dart';

class ProblemCardWidget extends StatefulWidget {
  final ProblemsContentEntity problem;

  const ProblemCardWidget({
    super.key,
    required this.problem,
  });

  @override
  State<ProblemCardWidget> createState() => _ProblemCardWidgetState();
}

class _ProblemCardWidgetState extends State<ProblemCardWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.problem.submittedByUserId != null) {
      context.read<ProblemsCubit>().fetchUser(widget.problem.submittedByUserId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = 'لا يوجد تاريخ';
    if (widget.problem.submissionDate != null) {
        final DateTime dateTime = DateTime.parse(widget.problem.submissionDate!);
        formattedDate = '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';

      }

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
                BlocBuilder<ProblemsCubit, ProblemsState>(
                  builder: (context, state) {
                    final user = state.usersMap[widget.problem.submittedByUserId];

                    if (user == null && widget.problem.submittedByUserId != null && state.userState == Status.loading) {
                      return const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2.0,),
                        ),
                      );
                    } else if (state.userState == Status.error && widget.problem.submittedByUserId != null) {
                      return Center(child: Text('خطأ: ${state.userError ?? 'غير معروف'}', style: TextStyle(color: Colors.red),));
                    } else if (user != null) {
                      return Row(
                        children: [
                          Text(
                            '${user.firstName ?? 'مستخدم'} ${user.lastName ?? 'غير معروف'}',
                            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            formattedDate,
                            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      );
                    }
                    return Text(
                      'مستخدم غير معروف',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 5),
                Text(
                  widget.problem.title ?? 'لا يوجد عنوان',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.problem.description ?? 'لا يوجد وصف',
                  style: TextStyle(fontSize: 16,color: Colors.black)
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'عرض التفاصيل للمشكلة: ${widget.problem.title ?? ''}'),
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
}
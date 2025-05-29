import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problems_response_entity.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class ProblemCardWidget extends StatelessWidget {
   ProblemCardWidget({super.key,required this.problem});
  ProblemsContentEntity problem;

  @override
  Widget build(BuildContext context) {
    return  Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                color:  Colors.grey[300],
              ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // اسم المبلغ وتاريخ البلاغ
                      Text(
                        //
                        '${problem.title} - ${DateFormat('yyyy/M/d').format(problem.submissionDate!)}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // عنوان المشكلة
                      Text(
                        problem.title ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // تفاصيل المشكلة (العنوان الثانوي)
                      Text(
                        problem.description ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Tags (دمشق، غير ذلك، شارع بغداد...)
                      // Wrap(
                      //   spacing: 8.0, // المسافة الأفقية بين الـ tags
                      //   runSpacing: 4.0, // المسافة العمودية بين صفوف الـ tags
                      //   children:
                      //   problem.status
                      //       .map(
                      //         (tag) => Chip(
                      //       label: Text(
                      //         tag,
                      //         style: const TextStyle(fontSize: 12),
                      //       ),
                      //       backgroundColor: Colors.grey[200],
                      //     ),
                      //   )
                      //       .toList() ?? '',
                      // ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // دائرة التقدم
                          CircularPercentIndicator(
                            radius: 30.0,
                            lineWidth: 5.0,
                            percent: 25,
                            // قيمة من 0.0 إلى 1.0
                            center: Text(
                              '${(problem.status! * 100)}%',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            progressColor: Colors.blue,
                            // يمكنك تغيير اللون
                            backgroundColor: Colors.grey[300]!,
                          ),
                          const SizedBox(width: 10),
                          // زر "المزيد من التفاصيل"
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: Implement navigation to problem details screen
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Viewing details for: ${problem.title}',
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black, // لون الزر
                                foregroundColor: Colors.white, // لون النص
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              child: const Text(
                                'المزيد من التفاصيل',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

  }


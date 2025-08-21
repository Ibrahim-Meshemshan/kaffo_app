import 'package:flutter/material.dart';
import 'package:kaffo/feature/app/home/presentation/widgets/card/stat_card.dart';

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 24.0),
      color: Colors.grey[100],
      child: Column(
        children: [
          Text(
            'إحصائيات حول التطبيق',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'بيانات توضح إنجازات التطبيق',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 40.0),
          Wrap(
            spacing: 24.0,
            runSpacing: 24.0,
            alignment: WrapAlignment.center,
            children: const [
              StatCard(value: '100+', description: 'الشكاوى التي يتم حلها يومياً'),
              StatCard(value: '200+', description: 'الأشخاص المتطوعين أسبوعياً'),
              StatCard(value: '200+', description: 'الشكاوى التي تم تقديمها من قبل المستخدمين'),
            ],
          ),
        ],
      ),
    );
  }
}

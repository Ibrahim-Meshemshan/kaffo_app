import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 24.0),
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Text(
              'حول التطبيق',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'هذا التطبيق  لتنظيم وإدارة الشكاوى للوزارات السورية يتم فيها تقديم الشكاوى من قبل المواطنين وعند ورود الشكوى للجهة المعنية تستطيع حلها و من الممكن ان تفوض الحل للتطوع او للتبرع لأجل الشكاوى بافضل واسرع وقت وجودة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.6,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

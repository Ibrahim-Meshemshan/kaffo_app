import 'package:flutter/material.dart';

import 'card/feature_card.dart';

class FeatureSection extends StatelessWidget {
  const FeatureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 24.0),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'اكتشف ميزات التطبيق',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'هذا التطبيق حيث تقوم بتقديم الشكاوى',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 40.0),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).size.width > 768 ? 3 : (MediaQuery.of(context).size.width > 480 ? 2 : 1),
            crossAxisSpacing: 24.0,
            mainAxisSpacing: 24.0,
            childAspectRatio: 1.2,
            children: const [
              FeatureCard(
                icon: Icons.people_alt_outlined,
                title: 'فريق متخصص للمتابعة',
                description: 'يتم تعيين فريق من خبراء للمساهمة في معالجة المشكلة وحلها',
              ),
              FeatureCard(
                icon: Icons.fast_forward_outlined,
                title: 'الرد بأسرع وقت',
                description: 'بعد ورود الشكوى للجهة المعنية سوف يتابع معك فريق من خبراء لمعالجة المشكلة',
              ),
              FeatureCard(
                icon: Icons.send_outlined,
                title: 'تقديم شكوى فوري',
                description: 'تستطيع تقديم الشكوى بأي وقت ويتم إحالتها للجهة المعنية فوراً',
              ),
              FeatureCard(
                icon: Icons.inbox_outlined,
                title: 'استقبال كافة أنواع الشكاوى',
                description: 'هذه التطبيق مصمم لاستقبال كافة أنواع الشكاوى اليومية في كافة البلاد',
              ),
              FeatureCard(
                icon: Icons.attach_money_outlined,
                title: 'فتح باب التبرعات',
                description: 'تستطيع المساهمة في حل الشكاوى من خلال التبرع لأجل الشكاوى',
              ),
              FeatureCard(
                icon: Icons.volunteer_activism_outlined,
                title: 'فتح باب التطوع للمواطنين',
                description: 'أي شخص يستطيع المساهمة في التطوع لمعالجة شكاوى المواطنين',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kaffo/feature/app/home/presentation/widgets/card/step_card.dart';

class HowToSubmitProblemSection extends StatelessWidget {
  const HowToSubmitProblemSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 24.0),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'كيفية تقديم الشكوى عبر التطبيق؟',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'فيما يلي خطوات تقديم الشكوى',
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
              StepCard(
                icon: Icons.login_outlined,
                title: 'قم بتسجيل الدخول',
                description: 'أولاً، قم بتسجيل الدخول إلى حسابك',
              ),
              StepCard(
                icon: Icons.report_problem_outlined,
                title: 'أرفع المشكلة',
                description: 'ثانياً، قم بتقديم تفاصيل المشكلة',
              ),
              StepCard(
                icon: Icons.hourglass_empty_outlined,
                title: 'انتظر الرد',
                description: 'أخيراً، انتظر حتى يتم حل المشكلة',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

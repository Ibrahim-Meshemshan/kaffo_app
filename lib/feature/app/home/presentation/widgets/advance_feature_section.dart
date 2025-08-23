import 'package:flutter/material.dart';

class AdvanceFeatureSection extends StatelessWidget {
  const AdvanceFeatureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 24.0),
      color: Colors.grey[100],
      child: Column(
        children: [
          Text(
            'الميزات المتقدمة الخاصة بالتطبيق',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            'اكتشف أهم الميزات التي تجعل التطبيق مميز وسهل للاستخدام',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 40.0),
          // Image of a dashboard or data analytics
          Image.asset(
            'assets/images/advance_feature.png', // Replace with a real image URL of a dashboard/analytics
            height: 75,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                'https://placehold.co/800x400/E5E7EB/000000?text=Advanced+Features+Mockup', // Fallback image
                height: 400,
                fit: BoxFit.contain,
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kaffo/core/routes_manager/routes_names.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
     return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 24.0),
      color: Colors.grey[100],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'تطبيق تنظيم وإدارة الشكاوى\nللوزارات السورية',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'قم بتقديم الشكوى الخاصة بك بكل أمان وسهولة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton.icon(
              onPressed: () {
                // Handle download app
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 4,
              ),
              icon: const Icon(Icons.download),
              label: InkWell(
                onTap: () => Navigator.pushNamed(context, RoutesNames.problems),
                child: const Text(
                  'فتح التطبيق',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            // Image of multiple phones displaying app interfaces
            Image.asset(
              'assets/images/login.png', // Replace with a real image URL of phone mockups
              height: 200,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://placehold.co/600x200/F3F4F6/000000?text=Phone+Mockups', // Fallback image
                  height: 200,
                  fit: BoxFit.contain,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

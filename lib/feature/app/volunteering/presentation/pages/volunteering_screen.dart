import 'package:flutter/material.dart';
import 'package:kaffo/core/routes_manager/routes_names.dart';
// Assuming MainScaffold is a custom widget you have
// import '../../../../../core/widgets/main_scaffold.dart';

class VolunteeringScreen extends StatelessWidget {
  const VolunteeringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end, // Align title to the right for RTL
          children: [
            Text(
              'التطوع (100)',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.people_alt_outlined,
              color: Colors.grey[700],
              size: 24,
            ),
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl, // For Arabic text
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16.0),
              Text(
                'قم بإختيار حالة التطوع التي ترغب بالتطوع من خلالها:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 40.0),
              // Donation Card
              _buildVolunteeringOptionCard(
                context: context,
                icon: Icons.attach_money_outlined,
                title: 'التبرع لحل المشكلة',
                description: 'في هذه الحالة تستطيع التبرع بمبلغ مالي للمساعدة في حل المشكلة.',
                onTap: () {
                  // todo: Navigator to  donation tap
                  Navigator.pushNamed(context, RoutesNames.problems);
                },
              ),
              const SizedBox(height: 24.0),
              // Contribution Card
              _buildVolunteeringOptionCard(
                context: context,
                icon: Icons.chat_bubble_outline,
                title: 'المساهمة في حل المشكلة',
                description: 'هنا تستطيع تقديم اقتراح للمساهمة في حل المشكلة.',
                onTap: () {
                  Navigator.pushNamed(context, RoutesNames.problems);
                },
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVolunteeringOptionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // Take full width
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.black, // Dark background as per image
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 48,
              color: Colors.white, // White icon on dark background
            ),
            const SizedBox(height: 16.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[400], // Lighter text for description
              ),
            ),
          ],
        ),
      ),
    );
  }
}

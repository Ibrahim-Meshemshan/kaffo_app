import 'package:flutter/material.dart';
import 'package:kaffo/feature/app/home/presentation/widgets/about_section.dart';
import 'package:kaffo/feature/app/home/presentation/widgets/feature_section.dart';
import 'package:kaffo/feature/app/home/presentation/widgets/how_to_submit_problem_section.dart';
import 'package:kaffo/feature/app/home/presentation/widgets/statistics_section.dart';
import 'package:kaffo/feature/app/home/presentation/widgets/top_section.dart';

import '../widgets/advance_feature_section.dart';


class HomeBodyScreen extends StatelessWidget {
  const HomeBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Directionality(
        textDirection: TextDirection.rtl, // For Arabic text
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Section
              TopSection(),
              // About Section
              AboutSection(),
              // Statistics Section
              StatisticsSection(),
              // Features Section
              FeatureSection(),
              // Advanced Features Section
              AdvanceFeatureSection(),
              // How to Submit Complaint Section
              HowToSubmitProblemSection()
            ],
          ),
        ),
      ),
    );
  }


}
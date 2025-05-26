import 'package:flutter/material.dart';
import 'package:kaffo/core/app_colors/colors.dart';
import 'drawer_screen.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final String? title;

  const MainScaffold({super.key, required this.body, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(title ?? 'كفو'),
      ),
      drawer: const DrawerScreen(),
      body: body,
    );
  }
}

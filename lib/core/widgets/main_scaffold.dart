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
        backgroundColor: AppColors.appBarColor.withOpacity(0.3),
        title: Text(title ?? 'كفو',style: TextStyle(fontFamily: 'Cairo',color: Colors.black),),
      ),
      drawer: const DrawerScreen(),
      body: body,
    );
  }
}

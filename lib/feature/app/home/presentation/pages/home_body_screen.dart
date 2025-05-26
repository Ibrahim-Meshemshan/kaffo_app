import 'package:flutter/material.dart';
import 'package:kaffo/core/widgets/custom_app_bar.dart';

import '../../../../../core/widgets/drawer_screen.dart';

class HomeBodyScreen extends StatelessWidget {
  const HomeBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      drawer: DrawerScreen(),
      body: Column(
        children: [],
      ),
    );
  }
}

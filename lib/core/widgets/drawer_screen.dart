import 'package:flutter/material.dart';
import 'package:kaffo/core/app_theme/app_theme.dart';
import 'package:kaffo/core/routes_manager/routes_names.dart';

import '../../gen/assets.gen.dart';
import '../app_colors/colors.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppColors.appBarColor),
            accountName: Text(
              'إبراهيم مشمشان',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: AppColors.primaryTextColor,
                fontSize: 18,
              ),
            ),
            accountEmail: Text(
              'ibrahimeshmeshan@gmail.com',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: AppColors.primaryTextColor,
                fontSize: 15,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(Assets.images.ibrahim.path),
              backgroundColor: Colors.white,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('الرئيسية'),
            onTap: () {
              Navigator.pushNamed(context, RoutesNames.homeBody);
            },
          ),
          ListTile(
            leading: const Icon(Icons.report_problem),
            title: const Text('المشكلات'),
            onTap: () {
              Navigator.pushNamed(context, RoutesNames.problems);
            },
          ),
          ListTile(
            leading: const Icon(Icons.volunteer_activism),
            title: const Text('التطوع'),
            onTap: () {
              Navigator.pushNamed(context, RoutesNames.volunteer);
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('الاحصائيات'),
            onTap: () {
              Navigator.pushNamed(context, RoutesNames.statistics);
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.group),
            title: const Text('مشاركاتي'),
            children: [
              ListTile(
                leading: const Icon(Icons.report),
                title: const Text('الشكاوي'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesNames.myComplaints);
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('التطوع'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesNames.myVolunteering);
                },
              ),
              ListTile(
                leading: const Icon(Icons.handshake),
                title: const Text('المساهمات'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesNames.myContributions);
                },
              ),
              ListTile(
                leading: const Icon(Icons.card_giftcard),
                title: const Text('التبرعات'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesNames.myDonations);
                },
              ),
            ],
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('تسجيل الخروج'),
            onTap: () {
              Navigator.pushNamed(context, RoutesNames.logout);
            },
          ),
        ],
      ),
    );
  }
}

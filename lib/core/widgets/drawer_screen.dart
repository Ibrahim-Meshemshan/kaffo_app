import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';  // مكتبة FontAwesome
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
                color: AppColors.black,
                fontSize: 18,
              ),
            ),
            accountEmail: Text(
              'ibrahimeshmeshan@gmail.com',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: AppColors.black,
                fontSize: 15,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(Assets.images.ibrahim.path),
              backgroundColor: Colors.white,
            ),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.house, size: 20),
            title: const Text('الرئيسية'),
            onTap: () {
              Navigator.pushNamed(context, RoutesNames.homeBody);
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.triangleExclamation, size: 20),
            title: const Text('المشكلات'),
            onTap: () {
              Navigator.pushNamed(context, RoutesNames.problems);
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.handHoldingHeart, size: 20),
            title: const Text('التطوع'),
            onTap: () {
              Navigator.pushNamed(context, RoutesNames.volunteer);
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.chartBar, size: 20),
            title: const Text('الاحصائيات'),
            onTap: () {
              Navigator.pushNamed(context, RoutesNames.statistics);
            },
          ),
          ExpansionTile(
            leading: const FaIcon(FontAwesomeIcons.peopleGroup, size: 20),
            title: const Text('مشاركاتي'),
            children: [
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.fileCircleExclamation, size: 20),
                title: const Text('الشكاوي'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesNames.myComplaints);
                },
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.handsHelping, size: 20),
                title: const Text('التطوع'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesNames.myVolunteering);
                },
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.handshake, size: 20),
                title: const Text('المساهمات'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesNames.myContributions);
                },
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.gift, size: 20),
                title: const Text('التبرعات'),
                onTap: () {
                  Navigator.pushNamed(context, RoutesNames.myDonations);
                },
              ),
            ],
          ),
          const Divider(),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.signOutAlt, size: 20),
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

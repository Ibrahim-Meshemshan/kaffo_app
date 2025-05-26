import 'package:flutter/material.dart';
import 'package:kaffo/core/app_colors/colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarColor,
      title: const Text('كفو'),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {

            // Navigator.pushNamed(context, RoutesNames.notifications);
          },
        ),
      ],
    );
  }
}

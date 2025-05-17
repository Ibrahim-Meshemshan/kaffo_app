import 'package:flutter/material.dart';

import '../app_colors/colors.dart';

class DialogUtils {
  static void showLoading(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Row(
            children: [
              const CircularProgressIndicator(color: AppColors.primaryColor),
              SizedBox(width: 18),
              Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  static void showSnackBar(
    BuildContext context,
    String message, {
    bool isError = true,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showMessage(
    BuildContext context,
    String message, {
    // String title = 'Notification',
    required Icon? Icon(icon),
    String? posActionName = 'OK',
    VoidCallback? posAction,
    bool isError = true,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          icon: Container(
            alignment: Alignment.center,
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor,
            ),
            child: Icon(Icons.check),
          ),
          iconColor: AppColors.primaryColor,
          content: Text(
            message,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (posAction != null) posAction();
              },
              child: Text(
                posActionName ?? 'OK',
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showSuccess(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: AppColors.primaryColor, size: 50),
              SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error, color: AppColors.primaryColor, size: 50),
              SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }
}

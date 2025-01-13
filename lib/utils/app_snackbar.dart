import 'package:flutter/material.dart';

import 'colors.dart';

$showSnackBar({
  required BuildContext context,
  required String message,
  IconData icon = Icons.close_rounded,
  // required Color backColor,
  Color contentTextColor = AppColors.white,
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.showSnackBar(customSnackbar(message, icon, contentTextColor));
}

SnackBar customSnackbar(String content, IconData icon, Color contentTextColor) {
  return SnackBar(
    elevation: 0,
    content: Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.white,
          child: Icon(
            icon,
            // color: const Color(0xff4B5563),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            content,
          ),
        ),
      ],
    ),
    // backgroundColor: backColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  );
}

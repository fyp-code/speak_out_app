import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.backgroundColor,
    this.loadingColor,
    this.textColor,
    this.buttonSize,
  });

  final VoidCallback onPressed;
  final String text;

  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? loadingColor;
  final Size? buttonSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.themeColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        minimumSize: buttonSize ?? const Size(double.infinity, 45),
        elevation: 0.0,
        overlayColor: Colors.transparent,
      ),
      onPressed: isLoading ? () {} : onPressed,
      child: isLoading
          ? Center(
              child: SizedBox(
              height: 23,
              width: 23,
              child: CircularProgressIndicator(
                color: loadingColor ?? Colors.white,
                strokeWidth: 2,
              ),
            ))
          : Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: textColor ?? AppColors.black,
                ),
              ),
            ),
    );
  }
}

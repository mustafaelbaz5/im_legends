import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';
import '../themes/app_texts_style.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.buttonText,
    this.textStyle,
    required this.onPressed,
    this.borderRadius,
    this.backgroundColor,
    this.buttonWidth,
    this.buttonHeight,
    this.verticalPadding,
    this.horizontalPadding,
    this.isLoading = false,
    this.icon,
  });
  final String buttonText;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final Color? backgroundColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? verticalPadding;
  final double? horizontalPadding;
  final bool isLoading;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(
          backgroundColor ?? AppColors.darkRedColor,
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            vertical: verticalPadding?.h ?? 12.h,
            horizontal: horizontalPadding?.w ?? 14.w,
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          Size(buttonWidth ?? double.maxFinite, buttonHeight?.h ?? 50.h),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 52)),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              width: 24.w,
              height: 24.h,
              child: const CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(buttonText, style: textStyle ?? RobotoTextStyles.whiteBold20),
    );
  }
}

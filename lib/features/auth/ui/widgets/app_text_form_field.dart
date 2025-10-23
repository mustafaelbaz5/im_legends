import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.hintText,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.isObscureText,
    this.suffixIcon,
    this.innerBackgroundColor,
    this.controller,
    required this.validator,
    required this.keyboardType,
  });
  final String hintText;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final TextInputType keyboardType;

  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? innerBackgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.greyColor,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(95, 185, 185, 185),
                width: 1.4,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.4),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.4),
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintText: hintText,
        hintStyle: hintStyle ?? TextStyle(fontSize: 14.sp, color: Colors.grey),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: innerBackgroundColor ?? Colors.transparent,
      ),

      obscureText: isObscureText ?? false,
      style:
          inputTextStyle ??
          TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontFamily: 'RobotoCondensed',
          ),
      validator: (value) {
        return validator(value);
      },
    );
  }
}

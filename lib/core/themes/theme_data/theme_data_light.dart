import 'package:flutter/material.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';

import '../../utils/extensions/context_extensions.dart';
import '../app_colors.dart';

ThemeData getLightTheme({required final BuildContext context}) {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.grey0,
    brightness: Brightness.light,
    colorScheme: _buildColorScheme(),
    textTheme: _buildTextTheme(context),
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    inputDecorationTheme: _buildInputDecorationTheme(),
  );
}

ColorScheme _buildColorScheme() {
  return const ColorScheme.light(
    primary: AppColors.primary300,
    secondary: AppColors.primary200,
    surface: AppColors.grey0,
    error: AppColors.red100,
  );
}

TextTheme _buildTextTheme(final BuildContext context) {
  return ThemeData.light().textTheme.apply(
    bodyColor: AppColors.grey900,
    displayColor: AppColors.grey900,
    fontFamily: context.currentFont,
  );
}

ElevatedButtonThemeData _buildElevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary300,
      foregroundColor: AppColors.grey0,
      disabledBackgroundColor: AppColors.grey200,
      disabledForegroundColor: AppColors.grey500,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: AppTextStyles.font16SemiBold,
    ),
  );
}

InputDecorationTheme _buildInputDecorationTheme() {
  return InputDecorationTheme(
    border: _buildOutlineBorder(AppColors.grey200),
    enabledBorder: _buildOutlineBorder(AppColors.grey200),
    focusedBorder: _buildOutlineBorder(AppColors.primary300),
    errorBorder: _buildOutlineBorder(AppColors.red100),
    focusedErrorBorder: _buildOutlineBorder(AppColors.red100),
    fillColor: AppColors.grey0,
    filled: true,
    hintStyle: AppTextStyles.font16Regular.copyWith(color: AppColors.grey400),
  );
}

OutlineInputBorder _buildOutlineBorder(final Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color),
  );
}

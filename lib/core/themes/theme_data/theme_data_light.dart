import 'package:flutter/material.dart';
import '../app_texts_style.dart';

import '../../utils/extensions/context_extensions.dart';
import '../app_colors.dart';

ThemeData getLightTheme({required final BuildContext context}) {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.grey0,
    brightness: Brightness.light,
    primaryColor: AppColors.primary300,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary300,
      primaryContainer: AppColors.primary50,
      secondary: AppColors.primary200,
      surface: AppColors.grey0,
      error: AppColors.red100,
      onPrimary: AppColors.grey0,
      onSecondary: AppColors.grey0,
      onSurface: AppColors.grey900,
      onError: AppColors.red0,
    ),
    textTheme: _buildTextTheme(context),
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    inputDecorationTheme: _buildInputDecorationTheme(),
    dividerColor: AppColors.grey200,
    disabledColor: AppColors.grey200,
    iconTheme: const IconThemeData(color: AppColors.grey900),
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
    labelStyle: AppTextStyles.font14Regular.copyWith(color: AppColors.grey600),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}

OutlineInputBorder _buildOutlineBorder(final Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color, width: 1.5),
  );
}

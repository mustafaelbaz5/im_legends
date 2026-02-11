import 'package:flutter/material.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';

import '../../utils/extensions/context_extensions.dart';
import '../app_colors.dart';

ThemeData getDarkTheme({required final BuildContext context}) {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.primary900,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary300,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary300,
      primaryContainer: AppColors.primary700,
      secondary: AppColors.primary200,
      surface: AppColors.grey800,
      error: AppColors.red100,
      onPrimary: AppColors.grey0,
      onSecondary: AppColors.grey0,
      onSurface: AppColors.grey0,
      onError: AppColors.red0,
    ),
    textTheme: _buildTextTheme(context),
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    inputDecorationTheme: _buildInputDecorationTheme(),
    dividerColor: AppColors.grey700,
    disabledColor: AppColors.grey600,
    iconTheme: const IconThemeData(color: AppColors.grey0),
  );
}

TextTheme _buildTextTheme(final BuildContext context) {
  return ThemeData.dark().textTheme.apply(
    bodyColor: AppColors.grey0,
    displayColor: AppColors.grey0,
    fontFamily: context.currentFont,
  );
}

ElevatedButtonThemeData _buildElevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary300,
      foregroundColor: AppColors.grey0,
      disabledBackgroundColor: AppColors.grey700,
      disabledForegroundColor: AppColors.grey500,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: AppTextStyles.font16SemiBold,
    ),
  );
}

InputDecorationTheme _buildInputDecorationTheme() {
  return InputDecorationTheme(
    border: _buildOutlineBorder(AppColors.grey600),
    enabledBorder: _buildOutlineBorder(AppColors.grey600),
    focusedBorder: _buildOutlineBorder(AppColors.primary300),
    errorBorder: _buildOutlineBorder(AppColors.red100),
    focusedErrorBorder: _buildOutlineBorder(AppColors.red100),
    fillColor: AppColors.grey800,
    filled: true,
    hintStyle: AppTextStyles.font16Regular.copyWith(color: AppColors.grey400),
    labelStyle: AppTextStyles.font14Regular.copyWith(color: AppColors.grey300),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}

OutlineInputBorder _buildOutlineBorder(final Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color, width: 1.5),
  );
}

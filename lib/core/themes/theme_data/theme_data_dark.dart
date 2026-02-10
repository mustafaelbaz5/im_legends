import 'package:flutter/material.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';

import '../../utils/extensions/context_extensions.dart';
import '../app_colors.dart';


ThemeData getDarkTheme({required final BuildContext context}) {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.grey900,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary300,
      brightness: Brightness.dark,
    ),
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: AppColors.grey0,
      displayColor: AppColors.grey0,
      fontFamily: context.currentFont,
    ),

    // Changed By the App General Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary300,
        foregroundColor: AppColors.grey0,
        disabledBackgroundColor: AppColors.grey800,
        disabledForegroundColor: AppColors.grey400,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: AppTextStyles.font16SemiBold,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.grey100),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.grey100),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primary200),
      ),
      fillColor: WidgetStateColor.resolveWith((final Set<WidgetState> states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors.primary100;
        }
        return AppColors.grey800;
      }),
      filled: true,
      hintStyle: AppTextStyles.font16Regular.copyWith(color: AppColors.grey400),
    ),
  );
}

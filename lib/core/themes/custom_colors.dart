import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomColors {
  // Backgrounds
  final Color background;
  final Color surface;
  final Color surfaceVariant;


  // Text
  final Color textPrimary;
  final Color textSecondary;

  // Borders & Dividers
  final Color border;
  final Color divider;

  // Status Containers
  final Color successContainer;
  final Color infoContainer;
  final Color warningContainer;
  final Color errorContainer;

  // Brand / Accent
  final Color accentBlue;
  final Color accentBlueSoft;

  const CustomColors._({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.divider,
    required this.successContainer,
    required this.infoContainer,
    required this.warningContainer,
    required this.errorContainer,
    required this.accentBlue,
    required this.accentBlueSoft,
  });

  /*──────────────── LIGHT ────────────────*/
  factory CustomColors.light() {
    return const CustomColors._(
      // Backgrounds
      background: AppColors.grey0,
      surface: AppColors.grey25,
      surfaceVariant: AppColors.grey50,


      // Text
      textPrimary: AppColors.grey900,
      textSecondary: AppColors.grey500,

      // Borders
      border: AppColors.grey200,
      divider: AppColors.grey100,

      // Status
      successContainer: AppColors.green25,
      infoContainer: AppColors.primary25,
      warningContainer: AppColors.yellow25,
      errorContainer: AppColors.red25,

      // Brand
      accentBlue: AppColors.primary300,
      accentBlueSoft: AppColors.primary50,
    );
  }

  /*──────────────── DARK ────────────────*/
  factory CustomColors.dark() {
    return const CustomColors._(
      // Backgrounds
      background: AppColors.grey900,
      surface: AppColors.grey800,
      surfaceVariant: AppColors.grey700,

      // Text
      textPrimary: AppColors.grey25,
      textSecondary: AppColors.grey400,

      // Borders
      border: AppColors.grey600,
      divider: AppColors.grey700,

      // Status
      successContainer: AppColors.green300,
      infoContainer: AppColors.primary200,
      warningContainer: AppColors.yellow200,
      errorContainer: AppColors.red200,

      // Brand
      accentBlue: AppColors.primary100,
      accentBlueSoft: AppColors.primary300,
    );
  }
}

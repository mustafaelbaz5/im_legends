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
  final Color textTertiary;

  // Borders & Dividers
  final Color border;
  final Color divider;

  // Status Containers
  final Color successContainer;
  final Color successText;
  final Color infoContainer;
  final Color infoText;
  final Color warningContainer;
  final Color warningText;
  final Color errorContainer;
  final Color errorText;

  // Brand / Accent
  final Color accentBlue;
  final Color accentBlueSoft;

  const CustomColors._({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.border,
    required this.divider,
    required this.successContainer,
    required this.successText,
    required this.infoContainer,
    required this.infoText,
    required this.warningContainer,
    required this.warningText,
    required this.errorContainer,
    required this.errorText,
    required this.accentBlue,
    required this.accentBlueSoft,
  });

  /*──────────────── LIGHT ────────────────*/
  factory CustomColors.light() {
    return const CustomColors._(
      background: AppColors.grey0,
      surface: AppColors.grey25,
      surfaceVariant: AppColors.grey50,

      textPrimary: AppColors.grey900,
      textSecondary: AppColors.grey600,
      textTertiary: AppColors.grey500,

      border: AppColors.grey200,
      divider: AppColors.grey100,

      successContainer: AppColors.green25,
      successText: AppColors.green300,
      infoContainer: AppColors.primary25,
      infoText: AppColors.primary300,
      warningContainer: AppColors.yellow25,
      warningText: AppColors.yellow300,
      errorContainer: AppColors.red25,
      errorText: AppColors.red300,

      accentBlue: AppColors.primary300,
      accentBlueSoft: AppColors.primary50,
    );
  }

  /*──────────────── DARK ────────────────*/
  factory CustomColors.dark() {
    return const CustomColors._(
      background: AppColors.grey900,
      surface: AppColors.grey800,
      surfaceVariant: AppColors.grey700,

      textPrimary: AppColors.grey0,
      textSecondary: AppColors.grey300,
      textTertiary: AppColors.grey400,

      border: AppColors.grey600,
      divider: AppColors.grey700,

      successContainer: AppColors.green300,
      successText: AppColors.green50,
      infoContainer: AppColors.primary300,
      infoText: AppColors.primary50,
      warningContainer: AppColors.yellow300,
      warningText: AppColors.yellow50,
      errorContainer: AppColors.red300,
      errorText: AppColors.red50,

      accentBlue: AppColors.primary200,
      accentBlueSoft: AppColors.primary100,
    );
  }
}

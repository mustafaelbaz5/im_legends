import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomColors {
  // Backgrounds
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color surfaceDark; // extra layer for cards or containers
  final Color scaffoldBackground;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  final Color textLink;

  // Borders & Dividers
  final Color border;
  final Color divider;
  final Color outline;

  // Status Containers
  final Color successContainer;
  final Color successText;
  final Color successContainerDark;

  final Color infoContainer;
  final Color infoText;
  final Color infoContainerDark;

  final Color warningContainer;
  final Color warningText;
  final Color warningContainerDark;

  final Color errorContainer;
  final Color errorText;
  final Color errorContainerDark;

  // Brand / Accent
  final Color accentBlue;
  final Color accentBlueSoft;
  final Color accentBlueDark;

  const CustomColors._({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.surfaceDark,
    required this.scaffoldBackground,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.textLink,
    required this.border,
    required this.divider,
    required this.outline,
    required this.successContainer,
    required this.successText,
    required this.successContainerDark,
    required this.infoContainer,
    required this.infoText,
    required this.infoContainerDark,
    required this.warningContainer,
    required this.warningText,
    required this.warningContainerDark,
    required this.errorContainer,
    required this.errorText,
    required this.errorContainerDark,
    required this.accentBlue,
    required this.accentBlueSoft,
    required this.accentBlueDark,
  });

  /*──────────────── LIGHT THEME ────────────────*/
  factory CustomColors.light() {
    return const CustomColors._(
      background: AppColors.primary0,
      surface: AppColors.primary25,
      surfaceVariant: AppColors.primary50,
      surfaceDark: AppColors.primary100,
      scaffoldBackground: AppColors.grey0,

      textPrimary: AppColors.grey900,
      textSecondary: AppColors.grey700,
      textTertiary: AppColors.grey500,
      textDisabled: AppColors.grey200,
      textLink: AppColors.primary300,

      border: AppColors.grey200,
      divider: AppColors.grey100,
      outline: AppColors.primary100,

      successContainer: AppColors.green25,
      successText: AppColors.green300,
      successContainerDark: AppColors.green50,

      infoContainer: AppColors.primary25,
      infoText: AppColors.primary300,
      infoContainerDark: AppColors.primary50,

      warningContainer: AppColors.yellow25,
      warningText: AppColors.yellow300,
      warningContainerDark: AppColors.yellow50,

      errorContainer: AppColors.red25,
      errorText: AppColors.red300,
      errorContainerDark: AppColors.red50,

      accentBlue: AppColors.primary300,
      accentBlueSoft: AppColors.primary50,
      accentBlueDark: AppColors.primary200,
    );
  }

  /*──────────────── DARK THEME ────────────────*/
  factory CustomColors.dark() {
    return const CustomColors._(
      background: AppColors.primary900,
      surface: AppColors.primary700,
      surfaceVariant: AppColors.primary600,
      surfaceDark: AppColors.primary500,
      scaffoldBackground: AppColors.grey800,

      textPrimary: AppColors.primary0,
      textSecondary: AppColors.grey300,
      textTertiary: AppColors.grey400,
      textDisabled: AppColors.grey500,
      textLink: AppColors.primary200,

      border: AppColors.primary400,
      divider: AppColors.primary500,
      outline: AppColors.primary300,

      successContainer: AppColors.green300,
      successText: AppColors.green50,
      successContainerDark: AppColors.green200,

      infoContainer: AppColors.primary300,
      infoText: AppColors.primary50,
      infoContainerDark: AppColors.primary200,

      warningContainer: AppColors.yellow300,
      warningText: AppColors.yellow50,
      warningContainerDark: AppColors.yellow200,

      errorContainer: AppColors.red300,
      errorText: AppColors.red50,
      errorContainerDark: AppColors.red200,

      accentBlue: AppColors.primary200,
      accentBlueSoft: AppColors.primary100,
      accentBlueDark: AppColors.primary300,
    );
  }
}

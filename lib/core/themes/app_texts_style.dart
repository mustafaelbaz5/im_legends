import 'package:flutter/material.dart';
import 'app_font_weight.dart';
import '../utils/spacing.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const TextStyle fontBold = TextStyle(fontWeight: AppFontWeight.bold);
  static const TextStyle fontSemiBold = TextStyle(
    fontWeight: AppFontWeight.semiBold,
  );
  static const TextStyle fontRegular = TextStyle(
    fontWeight: AppFontWeight.regular,
  );

  // Font Size 20
  static TextStyle font20Bold = TextStyle(
    fontSize: responsiveFontSize(20),
    fontWeight: AppFontWeight.bold,
  );
  static TextStyle font20SemiBold = TextStyle(
    fontSize: responsiveFontSize(20),
    fontWeight: AppFontWeight.semiBold,
  );
  static TextStyle font20Regular = TextStyle(
    fontSize: responsiveFontSize(20),
    fontWeight: AppFontWeight.regular,
  );

  // Font Size 18
  static TextStyle font18Bold = TextStyle(
    fontSize: responsiveFontSize(18),
    fontWeight: AppFontWeight.bold,
  );
  static TextStyle font18SemiBold = TextStyle(
    fontSize: responsiveFontSize(18),
    fontWeight: AppFontWeight.semiBold,
  );
  static TextStyle font18Regular = TextStyle(
    fontSize: responsiveFontSize(18),
    fontWeight: AppFontWeight.regular,
  );

  // Font Size 16
  static TextStyle font16Bold = TextStyle(
    fontSize: responsiveFontSize(16),
    fontWeight: AppFontWeight.bold,
  );
  static TextStyle font16SemiBold = TextStyle(
    fontSize: responsiveFontSize(16),
    fontWeight: AppFontWeight.semiBold,
  );
  static TextStyle font16Regular = TextStyle(
    fontSize: responsiveFontSize(16),
    fontWeight: AppFontWeight.regular,
  );

  // Font Size 14
  static TextStyle font14Bold = TextStyle(
    fontSize: responsiveFontSize(14),
    fontWeight: AppFontWeight.bold,
  );
  static TextStyle font14SemiBold = TextStyle(
    fontSize: responsiveFontSize(14),
    fontWeight: AppFontWeight.semiBold,
  );
  static TextStyle font14Regular = TextStyle(
    fontSize: responsiveFontSize(14),
    fontWeight: AppFontWeight.regular,
  );

  // Font Size 12
  static TextStyle font12Regular = TextStyle(
    fontSize: responsiveFontSize(12),
    fontWeight: AppFontWeight.regular,
  );
  static TextStyle font12SemiBold = TextStyle(
    fontSize: responsiveFontSize(12),
    fontWeight: AppFontWeight.semiBold,
  );
}

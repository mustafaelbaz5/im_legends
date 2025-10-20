import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../app_font_weight.dart';
import 'text_style_factory.dart';

class TajawalTextStyles {
  static const _font = 'Tajawal';

  // Grey Regular
  static final greyRegular12 = TextStyleFactory.create(
    font: _font,
    size: 12,
    weight: FontWeightHelper.regular,
    color: Colors.grey,
  );
  static final greyRegular14 = TextStyleFactory.create(
    font: _font,
    size: 14,
    weight: FontWeightHelper.regular,
    color: Colors.grey,
  );
  static final greyRegular16 = TextStyleFactory.create(
    font: _font,
    size: 16,
    weight: FontWeightHelper.regular,
    color: Colors.grey,
  );
  static final greyRegular18 = TextStyleFactory.create(
    font: _font,
    size: 18,
    weight: FontWeightHelper.regular,
    color: Colors.grey,
  );
  static final greyRegular20 = TextStyleFactory.create(
    font: _font,
    size: 20,
    weight: FontWeightHelper.regular,
    color: Colors.grey,
  );

  // White Bold
  static final whiteBold12 = TextStyleFactory.create(
    font: _font,
    size: 12,
    weight: FontWeightHelper.bold,
    color: Colors.white,
  );
  static final whiteBold14 = TextStyleFactory.create(
    font: _font,
    size: 14,
    weight: FontWeightHelper.bold,
    color: Colors.white,
  );
  static final whiteBold16 = TextStyleFactory.create(
    font: _font,
    size: 16,
    weight: FontWeightHelper.bold,
    color: Colors.white,
  );
  static final whiteBold18 = TextStyleFactory.create(
    font: _font,
    size: 18,
    weight: FontWeightHelper.bold,
    color: Colors.white,
  );
  static final whiteBold20 = TextStyleFactory.create(
    font: _font,
    size: 20,
    weight: FontWeightHelper.bold,
    color: Colors.white,
  );

  // Error Red
  static final errorRed12 = TextStyleFactory.create(
    font: _font,
    size: 12,
    weight: FontWeightHelper.bold,
    color: AppColors.darkRedColor,
  );
  static final errorRed14 = TextStyleFactory.create(
    font: _font,
    size: 14,
    weight: FontWeightHelper.bold,
    color: AppColors.darkRedColor,
  );
  static final errorRed16 = TextStyleFactory.create(
    font: _font,
    size: 16,
    weight: FontWeightHelper.bold,
    color: AppColors.darkRedColor,
  );
  static final errorRed18 = TextStyleFactory.create(
    font: _font,
    size: 18,
    weight: FontWeightHelper.bold,
    color: AppColors.darkRedColor,
  );
  static final errorRed20 = TextStyleFactory.create(
    font: _font,
    size: 20,
    weight: FontWeightHelper.bold,
    color: AppColors.darkRedColor,
  );
}

import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';
import '../app_colors.dart';
import '../app_font_weight.dart';
import 'text_style_factory.dart';

class BorelTextStyles {
  static const _font = AppAssets.fontBorel;
  static final whiteBold20 = TextStyleFactory.create(
    font: _font,
    size: 20,
    weight: FontWeightHelper.bold,
    color: Colors.white,
  );

  static final greyRegular12 = TextStyleFactory.create(
    font: _font,
    size: 12,
    weight: FontWeightHelper.regular,
    color: Colors.grey,
  );
  static final redBold12 = TextStyleFactory.create(
    font: _font,
    size: 12,
    weight: FontWeightHelper.bold,
    color: AppColors.darkRedColor,
  );

  static final greyRegular14 = TextStyleFactory.create(
    font: _font,
    size: 14,
    weight: FontWeightHelper.regular,
    color: Colors.grey,
  );
  static final redBold14 = TextStyleFactory.create(
    font: _font,
    size: 14,
    weight: FontWeightHelper.bold,
    color: AppColors.darkRedColor,
  );

  static final greyRegular16 = TextStyleFactory.create(
    font: _font,
    size: 16,
    weight: FontWeightHelper.regular,
    color: Colors.grey,
  );
  static final redBold16 = TextStyleFactory.create(
    font: _font,
    size: 16,
    weight: FontWeightHelper.bold,
    color: AppColors.darkRedColor,
  );

  static final greyRegular18 = TextStyleFactory.create(
    font: _font,
    size: 18,
    weight: FontWeightHelper.regular,
    color: Colors.grey,
  );
  static final redBold18 = TextStyleFactory.create(
    font: _font,
    size: 18,
    weight: FontWeightHelper.bold,
    color: AppColors.darkRedColor,
  );

  static final greyRegular20 = TextStyleFactory.create(
    font: _font,
    size: 20,
    weight: FontWeightHelper.regular,
    color: Colors.grey,
  );
  static final redBold20 = TextStyleFactory.create(
    font: _font,
    size: 20,
    weight: FontWeightHelper.bold,
    color: AppColors.darkRedColor,
  );
}

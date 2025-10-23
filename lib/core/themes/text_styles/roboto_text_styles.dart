import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_font_weight.dart';
import '../../utils/app_assets.dart';
import 'text_style_factory.dart';

class RobotoTextStyles {
  static const _font = AppAssets.fontRoboto;

  static final greyRegular12 = TextStyleFactory.create(
    font: _font,
    size: 12,
    weight: FontWeightHelper.regular,
    color: Colors.grey,
  );
  static final whiteBold12 = TextStyleFactory.create(
    font: _font,
    size: 12,
    weight: FontWeightHelper.bold,
    color: Colors.white,
  );

  static final greyRegular14 = TextStyleFactory.create(
    font: _font,
    size: 14,
    weight: FontWeightHelper.regular,
    color: Colors.grey,
  );
  static final whiteBold14 = TextStyleFactory.create(
    font: _font,
    size: 14,
    weight: FontWeightHelper.bold,
    color: Colors.white,
  );

  static final greyRegular16 = TextStyleFactory.create(
    font: _font,
    size: 16,
    weight: FontWeightHelper.regular,
    color: Colors.grey,
  );
  static final whiteSemiBold16 = TextStyleFactory.create(
    font: _font,
    size: 16,
    weight: FontWeightHelper.semiBold,
    color: Colors.white,
  );

  static final greyRegular18 = TextStyleFactory.create(
    font: _font,
    size: 18,
    weight: FontWeightHelper.regular,
    color: Colors.grey,
  );
  static final whiteBold18 = TextStyleFactory.create(
    font: _font,
    size: 18,
    weight: FontWeightHelper.bold,
    color: Colors.white,
  );

  static final greyBold20 = TextStyleFactory.create(
    font: _font,
    size: 20,
    weight: FontWeightHelper.bold,
    color: Colors.grey,
  );
  static final whiteBold20 = TextStyleFactory.create(
    font: _font,
    size: 20,
    weight: FontWeightHelper.bold,
    color: Colors.white,
  );

  static final whiteBold24 = TextStyleFactory.create(
    font: _font,
    size: 24,
    weight: FontWeightHelper.bold,
    color: Colors.white,
  );

  static final errorRed12 = TextStyleFactory.create(
    font: _font,
    size: 12,
    weight: FontWeightHelper.bold,
    color: AppColors.darkRedColor,
  );
}

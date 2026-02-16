import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox verticalSpacing(final double height) => SizedBox(height: height.h);
SizedBox horizontalSpacing(final double width) => SizedBox(width: width.w);

double responsiveHeight(final double height) => height.h;
double responsiveWidth(final double width) => width.w;

double responsiveFontSize(final double fontSize) => fontSize.sp;
double responsiveRadius(final double radius) => radius.r;

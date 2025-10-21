import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/spacing.dart';

class OnBoardingCustomCard extends StatelessWidget {
  const OnBoardingCustomCard({
    super.key,
    required this.title,
    required this.subTitle,
    this.icon,
    this.gradient,
  });

  final String title;
  final String subTitle;
  final IconData? icon;
  final List<Color>? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: gradient != null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradient!,
              )
            : const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2A3441), Color(0xFF1E2832)],
              ),
        border: Border.all(color: const Color(0xFF3A4553), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.3 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon section - more compact
                if (icon != null) ...[
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha((0.15 * 255).toInt()),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(icon!, color: Colors.white, size: 20.sp),
                  ),
                  SizedBox(height: 8.h),
                ],
                Flexible(
                  flex: 2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: BebasTextStyles.whiteBold14.copyWith(height: 1.1),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ),
                verticalSpacing(5),
                Flexible(
                  flex: 5,
                  child: Text(
                    subTitle,
                    style: RobotoTextStyles.greyRegular14.copyWith(
                      fontSize: 10.sp,
                      color: const Color(0xFFB0B8C1),
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

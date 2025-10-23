import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/themes/app_colors.dart';

class ChampionShimmer extends StatelessWidget {
  const ChampionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade500,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            // Header shimmer
            Container(
              height: 280.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.darkRedColor.withAlpha((0.5 * 255).toInt()),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white12,
                  ),
                  const SizedBox(height: 16),
                  Container(),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            // Stats shimmer
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha((0.6 * 255).toInt()),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  4,
                  (index) => Column(
                    children: [
                      Container(
                        height: 24.h,
                        width: 24.h,
                        decoration: const BoxDecoration(
                          color: Colors.white12,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 12.h,
                        width: 40.w,
                        color: Colors.white24,
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        height: 8.h,
                        width: 30.w,
                        color: Colors.white10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            // Top 3 shimmer
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha((0.6 * 255).toInt()),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Container(height: 20.h, width: 80.w, color: Colors.white24),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => Container(
                        height: index == 1 ? 140.h : 120.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

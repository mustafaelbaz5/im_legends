import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/utils/spacing.dart';

class ProfileShimmerLoading extends StatelessWidget {
  const ProfileShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade600,
      period: const Duration(milliseconds: 1200),
      child: Column(
        children: [
          // ==== Profile Header Shimmer ====
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 32.h, bottom: 24.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade900, Colors.black.withAlpha(150)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile image shimmer
                Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    shape: BoxShape.circle,
                  ),
                ),
                verticalSpacing(16),
                // Name shimmer
                Container(
                  width: 120.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                verticalSpacing(10),
                // Rank shimmer badge
                Container(
                  width: 80.w,
                  height: 26.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
              ],
            ),
          ),

          verticalSpacing(20),

          // ==== Stats Grid Shimmer ====
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GridView.builder(
              itemCount: 6,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          shape: BoxShape.circle,
                        ),
                      ),
                      verticalSpacing(8),
                      Container(
                        width: 40.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      verticalSpacing(6),
                      Container(
                        width: 60.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          verticalSpacing(20),

          // ==== Logout Button Shimmer ====
          Container(
            width: 200.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),

          verticalSpacing(40),
        ],
      ),
    );
  }
}

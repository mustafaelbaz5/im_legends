import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';
import 'package:im_legends/core/utils/spacing.dart';
import 'package:shimmer/shimmer.dart';

class HistoryShimmerLoading extends StatelessWidget {
  const HistoryShimmerLoading({super.key});

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 5,
      itemBuilder: (final context, final index) {
        return Container(
          margin: EdgeInsets.only(bottom: responsiveHeight(16)),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(responsiveRadius(16)),
            color: context.customColors.background.withValues(alpha: 0.1),
            border: Border.all(color: context.customColors.border, width: 1),
          ),
          child: Shimmer.fromColors(
            baseColor: context.customColors.textPrimary.withAlpha(50),
            highlightColor: context.customColors.textSecondary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: responsiveWidth(100),
                  height: responsiveHeight(20),
                  decoration: BoxDecoration(
                    color: context.customColors.textSecondary,
                    borderRadius: BorderRadius.circular(responsiveRadius(8)),
                  ),
                ),
                verticalSpacing(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Player Left
                    Column(
                      children: [
                        Container(
                          width: responsiveWidth(50),
                          height: responsiveHeight(50),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.customColors.textSecondary,
                          ),
                        ),
                        verticalSpacing(8),
                        Container(
                          width: responsiveWidth(60),
                          height: responsiveHeight(10),
                          color: context.customColors.textSecondary,
                        ),
                      ],
                    ),

                    // Score
                    Container(
                      width: responsiveWidth(60),
                      height: responsiveHeight(10),
                      color: context.customColors.textSecondary,
                    ),

                    // Player Right
                    Column(
                      children: [
                        Container(
                          width: responsiveWidth(60),
                          height: responsiveHeight(50),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.customColors.textSecondary,
                          ),
                        ),
                        verticalSpacing(8),
                        Container(
                          width: responsiveWidth(60),
                          height: responsiveHeight(10),
                          color: context.customColors.textSecondary,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

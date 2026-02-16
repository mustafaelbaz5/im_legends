import 'package:flutter/material.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/spacing.dart';
import 'package:shimmer/shimmer.dart';

class LeaderBoardShimmerLoading extends StatelessWidget {
  const LeaderBoardShimmerLoading({super.key});

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (final context, final index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: responsiveHeight(4)),
          padding: EdgeInsets.symmetric(
            horizontal: responsiveWidth(12),
            vertical: responsiveHeight(8),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(responsiveRadius(12)),
            color: context.customColors.background,
            border: Border.all(
              color: context.customColors.divider.withValues(alpha: 0.5),
              width: 0.5,
            ),
          ),
          child: Shimmer.fromColors(
            baseColor: context.customColors.textPrimary.withAlpha(50),
            highlightColor: context.customColors.textSecondary,
            child: Row(
              children: [
                // Avatar Circle
                Container(
                  width: responsiveWidth(50),
                  height: responsiveHeight(50),
                  decoration: BoxDecoration(
                    color: context.customColors.divider,
                    shape: BoxShape.circle,
                  ),
                ),

                // Player Info (Name + Points)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: responsiveWidth(100),
                        height: responsiveHeight(14),
                        decoration: BoxDecoration(
                          color: context.customColors.divider,
                          borderRadius: BorderRadius.circular(
                            responsiveRadius(4),
                          ),
                        ),
                      ),
                      verticalSpacing(4),
                      Container(
                        width: responsiveWidth(60),
                        height: responsiveHeight(20),
                        decoration: BoxDecoration(
                          color: context.customColors.divider,
                          borderRadius: BorderRadius.circular(
                            responsiveRadius(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                horizontalSpacing(8),

                // Stats Row (3 stats)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStatShimmer(context),
                    horizontalSpacing(14),
                    _buildStatShimmer(context),
                    horizontalSpacing(14),
                    _buildStatShimmer(context),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatShimmer(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: responsiveWidth(16),
          height: responsiveHeight(16),
          decoration: BoxDecoration(
            color: context.customColors.divider,
            shape: BoxShape.circle,
          ),
        ),
        verticalSpacing(4),
        Container(
          width: responsiveWidth(20),
          height: responsiveHeight(12),
          decoration: BoxDecoration(
            color: context.customColors.divider,
            borderRadius: BorderRadius.circular(responsiveRadius(4)),
          ),
        ),
      ],
    );
  }
}

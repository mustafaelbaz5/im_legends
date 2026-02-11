import 'package:flutter/material.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';
import 'package:im_legends/core/utils/spacing.dart';
import 'package:shimmer/shimmer.dart';

class LeaderBoardShimmerLoading extends StatelessWidget {
  const LeaderBoardShimmerLoading({super.key});

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: responsiveWidth(16),
        vertical: responsiveHeight(8),
      ),
      itemCount: 8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (final context, final index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: responsiveHeight(6)),
          child: Shimmer.fromColors(
            baseColor: context.customColors.divider.withValues(alpha: 0.1),
            highlightColor: context.customColors.divider.withValues(alpha: 0.2),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(12),
                vertical: responsiveHeight(10),
              ),
              decoration: BoxDecoration(
                color: context.customColors.divider.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(responsiveRadius(12)),
              ),
              child: Row(
                children: [
                  // Rank Circle
                  Container(
                    width: responsiveWidth(36),
                    height: responsiveHeight(36),
                    decoration: BoxDecoration(
                      color: context.customColors.divider.withValues(
                        alpha: 0.1,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  horizontalSpacing(10),

                  // Avatar Circle
                  Container(
                    width: responsiveWidth(50),
                    height: responsiveHeight(50),
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      shape: BoxShape.circle,
                    ),
                  ),
                  horizontalSpacing(12),

                  // Player Info (Name + Points)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: responsiveWidth(120),
                          height: responsiveHeight(14),
                          decoration: BoxDecoration(
                            color: context.customColors.divider.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(
                              responsiveRadius(6),
                            ),
                          ),
                        ),
                        verticalSpacing(6),
                        Container(
                          width: responsiveWidth(60),
                          height: responsiveHeight(12),
                          decoration: BoxDecoration(
                            color: context.customColors.divider.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(
                              responsiveRadius(6),
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
                    children: List.generate(3, (_) {
                      return Padding(
                        padding: EdgeInsets.only(left: responsiveWidth(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: responsiveWidth(20),
                              height: responsiveHeight(12),
                              color: context.customColors.divider.withValues(
                                alpha: 0.1,
                              ),
                            ),
                            verticalSpacing(4),
                            Container(
                              width: responsiveWidth(20),
                              height: responsiveHeight(10),
                              color: context.customColors.divider.withValues(
                                alpha: 0.1,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

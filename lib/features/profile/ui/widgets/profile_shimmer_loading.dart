import 'package:flutter/material.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/spacing.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmerLoading extends StatelessWidget {
  const ProfileShimmerLoading({super.key});

  @override
  Widget build(final BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.customColors.textPrimary.withAlpha(50),
      highlightColor: context.customColors.textSecondary,
      period: const Duration(milliseconds: 1200),
      child: CustomScrollView(
        slivers: [
          // Top bar with avatar shimmer
          SliverToBoxAdapter(
            child: SizedBox(
              height: responsiveHeight(240),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Top bar background
                  Container(
                    height: responsiveHeight(190),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(responsiveRadius(24)),
                        bottomRight: Radius.circular(responsiveRadius(24)),
                      ),
                    ),
                  ),

                  // Floating Avatar
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: responsiveWidth(100),
                        height: responsiveWidth(100),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.customColors.background,
                            width: 4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content area
          SliverToBoxAdapter(
            child: Column(
              children: [
                verticalSpacing(16),

                // Name shimmer
                Container(
                  width: responsiveWidth(150),
                  height: responsiveHeight(24),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(responsiveRadius(8)),
                  ),
                ),

                verticalSpacing(24),

                // Stats section shimmer
                _buildStatsShimmer(context),

                verticalSpacing(16),

                // Info section shimmer
                _buildInfoShimmer(context),

                verticalSpacing(16),

                // Settings section shimmer
                _buildSettingsShimmer(context),

                verticalSpacing(24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsShimmer(final BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(responsiveRadius(16)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(responsiveWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: responsiveWidth(100),
                  height: responsiveHeight(18),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(responsiveRadius(6)),
                  ),
                ),
                Container(
                  width: responsiveWidth(80),
                  height: responsiveHeight(28),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(responsiveRadius(20)),
                  ),
                ),
              ],
            ),
          ),

          // Win rate card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(20)),
            child: Container(
              padding: EdgeInsets.all(responsiveWidth(16)),
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(responsiveRadius(12)),
              ),
              child: Row(
                children: [
                  // Circle
                  Container(
                    width: responsiveWidth(70),
                    height: responsiveWidth(70),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      shape: BoxShape.circle,
                    ),
                  ),
                  horizontalSpacing(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: responsiveWidth(80),
                          height: responsiveHeight(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade600,
                            borderRadius: BorderRadius.circular(
                              responsiveRadius(4),
                            ),
                          ),
                        ),
                        verticalSpacing(8),
                        Row(
                          children: [
                            Container(
                              width: responsiveWidth(40),
                              height: responsiveHeight(24),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade600,
                                borderRadius: BorderRadius.circular(
                                  responsiveRadius(6),
                                ),
                              ),
                            ),
                            horizontalSpacing(8),
                            Container(
                              width: responsiveWidth(40),
                              height: responsiveHeight(24),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade600,
                                borderRadius: BorderRadius.circular(
                                  responsiveRadius(6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          verticalSpacing(20),

          // Stats grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(20)),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: responsiveHeight(12),
              crossAxisSpacing: responsiveWidth(12),
              childAspectRatio: 1.5,
              children: List.generate(
                4,
                (final index) => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(responsiveRadius(12)),
                  ),
                ),
              ),
            ),
          ),

          verticalSpacing(20),

          // Goal difference card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(20)),
            child: Container(
              height: responsiveHeight(80),
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(responsiveRadius(12)),
              ),
            ),
          ),

          verticalSpacing(20),
        ],
      ),
    );
  }

  Widget _buildInfoShimmer(final BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(responsiveRadius(16)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.fromLTRB(
              responsiveWidth(20),
              responsiveHeight(20),
              responsiveWidth(20),
              responsiveHeight(12),
            ),
            child: Row(
              children: [
                Container(
                  width: responsiveWidth(36),
                  height: responsiveWidth(36),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(responsiveRadius(10)),
                  ),
                ),
                horizontalSpacing(12),
                Container(
                  width: responsiveWidth(120),
                  height: responsiveHeight(18),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(responsiveRadius(6)),
                  ),
                ),
              ],
            ),
          ),

          // Info items
          ...List.generate(
            4,
            (final index) => Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsiveWidth(20),
                    vertical: responsiveHeight(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: responsiveWidth(40),
                        height: responsiveWidth(40),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(
                            responsiveRadius(12),
                          ),
                        ),
                      ),
                      horizontalSpacing(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: responsiveWidth(80),
                              height: responsiveHeight(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(
                                  responsiveRadius(4),
                                ),
                              ),
                            ),
                            verticalSpacing(6),
                            Container(
                              width: responsiveWidth(150),
                              height: responsiveHeight(16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(
                                  responsiveRadius(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: responsiveWidth(32),
                        height: responsiveWidth(32),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(
                            responsiveRadius(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (index < 3)
                  Divider(
                    height: 1,
                    indent: responsiveWidth(60),
                    endIndent: responsiveWidth(20),
                    color: Colors.grey.shade700,
                  ),
              ],
            ),
          ),

          verticalSpacing(4),
        ],
      ),
    );
  }

  Widget _buildSettingsShimmer(final BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(responsiveRadius(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.fromLTRB(
              responsiveWidth(20),
              responsiveHeight(20),
              responsiveWidth(20),
              responsiveHeight(12),
            ),
            child: Container(
              width: responsiveWidth(100),
              height: responsiveHeight(18),
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(responsiveRadius(6)),
              ),
            ),
          ),

          // Settings items
          ...List.generate(
            2,
            (final index) => Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsiveWidth(20),
                    vertical: responsiveHeight(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: responsiveWidth(40),
                        height: responsiveWidth(40),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(
                            responsiveRadius(12),
                          ),
                        ),
                      ),
                      horizontalSpacing(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: responsiveWidth(80),
                              height: responsiveHeight(14),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(
                                  responsiveRadius(4),
                                ),
                              ),
                            ),
                            verticalSpacing(6),
                            Container(
                              width: responsiveWidth(60),
                              height: responsiveHeight(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(
                                  responsiveRadius(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: responsiveWidth(16),
                        height: responsiveWidth(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                if (index < 1)
                  Divider(
                    height: 1,
                    indent: responsiveWidth(60),
                    endIndent: responsiveWidth(20),
                    color: Colors.grey.shade700,
                  ),
              ],
            ),
          ),

          verticalSpacing(4),
        ],
      ),
    );
  }
}

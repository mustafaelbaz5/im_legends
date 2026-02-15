import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:im_legends/core/models/players_states_model.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';
import 'package:im_legends/core/utils/spacing.dart';
import 'package:im_legends/features/profile/ui/widgets/profile_statistics/goals_overview.dart';
import 'package:im_legends/features/profile/ui/widgets/profile_statistics/stats_grid_view.dart';
import 'package:im_legends/features/profile/ui/widgets/profile_statistics/win_rate_card.dart';

class ProfileStatsSection extends StatelessWidget {
  final PlayerStatsModel stats;

  const ProfileStatsSection({super.key, required this.stats});

  @override
  Widget build(final BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(responsiveWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'profile.stats.title'.tr(),
                  style: AppTextStyles.font16Bold.copyWith(
                    color: context.customColors.textPrimary,
                  ),
                ),
                if (stats.rank != null)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsiveWidth(12),
                      vertical: responsiveHeight(6),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          context.customColors.accentBlue,
                          context.customColors.accentBlue.withAlpha(
                            (0.7 * 255).toInt(),
                          ),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(responsiveRadius(20)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.emoji_events, size: responsiveFontSize(16)),
                        horizontalSpacing(4),
                        Text(
                          'profile.stats.rank'.tr() + ' #${stats.rank}',
                          style: AppTextStyles.font12Regular,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // Win Rate Circle
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(20)),
            child: WinRateCard(stats: stats),
          ),
          // Stats Grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(20)),
            child: StatsGridView(stats: stats),
          ),
          // Goals Overview
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(20)),
            child: GoalsOverview(stats: stats),
          ),

          verticalSpacing(20),
        ],
      ),
    );
  }
}

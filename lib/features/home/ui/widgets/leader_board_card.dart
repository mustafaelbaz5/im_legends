import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/models/players_states_model.dart';
import '../../../../core/themes/app_colors.dart';
import 'player_info.dart';
import 'rank_and_avatar.dart';
import 'states_section.dart';
import '../../../../core/utils/spacing.dart';

class LeaderBoardCard extends StatelessWidget {
  final PlayerStatsModel player;
  final bool isCurrentUser;

  const LeaderBoardCard({
    super.key,
    this.isCurrentUser = false,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        height: 80.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: isCurrentUser
              ? AppColors.lightDarkColor
              : const Color(0xFF1E2128),
          border: isCurrentUser
              ? Border.all(color: AppColors.darkRedColor, width: 1)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.2 * 255).toInt()),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            RankAndAvatar(
              isCurrentUser: isCurrentUser,
              rank: player.rank,
              imageUrl: player.profileImage,
            ),
            horizontalSpacing(12),
            Expanded(
              flex: 2,
              child: PlayerInfo(
                playerName: player.playerName,
                points: player.points,
              ),
            ),

            // Stats Section
            StatesSection(
              Match: player.matchesPlayed,
              goalDifference: player.goalDifference,
            ),
          ],
        ),
      ),
    );
  }
}

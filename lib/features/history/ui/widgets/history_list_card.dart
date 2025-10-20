import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../../data/models/match_history_card_model.dart';
import 'history_card_player_info.dart';
import 'match_card_header.dart';
import 'score_display.dart';

class HistoryListCard extends StatelessWidget {
  final MatchHistoryCardModel match;

  const HistoryListCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.darkColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.5 * 255).toInt()),
            blurRadius: 12.r,
            offset: Offset(0, 6.h),
          ),
        ],
        border: Border.all(color: Colors.white.withAlpha((0.5 * 255).toInt())),
      ),
      child: Column(
        children: [
          MatchCardHeader(matchDate: match.matchDate),
          verticalSpacing(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HistoryCardPlayerInfo(
                playerName: match.winnerName,
                avatarUrl: match.winnerImage,
                isWinner: true,
              ),
              ScoreDisplay(match: match),
              HistoryCardPlayerInfo(
                playerName: match.loserName,
                avatarUrl: match.loserImage,
                isWinner: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

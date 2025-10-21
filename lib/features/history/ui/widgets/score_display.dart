import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_texts_style.dart';
import '../../data/models/match_history_card_model.dart';

class ScoreDisplay extends StatelessWidget {
  final MatchHistoryCardModel match;

  const ScoreDisplay({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${match.winnerScore}',
          style: RobotoTextStyles.whiteBold24.copyWith(
            color: AppColors.winColor,
          ),
        ),
        Text(
          '  -  ',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '${match.loserScore}',
          style: RobotoTextStyles.whiteBold24.copyWith(
            color: AppColors.loseColor,
          ),
        ),
      ],
    );
  }
}

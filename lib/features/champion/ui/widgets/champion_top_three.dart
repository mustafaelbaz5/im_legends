import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_colors.dart';
import '../../data/model/champion_player_model.dart';
import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/spacing.dart';
import 'champions_card.dart';

class ChampionTopThree extends StatelessWidget {
  final List<ChampionPlayerModel> topThree;
  const ChampionTopThree({super.key, required this.topThree});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withAlpha((0.3 * 255).toInt()),
            Colors.black.withAlpha((0.3 * 255).toInt()),
            Colors.black.withAlpha((0.9 * 255).toInt()),
            Colors.black.withAlpha((0.9 * 255).toInt()),
            Colors.black.withAlpha((0.9 * 255).toInt()),
            AppColors.darkRedColor.withAlpha((0.9 * 255).toInt()),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),

        border: Border.all(
          color: Colors.white.withAlpha((0.2 * 255).toInt()),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Text('Top 3 ', style: BebasTextStyles.whiteBold24),
          verticalSpacing(32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Second place (left)
              Flexible(child: ChampionsCard(champion: topThree[1])),
              // First place (center, elevated)
              Flexible(
                child: Transform.translate(
                  offset: Offset(0, -20.h),
                  child: ChampionsCard(champion: topThree[0]),
                ),
              ),
              // Third place (right)
              Flexible(child: ChampionsCard(champion: topThree[2])),
            ],
          ),
        ],
      ),
    );
  }
}

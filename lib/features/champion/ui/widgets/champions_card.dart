import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/champion_player_model.dart';
import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/functions/get_rank_color.dart';

class ChampionsCard extends StatelessWidget {
  final ChampionPlayerModel champion;
  late final int rank;
  late final bool isFirst;
  late final bool isSecond;

  ChampionsCard({super.key, required this.champion}) {
    rank = champion.stats.rank ?? 0;
    isFirst = rank == 1;
    isSecond = rank == 2;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: getRankColor(
                    isFirst
                        ? 1
                        : isSecond
                        ? 2
                        : 3,
                  ),
                  width: isFirst ? 4.w : 3.w,
                ),
              ),
              child: CircleAvatar(
                radius: isFirst ? 50.r : 40.r,
                backgroundColor: Colors.transparent,
                child: CircleAvatar(
                  radius: isFirst ? 46.r : 36.r,
                  backgroundImage: champion.user.profileImageUrl != null
                      ? NetworkImage(champion.user.profileImageUrl!)
                      : const AssetImage(AppAssets.appLogoPng) as ImageProvider,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(isFirst ? 6.w : 4.w),
              decoration: BoxDecoration(
                color: getRankColor(
                  isFirst
                      ? 1
                      : isSecond
                      ? 2
                      : 3,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withAlpha((0.3 * 255).toInt()),
                  width: 1.w,
                ),
              ),
              child: Text('#$rank', style: BebasTextStyles.whiteBold14),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          champion.user.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isFirst ? 18.sp : 16.sp,
            fontWeight: FontWeight.bold,
            color: getRankColor(
              isFirst
                  ? 1
                  : isSecond
                  ? 2
                  : 3,
            ),
          ),
        ),
      ],
    );
  }
}

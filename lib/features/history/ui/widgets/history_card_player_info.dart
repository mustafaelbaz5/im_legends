import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/text_styles/bebas_text_styles.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/themes/app_colors.dart';

class HistoryCardPlayerInfo extends StatelessWidget {
  final String playerName;
  final String? avatarUrl;
  final bool isWinner;

  const HistoryCardPlayerInfo({
    super.key,
    required this.playerName,
    this.avatarUrl,
    required this.isWinner,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final nameColor = isWinner
        ? AppColors.winColor
        : theme.brightness == Brightness.dark
        ? Colors.grey.shade300
        : AppColors.loseColor;

    final avatarBgColor = isWinner ? AppColors.winColor : AppColors.loseColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar with soft glow
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: isWinner ? AppColors.winColor : Colors.black,
                blurRadius: isWinner ? 14.r : 8.r,
                spreadRadius: isWinner ? 2.r : 1.r,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 28.r,
            backgroundColor: avatarBgColor,
            backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                ? NetworkImage(avatarUrl!)
                : null,
            child: (avatarUrl == null || avatarUrl!.isEmpty)
                ? Icon(Icons.person, size: 24.sp, color: nameColor)
                : null,
          ),
        ),
        verticalSpacing(10),
        SizedBox(
          width: 80.w,
          child: Text(
            playerName,
            style: BebasTextStyles.whiteBold14.copyWith(color: nameColor),
            textAlign: TextAlign.center,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

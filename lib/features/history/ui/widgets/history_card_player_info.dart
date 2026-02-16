import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

import '../../../../core/utils/spacing.dart';

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
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar with soft glow
        Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: CircleAvatar(
            radius: responsiveRadius(35),
            backgroundColor: context.customColors.successContainer.withValues(
              alpha: 0.3,
            ),
            backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                ? CachedNetworkImageProvider(avatarUrl!)
                : null,
            child: (avatarUrl == null || avatarUrl!.isEmpty)
                ? Icon(Icons.person, color: context.customColors.textSecondary)
                : null,
          ),
        ),
        verticalSpacing(10),
        SizedBox(
          width: responsiveWidth(100),
          child: Text(
            playerName,
            style: AppTextStyles.font12Regular,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

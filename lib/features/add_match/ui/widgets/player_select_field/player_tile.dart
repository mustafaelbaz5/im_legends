import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:im_legends/core/themes/app_colors.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';
import 'package:im_legends/core/utils/spacing.dart';

import '../../../../../core/themes/app_texts_style.dart';

class PlayerTile extends StatelessWidget {
  final String playerName;
  final String playerImage;
  final String playerId;
  final bool isSelected;
  final int index;

  final void Function(String id, String name, String imageUrl) onSelect;

  const PlayerTile({
    super.key,
    required this.playerName,
    required this.isSelected,
    required this.index,
    required this.onSelect,
    required this.playerImage,
    required this.playerId,
  });

  @override
  Widget build(final BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(vertical: responsiveHeight(4)),
      padding: EdgeInsets.symmetric(
        horizontal: responsiveWidth(12),
        vertical: responsiveHeight(10),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(responsiveRadius(16)),
        color: isSelected
            ? context.customColors.background
            : context.customColors.background.withValues(alpha: 0.5),
        border: isSelected
            ? Border.all(color: AppColors.primary300, width: 1.5)
            : null,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(responsiveRadius(16)),
        onTap: () => onSelect(playerId, playerName, playerImage),
        child: Row(
          children: [
            _buildAvatar(),
            horizontalSpacing(16),
            Expanded(
              child: Text(
                playerName,
                style: isSelected
                    ? AppTextStyles.font14Bold
                    : AppTextStyles.font14Regular,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary300,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final hasImage = playerImage.isNotEmpty;

    return Container(
      width: responsiveWidth(40),
      height: responsiveHeight(40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.primaries[index % Colors.primaries.length].withAlpha(
              (0.9 * 255).toInt(),
            ),
            Colors.primaries[(index + 1) % Colors.primaries.length].withAlpha(
              (0.7 * 255).toInt(),
            ),
          ],
        ),
      ),
      child: Center(
        child: hasImage
            ? ClipOval(
                child: CachedNetworkImage(
                  imageUrl: playerImage,
                  fit: BoxFit.cover,
                  width: responsiveWidth(40),
                  height: responsiveHeight(40),
                  placeholder: (final context, final url) => SizedBox(
                    width: responsiveWidth(20),
                    height: responsiveHeight(20),
                    child: Icon(
                      Icons.person,
                      color: context.customColors.textPrimary,
                    ),
                  ),
                  errorWidget: (final context, final url, final error) => Icon(
                    Icons.person,
                    color: context.customColors.textPrimary,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/app_texts_style.dart';

class PlayerTile extends StatelessWidget {
  final String playerName;
  final String playerImage;
  final String playerId;
  final bool isSelected;
  final int index;

  /// Updated: callback returns full player info (id, name, image)
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
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: isSelected
            ? const LinearGradient(
                colors: [Color(0xFF2A4A6B), Color(0xFF1E3A5F)],
              )
            : null,
        color: isSelected ? null : Colors.white.withAlpha((0.03 * 255).toInt()),
        border: isSelected
            ? Border.all(color: const Color(0xFF4A90E2), width: 2)
            : Border.all(
                color: Colors.white.withAlpha((0.08 * 255).toInt()),
                width: 1,
              ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () =>
            onSelect(playerId, playerName, playerImage),
        child: Row(
          children: [
            _buildAvatar(),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                playerName,
                style: BebasTextStyles.whiteBold20.copyWith(
                  fontSize: 16.sp,
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withAlpha((0.95 * 255).toInt()),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: Colors.blue, size: 24.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final hasImage = playerImage.isNotEmpty;

    return Container(
      width: 40.w,
      height: 40.h,
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
                  width: 40.w,
                  height: 40.h,
                  placeholder: (context, url) => const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.person, color: Colors.white),
                ),
              )
            : const Icon(Icons.person, color: Colors.white),
      ),
    );
  }
}

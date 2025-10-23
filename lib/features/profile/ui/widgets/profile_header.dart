import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/themes/text_styles/bebas_text_styles.dart';
import '../../../../core/utils/functions/get_rank_color.dart';

class ProfileHeader extends StatelessWidget {
  final int rank;
  final String name;
  final String? imageUrl;

  const ProfileHeader({
    super.key,
    required this.rank,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 32.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            getRankColor(rank).withAlpha((0.5 * 255).toInt()),
            Colors.black.withAlpha((0.3 * 255).toInt()),
            Colors.black,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.3 * 255).toInt()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withAlpha((0.4 * 255).toInt()),
                width: 3.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: getRankColor(rank).withAlpha((0.5 * 255).toInt()),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.person, color: Colors.white, size: 60),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Name
          Text(
            name,
            style: BebasTextStyles.whiteBold24.copyWith(
              fontSize: 28.sp,
              letterSpacing: 1.2,
            ),
          ),
          verticalSpacing(8),
          // Rank Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: getRankColor(rank),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: Colors.white.withAlpha((0.4 * 255).toInt()),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.emoji_events, size: 18.sp, color: Colors.white),
                SizedBox(width: 6.w),
                Text(
                  '#$rank',
                  style: BebasTextStyles.whiteBold20.copyWith(fontSize: 22.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

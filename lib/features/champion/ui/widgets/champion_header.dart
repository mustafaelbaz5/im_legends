import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/app_assets.dart';

class ChampionHeader extends StatelessWidget {
  final String name;
  final String? imageUrl;

  const ChampionHeader({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280.h,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(AppAssets.championBannerjpg),
          fit: BoxFit.cover,
          opacity: 0.9,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.2 * 255).toInt()),
            blurRadius: 6.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Champion Image with Trophy Overlay
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.goldColor, width: 3.w),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.goldColor,
                      blurRadius: 8.r,
                      spreadRadius: 2.r,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 80.r,
                  child: CircleAvatar(
                    radius: 150.r,
                    backgroundImage: imageUrl != null
                        ? CachedNetworkImageProvider(imageUrl!)
                        : const AssetImage(AppAssets.appLogoPng),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: const BoxDecoration(
                  color: AppColors.goldColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.emoji_events,
                  size: 18.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          verticalSpacing(8),
          Text(
            name,
            style: BebasTextStyles.whiteBold14.copyWith(fontSize: 32.sp),
          ),
          verticalSpacing(8),
          Text(
            'Champion',
            style: RobotoTextStyles.whiteBold20.copyWith(
              wordSpacing: 2,
              fontSize: 26.sp,
              color: Colors.white.withAlpha((0.8 * 255).toInt()),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ChampionShimmer extends StatelessWidget {
  const ChampionShimmer({super.key});

  @override
  Widget build(final BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade600 : Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),

            // ── Podium shimmer (2nd | 1st | 3rd) ──
            _PodiumShimmer(),

            SizedBox(height: 16.h),

            const Divider(),

            SizedBox(height: 8.h),

            // ── Leaderboard rows shimmer ──
            _LeaderboardShimmer(),
          ],
        ),
      ),
    );
  }
}

class _PodiumShimmer extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 2nd place
          Expanded(
            child: _PodiumSlotShimmer(podiumHeight: 70.h, avatarRadius: 30.r),
          ),
          // 1st place
          Expanded(
            child: _PodiumSlotShimmer(
              podiumHeight: 100.h,
              avatarRadius: 38.r,
              showCrown: true,
            ),
          ),
          // 3rd place
          Expanded(
            child: _PodiumSlotShimmer(podiumHeight: 50.h, avatarRadius: 26.r),
          ),
        ],
      ),
    );
  }
}

class _PodiumSlotShimmer extends StatelessWidget {
  final double podiumHeight;
  final double avatarRadius;
  final bool showCrown;

  const _PodiumSlotShimmer({
    required this.podiumHeight,
    required this.avatarRadius,
    this.showCrown = false,
  });

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Crown placeholder
        Container(
          height: 28.h,
          width: 28.w,
          decoration: showCrown
              ? const BoxDecoration(color: Colors.white, shape: BoxShape.circle)
              : null,
        ),

        SizedBox(height: 6.h),

        // Avatar
        CircleAvatar(radius: avatarRadius, backgroundColor: Colors.white),

        SizedBox(height: 8.h),

        // Name
        Container(
          height: 10.h,
          width: 60.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),

        SizedBox(height: 6.h),

        // Stat
        Container(
          height: 8.h,
          width: 44.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),

        SizedBox(height: 8.h),

        // Podium block
        Container(
          height: podiumHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
          ),
        ),
      ],
    );
  }
}

class _LeaderboardShimmer extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Column(
      children: List.generate(
        6,
        (final i) => _LeaderboardRowShimmer(isEven: i.isEven),
      ),
    );
  }
}

class _LeaderboardRowShimmer extends StatelessWidget {
  final bool isEven;

  const _LeaderboardRowShimmer({required this.isEven});

  @override
  Widget build(final BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      color: isEven ? colors.surfaceContainerLowest : colors.surface,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          // Rank number
          Container(
            height: 14.h,
            width: 20.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),

          SizedBox(width: 16.w),

          // Avatar
          CircleAvatar(radius: 16.r, backgroundColor: Colors.white),

          SizedBox(width: 10.w),

          // Name
          Expanded(
            child: Container(
              height: 12.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),

          SizedBox(width: 16.w),

          // Stat value
          Container(
            height: 14.h,
            width: 30.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}

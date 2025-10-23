import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../logic/cubit/profile_cubit.dart';
import 'states_grid_view.dart';

import '../../../../core/models/players_states_model.dart';
import '../../../../core/models/user_data.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/custom_text_button.dart';
import 'profile_header.dart';

class profileSuccessState extends StatelessWidget {
  const profileSuccessState({
    super.key,
    required this.playerProfile,
    required this.playerStats,
  });

  final UserData playerProfile;
  final PlayerStatsModel playerStats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            ProfileHeader(
              rank: playerStats.rank ?? 0,
              name: playerProfile.name,
              imageUrl: playerProfile.profileImageUrl,
            ),
          ],
        ),
        // Stats Grid
        StatsGridView(
          stats: [
            {
              'label': 'Points',
              'value': playerStats.points,
              'icon': Icons.star,
            },
            {
              'label': 'Matches',
              'value': playerStats.matchesPlayed,
              'icon': Icons.sports_esports,
            },
            {
              'label': 'Wins',
              'value': playerStats.wins,
              'icon': Icons.emoji_events,
            },
            {
              'label': 'Goals Scored',
              'value': playerStats.goalsScored,
              'icon': Icons.sports_soccer,
            },
            {
              'label': 'Goals received',
              'value': playerStats.goalsReceived,
              'icon': Icons.sports_soccer,
            },
            {
              'label': 'Goal Difference',
              'value': playerStats.goalDifference,
              'icon': Icons.sports_soccer,
            },
          ],
        ),
        verticalSpacing(16),

        // Logout Button with Confirmation Dialog
        SizedBox(
          width: 200.w,
          child: CustomTextButton(
            buttonText: 'Logout',
            backgroundColor: Colors.red,
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ),
        verticalSpacing(32),
      ],
    );
  }

  void _showLogoutDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
              SizedBox(width: 8.w),
              Text(
                'Confirm Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: TextStyle(color: Colors.grey.shade300, fontSize: 14.sp),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                // 👇 Use the parentContext here
                parentContext.read<ProfileCubit>().logout();
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

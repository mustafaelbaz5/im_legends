import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/text_styles/bebas_text_styles.dart';
import '../../../../core/widgets/custom_text_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/utils/spacing.dart';
import '../../logic/cubit/leader_board_cubit.dart';

class HomeHeaderContainer extends StatelessWidget {
  const HomeHeaderContainer({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 24.h),
        decoration: BoxDecoration(
          color: AppColors.darkColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.r),
            bottomRight: Radius.circular(24.r),
          ),
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withAlpha((0.1 * 255).toInt()),
              width: 1,
            ),
            left: BorderSide(
              color: Colors.white.withAlpha((0.1 * 255).toInt()),
              width: 1,
            ),
            right: BorderSide(
              color: Colors.white.withAlpha((0.1 * 255).toInt()),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: BlocBuilder<LeaderBoardCubit, LeaderBoardState>(
            builder: (context, state) {
              String displayName = "Player";

              if (state is LeaderBoardSuccess) {
                final currentUserId =
                    Supabase.instance.client.auth.currentUser?.id;
                final currentPlayer = state.leaderboard.firstWhere(
                  (p) => p.playerId == currentUserId,
                  orElse: () => state.leaderboard.first,
                );
                displayName = currentPlayer.playerName;
              } else if (state is LeaderBoardFailure) {
                displayName = "Error loading user";
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _getGreeting(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.greyColor.withAlpha((0.8 * 255).toInt()),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.1,
                    ),
                  ),
                  verticalSpacing(6),
                  Text(
                    displayName,
                    style: BebasTextStyles.whiteBold24.copyWith(
                      fontSize: 32.sp,
                      letterSpacing: 1.1,
                    ),
                  ),
                  verticalSpacing(10),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white.withAlpha((0.1 * 255).toInt()),
                      border: Border.all(
                        color: AppColors.greyColor.withAlpha(
                          (0.2 * 255).toInt(),
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.goldColor.withAlpha(
                            (0.2 * 255).toInt(),
                          ),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.sports_esports_rounded,
                          color: AppColors.goldColor,
                          size: 18.sp,
                        ),
                        horizontalSpacing(6),
                        Text(
                          "Ready to play?",
                          style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpacing(16),
                  SizedBox(
                    width: 250.w,
                    child: CustomTextButton(
                      buttonText: 'Add Match',
                      textStyle: BebasTextStyles.whiteBold24,
                      onPressed: () {
                        context.push(Routes.addMatchScreen);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_paths.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/functions/refresh_page.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../logic/cubit/profile_cubit.dart';
import 'widgets/profile_shimmer_loading.dart';
import 'widgets/profile_success_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoggedOut) {
          context.go(Routes.onBoardingScreen);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const CustomAppBar(title: 'Profile'),
            Expanded(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const ProfileShimmerLoading();
                  } else if (state is ProfileSuccess) {
                    final playerProfile = state.player.user;
                    final playerStats = state.player.stats;

                    return RefreshIndicator(
                      onRefresh: () => onRefresh(context),
                      backgroundColor: AppColors.lightDarkColor,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: profileSuccessState(
                          playerProfile: playerProfile,
                          playerStats: playerStats,
                        ),
                      ),
                    );
                  } else if (state is ProfileFailure) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

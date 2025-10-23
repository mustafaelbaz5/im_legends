import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/utils/functions/refresh_page.dart';
import '../../../core/utils/spacing.dart';
import '../logic/cubit/leader_board_cubit.dart';
import '../../../core/widgets/custom_app_bar.dart';
import 'widgets/home_header_container.dart';
import 'widgets/leader_board_list_view.dart';
import 'widgets/leader_board_shimmer_loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: Column(
        children: [
          const CustomAppBar(title: 'Leaderboard'),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () => onRefresh(context),
              backgroundColor: AppColors.lightDarkColor,
              color: Colors.white,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeHeaderContainer(),
                      verticalSpacing(16),

                      // --- Leaderboard Section
                      BlocBuilder<LeaderBoardCubit, LeaderBoardState>(
                        builder: (context, state) {
                          if (state is LeaderBoardLoading) {
                            return const LeaderBoardShimmerLoading();
                          } else if (state is LeaderBoardSuccess) {
                            return const LeadBoardListView();
                          } else if (state is LeaderBoardFailure) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Text(
                                  state.message,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

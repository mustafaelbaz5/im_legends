import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/functions/refresh_page.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../logic/cubit/champion_cubit.dart';
import 'widgets/champion_header.dart';
import 'widgets/champion_shimmer_loading.dart';
import 'widgets/champion_states.dart';
import 'widgets/champion_top_three.dart';

class ChampionScreen extends StatelessWidget {
  const ChampionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: 'Champions'),
          Expanded(
            child: BlocBuilder<ChampionCubit, ChampionState>(
              builder: (context, state) {
                if (state is ChampionLoading) {
                  return const ChampionShimmer();
                } else if (state is ChampionSuccess) {
                  final champion = state.players[0];
                  final topThree = state.players;
                  return RefreshIndicator(
                    onRefresh: () => onRefresh(context),
                    backgroundColor: AppColors.lightDarkColor,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          ChampionHeader(
                            name: champion.user.name,
                            imageUrl: champion.user.profileImageUrl,
                          ),
                          ChampionStats(
                            goals: champion.stats.goalDifference,
                            points: champion.stats.points,
                            wins: champion.stats.wins,
                            matches: champion.stats.matchesPlayed,
                          ),
                          ChampionTopThree(topThree: topThree),
                        ],
                      ),
                    ),
                  );
                } else if (state is ChampionFailure) {
                  return Center(child: Text(state.errorMessage));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

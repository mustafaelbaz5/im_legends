  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/champion/logic/cubit/champion_cubit.dart';
import '../../../features/history/logic/cubit/match_history_cubit.dart';
import '../../../features/home/logic/cubit/leader_board_cubit.dart';
import '../../../features/profile/logic/cubit/profile_cubit.dart';

Future<void> onRefresh(BuildContext context) async {
    await Future.wait([
      context.read<LeaderBoardCubit>().loadLeaderboard(),
      context.read<MatchHistoryCubit>().getMatchHistory(),
      context.read<ProfileCubit>().fetchProfile(),
      context.read<ChampionCubit>().fetchTopThree(),
    ]);
  }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'success_dialog.dart';
import '../../../notification/logic/cubit/notifications_cubit.dart';
import '../../../champion/logic/cubit/champion_cubit.dart';
import '../../../profile/logic/cubit/profile_cubit.dart';
import '../../../history/logic/cubit/match_history_cubit.dart';
import '../../../home/logic/cubit/leader_board_cubit.dart';
import '../../data/models/match_model.dart';
import '../../logic/cubit/add_match_cubit.dart';
import 'add_match_button.dart';

class AddMatchBlocConsumer extends StatelessWidget {
  const AddMatchBlocConsumer({
    super.key,
    required bool isAddButtonEnabled,
    required this.winnerPlayer,
    required this.loserPlayer,
    required this.winnerScore,
    required this.loserScore,
  }) : _isAddButtonEnabled = isAddButtonEnabled;

  final bool _isAddButtonEnabled;
  final String? winnerPlayer;
  final String? loserPlayer;
  final int winnerScore;
  final int loserScore;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMatchCubit, AddMatchState>(
      listener: (context, state) {
        if (state is AddMatchInsertSuccess) {
          context.read<NotificationsCubit>().handleMatchResult(
            winnerId: winnerPlayer!,
            loserId: loserPlayer!,
          );
          context.read<LeaderBoardCubit>().loadLeaderboard();
          context.read<MatchHistoryCubit>().getMatchHistory();
          context.read<ProfileCubit>().fetchProfile();
          context.read<ChampionCubit>().fetchTopThree();

          // Show success dialog
          showDialog(
            context: context,
            barrierDismissible: false, // force user to press button
            builder: (dialogContext) => const SuccessDialog(),
          );
        } else if (state is AddMatchFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AddMatchLoading;

        return AddMatchButton(
          isEnabled: _isAddButtonEnabled,
          isLoading: isLoading,
          onPressed: _isAddButtonEnabled
              ? () {
                  final match = MatchModel(
                    winnerId: winnerPlayer!,
                    loserId: loserPlayer!,
                    winnerScore: winnerScore,
                    loserScore: loserScore,
                  );
                  // call cubit
                  context.read<AddMatchCubit>().addMatch(match);
                }
              : null,
        );
      },
    );
  }
}

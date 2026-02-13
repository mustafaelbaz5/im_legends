import 'package:bloc/bloc.dart';
import 'package:im_legends/core/error/models/app_error.dart';
import 'package:im_legends/core/error/types/error_type.dart';
import 'package:meta/meta.dart';

import '../../data/models/match_model.dart';
import '../../data/repo/add_match_repo.dart';

part 'add_match_state.dart';

class AddMatchCubit extends Cubit<AddMatchState> {
  final AddMatchRepo addMatchRepo;

  AddMatchCubit({required this.addMatchRepo}) : super(const AddMatchInitial());

  // --- Scores ---
  void updateWinnerScore(final int change) {
    final newScore = state.winnerScore + change;
    if (newScore < 0) return;

    int adjustedLoser = state.loserScore;
    if (newScore <= state.loserScore) {
      adjustedLoser = newScore > 0 ? newScore - 1 : 0;
    }

    emit(state.copyWith(winnerScore: newScore, loserScore: adjustedLoser));
  }

  void updateLoserScore(final int change) {
    final newScore = state.loserScore + change;
    if (newScore < 0 || newScore > state.winnerScore) return;
    emit(state.copyWith(loserScore: newScore));
  }

  bool canIncrementLoser() => state.loserScore - 1 < state.winnerScore;

  // --- Selected Players ---
  void updateWinner(
    final String playerId,
    final String name,
    final String imageUrl,
  ) {
    emit(
      state.copyWith(
        winnerId: playerId,
        winnerName: name,
        winnerImage: imageUrl,
      ),
    );
  }

  void updateLoser(
    final String playerId,
    final String name,
    final String imageUrl,
  ) {
    emit(
      state.copyWith(loserId: playerId, loserName: name, loserImage: imageUrl),
    );
  }

  // --- Submission check ---
  bool canSubmit() {
    return state.winnerId != null &&
        state.loserId != null &&
        state.winnerId != state.loserId &&
        state.winnerScore >= state.loserScore;
  }

  // --- Reset ---
  void reset() {
    emit(const AddMatchState());
  }

  // --- Add match ---
  Future<void> addMatch(final MatchModel match) async {
    emit(AddMatchLoading());
    try {
      final success = await addMatchRepo.insertMatch(match);
      if (success) {
        emit(AddMatchInsertSuccess());
      } else {
        emit(
          const AddMatchFailure(
            error: AppError(
              messageKey: "Failed to insert match",
              type: ErrorType.unknown,
            ),
          ),
        );
      }
    } catch (e) {
      emit(
        AddMatchFailure(
          error: AppError(messageKey: e.toString(), type: ErrorType.unknown),
        ),
      );
    }
  }

  Future<void> getPlayersList() async {
    try {
      final players = await addMatchRepo.getAllUsers();
      emit(state.copyWith(players: players));
    } catch (e) {
      emit(
        AddMatchFailure(
          error: AppError(messageKey: e.toString(), type: ErrorType.unknown),
        ),
      );
    }
  }
}

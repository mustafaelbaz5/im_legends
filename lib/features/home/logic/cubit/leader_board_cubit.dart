import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/players_states_model.dart';
import '../../data/repo/leader_board_repo.dart';

part 'leader_board_state.dart';

class LeaderBoardCubit extends Cubit<LeaderBoardState> {
  final LeaderBoardRepo repo;
  LeaderBoardCubit({required this.repo}) : super(LeaderBoardInitial());

  Future<void> loadLeaderboard() async {
    emit(LeaderBoardLoading());
    try {
      final leaderboard = await repo.calculateLeaderboard();
      emit(LeaderBoardSuccess(leaderboard));
    } catch (e) {
      emit(LeaderBoardFailure('Failed to load leaderboard: ${e.toString()}'));
    }
  }
}

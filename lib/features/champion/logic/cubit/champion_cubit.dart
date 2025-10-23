import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/champion_player_model.dart';
import '../../data/repo/champion_repo.dart';

part 'champion_state.dart';

class ChampionCubit extends Cubit<ChampionState> {
  final ChampionRepo repository;

  ChampionCubit({required this.repository}) : super(ChampionInitial());

  /// Fetch only the Top 3 champions
  Future<void> fetchTopThree() async {
    emit(ChampionLoading());
    try {
      final players = await repository.getTopThree();

      if (players.isEmpty) {
        emit(ChampionFailure("⚠️ No champions found"));
      } else {
        emit(ChampionSuccess(players));
      }
    } catch (e) {
      emit(ChampionFailure("❌ Failed to fetch champions: $e"));
    }
  }
}

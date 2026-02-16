import '../../../../core/models/players_states_model.dart';

abstract class HomeRepo {
  Future<List<PlayerStatsModel>> calculateLeaderboard();
}

import '../model/champion_player_model.dart';

abstract class ChampionRepo {
  Future<List<ChampionPlayerModel>> getLeaderboard();
}

import 'package:im_legends/features/champion/data/model/champion_player_model.dart';
import 'package:im_legends/features/champion/data/model/champion_stat_calculator.dart';
import 'package:im_legends/features/champion/data/remote/champion_remote_ds.dart';
import 'package:im_legends/features/champion/data/repo/champion_repo.dart';

class ChampionRepoImpl implements ChampionRepo {
  final ChampionRemoteDs championRemoteDs;
  final ChampionStatCalculator calculator;

  ChampionRepoImpl({required this.championRemoteDs, required this.calculator});

  @override
  Future<List<ChampionPlayerModel>> getLeaderboard() async {
    final users = await championRemoteDs.getUsers();
    final matches = await championRemoteDs.getMatches();

    return calculator.compute(users: users, matches: matches);
  }
}

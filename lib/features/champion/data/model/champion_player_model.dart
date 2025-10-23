import '../../../../core/models/players_states_model.dart';
import '../../../../core/models/user_data.dart';

class ChampionPlayerModel {
  final UserData user;
  final PlayerStatsModel stats;


  ChampionPlayerModel({
    required this.user,
    required this.stats,
  });

  ChampionPlayerModel copyWith({
    UserData? user,
    PlayerStatsModel? stats,
    int? rank,
  }) {
    return ChampionPlayerModel(
      user: user ?? this.user,
      stats: stats ?? this.stats,
    );
  }
}

import '../../../../core/models/players_states_model.dart';
import '../../../../core/models/user_data.dart';
import '../model/champion_player_model.dart';
import '../service/champion_service.dart';

class ChampionRepo {
  final ChampionService _championService;

  ChampionRepo({required ChampionService championService})
    : _championService = championService;

  /// Computes the Top 3 players based on matches and user stats
  Future<List<ChampionPlayerModel>> getTopThree() async {
    try {
      // Fetch raw data from Supabase
      final matches = await _championService.getMatches();
      final users = await _championService.getUsers();

      if (users.isEmpty) throw Exception('No users found');
      if (matches.isEmpty) throw Exception('No matches found');

      // Initialize stats for each user
      final Map<String, PlayerStatsModel> statsMap = {
        for (var u in users)
          u['id']: PlayerStatsModel(
            playerId: u['id'],
            playerName: u['name'],
            profileImage: u['profile_image'],
          ),
      };

      // --- Calculate stats from match results ---
      for (var match in matches) {
        final winnerId = match['winner_id'] as String;
        final loserId = match['loser_id'] as String;
        final winnerScore = match['winner_score'] as int;
        final loserScore = match['loser_score'] as int;

        final winner = statsMap[winnerId];
        final loser = statsMap[loserId];

        if (winner == null || loser == null) continue;

        //  Update winner
        statsMap[winnerId] = winner.copyWith(
          matchesPlayed: winner.matchesPlayed + 1,
          wins: winner.wins + 1,
          goalsScored: winner.goalsScored + winnerScore,
          goalsReceived: winner.goalsReceived + loserScore,
          goalDifference:
              (winner.goalsScored + winnerScore) -
              (winner.goalsReceived + loserScore),
          points: winner.points + 3,
        );

        //  Update loser
        statsMap[loserId] = loser.copyWith(
          matchesPlayed: loser.matchesPlayed + 1,
          losses: loser.losses + 1,
          goalsScored: loser.goalsScored + loserScore,
          goalsReceived: loser.goalsReceived + winnerScore,
          goalDifference:
              (loser.goalsScored + loserScore) -
              (loser.goalsReceived + winnerScore),
        );
      }

      // --- Sort leaderboard by football ranking logic ---
      final sorted = statsMap.values.toList()
        ..sort((a, b) {
          if (b.points != a.points) {
            return b.points.compareTo(a.points);
          } else if (b.goalDifference != a.goalDifference) {
            return b.goalDifference.compareTo(a.goalDifference);
          } else {
            return b.goalsScored.compareTo(a.goalsScored);
          }
        });

      // --- Build Top 3 players ---
      final topThree = <ChampionPlayerModel>[];
      for (int i = 0; i < sorted.length && i < 3; i++) {
        final stat = sorted[i];
        final userMap = users.firstWhere(
          (u) => u['id'] == stat.playerId,
          orElse: () => {},
        );

        if (userMap.isEmpty) continue;

        final user = UserData(
          name: userMap['name'] ?? '',
          email: '', // Not needed for champion screen
          phoneNumber: '',
          age: 0,
          profileImageUrl: userMap['profile_image'],
        );

        topThree.add(
          ChampionPlayerModel(
            user: user,
            stats: stat.copyWith(rank: i + 1),
          ),
        );
      }

      return topThree;
    } catch (e) {
      throw Exception('ChampionRepo Error: $e');
    }
  }
}

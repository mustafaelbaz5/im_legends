import '../../../../core/models/players_states_model.dart';
import '../service/leader_board_service.dart';

class LeaderBoardRepo {
  final LeaderboardService _leaderboardService;

  LeaderBoardRepo({required LeaderboardService leaderboardService})
    : _leaderboardService = leaderboardService;

  Future<List<PlayerStatsModel>> calculateLeaderboard() async {
    final matches = await _leaderboardService.fetchMatches();
    final users = await _leaderboardService.fetchUsers();

    final Map<String, PlayerStatsModel> stats = {
      for (var u in users)
        u['id']: PlayerStatsModel(
          playerId: u['id'],
          playerName: u['name'],
          profileImage: u['profile_image'],
        ),
    };

    for (var match in matches) {
      final winnerId = match['winner_id'] as String;
      final loserId = match['loser_id'] as String;
      final winnerScore = match['winner_score'] as int;
      final loserScore = match['loser_score'] as int;

      final winner = stats[winnerId]!;
      final loser = stats[loserId]!;

      // --- Update Winner Stats ---
      stats[winnerId] = winner.copyWith(
        matchesPlayed: winner.matchesPlayed + 1,
        wins: winner.wins + 1,
        goalsScored: winner.goalsScored + winnerScore,
        goalsReceived: winner.goalsReceived + loserScore,
        goalDifference:
            (winner.goalsScored + winnerScore) -
            (winner.goalsReceived + loserScore),
        points: winner.points + 3,
      );

      // --- Update Loser Stats ---
      stats[loserId] = loser.copyWith(
        matchesPlayed: loser.matchesPlayed + 1,
        losses: loser.losses + 1,
        goalsScored: loser.goalsScored + loserScore,
        goalsReceived: loser.goalsReceived + winnerScore,
        goalDifference:
            (loser.goalsScored + loserScore) -
            (loser.goalsReceived + winnerScore),
      );
    }
    final leaderboard = stats.values.toList()
      ..sort((a, b) {
        if (b.points != a.points) {
          return b.points.compareTo(a.points);
        } else if (b.goalDifference != a.goalDifference) {
          return b.goalDifference.compareTo(a.goalDifference);
        } else {
          return b.goalsScored.compareTo(a.goalsScored);
        }
      });

    // Assign ranks after sorting
    for (int i = 0; i < leaderboard.length; i++) {
      leaderboard[i] = leaderboard[i].copyWith(rank: i + 1);
    }

    return leaderboard;
  }
}

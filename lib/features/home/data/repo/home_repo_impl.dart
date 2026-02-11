import 'package:im_legends/core/models/players_states_model.dart';
import 'package:im_legends/features/home/data/remote/home_remote_ds.dart';
import 'package:im_legends/features/home/data/repo/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDs remoteDs;

  HomeRepoImpl({required this.remoteDs});

  @override
  Future<List<PlayerStatsModel>> calculateLeaderboard() async {
    final matches = await remoteDs.fetchMatches();
    final users = await remoteDs.fetchUsers();

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
      ..sort((final a, final b) {
        if (b.points != a.points) {
          return b.points.compareTo(a.points);
        } else if (b.goalDifference != a.goalDifference) {
          return b.goalDifference.compareTo(a.goalDifference);
        } else {
          return b.goalsScored.compareTo(a.goalsScored);
        }
      });

    for (int i = 0; i < leaderboard.length; i++) {
      leaderboard[i] = leaderboard[i].copyWith(rank: i + 1);
    }

    return leaderboard;
  }
}

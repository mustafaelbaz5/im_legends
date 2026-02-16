import 'champion_player_model.dart';

class ChampionStatCalculator {
  List<ChampionPlayerModel> compute({
    required final List<Map<String, dynamic>> users,
    required final List<Map<String, dynamic>> matches,
  }) {
    // ── Step 1: Initialize a stats accumulator per user ──
    final Map<String, ChampionStats> statsMap = {
      for (final u in users) u['id'] as String: const ChampionStats(),
    };

    // ── Step 2: Accumulate stats from each match ──
    for (final match in matches) {
      final winnerId = match['winner_id'] as String?;
      final loserId = match['loser_id'] as String?;
      final winnerScore = match['winner_score'] as int? ?? 0;
      final loserScore = match['loser_score'] as int? ?? 0;

      if (winnerId == null || loserId == null) continue;

      final winner = statsMap[winnerId];
      final loser = statsMap[loserId];

      if (winner == null || loser == null) continue;

      // Update winner
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

      // Update loser
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

    // ── Step 3: Sort by football ranking logic ──
    final sorted = statsMap.entries.toList()
      ..sort((final a, final b) {
        final sa = a.value;
        final sb = b.value;
        if (sb.points != sa.points) return sb.points.compareTo(sa.points);
        if (sb.goalDifference != sa.goalDifference) {
          return sb.goalDifference.compareTo(sa.goalDifference);
        }
        return sb.goalsScored.compareTo(sa.goalsScored);
      });

    // ── Step 4: Map to ChampionPlayerModel with rank ──
    final userById = {for (final u in users) u['id'] as String: u};

    return sorted.indexed.map((final entry) {
      final index = entry.$1;
      final userId = entry.$2.key;
      final stats = entry.$2.value;
      final user = userById[userId];

      return ChampionPlayerModel(
        id: userId,
        name: user?['name'] as String? ?? '',
        profileImageUrl: user?['profile_image'] as String?,
        stats: stats,
        rank: index + 1,
      );
    }).toList();
  }
}

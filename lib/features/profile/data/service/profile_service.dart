import '../../../../core/models/players_states_model.dart';
import '../../../../core/models/user_data.dart';
import '../../../../core/service/supa_base_service.dart';

class ProfileService {
  final SupaBaseService supabaseService = SupaBaseService();

  /// ✅ Fetch and calculate full player stats
  Future<PlayerStatsModel> fetchPlayerStats(String userId) async {
    try {
      // 1️⃣ Fetch all users (id, name, profile image)
      final users = await supabaseService.supabase
          .from('users')
          .select('id, name, profile_image');

      // 2️⃣ Fetch all matches
      final matches = await supabaseService.supabase
          .from('matches')
          .select('*');

      // 3️⃣ Initialize player stats for all users
      final Map<String, PlayerStatsModel> stats = {
        for (var u in users)
          u['id']: PlayerStatsModel(
            playerId: u['id'],
            playerName: u['name'] ?? 'Unknown',
            profileImage: u['profile_image'],
          ),
      };

      // 4️⃣ Loop through all matches and calculate
      for (var match in matches) {
        final winnerId = match['winner_id'] as String?;
        final loserId = match['loser_id'] as String?;
        final winnerScore = (match['winner_score'] ?? 0) as int;
        final loserScore = (match['loser_score'] ?? 0) as int;

        if (winnerId == null || loserId == null) continue;

        // 🏆 Winner stats
        final winner = stats[winnerId];
        if (winner != null) {
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
        }

        // ❌ Loser stats
        final loser = stats[loserId];
        if (loser != null) {
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
      }

      // 5️⃣ Sort all players to compute ranking
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

      // 6️⃣ Assign rank
      for (int i = 0; i < leaderboard.length; i++) {
        leaderboard[i] = leaderboard[i].copyWith(rank: i + 1);
      }

      // 7️⃣ Return this specific user's stats
      final playerStats = leaderboard.firstWhere(
        (p) => p.playerId == userId,
        orElse: () => PlayerStatsModel(
          playerId: userId,
          playerName: 'Unknown Player',
          profileImage: null,
        ),
      );

      return playerStats;
    } catch (e) {
      print("❌ Error calculating player stats: $e");
      rethrow;
    }
  }

  /// ✅ Fetch user base info
  Future<UserData> fetchUserData(String userId) async {
    try {
      final response = await supabaseService.supabase
          .from('users')
          .select()
          .eq('id', userId)
          .single();

      return UserData.fromMap(response);
    } catch (e) {
      print("❌ Error fetching user data: $e");
      rethrow;
    }
  }

  /// ✅ Logout current user
  Future<void> logout() async {
    try {
      await supabaseService.logoutUser();
      print("✅ User logged out successfully from ProfileService");
    } catch (e) {
      print("❌ Logout failed: $e");
      rethrow;
    }
  }
}

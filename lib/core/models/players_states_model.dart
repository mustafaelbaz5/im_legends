import 'package:im_legends/core/models/match_model.dart';

class PlayerStatsModel {
  final String playerId;
  final String playerName;
  final String? profileImage;

  final int matchesPlayed;
  final int wins;
  final int losses;
  final int goalsScored;
  final int goalsReceived;
  final int points;
  final int? rank;

  PlayerStatsModel({
    required this.playerId,
    required this.playerName,
    this.profileImage,
    this.matchesPlayed = 0,
    this.wins = 0,
    this.losses = 0,
    this.goalsScored = 0,
    this.goalsReceived = 0,
    this.points = 0,
    this.rank,
  });

  PlayerStatsModel copyWith({
    final String? playerId,
    final String? playerName,
    final String? profileImage,
    final int? matchesPlayed,
    final int? wins,
    final int? losses,
    final int? goalsScored,
    final int? goalsReceived,
    final int? points,
    final int? rank,
  }) {
    return PlayerStatsModel(
      playerId: playerId ?? this.playerId,
      playerName: playerName ?? this.playerName,
      profileImage: profileImage ?? this.profileImage,
      matchesPlayed: matchesPlayed ?? this.matchesPlayed,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      goalsScored: goalsScored ?? this.goalsScored,
      goalsReceived: goalsReceived ?? this.goalsReceived,
      points: points ?? this.points,
      rank: rank ?? this.rank,
    );
  }
}

/// Calculate player stats from matches
PlayerStatsModel calculateStats({
  required final String userId,
  required final String userName,
  required final String? profileImage,
  required final List<MatchModel> matches,
}) {
  final int matchesPlayed = matches.length;
  int wins = 0;
  int losses = 0;
  int goalsScored = 0;
  int goalsReceived = 0;

  for (final match in matches) {
    final isWinner = match.winnerId == userId;
    final isLoser = match.loserId == userId;

    if (isWinner) {
      wins++;
      goalsScored += match.winnerScore;
      goalsReceived += match.loserScore;
    } else if (isLoser) {
      losses++;
      goalsScored += match.loserScore;
      goalsReceived += match.winnerScore;
    }
  }

  // Calculate points (you can adjust this formula)
  // Example: 3 points per win, 0 per loss
  final points = wins * 3;

  return PlayerStatsModel(
    playerId: userId,
    playerName: userName,
    profileImage: profileImage,
    matchesPlayed: matchesPlayed,
    wins: wins,
    losses: losses,
    goalsScored: goalsScored,
    goalsReceived: goalsReceived,
    points: points,
    rank: null, // Will be calculated separately if needed
  );
}

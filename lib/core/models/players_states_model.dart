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

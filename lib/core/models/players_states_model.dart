class PlayerStatsModel {
  final String playerId;
  final String playerName;
  final String? profileImage;

  final int matchesPlayed;
  final int wins;
  final int losses;
  final int goalsScored;
  final int goalsReceived;
  final int goalDifference;
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
    this.goalDifference = 0,
    this.points = 0,
    this.rank,
  });

  PlayerStatsModel copyWith({
    String? playerId,
    String? playerName,
    String? profileImage,
    int? matchesPlayed,
    int? wins,
    int? losses,
    int? goalsScored,
    int? goalsReceived,
    int? goalDifference,
    int? points,
    int? rank,
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
      goalDifference: goalDifference ?? this.goalDifference,
      points: points ?? this.points,
      rank: rank ?? this.rank,
    );
  }
}

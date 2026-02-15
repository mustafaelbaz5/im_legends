class MatchModel {
  final String winnerId;
  final String loserId;
  final int winnerScore;
  final int loserScore;
  final DateTime createdAt;

  MatchModel({
    required this.winnerId,
    required this.loserId,
    required this.winnerScore,
    required this.loserScore,
    final DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert to JSON for Supabase insert
  Map<String, dynamic> toJson() {
    return {
      'winner_id': winnerId,
      'loser_id': loserId,
      'winner_score': winnerScore,
      'loser_score': loserScore,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // Factory to parse from Supabase
  factory MatchModel.fromJson(final Map<String, dynamic> json) {
    return MatchModel(
      winnerId: json['winner_id'] as String,
      loserId: json['loser_id'] as String,
      winnerScore: json['winner_score'] as int,
      loserScore: json['loser_score'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

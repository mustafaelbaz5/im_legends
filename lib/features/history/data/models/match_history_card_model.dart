class MatchHistoryCardModel {
  final String matchId;
  final String winnerName;
  final String loserName;
  final String winnerImage;
  final String loserImage;
  final int winnerScore;
  final int loserScore;
  final DateTime matchDate;

  MatchHistoryCardModel({
    required this.matchId,
    required this.winnerName,
    required this.loserName,
    required this.winnerImage,
    required this.loserImage,
    required this.winnerScore,
    required this.loserScore,
    required this.matchDate,
  });

  factory MatchHistoryCardModel.fromJson(final Map<String, dynamic> json) {
    return MatchHistoryCardModel(
      matchId: json['id'] as String,
      winnerName: json['winner']['name'] as String,
      loserName: json['loser']['name'] as String,
      winnerImage: json['winner']['profile_image'] as String? ?? '',
      loserImage: json['loser']['profile_image'] as String? ?? '',
      winnerScore: (json['winner_score'] as num).toInt(),
      loserScore: (json['loser_score'] as num).toInt(),
      matchDate: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': matchId,
      'winner_name': winnerName,
      'loser_name': loserName,
      'winner_image': winnerImage,
      'loser_image': loserImage,
      'winner_score': winnerScore,
      'loser_score': loserScore,
      'match_date': matchDate.toIso8601String(),
    };
  }

  MatchHistoryCardModel copyWith({
    final String? matchId,
    final String? winnerName,
    final String? loserName,
    final String? winnerImage,
    final String? loserImage,
    final int? winnerScore,
    final int? loserScore,
    final DateTime? matchDate,
  }) {
    return MatchHistoryCardModel(
      matchId: matchId ?? this.matchId,
      winnerName: winnerName ?? this.winnerName,
      loserName: loserName ?? this.loserName,
      winnerImage: winnerImage ?? this.winnerImage,
      loserImage: loserImage ?? this.loserImage,
      winnerScore: winnerScore ?? this.winnerScore,
      loserScore: loserScore ?? this.loserScore,
      matchDate: matchDate ?? this.matchDate,
    );
  }
}

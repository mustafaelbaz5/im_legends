import 'package:easy_localization/easy_localization.dart';

class ChampionPlayerModel {
  final String id;
  final String name;
  final String? profileImageUrl;
  final ChampionStats stats;
  final int rank;

  const ChampionPlayerModel({
    required this.id,
    required this.name,
    this.profileImageUrl,
    required this.stats,
    required this.rank,
  });

  ChampionPlayerModel copyWith({
    final String? id,
    final String? name,
    final String? profileImageUrl,
    final ChampionStats? stats,
    final int? rank,
  }) {
    return ChampionPlayerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      stats: stats ?? this.stats,
      rank: rank ?? this.rank,
    );
  }
}

class ChampionStats {
  final int matchesPlayed;
  final int wins;
  final int losses;
  final int goalsScored;
  final int goalsReceived;
  final int goalDifference;
  final int points;

  const ChampionStats({
    this.matchesPlayed = 0,
    this.wins = 0,
    this.losses = 0,
    this.goalsScored = 0,
    this.goalsReceived = 0,
    this.goalDifference = 0,
    this.points = 0,
  });

  ChampionStats copyWith({
    final int? matchesPlayed,
    final int? wins,
    final int? losses,
    final int? goalsScored,
    final int? goalsReceived,
    final int? goalDifference,
    final int? points,
  }) {
    return ChampionStats(
      matchesPlayed: matchesPlayed ?? this.matchesPlayed,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      goalsScored: goalsScored ?? this.goalsScored,
      goalsReceived: goalsReceived ?? this.goalsReceived,
      goalDifference: goalDifference ?? this.goalDifference,
      points: points ?? this.points,
    );
  }
}

enum StatCategory { topScorers, topWins, bestDefense }

extension StatCategoryExt on StatCategory {
  String get label {
    switch (this) {
      case StatCategory.topScorers:
        return 'championship.top_scores'.tr();
      case StatCategory.topWins:
        return 'championship.top_wins'.tr();
      case StatCategory.bestDefense:
        return 'championship.best_defense'.tr();
    }
  }

  String get statLabel {
    switch (this) {
      case StatCategory.topScorers:
        return 'Goals';
      case StatCategory.topWins:
        return 'Wins';
      case StatCategory.bestDefense:
        return 'GD';
    }
  }

  int statValue(final ChampionPlayerModel player) {
    switch (this) {
      case StatCategory.topScorers:
        return player.stats.goalsScored;
      case StatCategory.topWins:
        return player.stats.wins;
      case StatCategory.bestDefense:
        return player.stats.goalDifference;
    }
  }

  List<ChampionPlayerModel> sorted(final List<ChampionPlayerModel> players) {
    final list = [...players];
    if (this == StatCategory.bestDefense) {
      list.sort((final a, final b) => statValue(a).compareTo(statValue(b)));
    } else {
      list.sort((final a, final b) => statValue(b).compareTo(statValue(a)));
    }
    return list;
  }
}

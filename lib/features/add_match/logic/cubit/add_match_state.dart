part of 'add_match_cubit.dart';

@immutable
class AddMatchState {
  final int winnerScore;
  final int loserScore;
  final List players;

  // Add selected players
  final String? winnerId;
  final String? winnerName;
  final String? winnerImage;
  final String? loserId;
  final String? loserName;
  final String? loserImage;

  const AddMatchState({
    this.players = const [],
    this.winnerScore = 0,
    this.loserScore = 0,
    this.winnerId,
    this.winnerName,
    this.winnerImage,
    this.loserId,
    this.loserName,
    this.loserImage,
  });

  AddMatchState copyWith({
    final int? winnerScore,
    final int? loserScore,
    final List? players,
    final String? winnerId,
    final String? winnerName,
    final String? winnerImage,
    final String? loserId,
    final String? loserName,
    final String? loserImage,
  }) {
    return AddMatchState(
      winnerScore: winnerScore ?? this.winnerScore,
      loserScore: loserScore ?? this.loserScore,
      players: players ?? this.players,
      winnerId: winnerId ?? this.winnerId,
      winnerName: winnerName ?? this.winnerName,
      winnerImage: winnerImage ?? this.winnerImage,
      loserId: loserId ?? this.loserId,
      loserName: loserName ?? this.loserName,
      loserImage: loserImage ?? this.loserImage,
    );
  }
}

class AddMatchInitial extends AddMatchState {
  const AddMatchInitial() : super();
}

class AddMatchLoading extends AddMatchState {}

class AddMatchInsertSuccess extends AddMatchState {}


class AddMatchFailure extends AddMatchState {
  final AppError error;
  const AddMatchFailure({required this.error});
}

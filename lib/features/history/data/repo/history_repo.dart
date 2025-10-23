import '../models/match_history_card_model.dart';
import '../service/history_service.dart';

class HistoryRepo {
  final HistoryService historyService = HistoryService();

  Future<List<MatchHistoryCardModel>> fetchMatches() async {
    final matches = await historyService.fetchMatches();

    return matches.map((match) {
      return MatchHistoryCardModel(
        matchId: match['id'] as String,
        winnerName: match['winner']['name'] as String,
        loserName: match['loser']['name'] as String,
        winnerImage: match['winner']['profile_image'] as String? ?? '',
        loserImage: match['loser']['profile_image'] as String? ?? '',
        winnerScore: (match['winner_score'] as num).toInt(), // int
        loserScore: (match['loser_score'] as num).toInt(), //  int
        matchDate: DateTime.parse(match['created_at'] as String), //  DateTime
      );
    }).toList();
  }
}

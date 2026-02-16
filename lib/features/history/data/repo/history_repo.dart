import '../models/match_history_card_model.dart';

abstract class HistoryRepo {
  Future<List<MatchHistoryCardModel>> fetchMatches();
}

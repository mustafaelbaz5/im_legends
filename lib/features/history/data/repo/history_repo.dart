import 'package:im_legends/features/history/data/models/match_history_card_model.dart';

abstract class HistoryRepo {
  Future<List<MatchHistoryCardModel>> fetchMatches();
}

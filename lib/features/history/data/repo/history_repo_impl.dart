import 'package:im_legends/features/history/data/remote/history_remote_ds.dart';
import 'package:im_legends/features/history/data/repo/history_repo.dart';

import '../models/match_history_card_model.dart';

class HistoryRepoImpl implements HistoryRepo {
  final HistoryRemoteDs historyRemoteDs;

  HistoryRepoImpl({required this.historyRemoteDs});
  @override
  Future<List<MatchHistoryCardModel>> fetchMatches()async {
    return historyRemoteDs.fetchAllMatches();
  }
}

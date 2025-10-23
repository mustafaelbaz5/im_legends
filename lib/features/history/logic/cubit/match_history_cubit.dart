import 'package:bloc/bloc.dart';
import '../../data/models/match_history_card_model.dart';
import '../../data/repo/history_repo.dart';
import 'package:meta/meta.dart';

part 'match_history_state.dart';

class MatchHistoryCubit extends Cubit<MatchHistoryState> {
  MatchHistoryCubit() : super(MatchHistoryInitial());

  Future<void> getMatchHistory() async {
    emit(MatchHistoryLoading());
    try {
      final matches = await HistoryRepo().fetchMatches();
      emit(MatchHistorySuccess(matches: matches));
    } catch (e) {
      emit(MatchHistoryError(errorMessage: e.toString()));
    }
  }
}

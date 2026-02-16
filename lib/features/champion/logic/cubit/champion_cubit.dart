import 'package:bloc/bloc.dart';
import '../../../../core/error/models/app_error.dart';
import '../../data/model/champion_player_model.dart';
import '../../data/repo/champion_repo.dart';

part 'champion_state.dart';

class ChampionCubit extends Cubit<ChampionState> {
  final ChampionRepo championRepo;

  ChampionCubit({required this.championRepo}) : super(const ChampionInitial());

  Future<void> fetchLeaderboard() async {
    emit(const ChampionLoading());
    try {
      final players = await championRepo.getLeaderboard();

      if (players.isEmpty) {
        emit(const ChampionEmpty());
      } else {
        emit(ChampionSuccess(players));
      }
    } catch (error) {
      emit(
        ChampionFailure(error: error is AppError ? error : AppError.unknown()),
      );
    }
  }
}

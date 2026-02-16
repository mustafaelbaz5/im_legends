import 'package:bloc/bloc.dart';
import '../../../../core/error/models/app_error.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/players_states_model.dart';
import '../../data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo repo;
  HomeCubit({required this.repo}) : super(HomeInitial());

  Future<void> loadLeaderboard() async {
    emit(HomeLoading());
    try {
      final leaderboard = await repo.calculateLeaderboard();
      emit(HomeSuccess(leaderboard));
    } catch (error) {
      emit(HomeFailure(error: error is AppError ? error : AppError.unknown()));
    }
  }
}

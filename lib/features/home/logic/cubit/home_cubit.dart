import 'package:bloc/bloc.dart';
import 'package:im_legends/core/error/models/app_error.dart';
import 'package:im_legends/core/error/types/error_type.dart';
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
    } catch (e) {
      emit(
        HomeFailure(
          error: AppError(messageKey: e.toString(), type: ErrorType.unknown),
        ),
      );
    }
  }
}

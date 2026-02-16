import '../../../../core/models/match_model.dart';

abstract class AddMatchRepo {
  Future<List<Map<String, dynamic>>> getAllUsers();
  Future<bool> insertMatch(final MatchModel match);
}

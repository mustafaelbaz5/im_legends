import '../../../../core/models/match_model.dart';
import '../remote/add_match_remote_ds.dart';
import 'add_match_repo.dart';

class AddMatchRepoImpl implements AddMatchRepo {
  final AddMatchRemoteDs addMatchService;

  AddMatchRepoImpl({required this.addMatchService});

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final users = await addMatchService.fetchAllUsers();
      return users;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> insertMatch(final MatchModel match) async {
    try {
      return await addMatchService.insertMatch(match);
    } catch (e) {
      rethrow;
    }
  }
}

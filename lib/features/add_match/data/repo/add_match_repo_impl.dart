import 'package:im_legends/features/add_match/data/models/match_model.dart';
import 'package:im_legends/features/add_match/data/remote/add_match_remote_ds.dart';
import 'package:im_legends/features/add_match/data/repo/add_match_repo.dart';

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

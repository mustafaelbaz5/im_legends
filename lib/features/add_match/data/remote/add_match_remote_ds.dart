import 'package:im_legends/core/error/types/error_handler.dart';
import 'package:im_legends/core/networking/supabase_service.dart';
import 'package:im_legends/core/models/match_model.dart';

class AddMatchRemoteDs {
  final SupabaseService supabaseService;

  AddMatchRemoteDs({required this.supabaseService});
  Future<List<Map<String, dynamic>>> fetchAllUsers() async {
    try {
      final response = await supabaseService.client
          .from('users')
          .select('id, name, profile_image')
          .order('name', ascending: true);

      return response
          .map(
            (final user) => {
              'id': user['id'] as String,
              'name': user['name'] as String,
              'profile_image': user['profile_image'] as String?,
            },
          )
          .toList();
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  Future<bool> insertMatch(final MatchModel match) async {
    try {
      await supabaseService.client
          .from('matches')
          .insert(match.toJson())
          .select();

      return true;
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }
}

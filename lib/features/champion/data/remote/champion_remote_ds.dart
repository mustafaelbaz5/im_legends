import '../../../../core/error/types/error_handler.dart';
import '../../../../core/networking/supabase_service.dart';

class ChampionRemoteDs {
  final SupabaseService subbaseService;

  ChampionRemoteDs({required this.subbaseService});
  Future<List<Map<String, dynamic>>> getMatches() async {
    try {
      final response = await subbaseService.client
          .from('matches')
          .select('winner_id, loser_id, winner_score, loser_score');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final response = await subbaseService.client
          .from('users')
          .select('id, name, profile_image');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('ChampionService: Failed to fetch users → $e');
    }
  }
}

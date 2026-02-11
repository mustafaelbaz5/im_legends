import 'package:im_legends/core/networking/supabase_service.dart';

class HomeRemoteDs {
  final SupabaseService supabaseService;

  HomeRemoteDs({required this.supabaseService});

  Future<List<Map<String, dynamic>>> fetchMatches() async {
    try {
      final response = await supabaseService.client.from('matches').select('*');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch matches: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final response = await supabaseService.client
        .from('users')
        .select('id, name, profile_image');
    return response;
  }
}

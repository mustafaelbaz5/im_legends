import 'package:supabase_flutter/supabase_flutter.dart';

class ChampionService {
  final SupabaseClient _supabase;

  ChampionService({SupabaseClient? client})
    : _supabase = client ?? Supabase.instance.client;

  /// Fetch all matches from Supabase
  Future<List<Map<String, dynamic>>> getMatches() async {
    try {
      final response = await _supabase.from('matches').select('*');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Failed to fetch matches: $e');
    }
  }

  /// Fetch all users (limited fields)
  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final response = await _supabase
          .from('users')
          .select('id, name, profile_image');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}

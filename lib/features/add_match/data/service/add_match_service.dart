import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/match_model.dart';

class AddMatchService {
  final supabase = Supabase.instance.client;

  // Fetch all users' IDs, names, and profile images
  Future<List<Map<String, dynamic>>> fetchAllUsers() async {
    try {
      final response = await supabase
          .from('users')
          .select('id, name, profile_image')
          .order('name', ascending: true);

      return response
          .map(
            (user) => {
              'id': user['id'] as String,
              'name': user['name'] as String,
              'profile_image': user['profile_image'] as String?,
            },
          )
          .toList();
    } catch (e) {
      debugPrint("❌ Error fetching all users: $e");
      return [];
    }
  }

  // Insert new match into Supabase
  Future<bool> insertMatch(MatchModel match) async {
    try {
      final response = await supabase
          .from('matches')
          .insert(match.toJson())
          .select();

      debugPrint("✅ Match inserted: $response");
      return true;
    } catch (e) {
      debugPrint("❌ Error inserting match: $e");
      return false;
    }
  }
}

import 'package:flutter/foundation.dart';
import 'supa_base_service.dart';

class TokenService extends SupaBaseService {
  Future<void> saveToken(String userId, String token) async {
    final existing = await supabase
        .from('user_tokens')
        .select('token')
        .eq('user_id', userId)
        .eq('token', token);

    if (existing.isEmpty) {
      await supabase.from('user_tokens').insert({
        'user_id': userId,
        'token': token,
        'created_at': DateTime.now().toIso8601String(),
      });
      debugPrint('✅ New token saved');
    } else {
      await supabase
          .from('user_tokens')
          .update({'updated_at': DateTime.now().toIso8601String()})
          .eq('user_id', userId)
          .eq('token', token);
      debugPrint('✅ Token updated');
    }
  }

  Future<List<String>> getTokens(String userId) async {
    final res = await supabase
        .from('user_tokens')
        .select('token')
        .eq('user_id', userId);
    return List<String>.from(res.map((t) => t['token'] as String));
  }

  Future<void> removeToken(String userId, String token) async {
    await supabase
        .from('user_tokens')
        .delete()
        .eq('user_id', userId)
        .eq('token', token);
  }

  Future<void> removeAllTokens(String userId) async {
    await supabase.from('user_tokens').delete().eq('user_id', userId);
  }
}

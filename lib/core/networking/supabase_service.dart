import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseClient get client => Supabase.instance.client;

  Future<void> signOut() => client.auth.signOut();

  User? get currentUser => client.auth.currentUser;
}

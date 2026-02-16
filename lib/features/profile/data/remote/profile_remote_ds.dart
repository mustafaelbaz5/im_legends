import 'dart:io';

import '../../../../core/config/app_constants.dart';
import '../../../../core/error/types/error_handler.dart';
import '../../../../core/models/match_model.dart';
import '../../../../core/models/user_data.dart';
import '../../../../core/networking/storage_remote_ds.dart';
import '../../../../core/networking/supabase_service.dart';
import '../../../../core/service/secure_storage.dart';

class ProfileRemoteDs {
  final SupabaseService supabaseService;
  final StorageRemoteDs storageRemoteDS;
  final SecureStorage secureStorage;

  ProfileRemoteDs({
    required this.supabaseService,
    required this.storageRemoteDS,
    required this.secureStorage,
  });

  /// Get current user ID
  String? get currentUserId => supabaseService.client.auth.currentUser?.id;

  /// Fetch current user data
  Future<UserData?> getCurrentUserData() async {
    try {
      if (currentUserId == null) return null;

      final response = await supabaseService.client
          .from('users')
          .select()
          .eq('id', currentUserId!)
          .single();

      return UserData.fromMap(response);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  /// Fetch all matches for current user
  Future<List<MatchModel>> getAllUserMatches() async {
    try {
      if (currentUserId == null) return [];

      final response = await supabaseService.client
          .from('matches')
          .select()
          .or('winner_id.eq.$currentUserId,loser_id.eq.$currentUserId');

      return (response as List)
          .map((final e) => MatchModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  /// Uploads a profile image and updates the user's record in one step
  Future<String?> uploadAndSetProfileImage(final File imageFile) async {
    try {
      return await storageRemoteDS.uploadAndSetProfileImage(
        currentUserId!,
        imageFile,
      );
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      await supabaseService.signOut();
      await secureStorage.delete(key: AppConstants.userIdKey);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }
}

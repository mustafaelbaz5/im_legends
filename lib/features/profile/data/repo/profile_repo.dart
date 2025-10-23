import '../../../../core/utils/secure_storage.dart';
import '../model/profile_model.dart';

import '../service/profile_service.dart';

class ProfileRepo {
  final ProfileService profileService;
  final SecureStorage secureStorage = SecureStorage();

  ProfileRepo({required this.profileService});

  /// Get full profile data + stats
  Future<UserProfileModel?> getProfileWithStats() async {
    final userId = await secureStorage.getUserId();

    if (userId == null || userId.isEmpty) {
      throw Exception("User ID not found in secure storage");
    }

    try {
      final user = await profileService.fetchUserData(userId);
      final stats = await profileService.fetchPlayerStats(userId);

      return UserProfileModel(user: user, stats: stats);
    } catch (e) {
      print("❌ Error fetching profile with stats: $e");
      return null;
    }
  }

  /// Logout user: clears secure storage + Supabase session
  Future<void> logout() async {
    await secureStorage.clearToken();
    await profileService.logout();
  }
}

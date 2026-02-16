import 'dart:io';

import '../../../../core/models/players_states_model.dart';
import '../../../../core/models/user_data.dart';
import '../model/profile_model.dart';
import '../remote/profile_remote_ds.dart';
import 'profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDs profileRemoteDs;

  ProfileRepoImpl({required this.profileRemoteDs});

  @override
  Future<UserData?> getCurrentUserData() async {
    return await profileRemoteDs.getCurrentUserData();
  }

  @override
  Future<UserProfileModel?> getProfileWithStats() async {
    try {
      // 1. Fetch user data
      final userData = await profileRemoteDs.getCurrentUserData();
      if (userData == null) return null;

      // 2. Fetch all user matches
      final matches = await profileRemoteDs.getAllUserMatches();

      // 3. Calculate stats from matches
      final stats = calculateStats(
        userId: profileRemoteDs.currentUserId!,
        userName: userData.name,
        profileImage: userData.profileImageUrl,
        matches: matches,
      );

      // 6. Return combined profile model
      return UserProfileModel(user: userData, stats: stats);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await profileRemoteDs.logout();
  }

  @override
  Future<String?> uploadAndSetProfileImage(final File imageFile) async {
    return await profileRemoteDs.uploadAndSetProfileImage(imageFile);
  }
}

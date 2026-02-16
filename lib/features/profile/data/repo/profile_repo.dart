import 'dart:io';

import '../../../../core/models/user_data.dart';
import '../model/profile_model.dart';

abstract class ProfileRepo {
  /// Fetch current user data
  Future<UserData?> getCurrentUserData();

  /// Fetch user profile with calculated stats
  Future<UserProfileModel?> getProfileWithStats();

  /// Uploads a profile image and updates the user's record in one step
  Future<String?> uploadAndSetProfileImage(final File imageFile);

  /// Logout user
  Future<void> logout();
}

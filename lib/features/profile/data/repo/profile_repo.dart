import 'dart:io';

import 'package:im_legends/core/models/user_data.dart';
import 'package:im_legends/features/profile/data/model/profile_model.dart';

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

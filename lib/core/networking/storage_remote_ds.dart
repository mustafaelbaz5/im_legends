import 'dart:io';

import 'package:im_legends/core/error/types/error_handler.dart';
import 'package:im_legends/core/networking/supabase_service.dart';

class StorageRemoteDs {
  final SupabaseService supabaseService;

  StorageRemoteDs({required this.supabaseService});

  /// Uploads a profile image to Supabase Storage and returns its public URL.
  Future<String?> uploadProfileImage(
    final File imageFile,
    final String userId,
  ) async {
    final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = '$userId/$fileName';

    try {
      // Upload the file
      await supabaseService.client.storage
          .from('profile_images')
          .upload(filePath, imageFile);

      // Return the public URL
      return supabaseService.client.storage
          .from('profile_images')
          .getPublicUrl(filePath);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  /// Updates the user's profile image URL in the database
  Future<void> updateUserProfileImage(
    final String userId,
    final String imageUrl,
  ) async {
    try {
      await supabaseService.client
          .from('users')
          .update({'profile_image': imageUrl})
          .eq('id', userId);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  /// Deletes a profile image from Supabase Storage
  Future<void> deleteProfileImage(final String filePath) async {
    try {
      await supabaseService.client.storage.from('profile_images').remove([
        filePath,
      ]);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  /// Uploads a new profile image and updates the user's record in one step
  Future<String?> uploadAndSetProfileImage(
    final String userId,
    final File imageFile,
  ) async {
    try {
      // 1️⃣ Upload image and get public URL
      final imageUrl = await uploadProfileImage(imageFile, userId);
      if (imageUrl == null) return null;

      // 2️⃣ Update DB
      await updateUserProfileImage(userId, imageUrl);

      return imageUrl;
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }
}

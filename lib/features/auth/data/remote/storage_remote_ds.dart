import 'dart:io';

import 'package:im_legends/core/error/types/error_handler.dart';
import 'package:im_legends/core/networking/supabase_service.dart';

class StorageRemoteDS {
  final SupabaseService supabaseService;

  StorageRemoteDS({required this.supabaseService});

  /// Upload profile image to storage
  Future<String?> uploadProfileImage(
    final File imageFile,
    final String userId,
  ) async {
    final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = '$userId/$fileName';

    try {
      await supabaseService.client.storage
          .from('profile_images')
          .upload(filePath, imageFile);
      return supabaseService.client.storage
          .from('profile_images')
          .getPublicUrl(filePath);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  /// Update user's profile image URL in DB
  Future<void> updateUserProfileImage(
    final String uid,
    final String imageUrl,
  ) async {
    try {
      await supabaseService.client
          .from('users')
          .update({'profile_image_url': imageUrl})
          .eq('id', uid);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  /// Delete profile image from storage
  Future<void> deleteProfileImage(final String filePath) async {
    try {
      await supabaseService.client.storage.from('profile_images').remove([
        filePath,
      ]);
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }

  /// Upload & update DB in one step
  Future<String?> uploadAndSetProfileImage(
    final String uid,
    final File imageFile,
  ) async {
    final url = await uploadProfileImage(imageFile, uid);
    if (url != null) await updateUserProfileImage(uid, url);
    return url;
  }
}

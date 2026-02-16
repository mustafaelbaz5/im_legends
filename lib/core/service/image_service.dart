import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageService {
  final _supabase = Supabase.instance.client;
  Future<String> uploadProfileImage(File imageFile, String userId) async {
    final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = '$userId/$fileName';

    try {
      await _supabase.storage
          .from('profile_images')
          .upload(filePath, imageFile);
      final publicUrl = _supabase.storage
          .from('profile_images')
          .getPublicUrl(filePath);
      debugPrint('✅ Profile image uploaded successfully: $publicUrl');
      return publicUrl;
    } on StorageException catch (e) {
      debugPrint("❌ Failed to upload profile image: ${e.message}");
      throw Exception('Failed to upload profile image: ${e.message}');
    } catch (e) {
      debugPrint("❌ Unexpected error while uploading profile image: $e");
      throw Exception('Unexpected error while uploading profile image: $e');
    }
  }

  Future<void> deleteProfileImage(String filePath) async {
    try {
      await _supabase.storage.from('profile_images').remove([filePath]);
      debugPrint('✅ Profile image deleted successfully: $filePath');
    } on StorageException catch (e) {
      debugPrint("❌ Failed to delete profile image: ${e.message}");
      throw Exception('Failed to delete profile image: ${e.message}');
    } catch (e) {
      debugPrint("❌ Unexpected error while deleting profile image: $e");
      throw Exception('Unexpected error while deleting profile image: $e');
    }
  }
}

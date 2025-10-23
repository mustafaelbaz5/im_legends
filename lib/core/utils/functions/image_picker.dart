import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<File?> showImageSourceActionSheet(BuildContext context) async {
    return showModalBottomSheet<File?>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: Colors.blueAccent,
                  ),
                  title: const Text('Choose from Gallery'),
                  onTap: () async {
                    Navigator.pop(
                      context,
                      await _pickImageFromSource(ImageSource.gallery),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt,
                    color: Colors.blueAccent,
                  ),
                  title: const Text('Take a Photo'),
                  onTap: () async {
                    Navigator.pop(
                      context,
                      await _pickImageFromSource(ImageSource.camera),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Handles picking image from camera or gallery
  static Future<File?> _pickImageFromSource(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 75);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}

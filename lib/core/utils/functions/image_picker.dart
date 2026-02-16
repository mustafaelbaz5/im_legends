import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../themes/app_texts_style.dart';
import '../extensions/context_extensions.dart';
import '../spacing.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<File?> showImageSourceActionSheet(
    final BuildContext context,
  ) async {
    return showModalBottomSheet<File?>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(responsiveRadius(24)),
        ),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: responsiveHeight(24),
              horizontal: responsiveWidth(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.photo_library,
                    color: context.customColors.accentBlue,
                  ),
                  title: Text(
                    'image_picker.choose_from_gallery'.tr(),
                    style: AppTextStyles.font16Regular,
                  ),
                  onTap: () async {
                    Navigator.pop(
                      context,
                      await _pickImageFromSource(ImageSource.gallery),
                    );
                  },
                ),
                verticalSpacing(12),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: context.customColors.accentBlue,
                  ),
                  title: Text(
                    'image_picker.take_photo'.tr(),
                    style: AppTextStyles.font16Regular,
                  ),
                  onTap: () async {
                    Navigator.pop(
                      context,
                      await _pickImageFromSource(ImageSource.camera),
                    );
                  },
                ),
                verticalSpacing(12),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Handles picking image from camera or gallery
  static Future<File?> _pickImageFromSource(final ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 75);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/functions/image_picker.dart';
import '../../../../core/utils/spacing.dart';

class UploadImageField extends StatefulWidget {
  final Function(File? image)? onImageSelected;

  const UploadImageField({super.key, this.onImageSelected});

  @override
  State<UploadImageField> createState() => _UploadImageFieldState();
}

class _UploadImageFieldState extends State<UploadImageField> {
  File? _profileImage;

  Future<void> _pickImage() async {
    try {
      final pickedImage = await ImagePickerHelper.showImageSourceActionSheet(
        context,
      );
      if (pickedImage != null) {
        setState(() {
          _profileImage = pickedImage;
        });
        widget.onImageSelected?.call(pickedImage);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to pick image. Please try again.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Semantics(
            label: 'Upload profile image',
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 48.r,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : null,
                  child: _profileImage == null
                      ? Icon(
                          Icons.person,
                          size: 48.r,
                          color: Theme.of(context).colorScheme.onSurface
                              .withAlpha((0.4 * 255).toInt()),
                        )
                      : null,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.surface,
                      width: 2.w,
                    ),
                  ),
                  padding: EdgeInsets.all(6.r),
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 16.r,
                  ),
                ),
              ],
            ),
          ),
        ),
        verticalSpacing(12),

        // Subtle secondary button
        TextButton.icon(
          onPressed: _pickImage,
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          icon: const Icon(Icons.upload, size: 18),
          label: const Text(
            'Upload Profile Image',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

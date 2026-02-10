import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/themes/app_colors.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';
import 'package:im_legends/core/widgets/custom_icon_bottom.dart';

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
  Widget build(final BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Semantics(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: responsiveRadius(60),
                  backgroundColor: context.customColors.border.withValues(
                    alpha: 0.3,
                  ),
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : null,
                  child: _profileImage == null
                      ? Icon(
                          Icons.person,
                          size: responsiveRadius(60),
                          color: context.customColors.accentBlue,
                        )
                      : null,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: context.customColors.textPrimary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.customColors.background,
                      width: 2.w,
                    ),
                  ),
                  padding: EdgeInsets.all(responsiveRadius(6)),
                  child: Icon(
                    Icons.edit,
                    color: context.customColors.background,
                    size: responsiveRadius(16),
                  ),
                ),
              ],
            ),
          ),
        ),
        verticalSpacing(12),

        // Subtle secondary button
        CustomIconBottom(
          icon: Icons.upload,
          onPressed: _pickImage,
          label: 'image_picker.upload_image'.tr(),
          labelStyle: AppTextStyles.font12Regular.copyWith(
            color: AppColors.primary300,
          ),
          iconColor: AppColors.primary300,
        ),
      ],
    );
  }
}

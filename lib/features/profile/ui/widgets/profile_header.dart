import 'package:flutter/material.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';
import 'package:im_legends/core/utils/spacing.dart';
import 'package:im_legends/features/profile/ui/widgets/profile_image_avatar.dart';
import 'package:im_legends/features/profile/ui/widgets/profile_top_bar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.name, this.imageUrl});

  final String name;
  final String? imageUrl;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: responsiveHeight(350),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const ProfileTopBar(),
          Positioned(
            top: responsiveHeight(190),
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: context.customColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(responsiveRadius(24)),
                  topRight: Radius.circular(responsiveRadius(24)),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: responsiveHeight(90),
                  left: responsiveWidth(24),
                  right: responsiveWidth(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    verticalSpacing(16),
                    Text(
                      name,
                      style: AppTextStyles.font20Bold.copyWith(
                        color: context.customColors.textPrimary,
                      ),
                    ),

                    verticalSpacing(16),
                  ],
                ),
              ),
            ),
          ),

          /// Floating Avatar
          Positioned(
            top: responsiveHeight(140),
            left: 0,
            right: 0,
            child: Center(
              child: ProfileImageAvatar(
                profileImageUrl: imageUrl ?? '',
                onEditTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

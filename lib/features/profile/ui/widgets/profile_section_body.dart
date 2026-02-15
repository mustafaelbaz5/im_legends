import 'package:flutter/material.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';

import '../../../../../../core/utils/spacing.dart';

class ProfileSectionBody extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const ProfileSectionBody({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
              responsiveWidth(20),
              responsiveHeight(20),
              responsiveWidth(20),
              responsiveHeight(12),
            ),
            child: Text(
              title,
              style: AppTextStyles.font16Bold.copyWith(
                color: context.customColors.textPrimary,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }
}

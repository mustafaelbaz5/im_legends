import 'package:flutter/material.dart';
import '../../../../../core/themes/app_texts_style.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/spacing.dart';

class ThemeOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemeOption({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(responsiveRadius(12)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: responsiveWidth(16),
          vertical: responsiveHeight(18),
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? context.customColors.scaffoldBackground
              : Colors.transparent,
          borderRadius: BorderRadius.circular(responsiveRadius(12)),
          border: Border.all(
            color: isSelected
                ? context.customColors.accentBlue
                : context.customColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: isSelected
                  ? context.customColors.accentBlue
                  : context.customColors.border,
              size: responsiveFontSize(20),
            ),
            horizontalSpacing(12),
            Text(
              title,
              style: AppTextStyles.font14Regular.copyWith(
                color: isSelected
                    ? context.customColors.accentBlue
                    : context.customColors.textSecondary,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: context.customColors.accentBlue,
                size: responsiveFontSize(20),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../themes/app_texts_style.dart';
import '../../utils/extensions/context_extensions.dart';

import '../../utils/spacing.dart';
import '../../widgets/custom_text_button.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String message;
  final String primaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;
  final IconData? icon;
  final Color? iconColor;

  const CustomDialog({
    super.key,
    this.title,
    required this.message,
    required this.primaryButtonText,
    this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(final BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: responsiveWidth(32)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsiveRadius(16)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: responsiveWidth(24),
          vertical: responsiveHeight(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Container(
                padding: EdgeInsets.all(responsiveRadius(24)),
                decoration: BoxDecoration(
                  color: (iconColor ?? context.customColors.surfaceVariant)
                      .withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: responsiveFontSize(32),
                  color: iconColor ?? context.customColors.surfaceVariant,
                ),
              ),
              verticalSpacing(8),
            ],
            if (title != null) ...[
              Text(
                title!,
                textAlign: TextAlign.center,
                style: AppTextStyles.fontBold.copyWith(
                  fontSize: responsiveFontSize(20),
                  color: context.customColors.textPrimary,
                ),
              ),
              verticalSpacing(8),
            ],
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.font14Regular.copyWith(
                color: context.customColors.textSecondary,
              ),
            ),
            verticalSpacing(16),
            Row(
              children: [
                if (secondaryButtonText != null)
                  Expanded(
                    child: CustomTextButton(
                      text: secondaryButtonText!,
                      textStyle: AppTextStyles.font14SemiBold,
                      size: CustomButtonSize.small,
                      style: CustomButtonStyle.outlined,
                      onPressed: () {
                        context.pop();
                        onSecondaryPressed?.call();
                      },
                    ),
                  ),
                if (secondaryButtonText != null) horizontalSpacing(8),
                Expanded(
                  child: CustomTextButton(
                    text: primaryButtonText,
                    textStyle: AppTextStyles.font14SemiBold,
                    size: CustomButtonSize.small,
                    onPressed: () {
                      context.pop();
                      onPrimaryPressed?.call();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

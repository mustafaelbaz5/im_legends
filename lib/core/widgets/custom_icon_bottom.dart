import 'package:flutter/material.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';
import 'package:im_legends/core/utils/spacing.dart';

class CustomIconBottom extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String? label;
  final String? tooltip;

  const CustomIconBottom({
    super.key,
    required this.icon,
    required this.onPressed,
    this.label,
    this.tooltip,
  });

  bool get _hasLabel => label != null;

  @override
  Widget build(final BuildContext context) {
    final borderRadius = BorderRadius.circular(responsiveRadius(12));
    final backgroundColor = context.customColors.divider.withValues(alpha: 0.5);

    final Widget button = Material(
      color: backgroundColor,
      borderRadius: borderRadius,
      elevation: 0,
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: label == null
                ? responsiveWidth(10)
                : responsiveWidth(12),
            vertical: 8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: responsiveFontSize(20),
                color: context.customColors.textSecondary,
              ),
              if (_hasLabel) ...[
                horizontalSpacing(6),
                Text(
                  label!,
                  style: AppTextStyles.font16Bold.copyWith(
                    color: context.customColors.textPrimary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );

    if (tooltip == null) return button;

    return Tooltip(message: tooltip!, child: button);
  }
}

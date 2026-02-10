import 'package:flutter/material.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';

import '../themes/app_colors.dart';

import '../utils/spacing.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style = CustomButtonStyle.filled,
    this.size = CustomButtonSize.medium,
    this.textStyle,
    this.foregroundColor,
    this.backgroundColor,
    this.borderColor,
    this.prefixIcon,
    this.suffixIcon,
    this.isLoading = false,
    this.isDisabled = false,
    this.borderRadius,
    this.contentPadding,
  });

  final String text;
  final VoidCallback? onPressed;

  final CustomButtonStyle style;
  final CustomButtonSize size;

  final TextStyle? textStyle;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool isLoading;
  final bool isDisabled;

  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  bool get _enabled => onPressed != null && !isLoading && !isDisabled;

  @override
  Widget build(final BuildContext context) {
    final colors = context.customColors;

    // Resolve base colors based on style
    late Color baseBackground;
    late Color baseForeground;
    late Color baseBorder;

    switch (style) {
      case CustomButtonStyle.filled:
        baseBackground = backgroundColor ?? AppColors.primary300;
        baseForeground = foregroundColor ?? Colors.white;
        baseBorder = Colors.transparent;
        break;
      case CustomButtonStyle.outlined:
        baseBackground = Colors.transparent;
        baseForeground = foregroundColor ?? AppColors.primary300;
        baseBorder = borderColor ?? AppColors.primary300;
        break;
      case CustomButtonStyle.soft:
        baseBackground = backgroundColor ?? colors.surfaceVariant;
        baseForeground = foregroundColor ?? colors.textPrimary;
        baseBorder = Colors.transparent;
        break;
    }

    // Apply disabled opacity
    final Color resolvedBackground = _enabled
        ? baseBackground
        : baseBackground.withValues(alpha: 0.3);

    final Color resolvedForeground = _enabled
        ? baseForeground
        : baseForeground.withValues(alpha: 0.6);

    final Color resolvedBorder = _enabled
        ? baseBorder
        : baseBorder.withValues(alpha: 0.4);

    // Button height by size
    final double height = switch (size) {
      CustomButtonSize.large => responsiveHeight(56),
      CustomButtonSize.small => responsiveHeight(40),
      CustomButtonSize.medium => responsiveHeight(52),
    };

    // Base text style (from app theme)
    final TextStyle baseTextStyle =
        textStyle ??
        (size == CustomButtonSize.small
            ? AppTextStyles.font14Bold
            : AppTextStyles.font16Bold);

    // Only override color if user didn't explicitly set one
    final TextStyle effectiveTextStyle = baseTextStyle.color == null
        ? baseTextStyle.copyWith(color: resolvedForeground)
        : baseTextStyle;

    // Icon size
    final double iconSize = size == CustomButtonSize.small
        ? responsiveRadius(18)
        : responsiveRadius(20);

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _enabled ? onPressed : null,
        style:
            ElevatedButton.styleFrom(
              backgroundColor: resolvedBackground,
              foregroundColor: resolvedForeground,
              disabledBackgroundColor: colors.surfaceVariant,
              disabledForegroundColor: colors.textSecondary,
              elevation: 0,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              padding:
                  contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: responsiveWidth(24),
                    vertical: responsiveHeight(12),
                  ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  borderRadius ?? responsiveRadius(12),
                ),
                side: style == CustomButtonStyle.outlined
                    ? BorderSide(
                        color: resolvedBorder,
                        width: responsiveWidth(1.5),
                      )
                    : BorderSide.none,
              ),
            ).copyWith(
              overlayColor: WidgetStateProperty.all(
                resolvedForeground.withValues(alpha: 0.12),
              ),
            ),
        child: isLoading
            ? SizedBox(
                width: responsiveWidth(24),
                height: responsiveHeight(24),
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    effectiveTextStyle.color ?? resolvedForeground,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    IconTheme(
                      data: IconThemeData(
                        size: iconSize,
                        color: effectiveTextStyle.color ?? resolvedForeground,
                      ),
                      child: prefixIcon!,
                    ),
                    horizontalSpacing(8),
                  ],
                  Flexible(
                    child: Text(
                      text,
                      style: effectiveTextStyle,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    horizontalSpacing(8),
                    IconTheme(
                      data: IconThemeData(
                        size: iconSize,
                        color: effectiveTextStyle.color ?? resolvedForeground,
                      ),
                      child: suffixIcon!,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}

enum CustomButtonStyle { filled, outlined, soft }

enum CustomButtonSize { small, medium, large }

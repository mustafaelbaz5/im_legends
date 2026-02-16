import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_texts_style.dart';
import '../utils/extensions/context_extensions.dart';

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

    /// --- Resolve base colors for the button based on style ---
    final Color baseBackground;
    final Color baseForeground;
    final Color baseBorder;

    switch (style) {
      case CustomButtonStyle.filled:
        baseBackground = backgroundColor ?? AppColors.primary300;
        baseForeground = foregroundColor ?? AppColors.grey0;
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

    /// --- Adjust colors if disabled ---
    final Color resolvedBackground = _enabled
        ? baseBackground
        : baseBackground.withValues(alpha: .1);
    final Color resolvedForeground = _enabled
        ? baseForeground
        : baseForeground.withValues(alpha: .6);
    final Color resolvedBorder = _enabled
        ? baseBorder
        : baseBorder.withValues(alpha: .4);

    /// --- Determine base text style ---
    final TextStyle baseTextStyle =
        textStyle ??
        (size == CustomButtonSize.small
            ? AppTextStyles.font14Bold
            : size == CustomButtonSize.medium
            ? AppTextStyles.font16Bold
            : AppTextStyles.font18Bold);

    final TextStyle effectiveTextStyle = baseTextStyle.copyWith(
      color: resolvedForeground,
    );

    final double iconSize = size == CustomButtonSize.small
        ? responsiveRadius(18)
        : size == CustomButtonSize.medium
        ? responsiveRadius(20)
        : responsiveRadius(22);

    return ElevatedButton(
      onPressed: _enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: resolvedBackground,
        foregroundColor: resolvedForeground,
        disabledBackgroundColor: resolvedBackground,
        disabledForegroundColor: resolvedForeground,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        padding:
            contentPadding ??
            EdgeInsets.symmetric(
              horizontal: size == CustomButtonSize.small
                  ? responsiveWidth(24)
                  : size == CustomButtonSize.medium
                  ? responsiveWidth(28)
                  : responsiveWidth(32),
              vertical: size == CustomButtonSize.small
                  ? responsiveHeight(12)
                  : size == CustomButtonSize.medium
                  ? responsiveHeight(14)
                  : responsiveHeight(16),
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? responsiveRadius(12),
          ),
          side: style == CustomButtonStyle.outlined
              ? BorderSide(color: resolvedBorder, width: responsiveWidth(1.5))
              : BorderSide.none,
        ),
      ),
      child: _buildChild(effectiveTextStyle, iconSize),
    );
  }

  Widget _buildChild(final TextStyle textStyle, final double iconSize) {
    if (isLoading) {
      return SizedBox(
        width: responsiveHeight(16),
        height: responsiveHeight(16),
        child: const CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.grey0),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          IconTheme(
            data: IconThemeData(size: iconSize, color: textStyle.color),
            child: prefixIcon!,
          ),
          horizontalSpacing(8),
        ],
        Flexible(
          child: Text(
            text,
            style: textStyle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        if (suffixIcon != null) ...[
          horizontalSpacing(8),
          IconTheme(
            data: IconThemeData(size: iconSize, color: textStyle.color),
            child: suffixIcon!,
          ),
        ],
      ],
    );
  }
}

enum CustomButtonStyle { filled, outlined, soft }

enum CustomButtonSize { small, medium, large }

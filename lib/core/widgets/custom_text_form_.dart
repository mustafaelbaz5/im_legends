import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';

import '../themes/app_colors.dart';

import '../utils/regex.dart';
import '../utils/spacing.dart';

enum CustomTextFieldStyle { filled, outlined, soft }

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.maxLines = 1,
    this.style = CustomTextFieldStyle.filled,
    this.inputTextStyle,
    this.hintStyle,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.contentPadding,
    this.borderRadius,
    this.autofocus = false,
    this.enabled = true,
    this.convertArabicNames = false,
  });

  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final int maxLines;
  final CustomTextFieldStyle style;

  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;

  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final bool autofocus;
  final bool enabled;
  final bool
  convertArabicNames; // Optional: convert Arabic names to English typing

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;
  ui.TextDirection _textDirection = ui.TextDirection.ltr;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    _updateTextDirection(widget.controller?.text ?? '');
  }

  void _toggleObscure() => setState(() => _obscureText = !_obscureText);

  void _updateTextDirection(final String value) {
    setState(() {
      _textDirection = AppRegex().isArabic(value)
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr;
    });
  }

  OutlineInputBorder _buildBorder(
    final Color color, {
    final double width = 1.0,
  }) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
      borderRadius: BorderRadius.circular(
        widget.borderRadius ?? responsiveRadius(16),
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final colors = context.customColors;
    final isEnabled = widget.enabled;

    // Resolve background
    final Color resolvedBackground =
        widget.backgroundColor ??
        (widget.style == CustomTextFieldStyle.outlined
            ? Colors.transparent
            : widget.style == CustomTextFieldStyle.soft
            ? colors.accentBlueSoft.withValues(alpha: 0.3)
            : colors.surfaceVariant.withValues(alpha: 0.35));

    // Resolve border colors
    final Color defaultBorderColor = widget.borderColor ?? colors.border;
    final Color focusedBorderColor =
        widget.focusedBorderColor ?? colors.accentBlue;

    // Text styles
    final TextStyle baseInputStyle =
        widget.inputTextStyle ??
        AppTextStyles.font16Regular.copyWith(color: colors.textPrimary);

    final TextStyle effectiveInputStyle = baseInputStyle.color == null
        ? baseInputStyle.copyWith(
            color: isEnabled ? colors.textPrimary : colors.textSecondary,
          )
        : baseInputStyle;

    final TextStyle effectiveHintStyle =
        widget.hintStyle ??
        AppTextStyles.font16Regular.copyWith(
          color: colors.textSecondary.withValues(alpha: 0.6),
        );

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      maxLines: widget.maxLines,
      autofocus: widget.autofocus,
      enabled: isEnabled,
      textDirection: _textDirection,
      style: effectiveInputStyle,
      validator: widget.validator,
      onChanged: (final value) {
        _updateTextDirection(value);
        widget.onChanged?.call(value);
      },
      decoration: InputDecoration(
        isDense: true,
        filled: widget.style != CustomTextFieldStyle.outlined,
        fillColor: resolvedBackground,
        hintText: widget.hintText,
        hintStyle: effectiveHintStyle,
        contentPadding:
            widget.contentPadding ??
            EdgeInsets.symmetric(
              horizontal: responsiveWidth(20),
              vertical: responsiveHeight(18),
            ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: _obscureText
                      ? colors.textSecondary
                      : colors.textPrimary,
                  size: responsiveRadius(22),
                ),
                onPressed: _toggleObscure,
              )
            : widget.suffixIcon,
        enabledBorder: widget.style == CustomTextFieldStyle.outlined
            ? _buildBorder(defaultBorderColor, width: responsiveRadius(1.2))
            : _buildBorder(
                defaultBorderColor.withValues(alpha: 0.6),
                width: responsiveRadius(0.8),
              ),
        focusedBorder: _buildBorder(
          focusedBorderColor,
          width: responsiveRadius(1.5),
        ),
        disabledBorder: _buildBorder(colors.border.withValues(alpha: 0.3)),
        errorBorder: _buildBorder(
          AppColors.red100,
          width: responsiveRadius(1.4),
        ),
        focusedErrorBorder: _buildBorder(
          AppColors.red100,
          width: responsiveRadius(1.6),
        ),
        border: widget.style == CustomTextFieldStyle.outlined
            ? _buildBorder(defaultBorderColor)
            : null,
      ),
    );
  }
}

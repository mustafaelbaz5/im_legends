import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../themes/app_font_family.dart';
import '../../themes/custom_colors.dart';
import 'object_extension.dart';

/// Navigation Extensions
extension NavigationExt on BuildContext {
  /// Push a new screen (Widget)
  Future<T?> push<T extends Object?>(final Widget page) {
    return Navigator.push(this, MaterialPageRoute(builder: (_) => page));
  }

  /// Replace current screen
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    final Widget page, {
    final TO? result,
  }) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (_) => page),
      result: result,
    );
  }

  /// Push and remove all previous screens
  Future<T?> pushAndRemoveAll<T extends Object?>(final Widget page) {
    return Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (_) => page),
      (_) => false,
    );
  }

  /// Pop current screen
  void pop<T extends Object?>([final T? result]) {
    if (mounted) {
      Navigator.pop(this, result);
    }
  }

  /// Push by route name
  Future<T?> pushNamed<T extends Object?>(
    final String routeName, {
    final Object? arguments,
  }) {
    return Navigator.of(
      this,
      rootNavigator: true,
    ).pushNamed(routeName, arguments: arguments);
  }

  /// Replace by route name
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    final String routeName, {
    final Object? arguments,
    final TO? result,
  }) {
    return Navigator.of(
      this,
      rootNavigator: true,
    ).pushReplacementNamed(routeName, arguments: arguments, result: result);
  }

  /// Push named route and clear previous navigation stack
  Future<T?> pushNamedAndRemoveAll<T extends Object?>(
    final String routeName, {
    final Object? arguments,
    final bool rootNavigator = true,
  }) {
    return Navigator.of(
      this,
      rootNavigator: rootNavigator,
    ).pushNamedAndRemoveUntil(
      routeName,
      (_) => false,
      arguments: arguments,
    );
  }
}

/// Theme Extensions
extension ThemeExt on BuildContext {
  /// Check if current theme is dark
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Access theme quickly
  ThemeData get theme => Theme.of(this);

  /// Access text theme quickly
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Access color scheme quickly
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Access custom colors quickly
  CustomColors get customColors => Theme.of(this).customColors;
}

/// Locale Extensions
extension LocaleExt on BuildContext {
  /// Check if current locale is Arabic
  bool get isArabic => EasyLocalization.of(this)!.locale.languageCode == 'ar';

  /// Get current locale
  Locale get localeLanguage => EasyLocalization.of(this)!.locale;

  /// Check if RTL language
  bool get isRTL => isArabic;
}

extension AppFontsExtension on BuildContext {
  String get currentFont {
    // If Arabic, use Tajawal; otherwise, Inter
    return isArabic ? AppFontFamily.tajawal : AppFontFamily.inter;
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../extensions/context_extensions.dart';
import '../../themes/cubit/theme_cubit.dart';

/// Switch Language between Arabic and English
void switchLanguage(final BuildContext context) {
  final Locale current = context.locale;

  // Switch locale
  if (current.languageCode == 'en') {
    context.setLocale(const Locale('ar'));
  } else {
    context.setLocale(const Locale('en'));
  }
  (context as Element).markNeedsBuild();
}

/// Switch Theme between Light and Dark
void switchTheme(final BuildContext context) {
  // Switch theme
  if (context.isDarkMode) {
    context.read<ThemeCubit>().updateTheme(ThemeMode.light);
  } else {
    context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
  }
}

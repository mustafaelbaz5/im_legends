import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  static const _themeKey = 'themeMode';

  /// Update the theme mode (Light / Dark / System)
  void updateTheme(final ThemeMode mode) => emit(mode);

  // HydratedBloc JSON Serialization
  @override
  ThemeMode? fromJson(final Map<String, dynamic> json) {
    final mode = json[_themeKey] as String?;
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  @override
  Map<String, dynamic>? toJson(final ThemeMode state) {
    final modeString = switch (state) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    return {_themeKey: modeString};
  }
}

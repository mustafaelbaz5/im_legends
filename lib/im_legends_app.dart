import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/di/dependency_injection.dart';
import 'package:im_legends/core/router/app_router.dart';
import 'package:im_legends/core/themes/cubit/theme_cubit.dart';
import 'package:im_legends/core/themes/theme_data/theme_data_dark.dart';
import 'package:im_legends/core/themes/theme_data/theme_data_light.dart';
import 'package:im_legends/features/auth/logic/cubit/auth_cubit.dart';
import 'package:im_legends/features/main_navigation/ui/main_scaffold.dart';
import 'package:im_legends/features/onboarding/ui/on_boarding_screen.dart';

class IMLegendsApp extends StatelessWidget {
  const IMLegendsApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(final BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (final context, final child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<AuthCubit>()..checkAuthStatus()),
            BlocProvider(create: (_) => ThemeCubit()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (final context, final mode) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (final context, final authState) {
                  return MaterialApp(
                    key: ValueKey(authState is AuthAuthenticated),
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    debugShowCheckedModeBanner: false,
                    title: 'ImLegends',
                    onGenerateRoute: appRouter.generateRoute,
                    home: _buildHome(authState),
                    theme: getLightTheme(context: context),
                    darkTheme: getDarkTheme(context: context),
                    themeMode: mode,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildHome(final AuthState state) {
    if (state is AuthInitial || state is AuthLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (state is AuthAuthenticated) {
      return const MainScaffold();
    } else {
      return const OnBoardingScreen();
    }
  }
}
// test123@gmail.com
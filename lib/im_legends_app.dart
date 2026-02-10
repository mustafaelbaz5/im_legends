import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/router/app_router.dart';
import 'package:im_legends/core/router/route_paths.dart';
import 'package:im_legends/core/themes/cubit/theme_cubit.dart';
import 'package:im_legends/core/themes/theme_data/theme_data_dark.dart';
import 'package:im_legends/core/themes/theme_data/theme_data_light.dart';

class IMLegendsApp extends StatelessWidget {
  const IMLegendsApp({super.key, required this.appRouter});
  final AppRouter appRouter;
  @override
  Widget build(final BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (final BuildContext context, final Widget? child) {
        return BlocProvider(
          create: (final BuildContext context) => ThemeCubit(),

          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (final BuildContext context, final ThemeMode mode) {
              return MaterialApp(
                key: ValueKey(context.locale),
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                initialRoute: Routes.onBoardingScreen,
                onGenerateRoute: appRouter.generateRoute,
                title: 'app_title'.tr(),
                theme: getLightTheme(context: context),
                darkTheme: getDarkTheme(context: context),
                themeMode: mode,
              );
            },
          ),
        );
      },
    );
  }
}
// test123@gmail.com
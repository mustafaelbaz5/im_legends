import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:im_legends/core/utils/app_assets.dart';

class IMLegendsApp extends StatelessWidget {
  const IMLegendsApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'IM Legends App',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF000000),
            fontFamily: AppAssets.fontRoboto,
          ),
          routerConfig: router, // Use GoRouter here
        );
      },
    );
  }
}

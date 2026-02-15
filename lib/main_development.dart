import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/config/app_config.dart';
import 'package:im_legends/core/service/secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/app_constants.dart';
import 'core/config/firebase_options.dart';
import 'core/di/dependency_injection.dart';
import 'core/router/app_router.dart';
import 'im_legends_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    EasyLocalization.ensureInitialized(),
    setupHydratedStorage(),
    setUpDependencies(),
  ]);

  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScreenUtil.ensureScreenSize();
  // await LocalNotificationService().initialize();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      child: IMLegendsApp(appRouter: AppRouter()),
    ),
  );
}

checkLoggedInUser() async {
  final String? userToken = await getIt<SecureStorage>().read(
    key: AppConstants.userIdKey,
  );
  if (userToken == null || userToken.isEmpty) {
    isLoggedInUser = false;
  } else {
    isLoggedInUser = true;
  }
}

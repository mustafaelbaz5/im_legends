import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/di/dependency_injection.dart';
import 'core/router/app_router.dart' as AppRouter;
import 'core/utils/shared_prefs.dart';
import 'features/notification/data/service/firebase_notifications_service.dart';
import 'features/notification/data/service/local_notifications.dart';
import 'firebase_options.dart';
import 'im_legends_app.dart';

/// === Initialize core services ===
Future<void> _initServices() async {
  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Local notifications
  await LocalNotificationService().initialize();

  // Supabase
  await Supabase.initialize(
    url: 'https://flutiryhpfdlpizyxqix.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZsdXRpcnlocGZkbHBpenl4cWl4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYxNTQ3NzIsImV4cCI6MjA3MTczMDc3Mn0.UhojXOtOrnvbwDKvyBVZn3Cl1gdUkr-NYuGBLQXIRi0',
  );

  // Dependency Injection
  setupGetIt();
}

/// === Main entry point ===
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure screen util sizing
  await ScreenUtil.ensureScreenSize();

  // Shared Preferences
  await SharedPrefStorage.instance.init();

  // Register background handler BEFORE runApp
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Init services
  await _initServices();

  // Run app
  runApp(IMLegendsApp(router: AppRouter.router));
}

// flutter run --release --flavor production --target lib/main_production.dart

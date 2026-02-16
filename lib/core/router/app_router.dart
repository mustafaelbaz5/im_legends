import 'package:flutter/material.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/auth/ui/sign_up_screen.dart';
import '../../features/notification/ui/notifications_screen.dart';

import 'routes.dart';

class AppRouter {
  Route<dynamic>? generateRoute(final RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      // Notifications
      case Routes.notificationsScreen:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      default:
        return null;
    }
  }
}

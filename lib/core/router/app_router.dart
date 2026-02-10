import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_legends/core/widgets/main_scaffold.dart';

import '../../features/add_match/logic/cubit/add_match_cubit.dart';
import '../../features/add_match/ui/add_match_screen.dart';
import '../../features/auth/data/service/auth_service.dart';
import '../../features/auth/logic/cubit/auth_cubit.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/auth/ui/sign_up_screen.dart';
import '../../features/champion/logic/cubit/champion_cubit.dart';
import '../../features/champion/ui/champion_screen.dart';
import '../../features/history/logic/cubit/match_history_cubit.dart';
import '../../features/history/ui/history_screen.dart';
import '../../features/home/logic/cubit/leader_board_cubit.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/notification/data/models/notification_model.dart';
import '../../features/notification/logic/cubit/notifications_cubit.dart';
import '../../features/notification/ui/notifications_screen.dart';
import '../../features/notification/ui/widgets/notification_details_screen.dart';
import '../../features/onboarding/ui/on_boarding_screen.dart';
import '../../features/profile/logic/cubit/profile_cubit.dart';
import '../../features/profile/ui/profile_screen.dart';
import '../di/dependency_injection.dart';
import '../widgets/not_screen_found.dart';
import 'route_paths.dart';

class AppRouter {
  Route<dynamic> generateRoute(final RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // ----------------- ONBOARDING -----------------
      case Routes.onBoardingScreen:
        return _authAwareRoute(const OnBoardingScreen());

      // ----------------- AUTH -----------------
      case Routes.loginScreen:
        return _materialRoute(_withAuthProviders(const LoginScreen()));

      case Routes.signUpScreen:
        return _materialRoute(_withAuthProviders(const SignUpScreen()));

      // ----------------- NOTIFICATIONS -----------------
      case Routes.notificationDetailsScreen:
        final notification = args as NotificationModel;
        return _materialRoute(
          NotificationDetailsScreen(notification: notification),
        );

      // ----------------- MAIN SHELL -----------------
      case Routes.homeScreen:
        return _mainRoute(const HomeScreen());

      case Routes.addMatchScreen:
        return _mainRoute(const AddMatchScreen());

      case Routes.championsScreen:
        return _mainRoute(const ChampionScreen());

      case Routes.historyScreen:
        return _mainRoute(const HistoryScreen());

      case Routes.profileScreen:
        return _mainRoute(const ProfileScreen());

      case Routes.notificationsScreen:
        return _mainRoute(const NotificationsScreen());

      // ----------------- FALLBACK -----------------
      default:
        return _materialRoute(const NotFoundScreen());
    }
  }
}

// -------------------------
// Helpers
// -------------------------
Route<dynamic> _materialRoute(final Widget child) {
  return MaterialPageRoute(builder: (_) => child);
}

Route<dynamic> _mainRoute(final Widget child) {
  return MaterialPageRoute(
    builder: (_) => _withMainProviders(MainScaffold(child: child)),
  );
}

Widget _withAuthProviders(final Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => getIt<AuthCubit>()),
      BlocProvider(create: (_) => getIt<NotificationsCubit>()),
    ],
    child: child,
  );
}

Widget _withMainProviders(final Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => getIt<LeaderBoardCubit>()..loadLeaderboard()),
      BlocProvider(
        create: (_) => getIt<MatchHistoryCubit>()..getMatchHistory(),
      ),
      BlocProvider(create: (_) => getIt<AddMatchCubit>()),
      BlocProvider(create: (_) => getIt<ProfileCubit>()..fetchProfile()),
      BlocProvider(create: (_) => getIt<ChampionCubit>()..fetchTopThree()),
      BlocProvider(
        create: (_) => getIt<NotificationsCubit>()..fetchNotifications(),
      ),
    ],
    child: child,
  );
}

Route<dynamic> _authAwareRoute(final Widget child) {
  return MaterialPageRoute(
    builder: (_) => FutureBuilder<bool>(
      future: AuthService.isLoggedIn(),
      builder: (final context, final snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          return _withMainProviders(const MainScaffold(child: HomeScreen()));
        }

        return child;
      },
    ),
  );
}


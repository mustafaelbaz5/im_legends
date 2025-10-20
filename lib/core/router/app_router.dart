import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
import '../widgets/main_scaffold.dart';
import '../widgets/not_screen_found.dart';
import 'route_paths.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: Routes.onBoardingScreen,
  errorBuilder: (_, __) => const NotFoundScreen(),
  redirect: _authRedirect,
  routes: [
    // Public routes
    GoRoute(
      path: Routes.onBoardingScreen,
      builder: (_, __) => const OnBoardingScreen(),
    ),
    GoRoute(
      path: Routes.loginScreen,
      builder: (_, __) => _withAuthProviders(const LoginScreen()),
    ),
    GoRoute(
      path: Routes.signUpScreen,
      builder: (_, __) => _withAuthProviders(const SignUpScreen()),
    ),
    GoRoute(
      path: Routes.notificationDetailsScreen,
      builder: (_, state) {
        final notification = state.extra as NotificationModel;
        return NotificationDetailsScreen(notification: notification);
      },
    ),

    // Main shell routes
    ShellRoute(
      builder: (_, __, child) => _withMainProviders(MainScaffold(child: child)),
      routes: [
        GoRoute(
          path: Routes.homeScreen,
          builder: (_, __) => const HomeScreen(),
        ),
        GoRoute(
          path: Routes.addMatchScreen,
          builder: (_, __) => const AddMatchScreen(),
        ),
        GoRoute(
          path: Routes.championsScreen,
          builder: (_, __) => const ChampionScreen(),
        ),
        GoRoute(
          path: Routes.historyScreen,
          builder: (_, __) => const HistoryScreen(),
        ),
        GoRoute(
          path: Routes.profileScreen,
          builder: (_, __) => const ProfileScreen(),
        ),
        GoRoute(
          path: Routes.notificationsScreen,
          builder: (_, __) => const NotificationsScreen(),
        ),
      ],
    ),
  ],
);

// -------------------------
// Helpers
// -------------------------

Widget _withAuthProviders(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => getIt<AuthCubit>()),
      BlocProvider(create: (_) => getIt<NotificationsCubit>()),
    ],
    child: child,
  );
}

Widget _withMainProviders(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => getIt<LeaderBoardCubit>()..loadLeaderboard()),
      BlocProvider(create: (_) => MatchHistoryCubit()..getMatchHistory()),
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

Future<String?> _authRedirect(BuildContext context, GoRouterState state) async {
  final isLoggedIn = await AuthService.isLoggedIn();

  if (!isLoggedIn && !Routes.publicRoutes.contains(state.matchedLocation)) {
    return Routes.onBoardingScreen;
  }
  if (isLoggedIn && state.matchedLocation == Routes.onBoardingScreen) {
    return Routes.homeScreen;
  }
  return null;
}

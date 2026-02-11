import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_legends/core/di/dependency_injection.dart';
import 'package:im_legends/features/add_match/logic/cubit/add_match_cubit.dart';
import 'package:im_legends/features/auth/logic/cubit/auth_cubit.dart';
import 'package:im_legends/features/auth/ui/login_screen.dart';
import 'package:im_legends/features/auth/ui/sign_up_screen.dart';
import 'package:im_legends/features/champion/logic/cubit/champion_cubit.dart';
import 'package:im_legends/features/history/logic/cubit/match_history_cubit.dart';
import 'package:im_legends/features/home/logic/cubit/leader_board_cubit.dart';
import 'package:im_legends/features/main_navigation/ui/main_scaffold.dart';
import 'package:im_legends/features/profile/logic/cubit/profile_cubit.dart';

import '../../features/onboarding/ui/on_boarding_screen.dart';
import 'routes.dart';

class AppRouter {
  Route<dynamic>? generateRoute(final RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      // ----------------- ONBOARDING -----------------
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      // ----------------- AUTH -----------------
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => _withAuthProviders(const LoginScreen()),
        );

      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => _withAuthProviders(const SignUpScreen()),
        );

      // ----------------- MAIN -----------------
      case Routes.mainScaffold:
        return MaterialPageRoute(
          builder: (_) => _withMainProviders(const MainScaffold()),
        );

      default:
        return null;
    }
  }
}

Widget _withAuthProviders(final Widget child) {
  return BlocProvider(create: (_) => getIt<AuthCubit>(), child: child);
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
    ],
    child: child,
  );
}

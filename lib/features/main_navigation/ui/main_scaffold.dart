import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';
import 'package:im_legends/features/add_match/ui/add_match_screen.dart';
import 'package:im_legends/features/champion/ui/champion_screen.dart';
import 'package:im_legends/features/home/logic/cubit/leader_board_cubit.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/utils/spacing.dart';
import '../../home/ui/home_screen.dart';
import '../../profile/ui/profile_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      BlocProvider.value(
        value: getIt<LeaderBoardCubit>(),
        child: const HomeScreen(),
      ),
      const AddMatchScreen(),
      const ChampionScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems(final BuildContext context) {
    final activeColor = AppColors.primary300;

    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home, size: responsiveRadius(24), color: activeColor),
        inactiveIcon: Icon(
          Icons.home,
          size: responsiveRadius(24),
          color: context.customColors.textSecondary,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.add_alert_outlined,
          size: responsiveRadius(24),
          color: activeColor,
        ),
        inactiveIcon: Icon(
          Icons.add_alert_outlined,
          size: responsiveRadius(24),
          color: context.customColors.textSecondary,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.search,
          size: responsiveRadius(28),
          color: AppColors.grey0,
        ),
        activeColorPrimary: activeColor,
        activeColorSecondary: Colors.white,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.person,
          color: activeColor,
          size: responsiveRadius(24),
        ),
        inactiveIcon: Icon(
          Icons.person,
          color: context.customColors.textSecondary,
          size: responsiveRadius(24),
        ),
      ),
    ];
  }

  @override
  Widget build(final BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarItems(context),
      navBarStyle: NavBarStyle.style9,
      backgroundColor: context.customColors.background,
      navBarHeight: responsiveHeight(58),
      padding: const EdgeInsets.only(top: 2, bottom: 8),
      decoration: NavBarDecoration(
        colorBehindNavBar: context.customColors.background,
        boxShadow: [
          BoxShadow(
            color: context.customColors.border.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      confineToSafeArea: true,
    );
  }
}

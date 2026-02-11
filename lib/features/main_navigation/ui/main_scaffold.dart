import 'package:flutter/material.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';
import 'package:im_legends/features/add_match/ui/add_match_screen.dart';
import 'package:im_legends/features/champion/ui/champion_screen.dart';
import 'package:im_legends/features/history/ui/history_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildScreens() {
    return const [
      HomeScreen(),
      HistoryScreen(),
      AddMatchScreen(),
      ChampionScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems(final BuildContext context) {
    return [
      _buildNavItem(context, Icons.home_rounded, Icons.home_outlined),
      _buildNavItem(context, Icons.history_rounded, Icons.history_outlined),
      _buildNavItem(
        context,
        Icons.add_circle,
        Icons.add_circle_outline,
        isCenterButton: true,
      ),
      _buildNavItem(context, Icons.emoji_events, Icons.emoji_events_outlined),
      _buildNavItem(context, Icons.person, Icons.person_outline),
    ];
  }

  PersistentBottomNavBarItem _buildNavItem(
    final BuildContext context,
    final IconData activeIcon,
    final IconData inactiveIcon, {
    final bool isCenterButton = false,
  }) {
    return PersistentBottomNavBarItem(
      icon: Icon(
        activeIcon,
        size: responsiveRadius(26),
        color: isCenterButton ? AppColors.grey0 : AppColors.primary400,
      ),
      inactiveIcon: Icon(
        inactiveIcon,
        size: responsiveRadius(26),
        color: isCenterButton
            ? AppColors.grey0
            : context.customColors.textPrimary,
      ),
      activeColorPrimary: AppColors.primary400,
      inactiveColorPrimary: context.customColors.textPrimary,
    );
  }

  @override
  Widget build(final BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarItems(context),
      navBarStyle: NavBarStyle.style16,
      backgroundColor: context.customColors.background,
      navBarHeight: responsiveHeight(70),
      padding: EdgeInsets.symmetric(
        vertical: responsiveHeight(4),
        horizontal: responsiveWidth(8),
      ),
      decoration: NavBarDecoration(
        colorBehindNavBar: context.customColors.background,
        border: Border(
          top: BorderSide(color: context.customColors.divider, width: 1),
        ),
      ),
      confineToSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
    );
  }
}

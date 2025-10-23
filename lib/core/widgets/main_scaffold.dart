import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../router/route_paths.dart';
import 'animated_page.dart';
import 'custom_bottom_navigation_bar.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  static final List<String> _tabs = [
    Routes.homeScreen,
    Routes.championsScreen,
    Routes.historyScreen,
    Routes.profileScreen,
  ];

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouter.of(context);
    final index = _tabs.indexWhere(
      (path) => location.routerDelegate.currentConfiguration.fullPath
          .startsWith(path),
    );
    return index == -1 ? 0 : index;
  }

  void _onTabSelected(BuildContext context, int index) {
    HapticFeedback.selectionClick();
    context.go(_tabs[index]);
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);

    return Scaffold(
      body: AnimatedPage(child: child),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.15 * 255).toInt()),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: CustomBottomNavBar(
          selectedIndex: currentIndex,
          onTabSelected: (i) => _onTabSelected(context, i),
        ),
      ),
    );
  }
}

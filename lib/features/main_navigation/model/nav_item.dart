import 'package:flutter/material.dart';

class NavItem {
  final Widget screen;
  final String iconPath;
  final String label;

  const NavItem({
    required this.screen,
    required this.iconPath,
    required this.label,
  });
}

import 'package:flutter/material.dart';
import 'package:layout/layout.dart';

// widget to handle app responsiveness
class AppLayout extends StatelessWidget {
  const AppLayout({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      xs: (_) => mobile,
      sm: (_) => tablet,
      md: (_) => desktop,
      lg: (_) => desktop,
      xl: (_) => desktop,
    );
  }
}

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashBoardLoadingPage extends HookConsumerWidget {
  const DashBoardLoadingPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileDashBoardLoadingPage(),
      tablet: _TabletDashBoardLoadingPage(),
      desktop: _DesktopDashBoardLoadingPage(),
    );
  }
}

// dashboard loading page for mobile
class _MobileDashBoardLoadingPage extends HookConsumerWidget {
  const _MobileDashBoardLoadingPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: DText(
            text: 'Loading ...!',
            textColor: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}

// dashboard loading page for tablet
class _TabletDashBoardLoadingPage extends HookConsumerWidget {
  const _TabletDashBoardLoadingPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: DText(
            text: 'Loading.....!',
            textColor: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}

// dashboard loading page for desktop
class _DesktopDashBoardLoadingPage extends HookConsumerWidget {
  const _DesktopDashBoardLoadingPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: DText(
            text: 'Loading.....!',
            textColor: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}

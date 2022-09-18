import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashBoardErrorPage extends HookConsumerWidget {
  const DashBoardErrorPage({
    Key? key,
    this.errorText,
  }) : super(key: key);
  final String? errorText;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileDashBoardErrorPage(
        errorText: errorText,
      ),
      tablet: _TabletDashBoardErrorPage(
        errorText: errorText,
      ),
      desktop: _DesktopDashBoardErrorPage(
        errorText: errorText,
      ),
    );
  }
}

// dashboard error page for mobile
class _MobileDashBoardErrorPage extends HookConsumerWidget {
  const _MobileDashBoardErrorPage({
    Key? key,
    this.errorText,
  }) : super(key: key);
  final String? errorText;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      body: SafeArea(
        child: Center(
          child: DText(
            text: 'Error $errorText',
            textColor: Theme.of(context).colorScheme.onErrorContainer,
          ),
        ),
      ),
    );
  }
}

// dashboard error page for tablet
class _TabletDashBoardErrorPage extends HookConsumerWidget {
  const _TabletDashBoardErrorPage({
    Key? key,
    this.errorText,
  }) : super(key: key);
  final String? errorText;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      body: SafeArea(
        child: Center(
          child: DText(
            text: 'Error $errorText',
            textColor: Theme.of(context).colorScheme.onErrorContainer,
          ),
        ),
      ),
    );
  }
}

// dashboard error page for desktop
class _DesktopDashBoardErrorPage extends HookConsumerWidget {
  const _DesktopDashBoardErrorPage({
    Key? key,
    this.errorText,
  }) : super(key: key);
  final String? errorText;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      body: SafeArea(
        child: Center(
          child: DText(
            text: 'Error $errorText',
            textColor: Theme.of(context).colorScheme.onErrorContainer,
          ),
        ),
      ),
    );
  }
}

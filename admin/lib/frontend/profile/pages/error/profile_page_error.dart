import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// profile error page hook consumer widget with app layout
class ProfileErrorPage extends HookConsumerWidget {
  const ProfileErrorPage({
    super.key,
    this.error,
  });
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileProfileErrorPage(
        error: error,
      ),
      tablet: _TabletProfileErrorPage(
        error: error,
      ),
      desktop: _DesktopProfileErrorPage(
        error: error,
      ),
    );
  }
}

// mobile profile error page
class _MobileProfileErrorPage extends HookConsumerWidget {
  const _MobileProfileErrorPage({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.redAccent,
      child: Center(
        child: Text(
          'Mobile Profile Error $error',
        ),
      ),
    );
  }
}

// tablet profile error page
class _TabletProfileErrorPage extends HookConsumerWidget {
  const _TabletProfileErrorPage({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.redAccent,
      child: const Center(
        child: Text(
          'Tablet Profile Error',
        ),
      ),
    );
  }
}

// desktop profile error page
class _DesktopProfileErrorPage extends HookConsumerWidget {
  const _DesktopProfileErrorPage({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.redAccent,
      child: const Center(
        child: Text(
          'Desktop Profile Error',
        ),
      ),
    );
  }
}

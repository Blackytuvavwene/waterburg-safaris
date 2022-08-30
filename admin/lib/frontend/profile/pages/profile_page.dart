import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileProfilePage(),
      tablet: _TabletProfilePage(),
      desktop: _DesktopProfilePage(),
    );
  }
}

// mobile profile page
class _MobileProfilePage extends HookConsumerWidget {
  const _MobileProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.redAccent,
      child: const Center(
        child: Text(
          'Mobile Profile',
        ),
      ),
    );
  }
}

// tablet profile page
class _TabletProfilePage extends HookConsumerWidget {
  const _TabletProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.redAccent,
      child: const Center(
        child: Text(
          'Tablet Profile',
        ),
      ),
    );
  }
}

// desktop profile page
class _DesktopProfilePage extends HookConsumerWidget {
  const _DesktopProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.redAccent,
      child: const Center(
        child: Text(
          'Desktop Profile',
        ),
      ),
    );
  }
}

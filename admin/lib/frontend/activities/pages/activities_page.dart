import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActivitiesPage extends HookConsumerWidget {
  const ActivitiesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileAciivitiesPage(),
      tablet: _TabletActivitiesPage(),
      desktop: _DesktopActivitiesPage(),
    );
  }
}

// mobile activities page
class _MobileAciivitiesPage extends HookConsumerWidget {
  const _MobileAciivitiesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.blueAccent,
      child: const Center(
        child: Text(
          'Mobile Activities',
        ),
      ),
    );
  }
}

// tablet activities page
class _TabletActivitiesPage extends HookConsumerWidget {
  const _TabletActivitiesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.blueAccent,
      child: const Center(
        child: Text(
          'Tablet Activities',
        ),
      ),
    );
  }
}

// desktop activities page
class _DesktopActivitiesPage extends HookConsumerWidget {
  const _DesktopActivitiesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.blueAccent,
      child: const Center(
        child: Text(
          'Desktop Activities',
        ),
      ),
    );
  }
}

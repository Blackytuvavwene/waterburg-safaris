import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// profile loading page hook consumer widget with app layout
class ProfileLoadingPage extends HookConsumerWidget {
  const ProfileLoadingPage({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileProfileLoadingPage(),
      tablet: _TabletProfileLoadingPage(),
      desktop: _DesktopProfileLoadingPage(),
    );
  }
}

// mobile profile loading page
class _MobileProfileLoadingPage extends HookConsumerWidget {
  const _MobileProfileLoadingPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          children: const [
            DText(
              text: 'Mobile Profile Loading',
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

// tablet profile loading page
class _TabletProfileLoadingPage extends HookConsumerWidget {
  const _TabletProfileLoadingPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          children: const [
            DText(
              text: 'Tablet Profile Loading',
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

// desktop profile loading page
class _DesktopProfileLoadingPage extends HookConsumerWidget {
  const _DesktopProfileLoadingPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          children: const [
            DText(
              text: 'Desktop Profile Loading',
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

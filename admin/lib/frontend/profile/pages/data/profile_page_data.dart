import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileDataPage extends HookConsumerWidget {
  const ProfileDataPage({
    Key? key,
    this.company,
  }) : super(key: key);
  final Company? company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileProfileDataPage(
        company: company,
      ),
      tablet: _TabletProfileDataPage(
        company: company,
      ),
      desktop: _DesktopProfileDataPage(
        company: company,
      ),
    );
  }
}

// mobile profile page
class _MobileProfileDataPage extends HookConsumerWidget {
  const _MobileProfileDataPage({
    Key? key,
    this.company,
  }) : super(key: key);
  final Company? company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: const Center(
        child: Text(
          'Mobile Profile',
        ),
      ),
    );
  }
}

// tablet profile page
class _TabletProfileDataPage extends HookConsumerWidget {
  const _TabletProfileDataPage({
    Key? key,
    this.company,
  }) : super(key: key);
  final Company? company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: const Center(
        child: Text(
          'Tablet Profile',
        ),
      ),
    );
  }
}

// desktop profile page
class _DesktopProfileDataPage extends HookConsumerWidget {
  const _DesktopProfileDataPage({
    Key? key,
    this.company,
  }) : super(key: key);
  final Company? company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: const Center(
        child: Text(
          'Desktop Profile',
        ),
      ),
    );
  }
}

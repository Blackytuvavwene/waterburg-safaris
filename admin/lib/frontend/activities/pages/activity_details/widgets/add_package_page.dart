import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// add package page
class AddPackagePage extends HookConsumerWidget {
  const AddPackagePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileAddPackagePage(),
      tablet: _TabletAddPackagePage(),
      desktop: _DesktopAddPackagePage(),
    );
  }
}

// mobile add package page
class _MobileAddPackagePage extends HookConsumerWidget {
  const _MobileAddPackagePage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: const Center(
        child: DText(
          text: 'Hello',
        ),
      ),
    );
  }
}

// tablet add package page
class _TabletAddPackagePage extends HookConsumerWidget {
  const _TabletAddPackagePage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// desktop add package page
class _DesktopAddPackagePage extends HookConsumerWidget {
  const _DesktopAddPackagePage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

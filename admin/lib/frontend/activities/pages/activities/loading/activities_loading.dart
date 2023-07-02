import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// activities loading
class ActivitiesLoading extends HookConsumerWidget {
  const ActivitiesLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _ActivitiesLoadingMobile(),
      tablet: _ActivitiesLoadingTablet(),
      desktop: _ActivitiesLoadingDesktop(),
    );
  }
}

// activities loading for mobile
class _ActivitiesLoadingMobile extends HookConsumerWidget {
  const _ActivitiesLoadingMobile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// activities loading for tablet
class _ActivitiesLoadingTablet extends HookConsumerWidget {
  const _ActivitiesLoadingTablet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// activities loading for desktop
class _ActivitiesLoadingDesktop extends HookConsumerWidget {
  const _ActivitiesLoadingDesktop({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// activity view page with app layout loading
class ActivityDetailsPageLoading extends HookConsumerWidget {
  const ActivityDetailsPageLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _ActivityDetailsPageLoadingMobile(),
      tablet: _ActivityDetailsPageLoadingTablet(),
      desktop: _ActivityDetailsPageLoadingDesktop(),
    );
  }
}

// activity view page loading for mobile
class _ActivityDetailsPageLoadingMobile extends HookConsumerWidget {
  const _ActivityDetailsPageLoadingMobile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// activity view page loading for tablet
class _ActivityDetailsPageLoadingTablet extends HookConsumerWidget {
  const _ActivityDetailsPageLoadingTablet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// activity view page loading for desktop
class _ActivityDetailsPageLoadingDesktop extends HookConsumerWidget {
  const _ActivityDetailsPageLoadingDesktop({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

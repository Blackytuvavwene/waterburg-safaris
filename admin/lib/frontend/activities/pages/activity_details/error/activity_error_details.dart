import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// activity view page with app layout error
class ActivityDetailsPageError extends HookConsumerWidget {
  const ActivityDetailsPageError({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _ActivityDetailsPageErrorMobile(
        error: error,
      ),
      tablet: _ActivityDetailsPageErrorTablet(
        error: error,
      ),
      desktop: _ActivityDetailsPageErrorDesktop(
        error: error,
      ),
    );
  }
}

// activity view page error for mobile
class _ActivityDetailsPageErrorMobile extends HookConsumerWidget {
  const _ActivityDetailsPageErrorMobile({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(
        child: DText(text: 'Activity View Page Error Desktop $error'),
      ),
    );
  }
}

// activity view page error for tablet
class _ActivityDetailsPageErrorTablet extends HookConsumerWidget {
  const _ActivityDetailsPageErrorTablet({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(
        child: DText(text: 'Activity View Page Error Desktop $error'),
      ),
    );
  }
}

// activity view page error for desktop
class _ActivityDetailsPageErrorDesktop extends HookConsumerWidget {
  const _ActivityDetailsPageErrorDesktop({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(
        child: DText(text: 'Activity View Page Error Desktop $error'),
      ),
    );
  }
}

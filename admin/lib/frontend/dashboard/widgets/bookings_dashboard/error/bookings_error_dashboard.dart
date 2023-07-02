import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class BookingsErrorDashboard extends HookConsumerWidget {
  const BookingsErrorDashboard({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileBookingsErrorDashboard(
        error: error,
      ),
      tablet: _TabletBookingsErrorDashboard(
        error: error,
      ),
      desktop: _DesktopBookingsErrorDashboard(
        error: error,
      ),
    );
  }
}

// bookins error dashboard for mobile
class _MobileBookingsErrorDashboard extends HookConsumerWidget {
  const _MobileBookingsErrorDashboard({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100.w,
      height: 100.h,
      color: Theme.of(context).colorScheme.errorContainer,
      child: Center(
        child: DText(
          text: error.toString(),
          textColor: Theme.of(context).colorScheme.onErrorContainer,
        ),
      ),
    );
  }
}

// bookins error dashboard for tablet
class _TabletBookingsErrorDashboard extends HookConsumerWidget {
  const _TabletBookingsErrorDashboard({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100.w,
      height: 100.h,
      color: Theme.of(context).colorScheme.errorContainer,
      child: Center(
        child: DText(
          text: error.toString(),
          textColor: Theme.of(context).colorScheme.onErrorContainer,
        ),
      ),
    );
  }
}

// bookins error dashboard for desktop
class _DesktopBookingsErrorDashboard extends HookConsumerWidget {
  const _DesktopBookingsErrorDashboard({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100.w,
      height: 100.h,
      color: Theme.of(context).colorScheme.errorContainer,
      child: Center(
        child: DText(
          text: error.toString(),
          textColor: Theme.of(context).colorScheme.onErrorContainer,
        ),
      ),
    );
  }
}

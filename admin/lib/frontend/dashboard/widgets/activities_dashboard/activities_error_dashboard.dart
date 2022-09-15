import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// dashboard activities error
class DashBoardActivitiesError extends HookConsumerWidget {
  const DashBoardActivitiesError({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileDashBoardActivitiesError(
        error: error,
      ),
      tablet: _TabletDashBoardActivitiesError(
        error: error,
      ),
      desktop: _DesktopDashBoardActivitiesError(
        error: error,
      ),
    );
  }
}

// dashboard activities error for mobile
class _MobileDashBoardActivitiesError extends HookConsumerWidget {
  const _MobileDashBoardActivitiesError({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// dashboard activities error for tablet
class _TabletDashBoardActivitiesError extends HookConsumerWidget {
  const _TabletDashBoardActivitiesError({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// dashboard activities error for desktop
class _DesktopDashBoardActivitiesError extends HookConsumerWidget {
  const _DesktopDashBoardActivitiesError({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

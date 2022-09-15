import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashBoardActivitiesLoading extends HookConsumerWidget {
  const DashBoardActivitiesLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileDashBoardActivitiesLoading(),
      tablet: _TabletDashBoardActivitiesLoading(),
      desktop: _DesktopDashBoardActivitiesLoading(),
    );
  }
}

// dashboard activities loading for mobile
class _MobileDashBoardActivitiesLoading extends HookConsumerWidget {
  const _MobileDashBoardActivitiesLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// dashboard activities loading for tablet
class _TabletDashBoardActivitiesLoading extends HookConsumerWidget {
  const _TabletDashBoardActivitiesLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// dashboard activities loading for desktop
class _DesktopDashBoardActivitiesLoading extends HookConsumerWidget {
  const _DesktopDashBoardActivitiesLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container().animate().shimmer();
  }
}

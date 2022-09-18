import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// dashboard bookings loading
class DashBoardBookingsLoading extends HookConsumerWidget {
  const DashBoardBookingsLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileDashBoardBookingsLoading(),
      tablet: _TabletDashBoardBookingsLoading(),
      desktop: _DesktopDashBoardBookingsLoading(),
    );
  }
}

// dashboard bookings loading for mobile
class _MobileDashBoardBookingsLoading extends HookConsumerWidget {
  const _MobileDashBoardBookingsLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// dashboard bookings loading for tablet
class _TabletDashBoardBookingsLoading extends HookConsumerWidget {
  const _TabletDashBoardBookingsLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// dashboard bookings loading for desktop
class _DesktopDashBoardBookingsLoading extends HookConsumerWidget {
  const _DesktopDashBoardBookingsLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

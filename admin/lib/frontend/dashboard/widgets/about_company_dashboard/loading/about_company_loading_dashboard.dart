import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// dashboard about company loading
class DashBoardAboutCompanyLoading extends HookConsumerWidget {
  const DashBoardAboutCompanyLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileDashBoardAboutCompanyLoading(),
      tablet: _TabletDashBoardAboutCompanyLoading(),
      desktop: _DesktopDashBoardAboutCompanyLoading(),
    );
  }
}

// dashboard about company loading for mobile
class _MobileDashBoardAboutCompanyLoading extends HookConsumerWidget {
  const _MobileDashBoardAboutCompanyLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// dashboard about company loading for tablet
class _TabletDashBoardAboutCompanyLoading extends HookConsumerWidget {
  const _TabletDashBoardAboutCompanyLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// dashboard about company loading for desktop
class _DesktopDashBoardAboutCompanyLoading extends HookConsumerWidget {
  const _DesktopDashBoardAboutCompanyLoading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

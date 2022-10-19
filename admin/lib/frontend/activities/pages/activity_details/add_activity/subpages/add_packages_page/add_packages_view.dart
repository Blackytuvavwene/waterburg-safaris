import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// add packages view hook consumer widget with app layout
class AddPackagesView extends HookConsumerWidget {
  const AddPackagesView({
    super.key,
    this.packageData,
  });
  final List<Package>? packageData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileAddPackagesView(
        packageData: packageData,
      ),
      tablet: _TabletAddPackagesView(
        packageData: packageData,
      ),
      desktop: _DesktopAddPackagesView(
        packageData: packageData,
      ),
    );
  }
}

// mobile add packages view
class _MobileAddPackagesView extends HookConsumerWidget {
  const _MobileAddPackagesView({
    this.packageData,
  });
  final List<Package>? packageData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// tablet add packages view
class _TabletAddPackagesView extends HookConsumerWidget {
  const _TabletAddPackagesView({
    this.packageData,
  });
  final List<Package>? packageData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// desktop add packages view
class _DesktopAddPackagesView extends HookConsumerWidget {
  const _DesktopAddPackagesView({
    this.packageData,
  });
  final List<Package>? packageData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

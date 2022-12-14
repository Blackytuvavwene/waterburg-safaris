import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

// activity packages page with app layout hook consumer widget
class ActivityPackagesPage extends HookConsumerWidget {
  const ActivityPackagesPage({
    Key? key,
    this.packages,
    this.activityId,
  }) : super(key: key);
  final List<Package>? packages;
  final String? activityId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileActivityPackagesPage(
        packages: packages,
        activityId: activityId,
      ),
      tablet: _TabletActivityPackagesPage(
        packages: packages,
        activityId: activityId,
      ),
      desktop: _DesktopActivityPackagesPage(
        packages: packages,
        activityId: activityId,
      ),
    );
  }
}

// mobile activity packages page
class _MobileActivityPackagesPage extends HookConsumerWidget {
  const _MobileActivityPackagesPage({
    Key? key,
    this.packages,
    this.activityId,
  }) : super(key: key);
  final List<Package>? packages;
  final String? activityId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 100.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
        vertical: 2.h,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DText(
              text: 'Packages available',
              fontSize: 16.sp,
              textAlign: TextAlign.center,
              textColor: Theme.of(context).colorScheme.onBackground,
            ),
            ...packages!.map(
              (e) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                  ),
                  child: PackageCard(
                    package: e,
                    activityId: activityId,
                    packages: packages,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// tablet activity packages page
class _TabletActivityPackagesPage extends HookConsumerWidget {
  const _TabletActivityPackagesPage({
    Key? key,
    this.packages,
    this.activityId,
  }) : super(key: key);
  final List<Package>? packages;
  final String? activityId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 100.h,
      width: 100.w,
      color: Theme.of(context).colorScheme.onSecondaryContainer,
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
        vertical: 2.h,
      ),
      child: SizedBox(
        width: 100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DText(
              text: 'Packages available',
              fontSize: 16.sp,
              textAlign: TextAlign.center,
              textColor: Theme.of(context).colorScheme.background,
            ),
            const Spacer(),
            SizedBox(
              width: 100.w,
              height: 50.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 2.w,
                  ),
                  ...packages!.map(
                    (e) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: 2.w,
                        ),
                        child: PackageCard(
                          package: e,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// desktop activity packages page
class _DesktopActivityPackagesPage extends HookConsumerWidget {
  const _DesktopActivityPackagesPage({
    Key? key,
    this.packages,
    this.activityId,
  }) : super(key: key);
  final List<Package>? packages;
  final String? activityId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 100.h,
      width: 100.w,
      color: Theme.of(context).colorScheme.onSecondaryContainer,
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
        vertical: 2.h,
      ),
      child: SizedBox(
        width: 100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DText(
              text: 'Packages available',
              fontSize: 16.sp,
              textAlign: TextAlign.center,
              textColor: Theme.of(context).colorScheme.background,
            ),
            const Spacer(),
            SizedBox(
              width: 100.w,
              height: 50.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 2.w,
                  ),
                  ...packages!.map(
                    (e) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: 2.w,
                        ),
                        child: PackageCard(
                          package: e,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:admin/lib.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

// activity packages page with app layout hook consumer widget
class ActivityPackagesPage extends HookConsumerWidget {
  const ActivityPackagesPage({
    Key? key,
    this.packages,
    this.activityId,
    this.activityNotifier,
    this.isEditing,
  }) : super(key: key);
  final List<Package>? packages;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  final ValueNotifier<bool>? isEditing;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileActivityPackagesPage(
        packages: packages,
        activityId: activityId,
        activityNotifier: activityNotifier,
      ),
      tablet: _TabletActivityPackagesPage(
        packages: packages,
        activityId: activityId,
        activityNotifier: activityNotifier,
      ),
      desktop: _DesktopActivityPackagesPage(
        packages: packages,
        activityId: activityId,
        activityNotifier: activityNotifier,
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
    this.activityNotifier,
  }) : super(key: key);
  final List<Package>? packages;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverPinnedToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 2.w,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DText(
                  text: 'Packages',
                  fontSize: 16.sp,
                ),
                // const Spacer(),
                TextButton(
                  onPressed: () {
                    // create empty model
                    final newPackage = EditPackageModel(
                      package: Package(),
                      activityId: activityId!,
                      packageCopy: Package(),
                      packages: packages!,
                      activityNotifier: activityNotifier!,
                      index: null,
                    );
                    // navigate to add package page
                    context.pushNamed(
                      'addPackage',
                      params: {
                        'activityId': activityId!,
                      },
                      extra: newPackage,
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        5.w,
                      ),
                    ),
                  ),
                  child: DText(
                    text: 'Add Package',
                    textColor: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPinnedToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(
              8.sp,
            ),
            child: const DText(
              text: 'Long press package in order to delete',
            ),
          ),
        ),
        SliverFillRemaining(
          child: packages != null || packages != []
              ? ListView(
                  padding: EdgeInsets.all(
                    2.w,
                  ),
                  children: [
                    ...packages!
                        .map((e) => PackageCard(
                              activityNotifier: activityNotifier,
                              index: packages!.indexOf(e),
                              package: e,
                              activityId: activityId,
                              packages: packages,
                            ))
                        .toList(),
                  ],
                )
              : Center(
                  child: Column(
                    children: const [
                      DText(
                        text: 'No packages',
                      )
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

// tablet activity packages page
class _TabletActivityPackagesPage extends HookConsumerWidget {
  const _TabletActivityPackagesPage({
    Key? key,
    this.packages,
    this.activityId,
    this.activityNotifier,
  }) : super(key: key);
  final List<Package>? packages;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
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
    this.activityNotifier,
  }) : super(key: key);
  final List<Package>? packages;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
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

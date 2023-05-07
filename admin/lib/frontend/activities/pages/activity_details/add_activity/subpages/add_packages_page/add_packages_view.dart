import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

// add packages view hook consumer widget with app layout
class AddPackagesView extends HookConsumerWidget {
  const AddPackagesView({
    super.key,
    required this.packageData,
    required this.activityNotifier,
  });
  final List<Package> packageData;
  final AddActivityNotifier activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileAddPackagesView(
        packageData: packageData,
        activityNotifier: activityNotifier,
      ),
      tablet: _TabletAddPackagesView(
        packageData: packageData,
        activityNotifier: activityNotifier,
      ),
      desktop: _DesktopAddPackagesView(
        packageData: packageData,
        activityNotifier: activityNotifier,
      ),
    );
  }
}

// mobile add packages view
class _MobileAddPackagesView extends HookConsumerWidget {
  const _MobileAddPackagesView({
    required this.packageData,
    required this.activityNotifier,
  });
  final List<Package> packageData;
  final AddActivityNotifier activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          packageData.isEmpty
              ? const SliverToBoxAdapter()
              : SliverAppBar(
                  title: DText(
                    text: 'Add packages',
                    fontSize: 14.sp,
                  ),
                  pinned: true,
                  automaticallyImplyLeading: false,
                  actions: [
                    TextButton.icon(
                      onPressed: () {
                        //TODO : implement delete all packages
                        // packageData = [];
                      },
                      icon: LineIcon.trash(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                      label: DText(
                        text: 'Clear All',
                        fontSize: 12.sp,
                        textColor:
                            Theme.of(context).colorScheme.onErrorContainer,
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .errorContainer
                            .withOpacity(
                              0.2,
                            ),
                        fixedSize: Size(
                          30.w,
                          2.h,
                        ),
                      ),
                    ),
                  ],
                ),
          packageData.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                      height: 76.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          DText(
                            text: 'No packages added yet',
                            fontSize: 14.sp,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          TextButton(
                            onPressed: () async {
                              final newPackage = await Navigator.push<Package>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AddPackagePage(),
                                ),
                              );
                              // update in list
                              if (newPackage != null) {
                                activityNotifier.updatePackages(
                                  package: newPackage,
                                );
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceVariant
                                  .withOpacity(
                                    0.3,
                                  ),
                              padding: EdgeInsets.all(8.sp),
                            ),
                            child: DText(
                              text: 'Add packages',
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 2.h,
                        ),
                        child: AddPackageViewCard(
                          package: packageData[index],
                        ),
                      );
                    },
                    childCount: packageData.length,
                  ),
                ),
        ],
      ),
      floatingActionButton: CustomElevatedButton(
        onPressed: () async {
          final newPackage = await Navigator.push<Package>(
            context,
            MaterialPageRoute(
              builder: (_) => const AddPackagePage(),
            ),
          );
          // add package to list
          if (newPackage != null) {
            activityNotifier.updatePackages(
              package: newPackage,
            );
          }
        },
        text: 'Add package',
        fontSize: 12.sp,
        width: 10.w,
        height: 7.h,
        borderRadius: BorderRadius.circular(
          10.sp,
        ),
      ),
    );
  }
}

// tablet add packages view
class _TabletAddPackagesView extends HookConsumerWidget {
  const _TabletAddPackagesView({
    required this.packageData,
    required this.activityNotifier,
  });
  final List<Package> packageData;
  final AddActivityNotifier activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// desktop add packages view
class _DesktopAddPackagesView extends HookConsumerWidget {
  const _DesktopAddPackagesView({
    required this.packageData,
    required this.activityNotifier,
  });
  final List<Package> packageData;
  final AddActivityNotifier activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

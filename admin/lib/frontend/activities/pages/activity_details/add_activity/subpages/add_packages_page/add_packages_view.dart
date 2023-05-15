import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                        // packageData = [];
                        activityNotifier.clearAllPackages();
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
                              final addPckgModel = AddPackageModel(
                                package: Package(),
                                activityId: '',
                                packageCopy: Package(),
                                packages: packageData,
                                activityNotifier: activityNotifier,
                              );
                              final newPackage =
                                  await context.pushNamed<Package>(
                                'addNewPackage',
                                extra: addPckgModel,
                              );
                              // add package to list
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
                          horizontal: 1.5.w,
                        ),
                        child: CustomPackageCard(
                          package: packageData[index],
                          navigateTo: () async {
                            final addPckgModel = AddPackageModel(
                              package: packageData[index],
                              activityId: '',
                              packageCopy: packageData[index],
                              packages: packageData,
                              activityNotifier: activityNotifier,
                              index: index,
                            );

                            final newPackage = await context.pushNamed<Package>(
                              'editNewPackage',
                              extra: addPckgModel,
                            );

                            // update in list
                            if (newPackage != null) {
                              activityNotifier.updatePackageInList(
                                package: newPackage,
                                index: index,
                              );
                            }
                          },
                          deletePackage: () {
                            activityNotifier.removePackageFromList(
                              index: index,
                            );
                          },
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
          final addPckgModel = AddPackageModel(
            package: Package(),
            activityId: '',
            packageCopy: Package(),
            packages: packageData,
            activityNotifier: activityNotifier,
          );
          final newPackage = await context.pushNamed<Package>(
            'addNewPackage',
            extra: addPckgModel,
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

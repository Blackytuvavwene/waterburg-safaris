import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

// add packages view hook consumer widget with app layout
class AddPackagesView extends HookConsumerWidget {
  const AddPackagesView({
    super.key,
    required this.packageData,
  });
  final ValueNotifier<List<Package>> packageData;
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
    required this.packageData,
  });
  final ValueNotifier<List<Package>> packageData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: CustomScrollView(slivers: [
        packageData.value.isEmpty
            ? const SliverToBoxAdapter()
            : SliverAppBar(
                title: DText(
                  text: 'Add packages',
                  fontSize: 14.sp,
                ),
                automaticallyImplyLeading: false,
              ),
        packageData.value.isEmpty
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
                            packageData.value = [
                              ...packageData.value,
                              if (newPackage != null) newPackage,
                            ];
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
                      child: PackageCard(
                        package: packageData.value[index],
                      ),
                    );
                  },
                  childCount: packageData.value.length,
                ),
              ),
      ]),
    );
  }
}

// tablet add packages view
class _TabletAddPackagesView extends HookConsumerWidget {
  const _TabletAddPackagesView({
    this.packageData,
  });
  final ValueNotifier<List<Package>>? packageData;
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
  final ValueNotifier<List<Package>>? packageData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

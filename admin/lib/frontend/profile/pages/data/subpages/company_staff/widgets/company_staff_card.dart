import 'package:admin/lib.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';

// company staff card hook consumer widget with app layout
class CompanyStaffCard extends HookConsumerWidget {
  const CompanyStaffCard({
    Key? key,
    this.companyStaff,
    this.companyId,
  }) : super(key: key);
  final CompanyStaff? companyStaff;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyStaffCard(
        companyStaff: companyStaff,
        companyId: companyId,
      ),
      tablet: _TabletCompanyStaffCard(
        companyStaff: companyStaff,
        companyId: companyId,
      ),
      desktop: _DesktopCompanyStaffCard(
        companyStaff: companyStaff,
        companyId: companyId,
      ),
    );
  }
}

// mobile company staff card
class _MobileCompanyStaffCard extends HookConsumerWidget {
  const _MobileCompanyStaffCard({
    this.companyStaff,
    this.companyId,
  });
  final CompanyStaff? companyStaff;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ExtendedImage.network(
                    companyStaff!.imageUrl!,
                    fit: BoxFit.fill,
                    shape: BoxShape.circle,
                    width: 110,
                    height: 100,
                    loadStateChanged: (state) {
                      switch (state.extendedImageLoadState) {
                        case LoadState.loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case LoadState.completed:
                          return ExtendedRawImage(
                            image: state.extendedImageInfo?.image,
                            fit: BoxFit.fill,
                            width: 110,
                            height: 100,
                          );
                        case LoadState.failed:
                          return const Center(
                            child: Icon(Icons.error),
                          );
                      }
                    },
                  ),
                ),
                ListTile(
                  title: Text(companyStaff!.fullName.toString()),
                  subtitle: Text(companyStaff!.jobTitle.toString()),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: PopupMenuButton(
                color: Theme.of(context).colorScheme.secondary,
                itemBuilder: (context) {
                  //TODO: add edit and delete options and navigate to edit page
                  return [
                    PopupMenuItem(
                      value: 'edit',
                      child: const Text('Edit'),
                      onTap: () {
                        // pass company staff data & company ID to edit page as arguments
                        final args = EditStaffRouteArguments(
                          staff: companyStaff,
                          companyId: companyId,
                        );
                        context.pushNamed(
                          'editStaffDetails',
                          extra: args,
                        );
                      },
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ];
                },
                icon: LineIcon.caretDown(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// tablet company staff card
class _TabletCompanyStaffCard extends HookConsumerWidget {
  const _TabletCompanyStaffCard({
    this.companyStaff,
    this.companyId,
  });
  final CompanyStaff? companyStaff;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            companyStaff!.imageUrl!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(companyStaff!.fullName.toString()),
            subtitle: Text(companyStaff!.jobTitle.toString()),
          ),
        ],
      ),
    );
  }
}

// desktop company staff card
class _DesktopCompanyStaffCard extends HookConsumerWidget {
  const _DesktopCompanyStaffCard({
    this.companyStaff,
    this.companyId,
  });
  final CompanyStaff? companyStaff;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            companyStaff!.imageUrl!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(companyStaff!.fullName.toString()),
            subtitle: Text(companyStaff!.jobTitle.toString()),
          ),
        ],
      ),
    );
  }
}

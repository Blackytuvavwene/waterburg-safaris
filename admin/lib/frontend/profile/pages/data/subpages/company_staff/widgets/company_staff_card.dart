import 'package:admin/lib.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';

// company staff card hook consumer widget with app layout
class CompanyStaffCard extends HookConsumerWidget {
  const CompanyStaffCard({
    Key? key,
    this.companyStaff,
  }) : super(key: key);
  final CompanyStaff? companyStaff;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyStaffCard(
        companyStaff: companyStaff,
      ),
      tablet: _TabletCompanyStaffCard(
        companyStaff: companyStaff,
      ),
      desktop: _DesktopCompanyStaffCard(
        companyStaff: companyStaff,
      ),
    );
  }
}

// mobile company staff card
class _MobileCompanyStaffCard extends HookConsumerWidget {
  const _MobileCompanyStaffCard({
    this.companyStaff,
  });
  final CompanyStaff? companyStaff;
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
                        context.pushNamed('editStaffDetails',
                            extra: companyStaff);
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
  });
  final CompanyStaff? companyStaff;
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
  });
  final CompanyStaff? companyStaff;
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

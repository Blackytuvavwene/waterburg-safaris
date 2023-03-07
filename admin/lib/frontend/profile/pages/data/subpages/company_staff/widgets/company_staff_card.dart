import 'dart:io';

import 'package:admin/lib.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

// company staff card hook consumer widget with app layout
class CompanyStaffCard extends HookConsumerWidget {
  const CompanyStaffCard({
    Key? key,
    this.companyStaff,
    this.companyId,
    this.onDelete,
    this.onTap,
    this.localStaff,
  }) : super(key: key);
  final CompanyStaff? companyStaff;
  final String? companyId;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  final LocalCompanyStaffModel? localStaff;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyStaffCard(
        companyStaff: companyStaff,
        companyId: companyId,
        onDelete: onDelete,
        onTap: onTap,
        localStaff: localStaff,
      ),
      tablet: _TabletCompanyStaffCard(
        companyStaff: companyStaff,
        companyId: companyId,
        onDelete: onDelete,
        onTap: onTap,
      ),
      desktop: _DesktopCompanyStaffCard(
        companyStaff: companyStaff,
        companyId: companyId,
        onDelete: onDelete,
        onTap: onTap,
      ),
    );
  }
}

// mobile company staff card
class _MobileCompanyStaffCard extends HookConsumerWidget {
  const _MobileCompanyStaffCard({
    this.companyStaff,
    this.companyId,
    this.onDelete,
    this.onTap,
    this.localStaff,
  });
  final CompanyStaff? companyStaff;
  final String? companyId;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  final LocalCompanyStaffModel? localStaff;
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
                  child: localStaff?.image?.path != null &&
                          localStaff?.image?.path != ''
                      ? ExtendedImage.file(
                          File(
                            localStaff!.image!.path.toString(),
                          ),
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
                        )
                      : companyStaff?.imageUrl != null
                          ? ExtendedImage.network(
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
                            )
                          : SizedBox(
                              height: 8.h,
                              child: const Center(
                                child: DText(
                                  text: 'No image',
                                ),
                              ),
                            ),
                ),
                ListTile(
                  title: DText(
                    text: companyStaff?.fullName.toString() ??
                        localStaff?.staffDetails?.fullName.toString(),
                  ),
                  subtitle: DText(
                    text: companyStaff?.jobTitle.toString() ??
                        localStaff?.staffDetails?.jobTitle.toString(),
                  ),
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
                      textStyle: GoogleFonts.dosis(),
                      onTap: onTap,
                      child: const Text(
                        'Edit',
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      textStyle: GoogleFonts.dosis(),
                      onTap: onDelete,
                      child: const Text(
                        'Delete',
                      ),
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
    this.onDelete,
    this.onTap,
  });
  final CompanyStaff? companyStaff;
  final String? companyId;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

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
    this.onDelete,
    this.onTap,
  });
  final CompanyStaff? companyStaff;
  final String? companyId;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
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

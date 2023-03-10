import 'dart:io';

import 'package:admin/lib.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
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
      child: SizedBox(
        width: 100.w,
        height: 15.h,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 2,
                child: localStaff?.image?.path != null &&
                        localStaff?.image?.path != ''
                    ? ExtendedImage.file(
                        File(
                          localStaff!.image!.path.toString(),
                        ),
                        fit: BoxFit.cover,
                        width: 100.w,
                        height: 150,
                        loadStateChanged: (state) {
                          switch (state.extendedImageLoadState) {
                            case LoadState.loading:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case LoadState.completed:
                              return ExtendedRawImage(
                                image: state.extendedImageInfo?.image,
                                fit: BoxFit.cover,
                                width: 100.w,
                                height: 150,
                              );
                            case LoadState.failed:
                              return Center(
                                child: LineIcon.exclamationTriangle(),
                              );
                          }
                        },
                      )
                    : companyStaff?.imageUrl != null
                        ? ExtendedImage.network(
                            companyStaff!.imageUrl!,
                            fit: BoxFit.cover,
                            width: 100.w,
                            height: 150,
                            loadStateChanged: (state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.loading:
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                case LoadState.completed:
                                  return ExtendedRawImage(
                                    image: state.extendedImageInfo?.image,
                                    fit: BoxFit.cover,
                                    width: 100.w,
                                    height: 150,
                                  );
                                case LoadState.failed:
                                  return Center(
                                    child: LineIcon.exclamationTriangle(),
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
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InfoTile(
                        title: companyStaff?.fullName.toString() ??
                            localStaff?.staffDetails?.fullName.toString(),
                        subtitle: companyStaff?.jobTitle.toString() ??
                            (localStaff?.staffDetails?.jobTitle.toString() ??
                                'Please add job position'),
                      ),
                      SizedBoxAppSpacing.smallY(),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: TextButton(
                                onPressed: onDelete,
                                style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                  minimumSize: Size.fromWidth(
                                    25.w,
                                  ),
                                ),
                                child: DText(
                                  text: 'Delete',
                                  textColor: Theme.of(context)
                                      .colorScheme
                                      .onErrorContainer,
                                ),
                              ),
                            ),
                            Flexible(
                              child: TextButton(
                                onPressed: onTap,
                                style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  minimumSize: Size.fromWidth(
                                    25.w,
                                  ),
                                ),
                                child: DText(
                                  text: 'Edit',
                                  textColor: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
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

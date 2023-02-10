import 'package:admin/lib.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class CompanyGalleryCard extends HookConsumerWidget {
  const CompanyGalleryCard({
    super.key,
    this.companyGallery,
  });
  final Gallery? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyGalleryCard(
        companyGallery: companyGallery,
      ),
      tablet: _TabletCompanyGalleryCard(
        companyGallery: companyGallery,
      ),
      desktop: _DesktopCompanyGalleryCard(
        companyGallery: companyGallery,
      ),
    );
  }
}

// mobile company gallery card
class _MobileCompanyGalleryCard extends HookConsumerWidget {
  const _MobileCompanyGalleryCard({
    this.companyGallery,
  });
  final Gallery? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          ExtendedImage.network(
            '${companyGallery?.imageUrl.toString()}',
            width: 100.w,
            height: 20.h,
            fit: BoxFit.cover,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                5.sp,
              ),
            ),
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
                    height: 20.h,
                  );
                case LoadState.failed:
                  return const Center(
                    child: DText(
                      text: 'Failed to load image',
                    ),
                  );
              }
            },
          ),
          ListTile(
            title: DText(
              text: companyGallery!.imageTitle!,
            ),
            subtitle: DText(
              text: companyGallery!.imageDescription!,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: IconButton(
                    onPressed: () {},
                    color: Theme.of(context).colorScheme.primaryContainer,
                    icon: LineIcon.editAlt(),
                  ),
                ),
                Flexible(
                  child: IconButton(
                    onPressed: () async {
                      // await ref.read(f)
                    },
                    color: Theme.of(context).colorScheme.errorContainer,
                    icon: LineIcon.trash(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// tablet company gallery card
class _TabletCompanyGalleryCard extends HookConsumerWidget {
  const _TabletCompanyGalleryCard({
    this.companyGallery,
  });
  final Gallery? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            companyGallery!.imageUrl!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(companyGallery!.imageTitle!),
            subtitle: Text(companyGallery!.imageDescription!),
          ),
        ],
      ),
    );
  }
}

// desktop company gallery card
class _DesktopCompanyGalleryCard extends HookConsumerWidget {
  const _DesktopCompanyGalleryCard({
    this.companyGallery,
  });
  final Gallery? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            companyGallery!.imageUrl!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(companyGallery!.imageTitle!),
            subtitle: Text(companyGallery!.imageDescription!),
          ),
        ],
      ),
    );
  }
}

// picked image cards
class PickedCompanyGalleryCard extends HookConsumerWidget {
  const PickedCompanyGalleryCard({
    super.key,
    this.companyGallery,
  });
  final ImageHelperModel? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _PickedMobileCompanyGalleryCard(
        companyGallery: companyGallery,
      ),
      tablet: _PickedTabletCompanyGalleryCard(
        companyGallery: companyGallery,
      ),
      desktop: _PickedDesktopCompanyGalleryCard(
        companyGallery: companyGallery,
      ),
    );
  }
}

// mobile company gallery card
class _PickedMobileCompanyGalleryCard extends HookConsumerWidget {
  const _PickedMobileCompanyGalleryCard({
    this.companyGallery,
  });
  final ImageHelperModel? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Flexible(
            child: kIsWeb
                ? ExtendedImage.network(
                    '${companyGallery?.imageFile?.filePath}',
                    width: 100.w,
                    height: 10.h,
                    fit: BoxFit.cover,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        5.sp,
                      ),
                    ),
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
                            height: 10.h,
                          );
                        case LoadState.failed:
                          return const Center(
                            child: DText(
                              text: 'Failed to load image',
                            ),
                          );
                      }
                    },
                  )
                : ExtendedImage.memory(
                    companyGallery!.bytes!,
                    width: 100.w,
                    height: 15.h,
                    fit: BoxFit.cover,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        5.sp,
                      ),
                    ),
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
                            height: 15.h,
                          );
                        case LoadState.failed:
                          return const Center(
                            child: DText(
                              text: 'Failed to load image',
                            ),
                          );
                      }
                    },
                  ),
          ),
          Flexible(
            child: ListTile(
              title: DText(
                text: companyGallery!.imageDetails!.imageTitle!.isNotEmpty
                    ? companyGallery!.imageDetails!.imageTitle
                    : 'Edit image title',
              ),
              subtitle: DText(
                text: companyGallery?.imageDetails?.imageTitle ??
                    'Edit image description',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: IconButton(
                      onPressed: () {},
                      color: Theme.of(context).colorScheme.primaryContainer,
                      icon: LineIcon.editAlt(),
                    ),
                  ),
                  Flexible(
                    child: IconButton(
                      onPressed: () async {
                        // remove from list
                        ref
                            .read(imageControllerNotifierProvider.notifier)
                            .removeImageFromState(image: companyGallery!);
                      },
                      color: Theme.of(context).colorScheme.errorContainer,
                      icon: LineIcon.trash(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// tablet company gallery card
class _PickedTabletCompanyGalleryCard extends HookConsumerWidget {
  const _PickedTabletCompanyGalleryCard({
    this.companyGallery,
  });
  final ImageHelperModel? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            companyGallery!.path!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(companyGallery!.imageDetails!.imageTitle!),
            subtitle: Text(companyGallery!.imageDetails!.imageDescription!),
          ),
        ],
      ),
    );
  }
}

// desktop company gallery card
class _PickedDesktopCompanyGalleryCard extends HookConsumerWidget {
  const _PickedDesktopCompanyGalleryCard({
    this.companyGallery,
  });
  final ImageHelperModel? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            companyGallery!.path!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(companyGallery!.imageDetails!.imageTitle!),
            subtitle: Text(companyGallery!.imageDetails!.imageDescription!),
          ),
        ],
      ),
    );
  }
}

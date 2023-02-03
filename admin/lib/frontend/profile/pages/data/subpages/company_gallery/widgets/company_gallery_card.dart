import 'package:admin/lib.dart';
import 'package:extended_image/extended_image.dart';
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
                    height: 30.h,
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

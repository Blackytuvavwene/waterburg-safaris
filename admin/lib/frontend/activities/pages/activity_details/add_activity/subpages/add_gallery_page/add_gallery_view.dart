import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

// add gallery view hook consumer widget with app layout
class AddGalleryView extends HookConsumerWidget {
  const AddGalleryView({
    super.key,
    required this.galleryData,
  });
  final ValueNotifier<List<ImageHelperModel>> galleryData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileAddGalleryView(
        galleryData: galleryData,
      ),
      tablet: _TabletAddGalleryView(
        galleryData: galleryData,
      ),
      desktop: _DesktopAddGalleryView(
        galleryData: galleryData,
      ),
    );
  }
}

// mobile add gallery view
class _MobileAddGalleryView extends HookConsumerWidget {
  const _MobileAddGalleryView({
    required this.galleryData,
  });
  final ValueNotifier<List<ImageHelperModel>> galleryData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: CustomScrollView(
        slivers: [
          galleryData.value.isNotEmpty
              ? SliverAppBar(
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  title: DText(
                    text: 'Activity gallery',
                    fontSize: 14.sp,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        //TODO: add gallery
                        final newGallery =
                            await ImageHelpers.pickAddMultipleImages();

                        galleryData.value = newGallery != null
                            ? [...galleryData.value, ...newGallery]
                            : galleryData.value;
                      },
                      child: DText(
                        text: 'Pick images',
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                )
              : const SliverToBoxAdapter(),
          SliverPersistentHeader(
            delegate: ImageCounterHeader(
              galleryCount: galleryData.value.length,
            ),
            pinned: true,
          ),
          galleryData.value.isNotEmpty
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: 1.h,
                          bottom: 1.h,
                          left: 2.w,
                          right: 2.w,
                        ),
                        child: AddPickedImage(image: galleryData.value[index]),
                      );
                    },
                    childCount: galleryData.value.length,
                  ),
                )
              : SliverToBoxAdapter(
                  child: SizedBox(
                    height: 70.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        DText(
                          text: 'No images selected yet',
                          fontSize: 14.sp,
                        ),
                        SizedBox(height: 2.h),
                        TextButton(
                          onPressed: () async {
                            //TODO: add gallery
                            final newGallery =
                                await ImageHelpers.pickAddMultipleImages();

                            galleryData.value = newGallery != null
                                ? [...galleryData.value, ...newGallery]
                                : galleryData.value;
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(
                                  0.1,
                                ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.5.h,
                            ),
                          ),
                          child: DText(
                            text: 'Add images',
                            fontSize: 12.sp,
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

// tablet add gallery view
class _TabletAddGalleryView extends HookConsumerWidget {
  const _TabletAddGalleryView({
    this.galleryData,
  });
  final ValueNotifier<List<ImageHelperModel>>? galleryData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// desktop add gallery view
class _DesktopAddGalleryView extends HookConsumerWidget {
  const _DesktopAddGalleryView({
    this.galleryData,
  });
  final ValueNotifier<List<ImageHelperModel>>? galleryData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

class ImageCounterHeader extends SliverPersistentHeaderDelegate {
  ImageCounterHeader({
    required this.galleryCount,
  });
  final int galleryCount;
  @override
  double minExtent = 50;
  @override
  double maxExtent = 50;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      child: Container(
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.background.withOpacity(
              0.5,
            ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Row(
            children: [
              DText(
                text: 'Picked ',
                fontSize: 14.sp,
              ),
              const Spacer(),
              DText(
                text: '$galleryCount images',
                fontSize: 12.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}

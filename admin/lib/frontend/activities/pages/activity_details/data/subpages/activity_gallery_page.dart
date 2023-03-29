import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

// activity gallery page with app layout hook consumer widget
class ActivityGalleryPage extends HookConsumerWidget {
  const ActivityGalleryPage({
    Key? key,
    this.gallery,
    this.activityId,
    this.activityNotifier,
    this.localImageProvider,
    this.imageControllerNotifier,
    this.isEditing,
    this.initialActivity,
  }) : super(key: key);
  final List<Gallery>? gallery;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  final AsyncValue<List<ImageHelperModel>?>? localImageProvider;
  final ImageControllerNotifier? imageControllerNotifier;
  final ValueNotifier<bool>? isEditing;
  final Activity? initialActivity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileActivityGalleryPage(
        gallery: gallery,
        activityId: activityId,
        activityNotifier: activityNotifier,
        localImageProvider: localImageProvider,
        imageControllerNotifier: imageControllerNotifier,
        isEditing: isEditing!,
      ),
      tablet: _TabletActivityGalleryPage(
        gallery: gallery,
        activityId: activityId,
        activityNotifier: activityNotifier,
      ),
      desktop: _DesktopActivityGalleryPage(
        gallery: gallery,
        activityId: activityId,
        activityNotifier: activityNotifier,
      ),
    );
  }
}

// mobile activity gallery page
class _MobileActivityGalleryPage extends HookConsumerWidget {
  const _MobileActivityGalleryPage({
    Key? key,
    this.gallery,
    this.activityId,
    this.activityNotifier,
    this.imageControllerNotifier,
    this.localImageProvider,
    required this.isEditing,
  }) : super(key: key);
  final List<Gallery>? gallery;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  final AsyncValue<List<ImageHelperModel>?>? localImageProvider;
  final ImageControllerNotifier? imageControllerNotifier;
  final ValueNotifier<bool> isEditing;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // activity gallery tabs
    final tabs = [
      Tab(
        text: 'Saved Images',
        icon: LineIcon.images(
          size: 16.sp,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      Tab(
        text: 'New Images',
        icon: LineIcon.imagesAlt(
          size: 16.sp,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    ];

    // activity gallery tab controller
    final tabController = useTabController(
      initialLength: tabs.length,
    );

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: DText(
            text: 'Activity Images',
            fontSize: 16.sp,
          ),
          automaticallyImplyLeading: false,
          bottom: localImageProvider?.asData?.value?.isNotEmpty == true
              ? TabBar(
                  controller: tabController,
                  tabs: tabs,
                )
              : null,
          actions: [
            SizedBox(
              height: 2,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                icon: LineIcon.plusCircle(
                  size: 16.sp,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                label: const DText(
                  text: 'Add Images',
                ),
                onPressed: () async {
                  // set is editing to true if not already
                  if (!isEditing.value) {
                    isEditing.value = true;
                  }
                  // pick images
                  await imageControllerNotifier!.pickImages();
                },
              ),
            ),
          ],
        ),
        if (localImageProvider?.value != null &&
            localImageProvider?.asData?.value?.isNotEmpty == true)
          SliverFillRemaining(
            child: TabBarView(
              controller: tabController,
              children: [
                ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 2.w,
                        right: 2.w,
                      ),
                      child: ImageCard(
                        imageDetails: gallery![index],
                      ),
                      //TODO: add on remove image
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 4.h,
                    );
                  },
                  itemCount: gallery!.length.toInt(),
                ),
                ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 2.w,
                        right: 2.w,
                      ),
                      child: PickedImageCard(
                        imageData: localImageProvider!.value![index],
                        onRemoveImage: () {
                          imageControllerNotifier!.removeImageFromState(
                            image: localImageProvider!.value![index],
                          );
                        },
                        onUpdateImageDetails: (image, imageDetails) {
                          // update image details
                          imageControllerNotifier!.updateImageGalleryDetails(
                            theImage: image,
                            galleryDetails: imageDetails,
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 4.h,
                    );
                  },
                  itemCount: localImageProvider!.value!.length,
                ),
              ],
            ),
          )
        else if (gallery != null || gallery!.isNotEmpty)
          SliverFillRemaining(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: gallery!.length.toInt(),
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 1.5.h,
                );
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 2.w,
                    right: 2.w,
                  ),
                  child: ImageCard(
                    imageDetails: gallery![index],
                    onRemoveImage: () {
                      // set is editing to true if not already
                      if (!isEditing.value) {
                        isEditing.value = true;
                      }

                      // remove image from activity gallery
                      activityNotifier?.deleteImageFromActivityGallery(
                        index: index,
                      );
                    },
                  ),
                );
              },
            ),
          )
        else
          SliverFillRemaining(
            child: Center(
              child: DText(
                text: 'No images found',
                fontSize: 16.sp,
              ),
            ),
          ),
      ],
    );
  }
}

// tablet activity gallery page
class _TabletActivityGalleryPage extends HookConsumerWidget {
  const _TabletActivityGalleryPage({
    Key? key,
    this.gallery,
    this.activityId,
    this.activityNotifier,
  }) : super(key: key);
  final List<Gallery>? gallery;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 90.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DText(
                    text: 'Activity Images',
                    fontSize: 16.sp,
                  ),
                  IconButton(
                    icon: LineIcon.editAlt(
                      size: 16.sp,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    onPressed: () {
                      //todo: show add image dialog
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => AddImagesDialog(
                      //     activityId: activityId.toString(),
                      //   ),
                      // );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              width: 100.w,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 80.h,
                ),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: gallery!.length.toInt(),
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 4.h,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 2.w,
                        right: 2.w,
                      ),
                      child: ImageCard(
                        imageDetails: gallery![index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// desktop activity gallery page
class _DesktopActivityGalleryPage extends HookConsumerWidget {
  const _DesktopActivityGalleryPage({
    Key? key,
    this.gallery,
    this.activityId,
    this.activityNotifier,
  }) : super(key: key);
  final List<Gallery>? gallery;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 90.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DText(
                    text: 'Activity Images',
                    fontSize: 16.sp,
                  ),
                  IconButton(
                    icon: LineIcon.editAlt(
                      size: 16.sp,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    onPressed: () {
                      //todo: show add image dialog for desktop
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => AddImagesDialog(
                      //     activityId: activityId.toString(),
                      //   ),
                      // );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              width: 100.w,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 80.h,
                ),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: gallery!.length.toInt(),
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 4.h,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 2.w,
                        right: 2.w,
                      ),
                      child: ImageCard(
                        imageDetails: gallery![index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

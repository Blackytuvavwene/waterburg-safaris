import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
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
  }) : super(key: key);
  final List<Gallery>? gallery;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileActivityGalleryPage(
        gallery: gallery,
        activityId: activityId,
        activityNotifier: activityNotifier,
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
  }) : super(key: key);
  final List<Gallery>? gallery;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 90.h,
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
                      // show add image dialog
                      showDialog(
                        context: context,
                        builder: (context) => AddImagesDialog(
                          activityId: activityId.toString(),
                        ),
                      );
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
                  maxHeight: 58.h,
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
                      child: ActivityImageCard(
                        image: gallery![index],
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
                      // show add image dialog
                      showDialog(
                        context: context,
                        builder: (context) => AddImagesDialog(
                          activityId: activityId.toString(),
                        ),
                      );
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
                      child: ActivityImageCard(
                        image: gallery![index],
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
                      // show add image dialog
                      showDialog(
                        context: context,
                        builder: (context) => AddImagesDialog(
                          activityId: activityId.toString(),
                        ),
                      );
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
                      child: ActivityImageCard(
                        image: gallery![index],
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

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';
import 'package:vrouter/vrouter.dart';

// dashboard activities data
class DashBoardActivitiesData extends HookConsumerWidget {
  const DashBoardActivitiesData({
    Key? key,
    this.activitiesData,
  }) : super(key: key);
  final List<Activity>? activitiesData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileDashBoardActivitiesData(
        activitiesData: activitiesData,
      ),
      tablet: _TabletDashBoardActivitiesData(
        activitiesData: activitiesData,
      ),
      desktop: _DesktopDashBoardActivitiesData(
        activitiesData: activitiesData,
      ),
    );
  }
}

// dashboard activities data for mobile
class _MobileDashBoardActivitiesData extends HookConsumerWidget {
  const _MobileDashBoardActivitiesData({
    Key? key,
    this.activitiesData,
  }) : super(key: key);
  final List<Activity>? activitiesData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        height: 45.h,
        width: 100.w,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 4.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100.w,
                child: Row(
                  children: [
                    DText(
                      text: 'Activities',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        ref
                            .read(routeIndexProvider.notifier)
                            .setIndexFromPath('activities');

                        context.vRouter.toNamed('activities');
                      },
                      // style: TextButton.styleFrom(),
                      icon: LineIcon.chevronCircleRight(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: DText(
                        text: 'View all',
                        textColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemCount: activitiesData!.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    return ActivityCard(
                      activity: activitiesData?[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

// dashboard activities data for tablet
class _TabletDashBoardActivitiesData extends HookConsumerWidget {
  const _TabletDashBoardActivitiesData({
    Key? key,
    this.activitiesData,
  }) : super(key: key);
  final List<Activity>? activitiesData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 55.h,
      width: 100.w,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 10.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DText(
                  text: 'Activities',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    ref
                        .read(routeIndexProvider.notifier)
                        .setIndexFromPath('activities');

                    context.vRouter.toNamed('activities');
                  },
                  // style: TextButton.styleFrom(),
                  icon: LineIcon.chevronCircleRight(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  label: DText(
                    text: 'View all',
                    textColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.custom(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                childrenDelegate: SliverChildListDelegate(
                  activitiesData!
                      .map(
                        (e) => ActivityCard(
                          activity: e,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// dashboard activities data for desktop
class _DesktopDashBoardActivitiesData extends HookConsumerWidget {
  const _DesktopDashBoardActivitiesData({
    Key? key,
    this.activitiesData,
  }) : super(key: key);
  final List<Activity>? activitiesData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 56.h,
      width: 100.w,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 10.h,
        ),
        child: Column(
          children: [
            Row(
              children: [
                DText(
                  text: 'Activities',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    ref
                        .read(routeIndexProvider.notifier)
                        .setIndexFromPath('activities');

                    context.vRouter.toNamed('activities');
                  },
                  // style: TextButton.styleFrom(),
                  icon: LineIcon.chevronCircleRight(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  label: DText(
                    text: 'View all',
                    textColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.custom(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                childrenDelegate: SliverChildListDelegate(
                  activitiesData!
                      .map(
                        (e) => ActivityCard(
                          activity: e,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityCard extends HookConsumerWidget {
  const ActivityCard({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _ActivityCardMobile(
        activity: activity,
      ),
      tablet: _ActivityCardTablet(
        activity: activity,
      ),
      desktop: _ActivityCardDesktop(
        activity: activity,
      ),
    );
  }
}

// activity card for mobile
class _ActivityCardMobile extends HookConsumerWidget {
  const _ActivityCardMobile({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100.w,
      height: 10.h,
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 2.h,
      ),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //TODO: add activity image
          // Expanded(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       image: DecorationImage(
          //         image: NetworkImage(
          //           activity!.activityGallery![0].imageUrl.toString(),
          //         ),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 10),
          DText(
            text: activity!.activityName!,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            textColor: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          const SizedBox(height: 5),
          DText(
            text: activity!.seoDescription!,
            fontSize: 10.sp,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textColor: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ],
      ),
    );
  }
}

// activity card for tablet
class _ActivityCardTablet extends HookConsumerWidget {
  const _ActivityCardTablet({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100.w,
      height: 16.h,
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
        vertical: 2.h,
      ),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //TODO: add activity image
          // Expanded(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       image: DecorationImage(
          //         image: NetworkImage(
          //           activity!.activityGallery![0].imageUrl.toString(),
          //         ),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 10),
          DText(
            text: activity!.activityName!,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            textColor: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          const SizedBox(height: 5),
          DText(
            text: activity!.seoDescription!,
            fontSize: 8.sp,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textColor: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ],
      ),
    );
  }
}

// activity card for desktop
class _ActivityCardDesktop extends HookConsumerWidget {
  const _ActivityCardDesktop({Key? key, this.activity}) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100.w,
      height: 40.h,
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
        vertical: 2.h,
      ),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //TODO: add activity image
          // Expanded(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       image: DecorationImage(
          //         image: NetworkImage(
          //           activity!.activityGallery![0].imageUrl.toString(),
          //         ),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 10),
          DText(
            text: activity!.activityName!,
            fontSize: 8.sp,
            fontWeight: FontWeight.w600,
            textColor: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          const SizedBox(height: 5),
          Expanded(
            child: DText(
              text: activity!.seoDescription!,
              fontSize: 6.sp,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textColor: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';
import 'package:vrouter/vrouter.dart';

// dashboard bookings data
class DashBoardBookingsData extends HookConsumerWidget {
  const DashBoardBookingsData({Key? key, required this.bookingsData})
      : super(key: key);
  final List<BookingModel> bookingsData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileDashBoardBookingsData(
        bookingsData: bookingsData,
      ),
      tablet: _TabletDashBoardBookingsData(
        bookingsData: bookingsData,
      ),
      desktop: _DesktopDashBoardBookingsData(
        bookingsData: bookingsData,
      ),
    );
  }
}

// dashboard bookings data for mobile
class _MobileDashBoardBookingsData extends HookConsumerWidget {
  const _MobileDashBoardBookingsData({Key? key, required this.bookingsData})
      : super(key: key);
  final List<BookingModel> bookingsData;
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
                    text: 'Bookings',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      ref
                          .read(routeIndexProvider.notifier)
                          .setIndexFromPath('bookings');

                      context.vRouter.toNamed('bookings');
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
                itemCount: bookingsData.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  return BookingDataCard(
                    bookingModel: bookingsData[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// dashboard bookings data for tablet
class _TabletDashBoardBookingsData extends HookConsumerWidget {
  const _TabletDashBoardBookingsData({Key? key, required this.bookingsData})
      : super(key: key);
  final List<BookingModel> bookingsData;
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
                  text: 'Bookings',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    ref
                        .read(routeIndexProvider.notifier)
                        .setIndexFromPath('bookings');

                    context.vRouter.toNamed('bookings');
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
                  bookingsData
                      .map(
                        (e) => BookingDataCard(
                          bookingModel: e,
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

// dashboard bookings data for desktop
class _DesktopDashBoardBookingsData extends HookConsumerWidget {
  const _DesktopDashBoardBookingsData({Key? key, required this.bookingsData})
      : super(key: key);
  final List<BookingModel> bookingsData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 70.h,
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
                  text: 'Bookings',
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    ref
                        .read(routeIndexProvider.notifier)
                        .setIndexFromPath('bookings');

                    context.vRouter.toNamed('bookings');
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
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                childrenDelegate: SliverChildListDelegate(
                  bookingsData
                      .map(
                        (e) => BookingDataCard(
                          bookingModel: e,
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

class BookingDataCard extends HookConsumerWidget {
  const BookingDataCard({
    Key? key,
    this.bookingModel,
  }) : super(key: key);
  final BookingModel? bookingModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _BookingDataCardMobile(
        bookingModel: bookingModel,
      ),
      tablet: _BookingDataCardTablet(
        bookingModel: bookingModel,
      ),
      desktop: _BookingDataCardDesktop(
        bookingModel: bookingModel,
      ),
    );
  }
}

// activity card for mobile
class _BookingDataCardMobile extends HookConsumerWidget {
  const _BookingDataCardMobile({
    Key? key,
    this.bookingModel,
  }) : super(key: key);
  final BookingModel? bookingModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100.w,
      height: 10.h,
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 2.h,
      ),
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            text: bookingModel?.activityDetails?.activityName,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            textColor: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          const SizedBox(height: 5),
          DText(
            text: bookingModel?.customerDetails?.fullNames,
            fontSize: 10.sp,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textColor: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          CustomElevatedButton(
            text: 'View details',
            onPressed: () {
              ref
                  .read(routeIndexProvider.notifier)
                  .setIndexFromPath('bookings');

              context.vRouter.toNamed('bookings');
            },
          )
        ],
      ),
    );
  }
}

// activity card for tablet
class _BookingDataCardTablet extends HookConsumerWidget {
  const _BookingDataCardTablet({
    Key? key,
    this.bookingModel,
  }) : super(key: key);
  final BookingModel? bookingModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100.w,
      height: 16.h,
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
        vertical: 2.h,
      ),
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            text: bookingModel?.activityDetails?.activityName,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            textColor: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          const SizedBox(height: 5),
          DText(
            text: bookingModel?.customerDetails?.fullNames,
            fontSize: 8.sp,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textColor: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          CustomElevatedButton(
            text: 'View details',
            onPressed: () {
              ref
                  .read(routeIndexProvider.notifier)
                  .setIndexFromPath('bookings');

              context.vRouter.toNamed('bookings');
            },
          )
        ],
      ),
    );
  }
}

// activity card for desktop
class _BookingDataCardDesktop extends HookConsumerWidget {
  const _BookingDataCardDesktop({
    Key? key,
    this.bookingModel,
  }) : super(key: key);
  final BookingModel? bookingModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100.w,
      height: 40.h,
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
        vertical: 2.h,
      ),
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            text: bookingModel?.activityDetails?.activityName,
            fontSize: 6.sp,
            fontWeight: FontWeight.w600,
            textColor: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          const SizedBox(height: 5),
          DText(
            text: bookingModel?.customerDetails?.fullNames,
            fontSize: 4.sp,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textColor: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          CustomElevatedButton(
            text: 'View details',
            onPressed: () {
              ref
                  .read(routeIndexProvider.notifier)
                  .setIndexFromPath('bookings');

              context.vRouter.toNamed('bookings');
            },
          )
        ],
      ),
    );
  }
}

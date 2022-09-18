import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// booking data dashboard
class BookingDashboard extends HookConsumerWidget {
  const BookingDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsList = ref.watch(bookingDataStreamProvider);
    return bookingsList.when(
      data: (bookings) {
        return DashBoardBookingsData(
          bookingsData: bookings,
        );
      },
      error: (error, stackTrace) {
        return BookingsErrorDashboard(
          error: error.toString(),
        );
      },
      loading: () {
        return const DashBoardBookingsLoading();
      },
    );
  }
}

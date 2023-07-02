import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// bookings page
class BookingsPage extends HookConsumerWidget {
  const BookingsPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingModel = ref.watch(bookingDataStreamProvider);
    return bookingModel.when(
      data: (bookingModel) {
        return BookingsDataPage(
          bookingModel: bookingModel,
        );
      },
      loading: () {
        return const BookingsLoadingPage();
      },
      error: (error, _) {
        return BookingsErrorPage(
          error: error.toString(),
        );
      },
    );
  }
}

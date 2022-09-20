import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// stream booking data from firestore
final bookingDataStreamProvider =
    StreamProvider.autoDispose<List<BookingModel>>((ref) {
  return ref.watch(bookingDbRepositoryProvider).getBookingsFromFirestore();
});

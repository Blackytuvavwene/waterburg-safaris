import 'package:admin/lib.dart';

abstract class BookingDatabaseAbstract {
  // get booking info from firestore
  Future<BookingModel> getBookingFromFirestore({String? bookingCode});

  // stream booking info from firestore
  Stream<BookingModel> streamBookingFromFirestore({String? bookingCode});

  //stream a list of bookings from firestore
  Stream<List<BookingModel>> getBookingsFromFirestore();

  // update booking on firestore
  Future<BookingModel> updateBookingInFirestore({BookingModel? bookingModel});

  // delete booking on firestore
  Future<void> deleteBookingFromFirestore({String? bookingCode});
}

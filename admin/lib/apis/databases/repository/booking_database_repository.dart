import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingDatabaseRepository implements BookingDatabaseAbstract {
  // cloud firestore instance
  final _firestore = FirebaseFirestore.instance;

  // get booking from firestore
  @override
  Future<BookingModel> getBookingFromFirestore({String? bookingCode}) async {
    try {
      final activity =
          await _firestore.collection('bookings').doc(bookingCode).get();
      return BookingModel.fromJson(activity.data()!);
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  // stream booking from firestore
  @override
  Stream<BookingModel> streamBookingFromFirestore({String? bookingCode}) {
    return _firestore.collection('bookings').doc(bookingCode).snapshots().map(
          (data) => BookingModel.fromJson(data.data()!),
        );
  }

  // get a list of bookings from firestore
  @override
  Stream<List<BookingModel>> getBookingsFromFirestore() {
    try {
      var data = _firestore.collection('bookings').snapshots().map(
            (activityData) => activityData.docs.map((e) {
              return BookingModel.fromJson(
                e.data(),
              );
            }).toList(),
          );

      return data;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  // update booking on firestore
  @override
  Future<BookingModel> updateBookingInFirestore(
      {BookingModel? bookingModel}) async {
    try {
      await _firestore
          .collection('bookings')
          .doc(bookingModel?.bookingCode)
          .update(bookingModel!.toJson());

      return bookingModel;
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  // delete activity on firestore
  @override
  Future<void> deleteBookingFromFirestore({String? bookingCode}) async {
    try {
      await _firestore.collection('bookings').doc(bookingCode).delete();
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }
}

import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyDatabaseRepository implements CompanyDatabaseAbstract {
  // cloud firestore instance
  final _firestore = FirebaseFirestore.instance;

  // get comapny info from firestore
  @override
  Future<Company> getBookingFromFirestore({String? companyId}) async {
    try {
      final activity =
          await _firestore.collection('aboutCompany').doc(companyId).get();
      return Company.fromJson(activity.data()!);
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  // stream company info from firestore
  @override
  Stream<Company> streamCompanyFromFirestore({String? companyId}) {
    final companyData =
        _firestore.collection('aboutCompany').doc(companyId).snapshots().map(
              (data) => Company.fromJson(data.data()!),
            );

    return companyData;
  }

  // update company info on firestore
  @override
  Future<Company> updateCompanyInFirestore({Company? companyModel}) async {
    try {
      await _firestore
          .collection('bookings')
          .doc(companyModel?.companyId)
          .update(companyModel!.toJson());

      return companyModel;
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  // delete company info on firestore
  @override
  Future<void> deleteCompanyFromFirestore({String? companyId}) async {
    try {
      await _firestore.collection('activities').doc(companyId).delete();
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }
}

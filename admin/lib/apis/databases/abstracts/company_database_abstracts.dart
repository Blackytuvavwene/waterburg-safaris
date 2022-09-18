import 'package:admin/lib.dart';

abstract class CompanyDatabaseAbstract {
  // get company info from firestore
  Future<Company> getBookingFromFirestore({String? companyId});

  // stream company info from firestore
  Stream<Company> streamCompanyFromFirestore({String? companyId});

  // update company info on firestore
  Future<Company> updateCompanyInFirestore({Company? companyModel});

  // delete company info on firestore
  Future<void> deleteCompanyFromFirestore({String? companyId});
}

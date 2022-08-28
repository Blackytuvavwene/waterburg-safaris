import 'package:admin/lib.dart';

abstract class UserDatabaseAbstract {
  // save user to firestore
  Future<UserModel> saveUserToFirestore({UserModel model});

  // get user from firestore
  Future<UserModel> getUserFromFirestore({String uid});

  // delete user from firestore
  Future<void> deleteUserFromFirestore({String uid});

  // update user in firestore
  Future<UserModel> updateUserInFirestore({UserModel model});
}

import 'dart:convert';

import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// user database repository that implements methods in user database abstract
class UserDatabaseRepository implements UserDatabaseAbstract {
  // cloud firestore instance
  final _firestore = FirebaseFirestore.instance;

  // save user to firestore
  @override
  Future<UserModel> saveUserToFirestore({UserModel? model}) async {
    try {
      final user = await _firestore
          .collection('users')
          .doc(model?.uid)
          .set(model!.toJson());

      return model;
    } catch (e) {
      throw e.toString();
    }
  }

  // get user from firestore
  @override
  Future<UserModel> getUserFromFirestore({String? uid}) async {
    try {
      var user = await _firestore.collection('users').doc(uid).get();
      return UserModel.fromJson(user.data is Map<String, dynamic>
          ? user.data
          : json.decode(user.data.toString()));
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  // delete user from firestore
  @override
  Future<void> deleteUserFromFirestore({String? uid}) async {}

  // update user in firestore
  @override
  Future<UserModel> updateUserInFirestore({UserModel? model}) async {
    try {
      await _firestore
          .collection('users')
          .doc(model?.uid)
          .update(model!.toJson());
      return model;
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }
}

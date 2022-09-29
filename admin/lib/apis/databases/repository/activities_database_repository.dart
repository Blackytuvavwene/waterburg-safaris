import 'dart:async';
import 'dart:io';

import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ActivitiesDatabaseRepository implements ActivitiesDatabaseAbstract {
  // cloud firestore instance
  final _firestore = FirebaseFirestore.instance;
  // firebase storage instance
  final _firebaseStorage = FirebaseStorage.instance;

  // activities storage reference
  _activitiesStorageReference({String? activityId}) {
    return _firebaseStorage.ref().child('activities/$activityId');
  }

  // add a new activity to firestore
  @override
  Future<Activity> addActivityToFirestore({Activity? activity}) async {
    try {
      await _firestore.collection('activities').doc(activity?.activityId).set(
            activity!.toJson(),
          );
      return activity;
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  // get activity from firestore
  @override
  Future<Activity> getActivityFromFirestore({String? activityId}) async {
    try {
      final activity =
          await _firestore.collection('activities').doc(activityId).get();
      return Activity.fromJson(activity.data()!);
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  // stream activity from firestore
  @override
  Stream<Activity> streamActivityFromFirestore({String? activityId}) {
    return _firestore.collection('activities').doc(activityId).snapshots().map(
          (data) => Activity.fromJson(data.data()!),
        );
  }

  // get a list of activities from firestore
  @override
  Stream<List<Activity>> getActivitiesFromFirestore() {
    try {
      var data = _firestore.collection('activities').snapshots().map(
            (activityData) => activityData.docs.map((e) {
              return Activity.fromJson(
                e.data(),
              );
            }).toList(),
          );

      return data;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  // update activity on firestore
  @override
  Future<Activity> updateActivityInFirestore({Activity? activity}) async {
    try {
      await _firestore
          .collection('activities')
          .doc(activity?.activityId)
          .update(activity!.toJson());

      return activity;
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  // delete activity on firestore
  @override
  Future<void> deleteActivityFromFirestore({String? activityId}) async {
    try {
      await _firestore.collection('activities').doc(activityId).delete();
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  // add list of images to firebase storage
  @override
  Future<List<String>> addImagesToFirebaseStorage({
    required List<XFile> images,
    required String activityId,
  }) async {
    // upload images to firebase storage
    var uploadImages = images.map(
      (image) async {
        final uploadTask = kIsWeb
            ? _firebaseStorage
                .ref()
                .child('activities/$activityId/${image.name}')
                .putData(await image.readAsBytes())
            : _firebaseStorage
                .ref()
                .child('activities/$activityId/${image.name}')
                .putFile(File(image.path));

        final imageUrl = await (await uploadTask).ref.getDownloadURL();
        return imageUrl;
      },
    ).toList();

    return Future.wait(uploadImages);
  }

  // generic function update activity on firestore
  @override
  Future<T> updateActivity<T>({
    required String activityId,
    required Map<String, dynamic> data,
    required String query,
  }) async {
    try {
      return await FirestoreHelper.updateDataInDoc(
          docId: activityId, docPath: 'activities', data: data, query: query);
    } catch (e) {
      throw e.toString();
    }
  }
}

import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivitiesDatabaseRepository implements ActivitiesDatabaseAbstract {
  // cloud firestore instance
  final _firestore = FirebaseFirestore.instance;

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
    var data = _firestore.collection('activities').snapshots().map(
          (activityData) => activityData.docs.map((e) {
            print(e.data());
            return Activity.fromJson(
              e.data(),
            );
          }).toList(),
        );

    return data;
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
}

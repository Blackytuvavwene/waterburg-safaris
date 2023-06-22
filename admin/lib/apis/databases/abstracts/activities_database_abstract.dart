import 'package:admin/lib.dart';
import 'package:image_picker/image_picker.dart';

abstract class ActivitiesDatabaseAbstract {
  // add a new activity to firestore
  Future<Activity> addActivityToFirestore({Activity activity});

  // get activity from firestore
  Future<Activity> getActivityFromFirestore({String? activityId});

  // stream activity from firestore
  Stream<Activity> streamActivityFromFirestore({String activityId});

  // get a list of activities from firestore
  Stream<List<Activity>> getActivitiesFromFirestore();

  // update activity on firestore
  Future<Activity> updateActivityInFirestore({Activity activity});

  // delete activity on firestore
  Future<void> deleteActivityFromFirestore({String activityId});

  // add list of images to firebase storage
  Future<List<String>> addImagesToFirebaseStorage({
    required List<XFile> images,
    required String activityId,
  });

  // generic function update activity on firestore
  Future<T> updateActivity<T>(
      {required String activityId, required T data, required String query});
}

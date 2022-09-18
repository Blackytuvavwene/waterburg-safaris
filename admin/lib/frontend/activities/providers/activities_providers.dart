import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// stream list of activities from firestore
final activitiesStreamProvider =
    StreamProvider.autoDispose<List<Activity>>((ref) {
  final db = ref.watch(activityDbRepositoryProvider);
  final Stream<List<Activity>> list = db.getActivitiesFromFirestore();
  return list;
});

// stream activity data from firestore
final activityDataStreamProvider =
    StreamProvider.family.autoDispose<Activity, String>((ref, activityId) {
  final db = ref.watch(activityDbRepositoryProvider);
  final Stream<Activity> activity =
      db.streamActivityFromFirestore(activityId: activityId);
  return activity;
});

import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activitiesStreamProvider =
    StreamProvider.autoDispose<List<Activity>>((ref) {
  final db = ref.watch(activityDbRepositoryProvider);
  final Stream<List<Activity>> list = db.getActivitiesFromFirestore();
  return list;
});

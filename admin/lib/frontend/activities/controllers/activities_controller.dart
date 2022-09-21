import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityControlNotifier extends StateNotifier<Activity?> {
  ActivityControlNotifier() : super(null);

  // update tags in activity
  void updateTagsInActivity({required List<String> tags}) {
    state = state!.copyWith(tags: tags);
  }

  // update activity gallery in activity
  void updateActivityGalleryInActivity(
      {required List<Gallery> activityGallery}) {
    state = state!.copyWith(activityGallery: activityGallery);
  }

  // update packages in activity
  void updatePackagesInActivity({required List<Package> packages}) {
    state = state!.copyWith(packages: packages);
  }
}

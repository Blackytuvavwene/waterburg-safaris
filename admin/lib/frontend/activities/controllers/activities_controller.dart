import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';

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

  // update activity name in
}

// activity repository provider controller
class ActivityDBController extends StateNotifier<AsyncValue<Activity>?> {
  ActivityDBController({this.activitiesDatabaseRepository})
      : super(AsyncValue.data(Activity()));
  ActivitiesDatabaseRepository? activitiesDatabaseRepository;

  // add a new activity to firestore
  Future<AsyncValue<Activity>> addActivityToFirestore(
      {required Activity activity}) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() async {
      final activityD = await activitiesDatabaseRepository!
          .addActivityToFirestore(activity: activity);
      return activityD;
    });
  }
}

class AddImageNotifier extends StateNotifier<AsyncValue<List<String>?>> {
  AddImageNotifier({this.activitiesDatabaseRepository})
      : super(const AsyncData(null));

  ActivitiesDatabaseRepository? activitiesDatabaseRepository;

  // add image to firebase storage
  Future<AsyncValue<List<String>?>> addImagesToFirebaseStorage(
      {required List<XFile> image, required String activityId}) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() async {
      final imageUrl = await activitiesDatabaseRepository!
          .addImagesToFirebaseStorage(images: image, activityId: activityId);
      return imageUrl;
    });
  }
}

final addImagesNotifierProvider =
    StateNotifierProvider<AddImageNotifier, AsyncValue<List<String>?>>((ref) {
  return AddImageNotifier(
      activitiesDatabaseRepository: ref.watch(activityDbRepositoryProvider));
});

// activity tab list model
class ActivityTabModel {
  final String? tabName;
  final Icon? tabIcon;
  final Widget? tabWidget;
  final int? tabIndex;
  ActivityTabModel({
    this.tabName,
    this.tabIcon,
    this.tabWidget,
    this.tabIndex,
  });
}

// activity tabs list with icons, titles and widgets and index
final activityTabsList = [
  ActivityTabModel(
    tabName: 'Info',
    tabIcon: LineIcon.infoCircle(),
    tabWidget: const ActivityInfoPage(),
    tabIndex: 0,
  ),
  ActivityTabModel(
    tabName: 'Gallery',
    tabIcon: LineIcon.imagesAlt(),
    tabWidget: const ActivityGalleryPage(),
    tabIndex: 1,
  ),
  ActivityTabModel(
    tabName: 'Packages',
    tabIcon: LineIcon.boxes(),
    tabWidget: const ActivityPackagesPage(),
    tabIndex: 2,
  ),
  ActivityTabModel(
    tabName: 'Tags',
    tabIcon: LineIcon.tags(),
    tabWidget: const ActivityTagsPage(),
    tabIndex: 3,
  ),
];

// activity tabs list provider
final activityTabsListProvider =
    Provider<List<ActivityTabModel>>((ref) => activityTabsList);

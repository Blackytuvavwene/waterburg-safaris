import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';

class ActivityControlNotifier extends StateNotifier<Activity?> {
  ActivityControlNotifier({
    this.initialActivity,
  }) : super(initialActivity);

  // initial activity data
  final Activity? initialActivity;

  // update tags in activity
  void updateTagsInActivity({required List<String> tags}) {
    state = state?.copyWith(tags: tags);
  }

  // delete image from activity gallery
  void deleteImageFromActivityGallery({required int index}) {
    state = state?.copyWith(
      activityGallery: [
        ...state?.activityGallery ?? [],
      ]..removeAt(index),
    );
  }

  // update activity gallery in activity
  void updateActivityGalleryInActivity(
      {required List<Gallery> activityGallery}) {
    state = state?.copyWith(activityGallery: activityGallery);
  }

  // update packages in activity
  void updatePackagesInActivity({
    required Package package,
  }) {
    state = state?.copyWith(
      packages: [
        ...state?.packages ?? [],
        package,
      ],
    );
  }

  // update activity name in activity
  void updateActivityName({
    required String activityName,
  }) {
    state = state?.copyWith(
      activityName: activityName,
    );
  }

  // update activity seoDescription
  void updateActivitySEODescription({
    required String seoDescription,
  }) {
    state = state?.copyWith(
      seoDescription: seoDescription,
    );
  }

  // update activity seoKeywords
  void addActivitySEOKeyword({
    required String seoKeywords,
  }) {
    state = state?.copyWith(
      tags: [
        ...state?.tags ?? [],
        seoKeywords,
      ],
    );
  }

  // delete activity seoKeyword
  void deleteActivitySEOKeyword({
    required String seoKeyword,
  }) {
    state = state?.copyWith(
      tags: [
        ...state?.tags ?? [],
      ]..remove(seoKeyword),
    );
  }

  // delete package from list
  void deletePackageFromList({
    required int index,
  }) {
    state = state?.copyWith(
      packages: [
        ...state?.packages ?? [],
      ]..removeAt(index),
    );
  }

  // update activity overview
  void updateActivityOverview({
    required String overview,
  }) {
    state = state?.copyWith(
      overview: overview,
    );
  }

  // update package info in list
  void updatePackageInList({
    required Package package,
    required int index,
  }) {
    // get the package to be updated first
    var pkg = state?.packages?[index];
    // update the package
    pkg = package;
    // update in list
    state = state?.copyWith(
      packages: [
        ...state?.packages ?? [],
      ]..[index] = pkg,
    );
    // update the state
    state = state?.copyWith(
      packages: [
        ...state?.packages ?? [],
      ],
    );
  }

  // add package to list
  void addPackage({
    required Package package,
  }) {
    // update
    state = state?.copyWith(
      packages: [
        ...state?.packages ?? [],
        package,
      ],
    );
  }

  // reset activity
  void resetActivity(Activity activity) {
    state = activity;
  }
}

// activity repository provider controller
class ActivityDBController extends StateNotifier<AsyncValue<Activity>?> {
  ActivityDBController({this.activitiesDatabaseRepository})
      : super(AsyncValue.data(Activity()));
  ActivitiesDatabaseRepository? activitiesDatabaseRepository;

  // add a new activity to firestore
  Future<AsyncValue<Activity>> addActivityToFirestore({
    required Activity activity,
  }) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() async {
      final activityD = await activitiesDatabaseRepository!
          .addActivityToFirestore(activity: activity);
      return activityD;
    });
  }

  // update activity in firestore
  Future<AsyncValue<Activity>> updateActivityInFirestore({
    required Activity activity,
    required List<ImageHelperModel> images,
  }) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() async {
      // first upload images to firebase storage and get the urls if images is not empty
      if (images.isNotEmpty) {
        final newImageUploads = images.map((e) async {
          final url = await ImageHelpers.addImageToFirebaseStorage(
            image: e.xFile!,
            path: 'activities/${activity.activityId}/gallery',
          );

          // return the new image as gallery model
          return Gallery(
            imageUrl: url,
            imageDescription: e.imageDetails?.imageDescription,
            imageTitle: e.imageDetails?.imageTitle,
          );
        }).toList();

        // get the new images
        final newImages = await Future.wait(newImageUploads);

        // update the activity gallery
        activity = activity.copyWith(
          slug: createSlug(
            text: activity.activityName!,
          ),
          activityGallery: [
            ...activity.activityGallery ?? [],
            ...newImages,
          ],
        );

        // update the activity in firestore
        final activityD =
            await FirestoreHelper.updateDataInDoc<Map<String, dynamic>>(
          docId: activity.activityId!,
          docPath: 'activities',
          data: activity.toJson(),
          query: activity.activityId!,
          merge: false,
        );
        return Activity.fromJson(activityD);
      } else {
        // update activity slug
        activity = activity.copyWith(
          slug: createSlug(
            text: activity.activityName!,
          ),
        );
        // update the activity in firestore
        final activityD =
            await FirestoreHelper.updateDataInDoc<Map<String, dynamic>>(
          docId: activity.activityId!,
          docPath: 'activities',
          data: activity.toJson(),
          query: activity.activityId!,
          merge: false,
        );

        return Activity.fromJson(activityD);
      }
    });
  }

  // delete activity from firestore
  Future deleteActivityFromFirestore({
    required String activityId,
    required Activity activity,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      // delete images from firebase storage
      for (var image in activity.activityGallery!) {
        await ImageHelpers.deleteImageFromFirebaseStorageByDownloadUrl(
          imageUrl: image.imageUrl!,
        );
      }

      await activitiesDatabaseRepository!
          .deleteActivityFromFirestore(activityId: activityId);

      return Activity();
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
    tabIcon: const LineIcon.infoCircle(),
    tabWidget: const ActivityInfoPage(),
    tabIndex: 0,
  ),
  ActivityTabModel(
    tabName: 'Gallery',
    tabIcon: const LineIcon.imagesAlt(),
    tabWidget: const ActivityGalleryPage(),
    tabIndex: 1,
  ),
  ActivityTabModel(
    tabName: 'Packages',
    tabIcon: const LineIcon.boxes(),
    tabWidget: const ActivityPackagesPage(),
    tabIndex: 2,
  ),
  ActivityTabModel(
    tabName: 'Tags',
    tabIcon: const LineIcon.tags(),
    tabWidget: const ActivityTagsPage(),
    tabIndex: 3,
  ),
];

// activity tabs list provider
final activityTabsListProvider =
    Provider<List<ActivityTabModel>>((ref) => activityTabsList);

// package controller notifier
class PackageControlNotifier extends StateNotifier<Package?> {
  PackageControlNotifier({
    this.initialPackage,
  }) : super(initialPackage);

  // initial package data
  final Package? initialPackage;

  // set initial package data
  void setInitialPackageData({
    required Package package,
  }) {
    state = package;
  }

  // update package name
  void updatePackageName({
    required String packageName,
  }) {
    state = state?.copyWith(
      packageName: packageName,
    );
  }

  // update package price
  void updatePackagePrice({
    required double packagePrice,
  }) {
    state = state?.copyWith(
      price: packagePrice,
    );
  }

  // update package description
  void updatePackageDescription({
    required String packageDescription,
  }) {
    state = state?.copyWith(
      description: packageDescription,
    );
  }

  // update package keywords
  void updatePackageKeywords({required String keyword}) {
    state = state?.copyWith(
      keywords: [
        ...state?.keywords ?? [],
        keyword,
      ],
    );
  }

  // update package offers
  void updatePackageOffers({
    required String packageOffer,
  }) {
    state = state?.copyWith(
      packageOffers: [
        ...state?.packageOffers ?? [],
        packageOffer,
      ],
    );
  }

  // remove package offer
  void removePackageOffer({
    required String packageOffer,
  }) {
    state = state?.copyWith(
      packageOffers: [
        ...state?.packageOffers ?? [],
      ]..remove(packageOffer),
    );
  }

  // remove package keyword
  void removePackageKeyword({
    required String keyword,
  }) {
    state = state?.copyWith(
      keywords: [
        ...state?.keywords ?? [],
      ]..remove(keyword),
    );
  }

  // update last price
  void updateLastPrice({
    required double lastPrice,
  }) {
    state = state?.copyWith(
      lastPrice: lastPrice,
    );
  }

  // update package discount
  void updatePackageDiscount({
    required double packageDiscount,
  }) {
    state = state?.copyWith(
      discountPercentage: packageDiscount,
    );
  }

  // update coupon code
  void updateCouponCode({
    required String couponCode,
  }) {
    state = state?.copyWith(
      coupon: couponCode,
    );
  }
}

// package controller provider
final packageControlNotifierProvider = StateNotifierProvider.autoDispose
    .family<PackageControlNotifier, Package?, Package?>((
  ref,
  package,
) {
  return PackageControlNotifier(
    initialPackage: package,
  );
});

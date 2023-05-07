import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddImagesNotifier extends StateNotifier<List<ImageHelperModel>> {
  AddImagesNotifier() : super([]);

  // add image to list
  Future<List<ImageHelperModel>> addImageToList() async {
    final newGallery = await ImageHelpers.pickAddMultipleImages();

    getNewList() {
      if (newGallery != null && state != []) {
        final newList = [...state, ...newGallery];
        return newList;
      } else if (newGallery != null && state == []) {
        return newGallery;
      } else {
        return state;
      }
    }

    final newList = getNewList();

    return state = newList;
  }

  // remove image from list
  void removeImageFromList({required ImageHelperModel image}) {
    state = state.where((element) => element != image).toList();
  }

  // update image details in list
  void updateImageDetailsInList({
    required int index,
    required Gallery gallery,
  }) {
    final list = state;

    list[index] = list[index].copyWith(imageDetails: gallery);
    state = [...list];
  }

  // clear image list
  void clearImageList() {
    state = [];
  }
}

final addImageNotifierProvider = StateNotifierProvider.autoDispose<
    AddImagesNotifier, List<ImageHelperModel>>((ref) {
  return AddImagesNotifier();
});

class AddActivityNotifier extends StateNotifier<Activity> {
  AddActivityNotifier() : super(Activity());

  // update activity name
  void updateActivityName({
    required String activityName,
  }) {
    state = state.copyWith(
      activityName: activityName,
    );
  }

  // update activity seo description
  void updateSeoDescription({
    required String seoDescription,
  }) {
    state = state.copyWith(
      seoDescription: seoDescription,
    );
  }

  // update activity overview
  void updateOverview({
    required String overview,
  }) {
    state = state.copyWith(
      overview: overview,
    );
  }

  // update activity tags
  void updateTags({
    required String tag,
  }) {
    state = state.copyWith(
      tags: [
        ...state.tags ?? [],
        tag,
      ],
    );
  }

  // update activity packages
  void updatePackages({
    required Package package,
  }) {
    state = state.copyWith(
      packages: [
        ...state.packages ?? [],
        package,
      ],
    );
  }

  // remove package from list
  void removePackageFromList({
    required int index,
  }) {
    state = state.copyWith(
      packages: [
        ...state.packages ?? [],
      ]..removeAt(index),
    );
  }

  // remove tag from list
  void removeTagFromList({
    required String tag,
  }) {
    state = state.copyWith(
      tags: [
        ...state.tags ?? [],
      ]..remove(tag),
    );
  }
}

// add activity provider
final addActivityControlProvider =
    StateNotifierProvider<AddActivityNotifier, Activity>((ref) {
  return AddActivityNotifier();
});

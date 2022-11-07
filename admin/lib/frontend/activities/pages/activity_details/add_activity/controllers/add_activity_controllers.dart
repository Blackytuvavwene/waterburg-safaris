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

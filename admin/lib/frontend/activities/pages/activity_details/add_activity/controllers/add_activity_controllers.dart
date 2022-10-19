import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddImagesNotifier extends StateNotifier<List<ImageHelperModel>> {
  AddImagesNotifier() : super([]);

  void addImage(ImageHelperModel image) {
    state = [...state, image];
  }

  void removeImage(ImageHelperModel image) {
    state = state.where((element) => element != image).toList();
  }

  void updateImage(ImageHelperModel image) {
    state = state.map((e) => e == image ? image : e).toList();
  }

  void updateImageList(List<ImageHelperModel> images) {
    state = images;
  }
}

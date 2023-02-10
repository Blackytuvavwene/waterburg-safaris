import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompanyGalleryDbNotifier extends StateNotifier<AsyncValue<Gallery?>> {
  CompanyGalleryDbNotifier({
    required this.gallery,
  }) : super(AsyncData(gallery));
  final Gallery? gallery;

  void _setData(Gallery? gallery) {
    state = AsyncData(gallery);
  }

  // delete selected image from firebase firestore and firebase storage
  Future<AsyncValue<Gallery?>> deleteFromFirebase({
    required String docPath,
    required String docId,
    required String query,
    required Gallery image,
  }) async {
    state = const AsyncLoading();

    return state = await AsyncValue.guard<Gallery?>(() async {
      final Gallery data = await FirestoreHelper.deleteInDocList<Gallery>(
        docPath: docPath,
        docId: docId,
        query: query,
        data: image,
      );
      return null;
    });
  }

  // update image in firestore
  Future<AsyncValue<Gallery?>> updateInFirebase({
    required String docPath,
    required String docId,
    required String query,
    required Gallery image,
  }) async {
    state = const AsyncLoading();

    return state = await AsyncValue.guard<Gallery?>(() async {
      final Gallery data = await FirestoreHelper.deleteInDocList<Gallery>(
        docPath: docPath,
        docId: docId,
        query: query,
        data: image,
      );
      return null;
    });
  }
}

// controller for picking and adding company images
class CompanyGalleryNotifier extends StateNotifier<List<ImageHelperModel>?> {
  CompanyGalleryNotifier() : super([]);

  // pick images
  Future pickImages() async {
    state = await ImageHelpers.pickAddMultipleImages();
  }
}

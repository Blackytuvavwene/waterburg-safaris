import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GalleryPage extends HookConsumerWidget {
  const GalleryPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final galleryData = ref.watch(
      firestoreGalleryAndVideoStreamProvider('gallery'),
    );
    return galleryData.when(
      data: (galleryResults) {
        return const GalleryDataPage();
      },
      error: (err, stackTrace) {
        return GalleryErrorPage(
          error: err.toString() + stackTrace.toString(),
        );
      },
      loading: () {
        return const GalleryLoadingPage();
      },
    );
  }
}

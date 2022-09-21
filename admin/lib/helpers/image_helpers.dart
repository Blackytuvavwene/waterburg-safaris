import 'dart:io';

import 'package:admin/lib.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelpers {
  // get asset image
  static String getAssetImage(String name) {
    return 'assets/images/$name';
  }

  // compress image
  static Future<File?> compressImage(ImageFile image) async {
    try {
      const compressionConfig = Configuration(
        outputType: ImageOutputType.webpThenPng,
        useJpgPngNativeCompressor: false,
        quality: 40,
      );
      final imageFileConfiguration = ImageFileConfiguration(
        input: image,
        config: compressionConfig,
      );
      final compressedImage = await compressor.compress(imageFileConfiguration);
      return File(compressedImage.filePath);
    } catch (e) {
      throw e.toString();
    }
  }

  // pick image
  static Future<File?> pickImage({ImageSource? imageSource}) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: imageSource!);
      if (image == null) {
        return null;
      }
      return File(image.path);
    } catch (e) {
      throw e.toString();
    }
  }

  // delete image from firebase storage
  static Future<void> deleteImageFromFirebaseStorage(
      {required String imageUrl}) async {
    try {
      final storage = FirebaseStorage.instance;
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      throw e.toString();
    }
  }
}

class ImageHelperNotifier extends StateNotifier<AsyncValue<File?>> {
  ImageHelperNotifier() : super(const AsyncData(null));
  // get image helper
  final imageHelper = ImageHelpers();

  // pick image
  Future<void> pickImage({ImageSource? imageSource}) async {
    state = const AsyncValue.loading();

    // use pickImage method from image helper
    state = AsyncValue.guard<File?>(() {
      final image = ImageHelpers.pickImage(
        imageSource: imageSource,
      );

      return image;
    }) as AsyncValue<File?>;
  }

  // compress image
  Future<void> compressImage(ImageFile? imageFile) async {
    state = const AsyncValue.loading();

    // use compressImage method from image helper
    state = AsyncValue.guard<File?>(() {
      final image = ImageHelpers.compressImage(imageFile!);

      return image;
    }) as AsyncValue<File?>;
  }
}

// notifier to add picked image to company gallery model
class GalleryImageControllerNotifier
    extends StateNotifier<AsyncValue<List<Gallery>>> {
  GalleryImageControllerNotifier() : super(const AsyncData(<Gallery>[]));

  // add image to gallery
  addImageToGalleryList({required Gallery gallery}) {
    state = AsyncData(state.asData!.value + [gallery]);
  }

  // remove image from gallery
  removeImageFromGalleryList({required Gallery gallery}) {
    state = AsyncData(state.asData!.value
        .where((element) => element.imageUrl != gallery.imageUrl)
        .toList());
  }
}

// gallery image controller notifier provider
final galleryImageControllerNotifierProvider =
    StateNotifierProvider.autoDispose<GalleryImageControllerNotifier,
        AsyncValue<List<Gallery>>>((ref) => GalleryImageControllerNotifier());

// image helper notifier provider
final imageHelperNotifierProvider =
    StateNotifierProvider.autoDispose<ImageHelperNotifier, AsyncValue<File?>>(
        (ref) => ImageHelperNotifier());

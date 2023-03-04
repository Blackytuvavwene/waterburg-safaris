// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:admin/lib.dart';
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelpers {
  // get asset image
  static String getAssetImage(String name) {
    return 'assets/images/$name';
  }

  // compress image
  static Future<XFile?> compressImage(ImageFile image) async {
    try {
      const compressionConfig = Configuration(
        outputType: ImageOutputType.webpThenJpg,
        useJpgPngNativeCompressor: false,
        quality: 40,
      );
      final imageFileConfiguration = ImageFileConfiguration(
        input: image,
        config: compressionConfig,
      );
      final compressedImage = await compressor.compress(imageFileConfiguration);
      return XFile(compressedImage.filePath);
    } catch (e) {
      throw e.toString();
    }
  }

  // imagefile to file
  static Future<XFile?> imageFileToFile(ImageFile image) async {
    try {
      final file = XFile(image.filePath);
      return file;
    } catch (e) {
      throw e.toString();
    }
  }

  // create placeholder image
  // static Future<String> createPlaceholderImage() async {
  //   try {
  //     final image = await ImagePicker().getImage(source: ImageSource.gallery);
  //     if (image != null) {
  //       final file = await imageFileToFile(
  //           fileToImageFile(File(image.path)) as ImageFile);
  //       if (file != null) {
  //         final compressedImage =
  //             await compressImage(fileToImageFile(file) as ImageFile);
  //         if (compressedImage != null) {
  //           final ref = FirebaseStorage.instance.ref().child('images');
  //           final task = ref.putFile(compressedImage);
  //           final snapshot = await task.whenComplete(() {});
  //           final url = await snapshot.ref.getDownloadURL();
  //           return url;
  //         }
  //       }
  //     }
  //     return '';
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  // file to imagefile
  static Future<ImageFile?> fileToImageFile(XFile file) async {
    try {
      final imageFile = await file.asImageFile;
      return imageFile;
    } catch (e) {
      throw e.toString();
    }
  }

  // pick add image
  static Future<ImageHelperModel?> pickAddImage(
      {ImageSource? imageSource}) async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(
        source: imageSource!,
        imageQuality: 80,
        maxHeight: 720,
        maxWidth: 2000,
      );
      if (image == null) {
        return null;
      }

      // final imageFile = await fileToImageFile(image);

      final newImage = ImageHelperModel(
        xFile: image,
        name: image.name,
        path: image.path,
        imageFile: await image.asImageFile,
        bytes: await image.readAsBytes(),
        imageDetails: Gallery(
          imageTitle: '',
          imageDescription: '',
          imageUrl: '',
        ),
      );

      return newImage;
    } catch (e) {
      throw e.toString();
    }
  }

  // convert uint8list to file
  static Future<XFile?> convertUint8ListToFile(
    Uint8List imageW,
  ) async {
    try {
      final file = XFile.fromData(imageW);

      return file;
    } catch (e) {
      throw e.toString();
    }
  }

  // convert uint8list to imagefile
  static Future<ImageFile?> convertUint8ListToImageFile(
    Uint8List imageW,
  ) async {
    try {
      final file = await convertUint8ListToFile(imageW);
      final imageFile = await fileToImageFile(file!);
      return imageFile;
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

  // pick add multiple images
  static Future<List<ImageHelperModel>?> pickAddMultipleImages() async {
    try {
      final picker = ImagePicker();
      final images = await picker.pickMultiImage(
        imageQuality: 80,
        maxHeight: 720,
        maxWidth: 2000,
      );
      if (images == null) {
        return null;
      }
      final files = <ImageHelperModel>[];
      for (final image in images) {
        // image.readAsBytes();
        // final file = await fileToImageFile(image);
        final newImage = ImageHelperModel(
          xFile: image,
          name: image.name,
          path: image.path,
          imageFile: await image.asImageFile,
          bytes: await image.readAsBytes(),
          imageDetails: Gallery(
            imageTitle: '',
            imageDescription: '',
            imageUrl: '',
          ),
        );
        files.add(newImage);
      }
      return files;
    } catch (e) {
      throw e.toString();
    }
  }

  // add image to firebase storage
  static Future<String> addImageToFirebaseStorage(
      {required XFile image, required String path}) async {
    try {
      final uploadTask = kIsWeb
          ? FirebaseStorage.instance
              .ref()
              .child('$path/${image.name}')
              .putData(await image.readAsBytes())
          : FirebaseStorage.instance
              .ref()
              .child('$path/${image.name}')
              .putFile(File(image.path));

      final imageUrl = await (await uploadTask).ref.getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  // delete image from firebase storage by download url
  static Future<void> deleteImageFromFirebaseStorageByDownloadUrl(
      {required String imageUrl}) async {
    try {
      final storage = FirebaseStorage.instance;
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();
    } on FirebaseException catch (e) {
      debugPrint(
        jsonEncode(
          {
            'task': 'Delete image',
            'error': e.message.toString(),
          },
        ),
      );
      throw e.message.toString();
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  // compress multiple images
  static Future<List<XFile>?> compressMultipleImages(
      {required List<XFile> files}) async {
    try {
      final compressedImages = <XFile>[];
      for (final file in files) {
        final imageFile = await fileToImageFile(file);
        final compressedImage = await compressImage(imageFile!);
        compressedImages.add(compressedImage!);
      }
      return compressedImages;
    } catch (e) {
      throw e.toString();
    }
  }
}

// image controller notifier
class ImageControllerNotifier
    extends StateNotifier<AsyncValue<List<ImageHelperModel>?>> {
  ImageControllerNotifier() : super(const AsyncData([]));

// pick images and add them to the state
  Future pickImages({
    ImageSource? imageSource,
  }) async {
    if (state.asData?.value != null || state.value != []) {
      final imagesInState = state.asData?.value;
      state = await AsyncValue.guard(() async {
        final images = await ImageHelpers.pickAddMultipleImages();

        // add images only if they are not null
        if (imagesInState != null && images != null) {
          return [...imagesInState, ...images];
        } else {
          return imagesInState;
        }
      });
    } else {
      state = await AsyncValue.guard(() async {
        final images = await ImageHelpers.pickAddMultipleImages();
        return images;
      });
    }
  }

  // delete an image from the list
  void removeImageFromState({required ImageHelperModel image}) {
    final images = state.asData?.value?.where((e) => e != image).toList();
    state = AsyncData(images);
  }

  // update image gallery values from specific image in list
  void updateImageGalleryDetails({
    required Gallery galleryDetails,
    required ImageHelperModel theImage,
  }) {
    final images = state.asData?.value?.map((element) {
      if (element == theImage) {
        element.copyWith(imageDetails: galleryDetails);
      }

      return element;
    }).toList();
    state = AsyncData(images);
  }
}

// image database controller notifier
class ImageDatabaseControllerNotifier
    extends StateNotifier<AsyncValue<List<Gallery>?>> {
  ImageDatabaseControllerNotifier() : super(const AsyncData([]));

  // upload images to firebase storage
  Future<AsyncValue<List<Gallery>?>> uploadImagesToFirebaseStorage({
    required List<ImageHelperModel> images,
    required String path,
  }) async {
    state = const AsyncValue.loading();
    return state = await AsyncValue.guard(() async {
      final uploadedImages = <Gallery>[];
      for (final image in images) {
        final imageUrl = await ImageHelpers.addImageToFirebaseStorage(
          image: image.xFile!,
          path: path,
        );
        final imageWithUrl = Gallery(
          imageTitle: image.imageDetails?.imageTitle,
          imageDescription: image.imageDetails?.imageDescription,
          imageUrl: imageUrl,
        );
        uploadedImages.add(imageWithUrl);
      }
      return uploadedImages;
    });
  }

  // delete images from firebase storage
  Future deleteImagesFromFirebaseStorage({
    required List<Gallery> images,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      for (final image in images) {
        await ImageHelpers.deleteImageFromFirebaseStorageByDownloadUrl(
          imageUrl: image.imageUrl!,
        );
      }
      return [];
    });
  }

  // delete image from firebase storage
  Future deleteImageFromFirebaseStorage({
    required Gallery image,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ImageHelpers.deleteImageFromFirebaseStorageByDownloadUrl(
        imageUrl: image.imageUrl!,
      );
      return [];
    });
  }
}

// image database controller notifier provider
final imageDatabaseControllerNotifierProvider =
    StateNotifierProvider.autoDispose<ImageDatabaseControllerNotifier,
        AsyncValue<List<Gallery>?>>((ref) {
  return ImageDatabaseControllerNotifier();
});

// expose image controller notifier as a provider
final imageControllerNotifierProvider = StateNotifierProvider.autoDispose<
    ImageControllerNotifier, AsyncValue<List<ImageHelperModel>?>>((ref) {
  return ImageControllerNotifier();
});

class ImageHelperNotifier extends StateNotifier<AsyncValue<ImageHelperModel?>> {
  ImageHelperNotifier() : super(const AsyncData(null));
  // get image helper
  final imageHelper = ImageHelpers();

  // pick image
  Future<AsyncValue<ImageHelperModel?>> pickImage(
      {ImageSource? imageSource}) async {
    state = const AsyncValue.loading();

    // use pickImage method from image helper
    return state = await AsyncValue.guard(() async {
      final image = await ImageHelpers.pickAddImage(
        imageSource: imageSource,
      );

      return image;
    });
  }

  // set image
  Future<void> setImage(ImageHelperModel? image) async {
    state = AsyncValue.data(image);
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
final imageHelperNotifierProvider = StateNotifierProvider.autoDispose<
    ImageHelperNotifier,
    AsyncValue<ImageHelperModel?>>((ref) => ImageHelperNotifier());

// image helper all devices using file picker
class ImageHelperAll {
  // pick image using file picker
  static Future<file_picker.PlatformFile> pickImage(
      {ImageSource? imageSource}) async {
    try {
      final picker = ImagePicker();
      final image = await file_picker.FilePicker.platform.pickFiles(
        type: file_picker.FileType.image,
        allowMultiple: false,
        withData: true,
        withReadStream: true,
        allowCompression: true,
        onFileLoading: (filePickerStatus) {
          print(filePickerStatus);
        },
      );

      final result = image?.files.first;

      return result!;
    } catch (e) {
      throw e.toString();
    }
  }
}

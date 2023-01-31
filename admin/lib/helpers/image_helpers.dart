// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:admin/lib.dart';
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';

// model class to help with image xfile and imagefile
class ImageHelperModel {
  ImageHelperModel({
    required this.xFile,
    required this.path,
    required this.name,
    required this.bytes,
    required this.imageFile,
    required this.imageDetails,
  });
  XFile? xFile;
  String? name;
  String? path;
  Uint8List? bytes;
  ImageFile? imageFile;
  Gallery? imageDetails;

  ImageHelperModel copyWith({
    XFile? xFile,
    String? name,
    String? path,
    Uint8List? bytes,
    ImageFile? imageFile,
    Gallery? imageDetails,
  }) {
    return ImageHelperModel(
      xFile: xFile ?? this.xFile,
      name: name ?? this.name,
      path: path ?? this.path,
      bytes: bytes ?? this.bytes,
      imageFile: imageFile ?? this.imageFile,
      imageDetails: imageDetails ?? this.imageDetails,
    );
  }
}

class ImageHelpers {
  // get asset image
  static String getAssetImage(String name) {
    return 'assets/images/$name';
  }

  // compress image
  static Future<XFile?> compressImage(ImageFile image) async {
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

  // pick image
  static Future<ImageHelperModel?> pickImage(
      {ImageSource? imageSource, String? storagePath}) async {
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
              imageUrl: await addImageToFirebaseStorage(
                image: image,
                path: storagePath!,
              )));

      return newImage;
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

  // web pick image
  static Future<Uint8List> webPickImage() async {
    try {
      final picker = ImagePicker();
      final image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      // if (image == null) {
      //   return null;
      // }
      final imageWeb = await image!.readAsBytes();
      return imageWeb;
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

  // pick multiple images
  static Future<List<ImageHelperModel>?> pickMultipleImages(
      {String? storagePath}) async {
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
                imageUrl: await addImageToFirebaseStorage(
                  image: image,
                  path: storagePath!,
                )));
        files.add(newImage);
      }
      return files;
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
    } catch (e) {
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

// multiple image helper controller notifier
class MultipleImageHelperControllerNotifier
    extends StateNotifier<AsyncValue<List<ImageHelperModel>?>> {
  MultipleImageHelperControllerNotifier()
      : super(const AsyncData(<ImageHelperModel>[]));

  // get image helper
  final imageHelper = ImageHelpers();

  // pick multiple images
  Future<AsyncValue<List<ImageHelperModel>?>> pickMultipleImages(
      {String? storagePath}) async {
    state = const AsyncValue.loading();

    // use pickMultipleImages method from image helper
    return state = await AsyncValue.guard<List<ImageHelperModel>?>(() async {
      final images =
          await ImageHelpers.pickMultipleImages(storagePath: storagePath);

      return images;
    });
  }

  // pick and add multiple images to list
  Future<AsyncValue<List<ImageHelperModel>?>> pickAndAddMultipleImagesToList(
      {String? storagePath}) async {
    // state = const AsyncValue.loading();

    // use pickMultipleImages method from image helper
    final images =
        await ImageHelpers.pickMultipleImages(storagePath: storagePath);

    // add images to list
    return state = images != null
        ? AsyncValue.data([...state.asData!.value!, ...images])
        : state;
  }

  // delete image from list
  Future<void> deleteImageFromList({required ImageHelperModel image}) async {
    await ImageHelpers.deleteImageFromFirebaseStorageByDownloadUrl(
        imageUrl: image.imageDetails!.imageUrl!);
    state = AsyncValue.data(state.asData!.value!
        .where((element) => element.path != image.path)
        .toList());
  }

//  clear list
  Future<void> clearList() async {
    try {
      EasyLoading.show(status: 'Deleting images...');
      for (final image in state.asData!.value!) {
        await ImageHelpers.deleteImageFromFirebaseStorageByDownloadUrl(
            imageUrl: image.imageDetails!.imageUrl!);
      }
      state = const AsyncData(<ImageHelperModel>[]);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  // update in list
  Future<void> updateInList(
      {required ImageHelperModel image, required int index}) async {
    final list = state.asData!.value!;
    list[index] = image;
    state = AsyncValue.data(list);
  }

  // update gallery in list
  Future<void> updateGalleryInList(
      {required Gallery gallery, required int index}) async {
    final list = state.asData!.value!;
    list[index].imageDetails = gallery;
    state = AsyncValue.data(list);
  }
}

// image  helper web controller notifier
class ImageHelperWebControllerNotifier
    extends StateNotifier<AsyncValue<ImageFile?>> {
  ImageHelperWebControllerNotifier() : super(const AsyncData(null));

  // get image helper
  final imageHelper = ImageHelpers();

  // convert file to image file
  Future<void> fileToImageFile({required XFile file}) async {
    state = const AsyncValue.loading();

    // use fileToImageFile method from image helper
    state = await AsyncValue.guard<ImageFile?>(() async {
      final imageFile = await ImageHelpers.fileToImageFile(file);

      return imageFile;
    });
  }

  // pick image
  // Future<void> pickImage() async {
  //   state = const AsyncValue.loading();

  //   // use pickImage method from image helper
  //   state = await AsyncValue.guard<Uint8List?>(() {
  //     final image = ImageHelpers.webPickImage();

  //     return image;
  //   });
  // }
}

// image file helper controller notifier provider
final imageFileHelperControllerNotifierProvider = StateNotifierProvider<
    ImageHelperWebControllerNotifier,
    AsyncValue<ImageFile?>>((ref) => ImageHelperWebControllerNotifier());

// gallery image controller notifier provider
final galleryImageControllerNotifierProvider =
    StateNotifierProvider.autoDispose<GalleryImageControllerNotifier,
        AsyncValue<List<Gallery>>>((ref) => GalleryImageControllerNotifier());

// image helper notifier provider
final imageHelperNotifierProvider = StateNotifierProvider.autoDispose<
    ImageHelperNotifier,
    AsyncValue<ImageHelperModel?>>((ref) => ImageHelperNotifier());

// multiple image helper controller notifier provider
final multipleImageHelperControllerNotifierProvider =
    StateNotifierProvider.autoDispose<MultipleImageHelperControllerNotifier,
            AsyncValue<List<ImageHelperModel>?>>(
        (ref) => MultipleImageHelperControllerNotifier());

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

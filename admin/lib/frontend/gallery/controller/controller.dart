<<<<<<< HEAD
import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'controller.g.dart';

// video helper model
class VideoHelperModel {
  final XFile video;
  final String videoDescription;

  VideoHelperModel({
    required this.video,
    required this.videoDescription,
  });
}

// video helper class
class VideoHelper {
  // pick video
  static Future<VideoHelperModel> pickVideo({
    required ImageSource source,
  }) async {
    try {
      // initialize the picker
      final picker = ImagePicker();
      // pick video
      final video = await picker.pickVideo(
        source: source,
      );

      // return video as video helper model
      return VideoHelperModel(
        video: video!,
        videoDescription: video.name,
      );
    } catch (e) {
      debugPrint(
        e.toString(),
      );

      throw e.toString();
    }
  }
}

// video picker controller
class VideoPickerControllerNotifier
    extends StateNotifier<AsyncValue<VideoHelperModel?>> {
  VideoPickerControllerNotifier()
      : super(
          const AsyncData<VideoHelperModel?>(null),
        );

  // pick video
  Future<AsyncValue<VideoHelperModel?>> pickVideo({
    required ImageSource source,
  }) async {
    state = const AsyncLoading();

    return state = await AsyncValue.guard<VideoHelperModel?>(() async {
      final video = await VideoHelper.pickVideo(source: source);
      return video;
    });
  }
}

// video picker controller provider
final videoPickerControllerProvider = StateNotifierProvider.autoDispose<
    VideoPickerControllerNotifier, AsyncValue<VideoHelperModel?>>(
  (ref) => VideoPickerControllerNotifier(),
);

// firestore gallery and video stream provider
final firestoreGalleryAndVideoStreamProvider = StreamProvider.autoDispose
    .family<VideoAndGalleryModel, String>((ref, docPath) {
  final firestoreInstance = FirebaseFirestore.instance;

  // stream list of gallery from firestore
  final gallery = firestoreInstance
      .collection('gallery')
      .doc('gallery')
      .snapshots()
      .map((event) => event.data());

  // stream list of video from firestore
  final video = firestoreInstance
      .collection('gallery')
      .doc('video')
      .snapshots()
      .map((event) => VideoAndGalleryModel.fromJson(event.data()!));

  // return stream of gallery and video
  // final model = VideoAndGalleryModel(
  //   image: gallery.map((event)async => await Gallery.fromJson(event!)).toList(),
  //   video: video.map((event) => VideoDTOModel.fromJson(event!)).toList(),
  // );
  return video;
});

// multiple video picker controller
class MultipleVideoPickerControllerNotifier
    extends StateNotifier<List<VideoHelperModel>> {
  MultipleVideoPickerControllerNotifier() : super([]);

  // add video to list
  void addVideoToList({
    required VideoHelperModel video,
  }) {
    state = [...state, video];
  }

  // remove video from list
  void removeVideoFromList({required int index}) {
    state = [...state]..removeAt(index);
  }

  // update video from list
  void updateVideoFromList({
    required int index,
    required VideoHelperModel video,
  }) {
    // update the video
    state[index] = video;
    // update the state
    state = [...state];
  }

  // clear video list
  void clearVideoList() {
    state = [];
  }
}

// multiple video picker controller provider
final multipleVideoPickerControllerProvider = StateNotifierProvider.autoDispose<
    MultipleVideoPickerControllerNotifier, List<VideoHelperModel>>(
  (ref) => MultipleVideoPickerControllerNotifier(),
);

// firebase video and gallery controller
class FirebaseVideoControllerNotifier
    extends StateNotifier<AsyncValue<List<VideoDTOModel>>> {
  FirebaseVideoControllerNotifier()
      : super(
          AsyncData<List<VideoDTOModel>>(
            [],
          ),
        );

  // add video to firebase
  Future<void> addVideosToFirebase({
    required List<VideoHelperModel> videos,
    required String docPath,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      List<VideoDTOModel> videoList = [];

      for (var e in videos) {
        // get doc id
        final docId = Uuid().v1();
        final videoUrl = await ImageHelpers.addImageToFirebaseStorage(
          image: e.video,
          path: 'videos',
        );

        // add to firestore
        final video = await FirestoreHelper.addDataToDoc(
          docPath: docPath,
          data: VideoDTOModel(
            videoUrl: videoUrl,
            videoDescription: e.videoDescription,
            id: docId,
          ).toJson(),
        );

        videoList.add(VideoDTOModel.fromJson(video));
      }

      return videoList;
    });
  }

  // add gallery to firebase
  Future<void> addGalleryToFirebase({
    required List<ImageHelperModel> gallery,
    required String docPath,
  }) async {
    state = const AsyncLoading();

    // state = await AsyncValue.guard(() async {
    //   final galleryUrl = await FirebaseStorageHelper.uploadMultipleFiles(
    //     files: gallery.map((e) => File(e.image.path)).toList(),
    //     path: docPath,
    //   );

    //   final galleryDetails = galleryUrl.map((e) {
    //     return Gallery(
    //       imageUrl: e,
    //       imageDescription: e,
    //     );
    //   }).toList();

    //   final videoAndGallery = await FirestoreHelper.addDocumentToFirestore(
    //     docPath: docPath,
    //     data: galleryDetails.map((e) => e.toJson()).toList(),
    //   );

    //   return videoAndGallery;
    // });
  }
}

// stream video from firestore
@riverpod
Stream<List<VideoDTOModel>> streamVideoFromFirestore(
    StreamVideoFromFirestoreRef ref) {
  final firestoreInstance = FirebaseFirestore.instance;

  // stream list of video from firestore
  final video = firestoreInstance.collection('videos').snapshots().map(
        (event) => event.docs
            .map(
              (e) => VideoDTOModel.fromJson(
                e.data(),
              ),
            )
            .toList(),
      );

  return video;
}

// stream gallery from firestore
@riverpod
Stream<List<GalleryDTOModel>> streamGalleryFromFirestore(
    StreamGalleryFromFirestoreRef ref) {
  final firestoreInstance = FirebaseFirestore.instance;

  // stream list of gallery from firestore
  final gallery = firestoreInstance.collection('gallery').snapshots().map(
        (event) => event.docs
            .map(
              (e) => GalleryDTOModel.fromJson(
                e.data(),
              ),
            )
            .toList(),
      );

  return gallery;
}

// get data

=======
import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'controller.g.dart';

// video helper model
class VideoHelperModel {
  final XFile video;
  final String videoDescription;

  VideoHelperModel({
    required this.video,
    required this.videoDescription,
  });
}

// video helper class
class VideoHelper {
  // pick video
  static Future<VideoHelperModel> pickVideo({
    required ImageSource source,
  }) async {
    try {
      // initialize the picker
      final picker = ImagePicker();
      // pick video
      final video = await picker.pickVideo(
        source: source,
      );

      // return video as video helper model
      return VideoHelperModel(
        video: video!,
        videoDescription: video.name,
      );
    } catch (e) {
      debugPrint(
        e.toString(),
      );

      throw e.toString();
    }
  }
}

// video picker controller
class VideoPickerControllerNotifier
    extends StateNotifier<AsyncValue<VideoHelperModel?>> {
  VideoPickerControllerNotifier()
      : super(
          const AsyncData<VideoHelperModel?>(null),
        );

  // pick video
  Future<AsyncValue<VideoHelperModel?>> pickVideo({
    required ImageSource source,
  }) async {
    state = const AsyncLoading();

    return state = await AsyncValue.guard<VideoHelperModel?>(() async {
      final video = await VideoHelper.pickVideo(source: source);
      return video;
    });
  }
}

// video picker controller provider
final videoPickerControllerProvider = StateNotifierProvider.autoDispose<
    VideoPickerControllerNotifier, AsyncValue<VideoHelperModel?>>(
  (ref) => VideoPickerControllerNotifier(),
);

// firestore gallery and video stream provider
final firestoreGalleryAndVideoStreamProvider = StreamProvider.autoDispose
    .family<VideoAndGalleryModel, String>((ref, docPath) {
  final firestoreInstance = FirebaseFirestore.instance;

  // stream list of gallery from firestore
  final gallery = firestoreInstance
      .collection('gallery')
      .doc('gallery')
      .snapshots()
      .map((event) => event.data());

  // stream list of video from firestore
  final video = firestoreInstance
      .collection('gallery')
      .doc('video')
      .snapshots()
      .map((event) => VideoAndGalleryModel.fromJson(event.data()!));

  // return stream of gallery and video
  // final model = VideoAndGalleryModel(
  //   image: gallery.map((event)async => await Gallery.fromJson(event!)).toList(),
  //   video: video.map((event) => VideoDTOModel.fromJson(event!)).toList(),
  // );
  return video;
});

// multiple video picker controller
class MultipleVideoPickerControllerNotifier
    extends StateNotifier<List<VideoHelperModel>> {
  MultipleVideoPickerControllerNotifier() : super([]);

  // add video to list
  void addVideoToList({
    required VideoHelperModel video,
  }) {
    state = [...state, video];
  }

  // remove video from list
  void removeVideoFromList({required int index}) {
    state = [...state]..removeAt(index);
  }

  // update video from list
  void updateVideoFromList({
    required int index,
    required VideoHelperModel video,
  }) {
    // update the video
    state[index] = video;
    // update the state
    state = [...state];
  }

  // clear video list
  void clearVideoList() {
    state = [];
  }
}

// multiple video picker controller provider
final multipleVideoPickerControllerProvider = StateNotifierProvider.autoDispose<
    MultipleVideoPickerControllerNotifier, List<VideoHelperModel>>(
  (ref) => MultipleVideoPickerControllerNotifier(),
);

// firebase video and gallery controller
class FirebaseVideoControllerNotifier
    extends StateNotifier<AsyncValue<List<VideoDTOModel>>> {
  FirebaseVideoControllerNotifier()
      : super(
          AsyncData<List<VideoDTOModel>>(
            [],
          ),
        );

  // add video to firebase
  Future<void> addVideosToFirebase({
    required List<VideoHelperModel> videos,
    required String docPath,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      List<VideoDTOModel> videoList = [];

      for (var e in videos) {
        // get doc id
        final docId = Uuid().v1();
        final videoUrl = await ImageHelpers.addImageToFirebaseStorage(
          image: e.video,
          path: 'videos',
        );

        // add to firestore
        final video = await FirestoreHelper.addDataToDoc(
          docPath: docPath,
          data: VideoDTOModel(
            videoUrl: videoUrl,
            videoDescription: e.videoDescription,
            id: docId,
          ).toJson(),
        );

        videoList.add(VideoDTOModel.fromJson(video));
      }

      return videoList;
    });
  }

  // add gallery to firebase
  Future<void> addGalleryToFirebase({
    required List<ImageHelperModel> gallery,
    required String docPath,
  }) async {
    state = const AsyncLoading();

    // state = await AsyncValue.guard(() async {
    //   final galleryUrl = await FirebaseStorageHelper.uploadMultipleFiles(
    //     files: gallery.map((e) => File(e.image.path)).toList(),
    //     path: docPath,
    //   );

    //   final galleryDetails = galleryUrl.map((e) {
    //     return Gallery(
    //       imageUrl: e,
    //       imageDescription: e,
    //     );
    //   }).toList();

    //   final videoAndGallery = await FirestoreHelper.addDocumentToFirestore(
    //     docPath: docPath,
    //     data: galleryDetails.map((e) => e.toJson()).toList(),
    //   );

    //   return videoAndGallery;
    // });
  }
}

// stream video from firestore
@riverpod
Stream<List<VideoDTOModel>> streamVideoFromFirestore(
    StreamVideoFromFirestoreRef ref) {
  final firestoreInstance = FirebaseFirestore.instance;

  // stream list of video from firestore
  final video = firestoreInstance.collection('videos').snapshots().map(
        (event) => event.docs
            .map(
              (e) => VideoDTOModel.fromJson(
                e.data(),
              ),
            )
            .toList(),
      );

  return video;
}

// stream gallery from firestore
@riverpod
Stream<List<GalleryDTOModel>> streamGalleryFromFirestore(
    StreamGalleryFromFirestoreRef ref) {
  final firestoreInstance = FirebaseFirestore.instance;

  // stream list of gallery from firestore
  final gallery = firestoreInstance.collection('gallery').snapshots().map(
        (event) => event.docs
            .map(
              (e) => GalleryDTOModel.fromJson(
                e.data(),
              ),
            )
            .toList(),
      );

  return gallery;
}

// get data

>>>>>>> 6dbeed21ae13da762a8632ba99c4b91e03dd3557

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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

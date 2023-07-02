<<<<<<< HEAD
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:video_player/video_player.dart';

// a custom hook that returns a videoplayercontroller from a video url
ValueNotifier<VideoPlayerController> useVideoPlayerController(
  String videoUrl,
  VideoFormat? formatHint,
  Future<ClosedCaptionFile>? closedCaptionFile,
  VideoPlayerOptions? videoPlayerOptions,
  Map<String, String>? httpHeaders,
) {
  final videoPlayerController = useState<VideoPlayerController>(
    VideoPlayerController.network(
      videoUrl,
      formatHint: formatHint,
      closedCaptionFile: closedCaptionFile,
      videoPlayerOptions: videoPlayerOptions,
      httpHeaders: httpHeaders ?? {},
    ),
  );

  useEffect(() {
    // initialize the video player controller
    videoPlayerController.value.initialize().then((_) {
      // ensure the first frame is shown after the video is initialized
      videoPlayerController.value.play();
      videoPlayerController.value.setLooping(true);
    });
    return () {
      videoPlayerController.value.dispose();
    };
  }, []);

  return videoPlayerController;
}

// a custom hook that returns a videoplayercontroller from a video file
ValueNotifier<VideoPlayerController> useVideoPlayerControllerFromFile({
  required File videoFile,
  Future<ClosedCaptionFile>? closedCaptionFile,
  VideoPlayerOptions? videoPlayerOptions,
  Map<String, String>? httpHeaders,
}) {
  final videoPlayerController = useState<VideoPlayerController>(
    VideoPlayerController.file(
      videoFile,
      closedCaptionFile: closedCaptionFile,
      videoPlayerOptions: videoPlayerOptions,
      httpHeaders: httpHeaders ?? {},
    ),
  );

  useEffect(() {
    // initialize the video player controller
    videoPlayerController.value.initialize().then((_) {
      // ensure the first frame is shown after the video is initialized
      videoPlayerController.value.setLooping(true);
    });
    return () {
      videoPlayerController.value.dispose();
    };
  }, []);

  return videoPlayerController;
}
=======
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:video_player/video_player.dart';

// a custom hook that returns a videoplayercontroller from a video url
ValueNotifier<VideoPlayerController> useVideoPlayerController(
  String videoUrl,
  VideoFormat? formatHint,
  Future<ClosedCaptionFile>? closedCaptionFile,
  VideoPlayerOptions? videoPlayerOptions,
  Map<String, String>? httpHeaders,
) {
  final videoPlayerController = useState<VideoPlayerController>(
    VideoPlayerController.network(
      videoUrl,
      formatHint: formatHint,
      closedCaptionFile: closedCaptionFile,
      videoPlayerOptions: videoPlayerOptions,
      httpHeaders: httpHeaders ?? {},
    ),
  );

  useEffect(() {
    // initialize the video player controller
    videoPlayerController.value.initialize().then((_) {
      // ensure the first frame is shown after the video is initialized
      videoPlayerController.value.play();
      videoPlayerController.value.setLooping(true);
    });
    return () {
      videoPlayerController.value.dispose();
    };
  }, []);

  return videoPlayerController;
}

// a custom hook that returns a videoplayercontroller from a video file
ValueNotifier<VideoPlayerController> useVideoPlayerControllerFromFile({
  required File videoFile,
  Future<ClosedCaptionFile>? closedCaptionFile,
  VideoPlayerOptions? videoPlayerOptions,
  Map<String, String>? httpHeaders,
}) {
  final videoPlayerController = useState<VideoPlayerController>(
    VideoPlayerController.file(
      videoFile,
      closedCaptionFile: closedCaptionFile,
      videoPlayerOptions: videoPlayerOptions,
      httpHeaders: httpHeaders ?? {},
    ),
  );

  useEffect(() {
    // initialize the video player controller
    videoPlayerController.value.initialize().then((_) {
      // ensure the first frame is shown after the video is initialized
      videoPlayerController.value.setLooping(true);
    });
    return () {
      videoPlayerController.value.dispose();
    };
  }, []);

  return videoPlayerController;
}
>>>>>>> 6dbeed21ae13da762a8632ba99c4b91e03dd3557

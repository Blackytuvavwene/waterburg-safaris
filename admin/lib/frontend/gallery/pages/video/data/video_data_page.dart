import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';
import 'package:universal_io/io.dart';
import 'package:video_player/video_player.dart';

// video data page hook consumer widget with app layout
class VideoDataPage extends HookConsumerWidget {
  const VideoDataPage({
    Key? key,
    this.data,
    required this.multipleVideoPickerControllerNotifier,
    required this.videoPickerControllerNotifier,
    this.pickedVideo,
    this.localVideos = const [],
  }) : super(key: key);
  final List<VideoDTOModel>? data;
  final MultipleVideoPickerControllerNotifier
      multipleVideoPickerControllerNotifier;
  final VideoPickerControllerNotifier videoPickerControllerNotifier;
  final AsyncValue<VideoHelperModel?>? pickedVideo;
  final List<VideoHelperModel> localVideos;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileVideoDataPage(
        data: data,
        multipleVideoPickerControllerNotifier:
            multipleVideoPickerControllerNotifier,
        videoPickerControllerNotifier: videoPickerControllerNotifier,
        pickedVideo: pickedVideo,
        localVideos: localVideos,
      ),
      tablet: _TabletVideoDataPage(
        data: data,
        multipleVideoPickerControllerNotifier:
            multipleVideoPickerControllerNotifier,
        videoPickerControllerNotifier: videoPickerControllerNotifier,
      ),
      desktop: _DesktopVideoDataPage(
        data: data,
        multipleVideoPickerControllerNotifier:
            multipleVideoPickerControllerNotifier,
        videoPickerControllerNotifier: videoPickerControllerNotifier,
      ),
    );
  }
}

// video data page mobile
class _MobileVideoDataPage extends HookConsumerWidget {
  const _MobileVideoDataPage({
    this.data,
    required this.multipleVideoPickerControllerNotifier,
    required this.videoPickerControllerNotifier,
    this.pickedVideo,
    this.localVideos = const [],
  });
  final List<VideoDTOModel>? data;
  final MultipleVideoPickerControllerNotifier
      multipleVideoPickerControllerNotifier;
  final VideoPickerControllerNotifier videoPickerControllerNotifier;
  final AsyncValue<VideoHelperModel?>? pickedVideo;
  final List<VideoHelperModel> localVideos;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Video'),
      // ),
      body: CustomScrollView(
        slivers: [
          if (data != null)
            if (data!.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ListTile(
                      title: DText(
                        text: data![index].videoUrl,
                      ),
                    );
                  },
                  childCount: data!.length,
                ),
              )
            else
              SliverFillRemaining(
                  child: ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                    ),
                    child: LocalVideoPlayerWidget(
                      videoFile: localVideos[index],
                      index: index,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: localVideos.length,
              )),
        ],
      ),
      floatingActionButton: CustomElevatedButton(
        text: 'Add Video',
        onPressed: () async {
          final video = await videoPickerControllerNotifier.pickVideo(
            source: ImageSource.gallery,
          );

          // if video is not null
          if (video.value != null) {
            // add video to list
            multipleVideoPickerControllerNotifier.addVideoToList(
                video: video.value!);
          }
        },
        width: 10.w,
        height: 5.h,
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
    );
  }
}

// video data page tablet
class _TabletVideoDataPage extends HookConsumerWidget {
  const _TabletVideoDataPage({
    this.data,
    required this.multipleVideoPickerControllerNotifier,
    required this.videoPickerControllerNotifier,
  });
  final List<VideoDTOModel>? data;
  final MultipleVideoPickerControllerNotifier
      multipleVideoPickerControllerNotifier;
  final VideoPickerControllerNotifier videoPickerControllerNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text(
          data?.first.videoUrl ?? 'Video',
        ),
      ),
    );
  }
}

// video data page desktop
class _DesktopVideoDataPage extends HookConsumerWidget {
  const _DesktopVideoDataPage({
    this.data,
    required this.multipleVideoPickerControllerNotifier,
    required this.videoPickerControllerNotifier,
  });
  final List<VideoDTOModel>? data;
  final MultipleVideoPickerControllerNotifier
      multipleVideoPickerControllerNotifier;
  final VideoPickerControllerNotifier videoPickerControllerNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text(
          data?.first.videoUrl ?? 'Video',
        ),
      ),
    );
  }
}

// video player widget
class LocalVideoPlayerWidget extends HookConsumerWidget {
  const LocalVideoPlayerWidget({
    Key? key,
    this.looping = false,
    this.autoplay = false,
    required this.videoFile,
    required this.index,
  }) : super(key: key);
  final VideoHelperModel videoFile;
  final bool looping;
  final bool autoplay;
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // use video player controller
    final videoPlayerController = useVideoPlayerControllerFromFile(
      videoFile: File(videoFile.video.path),
    );

    // is playing
    final isPlaying = useState(false);
    return SizedBox(
      width: 100.w,
      height: 25.h,
      child: AspectRatio(
        aspectRatio: videoPlayerController.value.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(videoPlayerController.value),
            if (videoPlayerController.value.value.isBuffering)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              const SizedBox.shrink(),
            Center(
              child: IconButton(
                iconSize: 26.sp,
                icon: isPlaying.value
                    ? LineIcon.pauseCircleAlt()
                    : LineIcon.playCircleAlt(),
                onPressed: () {
                  if (videoPlayerController.value.value.isPlaying == true) {
                    isPlaying.value = false;
                    videoPlayerController.value.pause();
                  } else {
                    isPlaying.value = true;
                    videoPlayerController.value.play();
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 100.w,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: LineIcon.editAlt(),
                      onPressed: () {
                        //todo: edit video
                      },
                    ),
                    IconButton(
                      icon: LineIcon.trash(),
                      onPressed: () {
                        // delete video
                        ref
                            .read(
                                multipleVideoPickerControllerProvider.notifier)
                            .removeVideoFromList(
                              index: index,
                            );
                      },
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: VideoProgressIndicator(
                videoPlayerController.value,
                allowScrubbing: true,
                padding: const EdgeInsets.all(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

<<<<<<< HEAD
import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GalleryPage extends HookConsumerWidget {
  const GalleryPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final galleryData = ref.watch(streamGalleryFromFirestoreProvider);
    final videoData = ref.watch(streamVideoFromFirestoreProvider);

    // video picker helper
    final videoPickerHelper = ref.watch(videoPickerControllerProvider);
    // multiple video picker helper
    final multipleVideoPickerHelper =
        ref.watch(multipleVideoPickerControllerProvider);

    // video picker helper notifier
    final videoPickerHelperNotifier =
        ref.read(videoPickerControllerProvider.notifier);
    // multiple video picker helper notifier
    final multipleVideoPickerHelperNotifier =
        ref.read(multipleVideoPickerControllerProvider.notifier);
    return GalleryPageHandler(
      gallery: galleryData.when(
        data: (data) {
          return GalleryDataPage(gallery: data);
        },
        error: (error, stackTrace) {
          return GalleryErrorPage(
            error: error.toString(),
          );
        },
        loading: () {
          return const GalleryLoadingPage();
        },
      ),
      video: videoData.when(
        data: (data) {
          return VideoDataPage(
            data: data,
            videoPickerControllerNotifier: videoPickerHelperNotifier,
            multipleVideoPickerControllerNotifier:
                multipleVideoPickerHelperNotifier,
            pickedVideo: videoPickerHelper,
            localVideos: multipleVideoPickerHelper,
          );
        },
        error: (error, stackTrace) {
          return VideoErrorPage(
            error: error.toString(),
          );
        },
        loading: () {
          return const VideoLoadingPage();
        },
      ),
    );
  }
}

class GalleryPageHandler extends HookConsumerWidget {
  const GalleryPageHandler({
    super.key,
    required this.gallery,
    required this.video,
  });
  final Widget video;
  final Widget gallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // page controller
    // final pageController = usePageController();
    // tab controller
    final tabController = useTabController(initialLength: 2);
    return Scaffold(
      appBar: AppBar(
        title: const DText(
          text: 'Gallery',
        ),
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: tabController,
          labelStyle: GoogleFonts.dosis(),
          tabs: const [
            Tab(
              text: 'Videos',
            ),
            Tab(
              text: 'Photos',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          video,
          gallery,
        ],
      ),
    );
  }
}
=======
import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GalleryPage extends HookConsumerWidget {
  const GalleryPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final galleryData = ref.watch(streamGalleryFromFirestoreProvider);
    final videoData = ref.watch(streamVideoFromFirestoreProvider);

    // video picker helper
    final videoPickerHelper = ref.watch(videoPickerControllerProvider);
    // multiple video picker helper
    final multipleVideoPickerHelper =
        ref.watch(multipleVideoPickerControllerProvider);

    // video picker helper notifier
    final videoPickerHelperNotifier =
        ref.read(videoPickerControllerProvider.notifier);
    // multiple video picker helper notifier
    final multipleVideoPickerHelperNotifier =
        ref.read(multipleVideoPickerControllerProvider.notifier);
    return GalleryPageHandler(
      gallery: galleryData.when(
        data: (data) {
          return GalleryDataPage(gallery: data);
        },
        error: (error, stackTrace) {
          return GalleryErrorPage(
            error: error.toString(),
          );
        },
        loading: () {
          return const GalleryLoadingPage();
        },
      ),
      video: videoData.when(
        data: (data) {
          return VideoDataPage(
            data: data,
            videoPickerControllerNotifier: videoPickerHelperNotifier,
            multipleVideoPickerControllerNotifier:
                multipleVideoPickerHelperNotifier,
            pickedVideo: videoPickerHelper,
            localVideos: multipleVideoPickerHelper,
          );
        },
        error: (error, stackTrace) {
          return VideoErrorPage(
            error: error.toString(),
          );
        },
        loading: () {
          return const VideoLoadingPage();
        },
      ),
    );
  }
}

class GalleryPageHandler extends HookConsumerWidget {
  const GalleryPageHandler({
    super.key,
    required this.gallery,
    required this.video,
  });
  final Widget video;
  final Widget gallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // page controller
    // final pageController = usePageController();
    // tab controller
    final tabController = useTabController(initialLength: 2);
    return Scaffold(
      appBar: AppBar(
        title: const DText(
          text: 'Gallery',
        ),
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: tabController,
          labelStyle: GoogleFonts.dosis(),
          tabs: const [
            Tab(
              text: 'Videos',
            ),
            Tab(
              text: 'Photos',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          video,
          gallery,
        ],
      ),
    );
  }
}
>>>>>>> 6dbeed21ae13da762a8632ba99c4b91e03dd3557

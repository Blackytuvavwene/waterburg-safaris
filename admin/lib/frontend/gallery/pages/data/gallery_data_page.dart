import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// gallery data page stateless hook consumer with app layout
class GalleryDataPage extends HookConsumerWidget {
  const GalleryDataPage({super.key, required this.gallery,});
  final List<Gallery> gallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileGalleryDataPage(),
      tablet: _TabletGalleryDataPage(),
      desktop: _DesktopGalleryDataPage(),
    );
  }
}

// gallery data page mobile
class _MobileGalleryDataPage extends HookConsumerWidget {
  const _MobileGalleryDataPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// gallery data page tablet
class _TabletGalleryDataPage extends HookConsumerWidget {
  const _TabletGalleryDataPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// gallery data page desktop
class _DesktopGalleryDataPage extends HookConsumerWidget {
  const _DesktopGalleryDataPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// video data page stateless hook consumer with app layout
class VideoDataPage extends HookConsumerWidget {
  const VideoDataPage({super.key, required this.videos,});
  final List<VideoDTOModel> videos;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileVideoDataPage(),
      tablet: _TabletVideoDataPage(),
      desktop: _DesktopVideoDataPage(),
    );
  }
}

// video data page mobile
class _MobileVideoDataPage extends HookConsumerWidget {
  const _MobileVideoDataPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(child: DText(text: 'Loaded sy',),);
  }
}

// video data page tablet
class _TabletVideoDataPage extends HookConsumerWidget {
  const _TabletVideoDataPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// video data page desktop
class _DesktopVideoDataPage extends HookConsumerWidget {
  const _DesktopVideoDataPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}


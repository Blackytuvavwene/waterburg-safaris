import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GalleryPage extends HookConsumerWidget {
  const GalleryPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videos = ref.watch(firestoreVideoStreamProvider('videos'));
    final images = ref.watch(firestoreGalleryStreamProvider('images'));
    return AppLayout(
      mobile: _MobileGalleryPage(
        videoPage: videos.when(data: (data){
          return VideoDataPage(videos: data,);
        }, error: (error,stackTrace){
          return VideoErrorPage(error: error.toString(),);
        }, loading: (){
          return const VideoLoadingPage();
        },),
        imagePage: images.when(data: (data){
          return GalleryDataPage(gallery: data,);
        }, error: (error,stackTrace){
          return GalleryErrorPage(error: error.toString(),);
        }, loading: (){
          return const GalleryLoadingPage();
        },),
      ),
      tablet: _TabletGalleryPage(),
      desktop: _DesktopGalleryPage(),
    );
}


}


// gallery page mobile
class _MobileGalleryPage extends HookConsumerWidget {
  const _MobileGalleryPage({required this.videoPage, required this.imagePage,});
  final Widget videoPage;
  final Widget imagePage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
body: CustomScrollView(slivers: [
  SliverToBoxAdapter(
    child: Container(
      height: 200,
      child: videoPage,
    ),
  ),
  SliverToBoxAdapter(
    child: Container(
      height: 200,
      child: imagePage,
    ),
  ),
],),
    );
  }
}

// gallery page tablet
class _TabletGalleryPage extends HookConsumerWidget {
  const _TabletGalleryPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// gallery page desktop
class _DesktopGalleryPage extends HookConsumerWidget {
  const _DesktopGalleryPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

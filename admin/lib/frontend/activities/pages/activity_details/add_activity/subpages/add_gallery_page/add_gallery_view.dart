import 'package:admin/global/global.dart';
import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// add gallery view hook consumer widget with app layout
class AddGalleryView extends HookConsumerWidget {
  const AddGalleryView({
    super.key,
    this.galleryData,
  });
  final List<Gallery>? galleryData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileAddGalleryView(
        galleryData: galleryData,
      ),
      tablet: _TabletAddGalleryView(
        galleryData: galleryData,
      ),
      desktop: _DesktopAddGalleryView(
        galleryData: galleryData,
      ),
    );
  }
}

// mobile add gallery view
class _MobileAddGalleryView extends HookConsumerWidget {
  const _MobileAddGalleryView({
    this.galleryData,
  });
  final List<Gallery>? galleryData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// tablet add gallery view
class _TabletAddGalleryView extends HookConsumerWidget {
  const _TabletAddGalleryView({
    this.galleryData,
  });
  final List<Gallery>? galleryData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// desktop add gallery view
class _DesktopAddGalleryView extends HookConsumerWidget {
  const _DesktopAddGalleryView({
    this.galleryData,
  });
  final List<Gallery>? galleryData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

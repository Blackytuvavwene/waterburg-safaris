<<<<<<< HEAD
import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// gallery data page stateless hook consumer with app layout
class GalleryDataPage extends HookConsumerWidget {
  const GalleryDataPage({
    super.key,
    required this.gallery,
  });
  final List<GalleryDTOModel> gallery;
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
=======
import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// gallery data page stateless hook consumer with app layout
class GalleryDataPage extends HookConsumerWidget {
  const GalleryDataPage({
    super.key,
    required this.gallery,
  });
  final List<GalleryDTOModel> gallery;
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
>>>>>>> 6dbeed21ae13da762a8632ba99c4b91e03dd3557

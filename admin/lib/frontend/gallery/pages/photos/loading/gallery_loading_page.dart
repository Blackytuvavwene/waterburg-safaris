import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// gallery loading page hook consumer widget with app layout
class GalleryLoadingPage extends HookConsumerWidget {
  const GalleryLoadingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileGalleryLoadingPage(),
      tablet: _TabletGalleryLoadingPage(),
      desktop: _DesktopGalleryLoadingPage(),
    );
  }
}

// gallery loading page mobile
class _MobileGalleryLoadingPage extends HookConsumerWidget {
  const _MobileGalleryLoadingPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// gallery loading page tablet
class _TabletGalleryLoadingPage extends HookConsumerWidget {
  const _TabletGalleryLoadingPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// gallery loading page desktop
class _DesktopGalleryLoadingPage extends HookConsumerWidget {
  const _DesktopGalleryLoadingPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

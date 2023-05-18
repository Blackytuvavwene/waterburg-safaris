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

// video loading page hook consumer widget with app layout
class VideoLoadingPage extends HookConsumerWidget {
  const VideoLoadingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileVideoLoadingPage(),
      tablet: _TabletVideoLoadingPage(),
      desktop: _DesktopVideoLoadingPage(),
    );
  }
}

// video loading page mobile
class _MobileVideoLoadingPage extends HookConsumerWidget {
  const _MobileVideoLoadingPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// video loading page tablet
class _TabletVideoLoadingPage extends HookConsumerWidget {
  const _TabletVideoLoadingPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// video loading page desktop
class _DesktopVideoLoadingPage extends HookConsumerWidget {
  const _DesktopVideoLoadingPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}


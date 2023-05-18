import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// gallery error page stateless hook consumer with app layout
class GalleryErrorPage extends HookConsumerWidget {
  const GalleryErrorPage({
    Key? key,
    required this.error,
  }) : super(key: key);
  final String error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileGalleryErrorPage(
        error: error,
      ),
      tablet: _TabletGalleryErrorPage(
        error: error,
      ),
      desktop: _DesktopGalleryErrorPage(
        error: error,
      ),
    );
  }
}

// gallery error page mobile
class _MobileGalleryErrorPage extends HookConsumerWidget {
  const _MobileGalleryErrorPage({
    required this.error,
  });
  final String error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('Gallery Error Page Mobile $error'),
      ),
    );
  }
}

// gallery error page tablet
class _TabletGalleryErrorPage extends HookConsumerWidget {
  const _TabletGalleryErrorPage({
    required this.error,
  });
  final String error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('Gallery Error Page Tablet $error'),
      ),
    );
  }
}

// gallery error page desktop
class _DesktopGalleryErrorPage extends HookConsumerWidget {
  const _DesktopGalleryErrorPage({
    required this.error,
  });
  final String error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Gallery Error Page Desktop'),
      ),
    );
  }
}

// video error page stateless hook consumer with app layout
class VideoErrorPage extends HookConsumerWidget {
  const VideoErrorPage({
    Key? key,
    required this.error,
  }) : super(key: key);
  final String error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileVideoErrorPage(
        error: error,
      ),
      tablet: _TabletVideoErrorPage(
        error: error,
      ),
      desktop: _DesktopVideoErrorPage(
        error: error,
      ),
    );
  }
}

// video error page mobile
class _MobileVideoErrorPage extends HookConsumerWidget {
  const _MobileVideoErrorPage({
    required this.error,
  });
  final String error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('Video Error Page Mobile $error'),
      ),
    );
  }
}

// video error page tablet
class _TabletVideoErrorPage extends HookConsumerWidget {
  const _TabletVideoErrorPage({
    required this.error,
  });
  final String error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text('Video Error Page Tablet $error'),
      ),
    );
  }
}

// video error page desktop
class _DesktopVideoErrorPage extends HookConsumerWidget {
  const _DesktopVideoErrorPage({
    required this.error,
  });
  final String error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Video Error Page Desktop'),
      ),
    );
  }
}

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// video error page hook consumer widget with app layout
class VideoErrorPage extends HookConsumerWidget {
  const VideoErrorPage({
    super.key,
    this.error,
  });
  final String? error;
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
    this.error,
  });
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: DText(
          text: error ?? 'Error',
        ),
      ),
    );
  }
}

// video error page tablet
class _TabletVideoErrorPage extends HookConsumerWidget {
  const _TabletVideoErrorPage({
    this.error,
  });
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: DText(
          text: error ?? 'Error',
        ),
      ),
    );
  }
}

// video error page desktop
class _DesktopVideoErrorPage extends HookConsumerWidget {
  const _DesktopVideoErrorPage({
    this.error,
  });
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: DText(
          text: error ?? 'Error',
        ),
      ),
    );
  }
}

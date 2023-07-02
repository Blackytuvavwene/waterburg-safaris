import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// video loading page hook consumer widget with app layout
class VideoLoadingPage extends HookConsumerWidget {
  const VideoLoadingPage({
    super.key,
    this.loading,
  });
  final String? loading;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileVideoLoadingPage(
        loading: loading,
      ),
      tablet: _TabletVideoLoadingPage(
        loading: loading,
      ),
      desktop: _DesktopVideoLoadingPage(
        loading: loading,
      ),
    );
  }
}

// video loading page mobile
class _MobileVideoLoadingPage extends HookConsumerWidget {
  const _MobileVideoLoadingPage({
    this.loading,
  });
  final String? loading;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: DText(
          text: loading ?? 'Loading',
        ),
      ),
    );
  }
}

// video loading page tablet
class _TabletVideoLoadingPage extends HookConsumerWidget {
  const _TabletVideoLoadingPage({
    this.loading,
  });
  final String? loading;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: DText(
          text: loading ?? 'Loading',
        ),
      ),
    );
  }
}

// video loading page desktop
class _DesktopVideoLoadingPage extends HookConsumerWidget {
  const _DesktopVideoLoadingPage({
    this.loading,
  });
  final String? loading;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: DText(
          text: loading ?? 'Loading',
        ),
      ),
    );
  }
}

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class PickImagesPage extends HookConsumerWidget {
  const PickImagesPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
        mobile: _MobilePickImagesPage(),
        tablet: _TabletPickImagesPage(),
        desktop: _DesktopPickImagesPage());
  }
}

// mobile pick images page with container child
class _MobilePickImagesPage extends HookConsumerWidget {
  const _MobilePickImagesPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: DText(
          text: 'Pick images',
          fontSize: 14.sp,
        ),
      ),
      body: Container(),
    );
  }
}

// tablet pick images page with container child
class _TabletPickImagesPage extends HookConsumerWidget {
  const _TabletPickImagesPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// desktop pick images page with container child
class _DesktopPickImagesPage extends HookConsumerWidget {
  const _DesktopPickImagesPage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

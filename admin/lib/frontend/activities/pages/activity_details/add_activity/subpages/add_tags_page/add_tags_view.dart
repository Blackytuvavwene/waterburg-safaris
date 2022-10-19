import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// add tags view hook consumer widget with app layout
class AddTagsView extends HookConsumerWidget {
  const AddTagsView({
    super.key,
    this.tagData,
  });
  final List<String>? tagData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileAddTagsView(
        tagData: tagData,
      ),
      tablet: _TabletAddTagsView(
        tagData: tagData,
      ),
      desktop: _DesktopAddTagsView(
        tagData: tagData,
      ),
    );
  }
}

// mobile add tags view
class _MobileAddTagsView extends HookConsumerWidget {
  const _MobileAddTagsView({
    this.tagData,
  });
  final List<String>? tagData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// tablet add tags view
class _TabletAddTagsView extends HookConsumerWidget {
  const _TabletAddTagsView({
    this.tagData,
  });
  final List<String>? tagData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// desktop add tags view
class _DesktopAddTagsView extends HookConsumerWidget {
  const _DesktopAddTagsView({
    this.tagData,
  });
  final List<String>? tagData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

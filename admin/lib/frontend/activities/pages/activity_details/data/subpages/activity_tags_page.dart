import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// activity tags page with app layout
class ActivityTagsPage extends HookConsumerWidget {
  const ActivityTagsPage({
    Key? key,
    this.tags,
    this.activityId,
    this.activityNotifier,
    this.isEditing,
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  final ValueNotifier<bool>? isEditing;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileActivityTagsPage(
        tags: tags,
        activityId: activityId,
        activityNotifier: activityNotifier,
        isEditing: isEditing,
      ),
      tablet: _TabletActivityTagsPage(
        tags: tags,
        activityId: activityId,
        activityNotifier: activityNotifier,
      ),
      desktop: _DesktopActivityTagsPage(
        tags: tags,
        activityId: activityId,
        activityNotifier: activityNotifier,
      ),
    );
  }
}

// mobile activity tags page
class _MobileActivityTagsPage extends HookConsumerWidget {
  const _MobileActivityTagsPage({
    Key? key,
    this.tags,
    this.activityId,
    this.activityNotifier,
    this.isEditing,
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  final ValueNotifier<bool>? isEditing;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ActivityTags(
        tags: tags,
        activityId: activityId,
        isEditing: isEditing,
      ),
    );
  }
}

// tablet activity tags page
class _TabletActivityTagsPage extends HookConsumerWidget {
  const _TabletActivityTagsPage({
    Key? key,
    this.tags,
    this.activityId,
    this.activityNotifier,
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ActivityTags(
        tags: tags,
        activityId: activityId,
      ),
    );
  }
}

// desktop activity tags page
class _DesktopActivityTagsPage extends HookConsumerWidget {
  const _DesktopActivityTagsPage({
    Key? key,
    this.tags,
    this.activityId,
    this.activityNotifier,
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ActivityTags(
        tags: tags,
        activityId: activityId,
      ),
    );
  }
}

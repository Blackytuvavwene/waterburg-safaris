import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// activity tags page with app layout
class ActivityTagsPage extends HookConsumerWidget {
  const ActivityTagsPage({
    Key? key,
    this.tags,
    this.activityId,
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileActivityTagsPage(
        tags: tags,
        activityId: activityId,
      ),
      tablet: _TabletActivityTagsPage(
        tags: tags,
        activityId: activityId,
      ),
      desktop: _DesktopActivityTagsPage(
        tags: tags,
        activityId: activityId,
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
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
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

// tablet activity tags page
class _TabletActivityTagsPage extends HookConsumerWidget {
  const _TabletActivityTagsPage({
    Key? key,
    this.tags,
    this.activityId,
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
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
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
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

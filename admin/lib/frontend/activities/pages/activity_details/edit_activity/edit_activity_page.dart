import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditActivityPage extends HookConsumerWidget {
  const EditActivityPage({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityData = ref.watch(activityToEditActivityPageProvider);
    return AppLayout(
      mobile: _MobileEditActivityPage(
        activity: activityData,
      ),
      tablet: _TabletEditActivityPage(
        activity: activityData,
      ),
      desktop: _DesktopEditActivityPage(
        activity: activityData,
      ),
    );
  }
}

// mobile edit activity page
class _MobileEditActivityPage extends HookConsumerWidget {
  const _MobileEditActivityPage({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// tablet edit activity page
class _TabletEditActivityPage extends HookConsumerWidget {
  const _TabletEditActivityPage({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// desktop edit activity page
class _DesktopEditActivityPage extends HookConsumerWidget {
  const _DesktopEditActivityPage({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: DText(
          text: 'Edit Activity $activity',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: ListView(
              children: [
                TextFormField(
                  initialValue: activity!.activityName,
                  decoration: const InputDecoration(
                    labelText: 'Activity Name',
                  ),
                ),
                TextFormField(
                  initialValue: activity!.seoDescription,
                  decoration: const InputDecoration(
                    labelText: 'Activity Description',
                  ),
                ),
                const DFormTextAreaField()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

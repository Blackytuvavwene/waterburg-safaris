import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddActivityPage extends HookConsumerWidget {
  const AddActivityPage({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityData = ref.watch(activityToEditActivityPageProvider);
    return AppLayout(
      mobile: _MobileAddActivityPage(
        activity: activityData,
      ),
      tablet: _TabletAddActivityPage(
        activity: activityData,
      ),
      desktop: _DesktopAddActivityPage(
        activity: activityData,
      ),
    );
  }
}

// mobile edit activity page
class _MobileAddActivityPage extends HookConsumerWidget {
  const _MobileAddActivityPage({
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
class _TabletAddActivityPage extends HookConsumerWidget {
  const _TabletAddActivityPage({
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
class _DesktopAddActivityPage extends HookConsumerWidget {
  const _DesktopAddActivityPage({
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

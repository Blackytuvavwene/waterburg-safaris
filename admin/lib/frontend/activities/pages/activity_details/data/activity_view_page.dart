import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// activity view page with app layout
class ActivityDetailsPage extends HookConsumerWidget {
  const ActivityDetailsPage({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _ActivityDetailsPageMobile(
        activity: activity,
      ),
      tablet: _ActivityDetailsPageTablet(
        activity: activity,
      ),
      desktop: _ActivityDetailsPageDesktop(
        activity: activity,
      ),
    );
  }
}

// activity view page for mobile
class _ActivityDetailsPageMobile extends HookConsumerWidget {
  const _ActivityDetailsPageMobile({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: DText(
                  text: activity!.activityName.toString(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// activity view page for tablet
class _ActivityDetailsPageTablet extends HookConsumerWidget {
  const _ActivityDetailsPageTablet({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: DText(
                  text: activity!.activityName.toString(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// activity view page for desktop
class _ActivityDetailsPageDesktop extends HookConsumerWidget {
  const _ActivityDetailsPageDesktop({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: DText(
                  text: activity!.activityName.toString(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

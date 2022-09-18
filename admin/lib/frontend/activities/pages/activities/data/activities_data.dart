import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vrouter/vrouter.dart';

class ActivitiesData extends HookConsumerWidget {
  const ActivitiesData({
    Key? key,
    this.activitiesData,
  }) : super(key: key);
  final List<Activity>? activitiesData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _ActivitiesDataMobile(
        activitiesData: activitiesData,
      ),
      tablet: _ActivitiesDataTablet(
        activitiesData: activitiesData,
      ),
      desktop: _ActivitiesDataDesktop(
        activitiesData: activitiesData,
      ),
    );
  }
}

// activities data for mobile
class _ActivitiesDataMobile extends HookConsumerWidget {
  const _ActivitiesDataMobile({
    Key? key,
    this.activitiesData,
  }) : super(key: key);
  final List<Activity>? activitiesData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: activitiesData!
                .map(
                  (e) => ListTile(
                    onTap: () {
                      context.vRouter.toNamed(
                        'activityDetails',
                        pathParameters: {
                          'activityId': e.activityId.toString(),
                        },
                      );
                    },
                    title: DText(
                      text: e.activityName.toString(),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

// activities data for tablet
class _ActivitiesDataTablet extends HookConsumerWidget {
  const _ActivitiesDataTablet({
    Key? key,
    this.activitiesData,
  }) : super(key: key);
  final List<Activity>? activitiesData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: activitiesData!
                .map(
                  (e) => ListTile(
                    onTap: () {
                      context.vRouter.toNamed(
                        'activityDetails',
                        pathParameters: {
                          'activityId': e.activityId.toString(),
                        },
                      );
                    },
                    title: DText(
                      text: e.activityName.toString(),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

// activities data for desktop
class _ActivitiesDataDesktop extends HookConsumerWidget {
  const _ActivitiesDataDesktop({
    Key? key,
    this.activitiesData,
  }) : super(key: key);
  final List<Activity>? activitiesData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: activitiesData!
                .map(
                  (e) => ListTile(
                    onTap: () {
                      context.vRouter.toNamed(
                        'activityDetails',
                        pathParameters: {
                          'activityId': e.activityId.toString(),
                        },
                      );
                    },
                    title: DText(
                      text: e.activityName.toString(),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

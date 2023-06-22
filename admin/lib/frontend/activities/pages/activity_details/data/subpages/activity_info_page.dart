import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

// activity info page with app layout hook consumer widget
class ActivityInfoPage extends HookConsumerWidget {
  const ActivityInfoPage({
    Key? key,
    this.activity,
    this.activityNotifier,
    this.isEditing,
  }) : super(key: key);
  final Activity? activity;
  final ActivityControlNotifier? activityNotifier;
  final ValueNotifier<bool>? isEditing;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileActivityInfoPage(
        activity: activity,
        activityNotifier: activityNotifier,
        isEditing: isEditing,
      ),
      tablet: _TabletActivityInfoPage(
        activity: activity,
        activityNotifier: activityNotifier,
      ),
      desktop: _DesktopActivityInfoPage(
        activity: activity,
        activityNotifier: activityNotifier,
      ),
    );
  }
}

// mobile activity info page
class _MobileActivityInfoPage extends HookConsumerWidget {
  const _MobileActivityInfoPage({
    Key? key,
    this.activity,
    this.activityNotifier,
    this.isEditing,
  }) : super(key: key);
  final Activity? activity;
  final ActivityControlNotifier? activityNotifier;
  final ValueNotifier<bool>? isEditing;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    ActivityDescriptionViewCard(
                      title: 'Activity SEO Description',
                      description: activity!.seoDescription.toString(),
                      onTap: () {
                        // set is editing to true if not already
                        if (!isEditing!.value) {
                          isEditing!.value = true;
                        }
                        showDialog(
                          context: context,
                          builder: (context) => ActivityDescriptionPopUp(
                            description: activity!.seoDescription.toString(),
                            field: 'seoDescription',
                            activityId: activity?.activityId.toString(),
                            maxLength: 200,
                            onSaved: (value) {
                              activityNotifier?.updateActivitySEODescription(
                                seoDescription: value,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    ActivityDescriptionViewCard(
                      title: 'Activity overview',
                      description: activity!.overview.toString(),
                      onTap: () {
                        // set is editing to true if not already
                        if (!isEditing!.value) {
                          isEditing!.value = true;
                        }

                        showDialog(
                          context: context,
                          builder: (context) => ActivityDescriptionPopUp(
                            description: activity!.overview.toString(),
                            field: 'overview',
                            activityId: activity?.activityId.toString(),
                            maxLength: 1250,
                            onSaved: (value) {
                              activityNotifier?.updateActivityOverview(
                                overview: value,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// tablet activity info page
class _TabletActivityInfoPage extends HookConsumerWidget {
  const _TabletActivityInfoPage({
    Key? key,
    this.activity,
    this.activityNotifier,
  }) : super(key: key);
  final Activity? activity;
  final ActivityControlNotifier? activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  ActivityDescriptionViewCard(
                    title: 'Activity SEO Description',
                    description: activity!.seoDescription.toString(),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ActivityDescriptionPopUp(
                          description: activity?.seoDescription.toString(),
                          field: 'seoDescription',
                          activityId: activity?.activityId.toString(),
                          maxLength: 200,
                          onSaved: (value) {
                            activityNotifier?.updateActivitySEODescription(
                              seoDescription: value,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  ActivityDescriptionViewCard(
                    title: 'Activity overview',
                    description: activity!.overview.toString(),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ActivityDescriptionPopUp(
                          description: activity!.overview.toString(),
                          field: 'overview',
                          activityId: activity?.activityId.toString(),
                          maxLength: 1250,
                          onSaved: (value) {
                            activityNotifier?.updateActivityOverview(
                              overview: value,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// desktop activity info page
class _DesktopActivityInfoPage extends HookConsumerWidget {
  const _DesktopActivityInfoPage({
    Key? key,
    this.activity,
    this.activityNotifier,
  }) : super(key: key);
  final Activity? activity;
  final ActivityControlNotifier? activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  ActivityDescriptionViewCard(
                    title: 'Activity SEO Description',
                    description: activity!.seoDescription.toString(),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ActivityDescriptionPopUp(
                            description: activity!.seoDescription.toString(),
                            field: 'seoDescription',
                            activityId: activity?.activityId.toString(),
                            maxLength: 200,
                            onSaved: (value) {
                              activityNotifier?.updateActivitySEODescription(
                                seoDescription: value,
                              );
                            }),
                      );
                    },
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  ActivityDescriptionViewCard(
                    title: 'Activity overview',
                    description: activity!.overview.toString(),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ActivityDescriptionPopUp(
                          description: activity!.overview.toString(),
                          field: 'overview',
                          activityId: activity?.activityId.toString(),
                          maxLength: 1250,
                          onSaved: (value) {
                            activityNotifier?.updateActivityOverview(
                              overview: value,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

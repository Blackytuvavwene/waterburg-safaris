import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

// activity preiview container hook widget with applayout
class ActivityPreviewContainer extends HookConsumerWidget {
  const ActivityPreviewContainer({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _ActivityPreviewContainerMobile(
        activity: activity,
      ),
      tablet: _ActivityPreviewContainerTablet(
        activity: activity,
      ),
      desktop: _ActivityPreviewContainerDesktop(
        activity: activity,
      ),
    );
  }
}

// activity preview container mobile
class _ActivityPreviewContainerMobile extends HookConsumerWidget {
  const _ActivityPreviewContainerMobile({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.primary.withOpacity(
            0.1,
          ),
      height: 50.h,
      width: 100.w,
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.h,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 2.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 100.w,
              height: 6.h,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: DText(
                        text: activity?.activityName.toString(),
                        fontSize: 19.sp,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 3,
                      child: CustomElevatedButton(
                        text: 'View details',
                        textColor: Theme.of(context).colorScheme.onPrimary,
                        onPressed: () {
                          context.pushNamed(
                            'activityDetails',
                            params: {
                              'activityId': activity!.activityId.toString(),
                            },
                          );
                        },
                        primary: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
              ),
              child: DText(
                text: activity?.seoDescription.toString(),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
              ),
              child: DText(
                text: 'Activity has following packages',
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 0; i < activity!.packages!.length; i++)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 1.h,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: DText(
                                text: activity!.packages![i].packageName
                                    .toString(),
                              ),
                            ),
                            Expanded(
                              child: DText(
                                text: activity!.packages![i].price.toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

// activity preview container tablet
class _ActivityPreviewContainerTablet extends HookConsumerWidget {
  const _ActivityPreviewContainerTablet({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.primary.withOpacity(
            0.1,
          ),
      height: 40.h,
      width: 100.w,
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.h,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 2.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 100.w,
              height: 6.h,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: DText(
                        text: activity?.activityName.toString(),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: CustomElevatedButton(
                        text: 'View details',
                        textColor: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 8.sp,
                        onPressed: () {
                          context.pushNamed(
                            'activityDetails',
                            params: {
                              'activityId': activity!.activityId.toString(),
                            },
                          );
                        },
                        primary: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
              ),
              child: DText(
                text: activity?.seoDescription.toString(),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
              ),
              child: DText(
                text: 'Activity has following packages',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < activity!.packages!.length; i++)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 1.h,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: DText(
                              text:
                                  activity!.packages![i].packageName.toString(),
                            ),
                          ),
                          Expanded(
                            child: DText(
                              text: activity!.packages![i].price.toString(),
                            ),
                          ),
                        ],
                      ),
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

// activity preview container desktop
class _ActivityPreviewContainerDesktop extends HookConsumerWidget {
  const _ActivityPreviewContainerDesktop({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.primary.withOpacity(
            0.1,
          ),
      height: 10.h,
      width: 100.w,
      margin: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 2.h,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 2.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 100.w,
              height: 6.h,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: DText(
                        text: activity?.activityName.toString(),
                        fontSize: 8.sp,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 3,
                      child: CustomElevatedButton(
                        text: 'View details',
                        textColor: Theme.of(context).colorScheme.onPrimary,
                        onPressed: () {
                          context.pushNamed(
                            'activityDetails',
                            params: {
                              'activityId': activity!.activityId.toString(),
                            },
                          );
                        },
                        primary: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 1.5.w,
              ),
              child: DText(
                text: activity?.seoDescription.toString(),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 1.5.w,
              ),
              child: DText(
                text: 'Activity has following packages',
                fontSize: 6.sp,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 1.5.w,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 0; i < activity!.packages!.length; i++)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 1.h,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: DText(
                                text: activity!.packages![i].packageName
                                    .toString(),
                              ),
                            ),
                            Expanded(
                              child: DText(
                                text: activity!.packages![i].price.toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

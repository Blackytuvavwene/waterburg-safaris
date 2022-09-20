import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

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
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(
            left: 2.w,
          ),
          child: DText(
            text: activity?.activityName.toString(),
            fontSize: 10.sp,
          ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 4.w,
            ),
            child: LineIcon.editAlt(
              size: 10.sp,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
        toolbarHeight: 10.h,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        DText(
                          text: 'Activity Details',
                          fontSize: 8.sp,
                        ),
                        Divider(
                          height: 1.h,
                        ),
                        DText(
                          text: activity?.seoDescription.toString(),
                          fontSize: 6.sp,
                        ),
                        Divider(
                          height: 4.h,
                        ),
                        DText(
                          text: 'Activity Overview',
                          fontSize: 8.sp,
                        ),
                        Divider(
                          height: 1.h,
                        ),
                        DText(
                          text: activity?.overview.toString(),
                          fontSize: 6.sp,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DText(
                          text: 'Activity Images',
                          fontSize: 8.sp,
                        ),
                        Divider(
                          height: 1.h,
                        ),
                        SizedBox(
                          height: 100.h,
                          width: 100.w,
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemCount:
                                activity!.activityGallery!.length.toInt(),
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: 4.h,
                              );
                            },
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: 2.w,
                                  right: 2.w,
                                ),
                                child: Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        activity!
                                            .activityGallery![index].imageUrl
                                            .toString(),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 60.h,
                width: 100.w,
                color: Theme.of(context).colorScheme.onBackground,
                child: Column(
                  children: [
                    DText(
                      text: 'Packages available',
                      fontSize: 8.sp,
                    ),
                    Wrap(
                      spacing: 2.w,
                      children: activity!.packages!
                          .map(
                            (package) => PackageCard(
                              package: package,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

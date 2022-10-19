import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

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
      appBar: AppBar(
          title: DText(
            text: 'Activities',
            fontSize: 19.sp,
          ),
          leading: null,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    context.pushNamed('addActivity');
                  },
                  child: SizedBox(
                    width: 25.w,
                    height: 5.h,
                    child: DText(
                      text: 'Add Activity',
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ],
            ),
          ]),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: activitiesData!
                .map(
                  (e) => ActivityPreviewContainer(
                    activity: e,
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
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
          child: DText(
            text: 'Activities',
            fontSize: 12.sp,
          ),
        ),
        toolbarHeight: 8.h,
        leading: null,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 100.w,
            height: 100.h,
            child: ListView.custom(
              shrinkWrap: true,
              childrenDelegate: SliverChildListDelegate(
                activitiesData!
                    .map(
                      (e) => ActivityPreviewContainer(
                        activity: e,
                      ),
                    )
                    .toList(),
              ),
            ),
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
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(
            left: 8.w,
          ),
          child: DText(
            text: 'Activities',
            fontSize: 12.sp,
          ),
        ),
        leading: null,
        toolbarHeight: 16.h,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 100.w,
            height: 100.h,
            child: GridView.custom(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1.5.w,
                mainAxisSpacing: 2.w,
                childAspectRatio: 1.5,
              ),
              childrenDelegate: SliverChildListDelegate(
                activitiesData!
                    .map(
                      (e) => ActivityPreviewContainer(
                        activity: e,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

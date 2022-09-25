import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

enum ActivityEditType {
  editAll,
  editActivityName,
  editSeoDescription,
  editActivityGallery,
  editActivityPackages,
  editActivityOverview,
  editActivityTags,
  none,
}

// edit activity type state  provider
final editActivityTypeProvider = StateProvider<ActivityEditType>(
  (ref) => ActivityEditType.none,
);

// toggle edit activity type between editAll and none
final toggleEditType = Provider(
  (ref) => () {
    final editType = ref.watch(editActivityTypeProvider);
    void toggleEditActivityType() {
      if (editType == ActivityEditType.editAll) {
        ref.read(editActivityTypeProvider.notifier).state =
            ActivityEditType.none;
      } else {
        ref.read(editActivityTypeProvider.notifier).state =
            ActivityEditType.editAll;
      }
    }

    return toggleEditActivityType();
  },
);

// activity view page with app layout
class ActivityDetailsPage extends HookConsumerWidget {
  const ActivityDetailsPage({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // activity edit type watch provider
    final editActivityTypeController =
        ref.watch(editActivityTypeProvider.state);
    final editActivityType = editActivityTypeController.state;

    return AppLayout(
      mobile: _ActivityDetailsPageMobile(
        activity: activity,
        editActivityType: editActivityType,
        editActivityTypeController: editActivityTypeController,
      ),
      tablet: _ActivityDetailsPageTablet(
        activity: activity,
        editActivityType: editActivityType,
        editActivityTypeController: editActivityTypeController,
      ),
      desktop: _ActivityDetailsPageDesktop(
        activity: activity,
        editActivityType: editActivityType,
        editActivityTypeController: editActivityTypeController,
      ),
    );
  }
}

// activity view page for mobile
class _ActivityDetailsPageMobile extends HookConsumerWidget {
  const _ActivityDetailsPageMobile({
    Key? key,
    this.activity,
    this.editActivityType,
    this.editActivityTypeController,
  }) : super(key: key);
  final Activity? activity;
  final StateController<ActivityEditType>? editActivityTypeController;
  final ActivityEditType? editActivityType;
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
            child: IconButton(
              icon: LineIcon.editAlt(
                size: 10.sp,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: () {
                // set edit activity type to edit all
                ref.read(toggleEditType).call();
              },
            ),
          ),
        ],
        // toolbarHeight: 10.h,
      ),
      body: SafeArea(
        child: SizedBox(
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
                      ActivityDescriptionViewCard(
                        title: 'Activity SEO Description',
                        description: activity!.seoDescription.toString(),
                        editType: editActivityType,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                const ActivityDescriptionPopUp(),
                          ).then(
                            (value) {
                              if (value != null) {
                                // update description in firestore
                                // ref.read(descriptionNotifierProvider.notifier).updateDescriptionInFirestore(
                                //       activityId: activity!.activityId.toString(),
                                //       description: value,
                                //       field: 'description',
                                //     );
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      DText(
                        text: 'Activity Overview',
                        fontSize: 16.sp,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      DText(
                        text: activity?.overview.toString(),
                        fontSize: 14.sp,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DText(
                        text: 'Activity Images',
                        fontSize: 16.sp,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        width: 100.w,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 80.h,
                          ),
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemCount:
                                activity!.activityGallery!.length.toInt(),
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 4.h,
                              );
                            },
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: 2.w,
                                  right: 2.w,
                                ),
                                child: ActivityImageCard(
                                  image: activity!.activityGallery![index],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60.h,
                  width: 100.w,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 2.h,
                  ),
                  child: SizedBox(
                    width: 100.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DText(
                          text: 'Packages available',
                          fontSize: 16.sp,
                          textAlign: TextAlign.center,
                          textColor: Theme.of(context).colorScheme.background,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 100.w,
                          height: 50.h,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              SizedBox(
                                width: 2.w,
                              ),
                              ...activity!.packages!.map(
                                (e) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: 2.w,
                                    ),
                                    child: PackageCard(
                                      package: e,
                                    ),
                                  );
                                },
                              ),
                            ],
                            // children: activity!.packages!
                            //     .map(
                            //       (package) => PackageCard(
                            //         package: package,
                            //       ),
                            //     )
                            //     .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Center(
                  child: ImagePickerWidget(),
                )
              ],
            ),
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
    this.editActivityType,
    this.editActivityTypeController,
  }) : super(key: key);
  final Activity? activity;
  final StateController<ActivityEditType>? editActivityTypeController;
  final ActivityEditType? editActivityType;
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
            child: IconButton(
              icon: LineIcon.editAlt(
                size: 10.sp,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: () {
                // set edit activity type to edit all
                ref.read(toggleEditType).call();
              },
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                      ),
                      child: Column(
                        children: [
                          ActivityDescriptionViewCard(
                            title: 'Activity SEO Description',
                            description: activity!.seoDescription.toString(),
                            editType: editActivityType,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const ActivityDescriptionPopUp(),
                              ).then(
                                (value) {
                                  if (value != null) {
                                    // update description in firestore
                                    // ref.read(descriptionNotifierProvider.notifier).updateDescriptionInFirestore(
                                    //       activityId: activity!.activityId.toString(),
                                    //       description: value,
                                    //       field: 'description',
                                    //     );
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          DText(
                            text: 'Activity Overview',
                            fontSize: 6.sp,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          DText(
                            text: activity?.overview.toString(),
                            fontSize: 4.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DText(
                            text: 'Activity Images',
                            fontSize: 6.sp,
                          ),
                          SizedBox(
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
                                return SizedBox(
                                  height: 4.h,
                                );
                              },
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: 2.w,
                                    right: 2.w,
                                  ),
                                  child: ActivityImageCard(
                                    image: activity!.activityGallery![index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
                      fontSize: 6.sp,
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
              const ImagePickerWidget()
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
    this.editActivityType,
    this.editActivityTypeController,
  }) : super(key: key);
  final Activity? activity;
  final StateController<ActivityEditType>? editActivityTypeController;
  final ActivityEditType? editActivityType;
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
            child: IconButton(
              icon: LineIcon.editAlt(
                size: 10.sp,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: () {
                // set edit activity type to edit all
                ref.read(toggleEditType).call();
              },
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                      ),
                      child: Column(
                        children: [
                          ActivityDescriptionViewCard(
                            title: 'Activity SEO Description',
                            description: activity!.seoDescription.toString(),
                            editType: editActivityType,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const ActivityDescriptionPopUp(),
                              ).then(
                                (value) {
                                  if (value != null) {
                                    // update description in firestore
                                    // ref.read(descriptionNotifierProvider.notifier).updateDescriptionInFirestore(
                                    //       activityId: activity!.activityId.toString(),
                                    //       description: value,
                                    //       field: 'description',
                                    //     );
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          DText(
                            text: 'Activity Overview',
                            fontSize: 6.sp,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          DText(
                            text: activity?.overview.toString(),
                            fontSize: 4.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DText(
                            text: 'Activity Images',
                            fontSize: 6.sp,
                          ),
                          SizedBox(
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
                                return SizedBox(
                                  height: 4.h,
                                );
                              },
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: 2.w,
                                    right: 2.w,
                                  ),
                                  child: ActivityImageCard(
                                    image: activity!.activityGallery![index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 3,
                child: Center(
                  child: Container(
                    width: 100.w,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    padding: EdgeInsets.only(
                      bottom: 10.h,
                      top: 5.h,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 100.w,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.w,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DText(
                                    text: 'Packages available',
                                    fontSize: 6.sp,
                                    textColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: LineIcon.editAlt(
                                      size: 6.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
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
                  ),
                ),
              ),
              const ImagePickerWidget()
            ],
          ),
        ),
      ),
    );
  }
}

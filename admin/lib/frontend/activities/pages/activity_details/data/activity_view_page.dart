import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
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
final editActivityTypeProvider = StateProvider.autoDispose<ActivityEditType>(
  (ref) => ActivityEditType.none,
);

// toggle edit activity type between editAll and none
// final toggleEditType = Provider(
//   (ref) => () {
//     final editType = ref.watch(editActivityTypeProvider);
//     void toggleEditActivityType() {
//       if (editType == ActivityEditType.editAll) {
//         ref.read(editActivityTypeProvider.notifier).state =
//             ActivityEditType.none;
//       } else {
//         ref.read(editActivityTypeProvider.notifier).state =
//             ActivityEditType.editAll;
//       }
//     }

//     return toggleEditActivityType();
//   },
// );

// activity view page with app layout
class ActivityDetailsPage extends HookConsumerWidget {
  const ActivityDetailsPage({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch activity provider
    final activityProvider = ref.watch(
      activityControlNotifierProvider(
        activity,
      ),
    );

    // handle edit
    final isEditing = useState(false);

    // read activity notifier provider
    final activityNotifier = ref.read(activityControlNotifierProvider(
      activity,
    ).notifier);

    // activity edit type watch provider
    final editActivityTypeController =
        ref.read(editActivityTypeProvider.notifier);
    final editActivityType = ref.watch(editActivityTypeProvider);

    // watch local image provider
    final localImageProvider = ref.watch(
      imageControllerNotifierProvider,
    );

    // read image controller provider
    final imageControllerNotifier = ref.read(
      imageControllerNotifierProvider.notifier,
    );

    return AppLayout(
      mobile: _ActivityDetailsPageMobile(
        activity: activityProvider,
        editActivityType: editActivityType,
        editActivityTypeController: editActivityTypeController,
        activityNotifier: activityNotifier,
        localImageProvider: localImageProvider,
        imageControllerNotifier: imageControllerNotifier,
        isEditing: isEditing,
      ),
      tablet: _ActivityDetailsPageTablet(
        activity: activity,
        editActivityType: editActivityType,
        editActivityTypeController: editActivityTypeController,
        activityNotifier: activityNotifier,
      ),
      desktop: _ActivityDetailsPageDesktop(
        activity: activity,
        editActivityType: editActivityType,
        editActivityTypeController: editActivityTypeController,
        activityNotifier: activityNotifier,
      ),
    );
  }
}

class UpdateNameField extends HookConsumerWidget {
  const UpdateNameField({
    super.key,
    this.activityId,
    this.activityName,
    this.editActivityTypeController,
  });
  final String? activityId;
  final String? activityName;
  final StateController<ActivityEditType>? editActivityTypeController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityNameController = useTextEditingController(text: activityName);
    // listen to updates on activity name
    ref.listen(descriptionNotifierProvider,
        (AsyncValue<String>? previous, AsyncValue<String> current) {
      current.when(data: (data) {
        return EasyLoading.showSuccess('Activity name updated to $data');
      }, error: (error, stackTrace) {
        return EasyLoading.showError('Error updating activity name');
      }, loading: () {
        return EasyLoading.show(status: 'Updating activity name...');
      });
    });
    return TextField(
      controller: activityNameController,
      maxLines: null,
      minLines: null,
      expands: true,
      decoration: InputDecoration(
        hintText: 'Activity Name',
        hintStyle: GoogleFonts.dosis(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 2.5.w,
          vertical: 1.h,
        ),
        suffix: IconButton(
          onPressed: () async {
            await ref
                .read(descriptionNotifierProvider.notifier)
                .updateStringFieldInFirestore(
                  activityId: activityId!,
                  description: activityNameController.text,
                  field: 'activityName',
                );

            editActivityTypeController!
                .update((state) => state = ActivityEditType.none);
          },
          padding: EdgeInsets.zero,
          icon: LineIcon.saveAlt(
            size: 16.sp,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.onBackground),
        ),
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
    this.activityNotifier,
    this.localImageProvider,
    this.imageControllerNotifier,
    this.isEditing,
  }) : super(key: key);
  final Activity? activity;
  final StateController<ActivityEditType>? editActivityTypeController;
  final ActivityEditType? editActivityType;
  final ActivityControlNotifier? activityNotifier;
  final AsyncValue<List<ImageHelperModel>?>? localImageProvider;
  final ImageControllerNotifier? imageControllerNotifier;
  final ValueNotifier<bool>? isEditing;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabs = ref.watch(activityTabsListProvider);
    final tabController = useTabController(initialLength: tabs.length);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 8.h,
        title: Padding(
          padding: EdgeInsets.only(
            left: 2.w,
          ),
          child: Row(
            children: [
              editActivityType == ActivityEditType.editActivityName
                  ? Center(
                      child: SizedBox(
                        height: 6.h,
                        width: 60.w,
                        child: UpdateNameField(
                          activityId: activity?.activityId,
                          editActivityTypeController:
                              editActivityTypeController,
                          activityName: activity?.activityName,
                        ),
                      ),
                    ).animate().fade(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 200),
                        begin: 0,
                        end: 1,
                      )
                  : DText(
                      text: activity?.activityName.toString(),
                      fontSize: 16.sp,
                    ),
              IconButton(
                icon: editActivityType == ActivityEditType.editActivityName
                    ? LineIcon.timesCircle(
                        size: 16.sp,
                        color: Theme.of(context).colorScheme.onBackground,
                      )
                    : LineIcon.editAlt(
                        size: 16.sp,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                onPressed: () {
                  // set is editing to true if false
                  if (isEditing!.value == false) {
                    isEditing!.value = true;
                  }

                  // set edit activity type to edit all
                  editActivityType == ActivityEditType.editActivityName
                      ? editActivityTypeController!.state =
                          ActivityEditType.none
                      : editActivityTypeController!.state =
                          ActivityEditType.editActivityName;

                  // // reverse activity name animation controller
                  // editActivityType == ActivityEditType.editActivityName
                  //     ? forwardActivityNameAnimationController()
                  //     : reverseActivityNameAnimationController();
                },
              )
            ],
          ),
        ),
        elevation: 0,

        bottom: TabBar(
          controller: tabController,
          tabs: tabs
              .map((tab) => Tab(
                    text: tab.tabName,
                    icon: tab.tabIcon,
                  ))
              .toList(),
        ),
        // toolbarHeight: 10.h,
      ),
      body: SafeArea(
        bottom: false,
        maintainBottomViewPadding: false,
        child: TabBarView(
          controller: tabController,
          children: [
            ActivityInfoPage(
              activity: activity,
              activityNotifier: activityNotifier,
              isEditing: isEditing,
            ),
            ActivityGalleryPage(
              activityId: activity?.activityId,
              gallery: activity?.activityGallery,
              activityNotifier: activityNotifier,
              localImageProvider: localImageProvider,
              imageControllerNotifier: imageControllerNotifier,
              isEditing: isEditing!,
            ),
            ActivityPackagesPage(
              activityId: activity?.activityId,
              packages: activity?.packages,
              activityNotifier: activityNotifier,
              isEditing: isEditing!,
            ),
            ActivityTagsPage(
              activityId: activity?.activityId,
              tags: activity?.tags,
              activityNotifier: activityNotifier,
              isEditing: isEditing!,
            ),
          ],
        ),
      ),
      bottomNavigationBar: isEditing!.value
          ? Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () async {
                      editActivityTypeController!
                          .update((state) => state = ActivityEditType.none);
                    },
                    text: 'Cancel Changes',
                    primary: Theme.of(context).colorScheme.errorContainer,
                    textColor: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
                Expanded(
                  child: CustomElevatedButton(
                    primary: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      //TODO: save changes to firestore
                      editActivityTypeController!
                          .update((state) => state = ActivityEditType.none);

                      // set is editing to false
                      isEditing!.value = false;
                    },
                    text: 'Save & Publish',
                    textColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            )
          : null,
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
    this.activityNotifier,
  }) : super(key: key);
  final Activity? activity;
  final StateController<ActivityEditType>? editActivityTypeController;
  final ActivityEditType? editActivityType;
  final ActivityControlNotifier? activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabs = ref.watch(activityTabsListProvider);
    final tabController = useTabController(initialLength: tabs.length);
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
                // ref.read(toggleEditType).call();
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
                                builder: (context) => ActivityDescriptionPopUp(
                                  field: 'SEO Description',
                                  description:
                                      activity?.seoDescription.toString(),
                                  onSaved: (value) {
                                    activityNotifier
                                        ?.updateActivitySEODescription(
                                      seoDescription: value,
                                    );
                                  },
                                ),
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
              Center(
                child: ImagePickerWidget(
                  activityId: activity!.activityId,
                ),
              ),
              Center(
                child: ActivityTags(
                  tags: activity?.tags,
                ),
              )
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
    this.activityNotifier,
  }) : super(key: key);
  final Activity? activity;
  final StateController<ActivityEditType>? editActivityTypeController;
  final ActivityEditType? editActivityType;
  final ActivityControlNotifier? activityNotifier;
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
                // ref.read(toggleEditType).call();
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
                                builder: (context) => ActivityDescriptionPopUp(
                                  field: 'SEO Description',
                                  description:
                                      activity?.seoDescription.toString(),
                                  onSaved: (value) {
                                    activityNotifier
                                        ?.updateActivitySEODescription(
                                      seoDescription: value,
                                    );
                                  },
                                ),
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
              Center(
                child: ImagePickerWidget(
                  activityId: activity!.activityId,
                ),
              ),
              Center(
                child: ActivityTags(
                  tags: activity?.tags,
                  activityId: activity!.activityId,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

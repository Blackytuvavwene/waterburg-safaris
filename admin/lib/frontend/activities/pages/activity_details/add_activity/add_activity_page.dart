import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';

class AddActivityPage extends HookConsumerWidget {
  const AddActivityPage({
    Key? key,
    this.activity,
  }) : super(key: key);
  final Activity? activity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<Activity>?>(addActivityToFirestoreProvider,
        (AsyncValue<Activity>? previous, AsyncValue<Activity>? next) {
      next!.when(
        data: (Activity? activity) {
          return EasyLoading.showSuccess('Activity added successfully');
        },
        loading: () => EasyLoading.show(status: 'Loading...'),
        error: (Object? error, StackTrace? stackTrace) =>
            EasyLoading.showError(error.toString()),
      );
    });

    // watch activity control notifier
    final activityData = ref.watch(addActivityControlProvider);
    // read the control notifier
    final activityNotifier = ref.read(addActivityControlProvider.notifier);

    final imagesPicked = ref.watch(addImageNotifierProvider);
    final addImageNotifier = ref.read(addImageNotifierProvider.notifier);

    final tabs = [
      {
        'name': 'Details',
        'view': AddInfoView(
          activityData: activityData,
          activityNotifier: activityNotifier,
        ),
        'icon': LineIcon.infoCircle(),
      },
      {
        'name': 'Gallery',
        'view': AddGalleryView(
          galleryData: imagesPicked,
          addImageNotifier: addImageNotifier,
        ),
        'icon': LineIcon.imagesAlt(),
      },
      {
        'name': 'Packages',
        'view': AddPackagesView(
          packageData: activityData.packages ?? [],
          activityNotifier: activityNotifier,
        ),
        'icon': LineIcon.boxOpen(),
      },
      {
        'name': 'Tags',
        'view': AddTagsView(
          tagData: activityData.tags ?? [],
          activityNotifier: activityNotifier,
        ),
        'icon': LineIcon.tags(),
      }
    ];

    final tabController = useTabController(initialLength: tabs.length);
    final tabView = TabBarView(
      controller: tabController,
      children: tabs.map((e) => e['view'] as Widget).toList(),
    );

    final tabBar = TabBar(
      controller: tabController,
      isScrollable: true,
      tabs: tabs
          .map(
            (e) => Tab(
              icon: e['icon'] as Widget,
              text: e['name'] as String,
            ),
          )
          .toList(),
    );

    final pageIndex = useState(0);

    final pageViewController = usePageController();

    final pageView = PageView(
      controller: pageViewController,
      onPageChanged: (index) {
        pageIndex.value = index;
      },
      children: tabs.map((e) => e['view'] as Widget).toList(),
    );

    final navRailTabs = tabs
        .map(
          (e) => NavigationRailDestination(
            icon: e['icon'] as Widget,
            label: DText(text: e['name'] as String),
          ),
        )
        .toList();

    final navRail = NavigationRail(
      selectedIndex: pageIndex.value,
      onDestinationSelected: (index) {
        pageIndex.value = index;
        pageViewController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      },
      destinations: navRailTabs,
    );

    return AppLayout(
      mobile: _MobileAddActivityPage(
        activity: activityData,
        tabView: tabView,
        tabBar: tabBar,
        pickedImages: imagesPicked,
      ),
      tablet: _TabletAddActivityPage(
        activity: activityData,
        pageView: pageView,
        navRail: navRail,
      ),
      desktop: _DesktopAddActivityPage(
        activity: activityData,
        pageView: pageView,
        navRail: navRail,
      ),
    );
  }
}

// mobile edit activity page
class _MobileAddActivityPage extends HookConsumerWidget {
  const _MobileAddActivityPage({
    Key? key,
    this.activity,
    this.tabView,
    this.tabBar,
    this.pickedImages,
  }) : super(key: key);
  final Activity? activity;
  final TabBarView? tabView;
  final TabBar? tabBar;
  final List<ImageHelperModel>? pickedImages;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: DText(
          text: activity == null ? 'Add Activity' : 'Edit Activity',
        ),
        bottom: tabBar,
        actions: [
          IconButton(
            onPressed: () async {
              final newActivityId =
                  FirebaseFirestore.instance.collection('activities').doc().id;

              final newActivity = Activity(
                activityId: newActivityId,
                activityName: activity!.activityName,
                overview: activity!.overview,
                seoDescription: activity!.seoDescription,
                slug: createSlug(
                  text: activity!.activityName!,
                ),
                activityGallery:
                    await Future.wait(pickedImages!.map((imageModel) async {
                  final newGallery = Gallery(
                      imageDescription:
                          imageModel.imageDetails?.imageDescription,
                      imageTitle: imageModel.imageDetails?.imageTitle,
                      imageUrl: await ImageHelpers.addImageToFirebaseStorage(
                        image: imageModel.xFile!,
                        path: 'activities/$newActivityId',
                      ));

                  return newGallery;
                }).toList()),
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                packages: activity!.packages,
                tags: activity!.tags,
              );

              await ref
                  .read(addActivityToFirestoreProvider.notifier)
                  .addActivityToFirestore(
                    activity: newActivity,
                  );

              context.pop();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: tabView,
    );
  }
}

// tablet edit activity page
class _TabletAddActivityPage extends HookConsumerWidget {
  const _TabletAddActivityPage({
    Key? key,
    this.activity,
    this.pageView,
    this.navRail,
  }) : super(key: key);
  final Activity? activity;
  final NavigationRail? navRail;
  final PageView? pageView;
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
        child: Row(
          children: [
            navRail!,
            Expanded(
              child: pageView!,
            ),
          ],
        ),
      ),
    );
  }
}

// desktop edit activity page
class _DesktopAddActivityPage extends HookConsumerWidget {
  const _DesktopAddActivityPage({
    Key? key,
    this.activity,
    this.pageView,
    this.navRail,
  }) : super(key: key);
  final Activity? activity;
  final NavigationRail? navRail;
  final PageView? pageView;
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
        child: Row(
          children: [
            navRail!,
            Expanded(
              child: pageView!,
            ),
          ],
        ),
      ),
    );
  }
}

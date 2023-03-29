import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class ActivityTagsNotifier extends StateNotifier<AsyncValue<List<String>>> {
  ActivityTagsNotifier({
    required this.activitiesDatabaseRepository,
  }) : super(const AsyncData(<String>[]));

  // activity database repository
  ActivitiesDatabaseRepository activitiesDatabaseRepository;

  // add a new tag to firestore
  Future<AsyncValue<List<String>>> addTagToFirestore({
    required ActivitTagsModel tag,
    required String activityId,
    required String query,
  }) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() async {
      final tagD = await FirestoreHelper.updateDataInDocList<String>(
          data: tag.tags,
          docId: activityId,
          query: query,
          docPath: 'activities');
      return tagD;
    });
  }

  // add tags to firestore
  Future<AsyncValue<List<String>>> addTagsToFirestore({
    required List<String> tags,
    required String activityId,
    required String query,
  }) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() async {
      print({tags: '$tags', activityId: activityId, query: query});
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('activities').doc(activityId).update({
        query: FieldValue.arrayUnion(tags),
      }).then((value) => print({'Data updated': tags}));
      return tags;
    });
  }

  // add tags to state
  void addTagsToState({required List<String> tags}) {
    state = AsyncData(tags);
  }

  // add first tag to state
  void addFirstTagToState({required String tag}) {
    state = AsyncData(<String>[tag]);
  }

  // add tag to state
  void addTagToState({required String tag}) {
    final tags = state.asData!.value;
    state = AsyncData(<String>[...tags, tag]);
  }

  // remove a tag from firestore
  Future<AsyncValue<List<String>?>> removeTagFromFirestore({
    required String tag,
    required String activityId,
    required String query,
  }) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() async {
      final tagD = await FirestoreHelper.deleteDataInDocList<String>(
          data: <String>[tag],
          docId: activityId,
          query: query,
          docPath: 'activities');
      return tagD;
    });
  }

  // remove tag from state
  void removeTagFromState({required String tag}) {
    if (state.asData?.value != null) {
      final tags = state.asData!.value;
      tags.remove(tag);
      state = AsyncData(tags);
    }
  }
}

// activity tags model
class ActivitTagsModel {
  final List<String> tags;
  ActivitTagsModel({required this.tags});

  factory ActivitTagsModel.fromFirestore(Map<String, dynamic> json) {
    return ActivitTagsModel(
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'tags': tags,
    };
  }
}

// activity tags provider notifier
final activityTagsNotifierProvider =
    StateNotifierProvider<ActivityTagsNotifier, AsyncValue<List<String>>>(
        (ref) {
  return ActivityTagsNotifier(
    activitiesDatabaseRepository: ref.watch(activityDbRepositoryProvider),
  );
});

class ActivityTags extends HookConsumerWidget {
  const ActivityTags({
    Key? key,
    this.tags,
    this.activityId,
    this.isEditing,
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  final ValueNotifier<bool>? isEditing;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileActivityTags(
        tags: tags,
        activityId: activityId,
        isEditing: isEditing,
      ),
      tablet: _TabletActivityTags(
        tags: tags,
        activityId: activityId,
      ),
      desktop: _DesktopActivityTags(
        tags: tags,
        activityId: activityId,
      ),
    );
  }
}

// mobile activity tags
class _MobileActivityTags extends HookConsumerWidget {
  const _MobileActivityTags({
    Key? key,
    this.tags,
    this.activityId,
    this.isEditing,
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  final ValueNotifier<bool>? isEditing;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsController = useTextEditingController();
    final tagsList = useState<List<String>>(<String>[]);
    final tagsInState = ref.watch(activityTagsNotifierProvider);
    final tagsStateController = ref.read(activityTagsNotifierProvider.notifier);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: SizedBox(
                      width: 100.w,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: tagsController,
                              decoration: const InputDecoration(
                                labelText: 'Add a tag',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (tagsController.text.isNotEmpty) {
                                tagsList.value = [
                                  ...tagsList.value,
                                  tagsController.text
                                ];
                                print('tagsList.value: ${tagsList.value}');
                                tagsController.clear();
                              }
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: SizedBox(
                      height: 80.h,
                      width: 100.w,
                      child: ListView(
                        children: [
                          // new tags
                          tagsList.value.isNotEmpty
                              ? SizedBox(
                                  width: 100.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        child: DText(
                                          text: 'New tags',
                                          fontSize: 18.sp,
                                        ),
                                      ),
                                      Wrap(
                                        spacing: 2.w,
                                        children: [
                                          for (var tag in tagsList.value)
                                            Container(
                                              child: Chip(
                                                label: Text(tag),
                                                deleteIcon: LineIcon.trash(),
                                                onDeleted: () {
                                                  tagsList.value = tagsList
                                                      .value
                                                      .where((element) =>
                                                          element != tag)
                                                      .toList();
                                                },
                                              ).animate().scale().slide(),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            width: 100.w,
                            child: DText(
                              text: 'Tags from database tags',
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(
                            width: 100.w,
                            child: Wrap(
                              spacing: 2.w,
                              children: [
                                for (var tag in tags!)
                                  Container(
                                    child: Chip(
                                      label: DText(
                                        text: tag,
                                      ),
                                      deleteIcon: LineIcon.trash(
                                        color: Colors.red,
                                      ),
                                      onDeleted: () async {
                                        // tags?.remove(tag);
                                        print(tags);
                                        await tagsStateController
                                            .removeTagFromFirestore(
                                          tag: tag,
                                          activityId: activityId!,
                                          query: 'tags',
                                        );
                                        tagsStateController.removeTagFromState(
                                          tag: tag,
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomElevatedButton(
        onPressed: () async {
          await tagsStateController.addTagsToFirestore(
            tags: tagsList.value,
            activityId: activityId!,
            query: 'tags',
          );
          tagsList.value = [];
        },
        text: 'Upload new tags  ( ${tagsList.value.length} )',
      ),
    );
  }
}

// tablet activity tags
class _TabletActivityTags extends HookConsumerWidget {
  const _TabletActivityTags({
    Key? key,
    this.tags,
    this.activityId,
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Wrap(
        children: [
          for (var tag in tags!)
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Chip(
                label: DText(
                  text: tag,
                ),
                backgroundColor: Colors.blue,
              ),
            ),
        ],
      ),
    );
  }
}

// desktop activity tags
class _DesktopActivityTags extends HookConsumerWidget {
  const _DesktopActivityTags({
    Key? key,
    this.tags,
    this.activityId,
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Wrap(
        children: [
          for (var tag in tags!)
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Chip(
                label: DText(
                  text: tag,
                ),
                backgroundColor: Colors.blue,
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
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
      final tagD =
          await activitiesDatabaseRepository.updateActivity<List<String>>(
              data: tag.toFirestore(), activityId: activityId, query: query);
      return tagD;
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
      final tagD = await activitiesDatabaseRepository
          .updateActivity<List<String>>(data: {
        'tags': [tag]
      }, activityId: activityId, query: query);
      return tagD;
    });
  }

  // remove tag from state
  void removeTagFromState({required String tag}) {
    final tags = state.asData?.value;
    tags!.remove(tag);
    state = AsyncData(tags);
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
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileActivityTags(
        tags: tags,
        activityId: activityId,
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
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsController = useTextEditingController();
    final tagsInState = ref.watch(activityTagsNotifierProvider);
    final tagsStateController = ref.read(activityTagsNotifierProvider.notifier);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 8.h,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: tagsController,
                  decoration: const InputDecoration(
                    labelText: 'Add a tag',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (tagsController.text.isNotEmpty) {
                    tagsStateController.addTagToFirestore(
                      tag: ActivitTagsModel(
                          tags: [...tags!, tagsController.text]),
                      activityId: activityId!,
                      query: 'tags',
                    );
                    tagsController.clear();
                  }
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          Wrap(
            children: [
              tagsInState.when(
                data: (tags) {
                  return tags.isNotEmpty
                      ? Wrap(
                          children: tags
                              .map(
                                (tag) => Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: Chip(
                                    label: Text(tag),
                                    deleteIcon: const Icon(Icons.close),
                                    onDeleted: () async {
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
                              )
                              .toList(),
                        )
                      : const SizedBox();
                },
                loading: () => const SizedBox(),
                error: (error, stack) => const SizedBox(),
              ),
              for (var tag in tags!)
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: DText(
                      text: tag,
                    ),
                    deleteIcon: LineIcon.minus(
                      color: Colors.red,
                    ),
                    onDeleted: () async {
                      tags?.remove(tag);
                      print(tags);
                      await tagsStateController.addTagToFirestore(
                        tag: ActivitTagsModel(tags: tags!),
                        activityId: activityId!,
                        query: 'tags',
                      );
                    },
                    backgroundColor: Colors.blue,
                  ),
                ),
            ],
          ),
        ],
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

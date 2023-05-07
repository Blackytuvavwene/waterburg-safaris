import 'package:admin/lib.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

// activity tags page with app layout
class ActivityTagsPage extends HookConsumerWidget {
  const ActivityTagsPage({
    Key? key,
    this.tags,
    this.activityId,
    this.activityNotifier,
    this.isEditing,
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  final ValueNotifier<bool>? isEditing;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileActivityTagsPage(
        tags: tags,
        activityId: activityId,
        activityNotifier: activityNotifier,
        isEditing: isEditing,
      ),
      tablet: _TabletActivityTagsPage(
        tags: tags,
        activityId: activityId,
        activityNotifier: activityNotifier,
      ),
      desktop: _DesktopActivityTagsPage(
        tags: tags,
        activityId: activityId,
        activityNotifier: activityNotifier,
      ),
    );
  }
}

// mobile activity tags page
class _MobileActivityTagsPage extends HookConsumerWidget {
  const _MobileActivityTagsPage({
    Key? key,
    this.tags,
    this.activityId,
    this.activityNotifier,
    this.isEditing,
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  final ValueNotifier<bool>? isEditing;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // tag text controller
    final tagController = useTextEditingController();
    // focus node to enable focus on text field
    final tagFocusNode = useFocusNode();

    return GestureDetector(
      onTap: () {
        // dismiss keyboard
        tagFocusNode.unfocus();
      },
      child: CustomScrollView(
        slivers: [
          SliverPinnedToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(
                8.sp,
              ),
              child: Form(
                child: TextFormField(
                  controller: tagController,
                  focusNode: tagFocusNode,
                  style: GoogleFonts.dosis(),
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter search keywords here for activity',
                  ),
                  onFieldSubmitted: (value) {
                    if (isEditing?.value == false) {
                      isEditing?.value = true;
                    }
                    // update list
                    activityNotifier?.addActivitySEOKeyword(
                      seoKeywords: tagController.text,
                    );
                    // clear controller
                    tagController.clear();
                    // request focus
                    tagFocusNode.requestFocus();
                  },
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.all(
                8.sp,
              ),
              child: Wrap(
                spacing: 12.sp,
                children: [
                  if (tags != null)
                    if (tags!.isNotEmpty || tags != [])
                      ...tags!.map(
                        (tag) {
                          return Chip(
                            label: DText(
                              text: tag,
                            ),
                            onDeleted: () {
                              if (isEditing?.value == false) {
                                isEditing?.value = true;
                              }
                              activityNotifier?.deleteActivitySEOKeyword(
                                seoKeyword: tag,
                              );
                            },
                          ).animate().slideY();
                        },
                      )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// tablet activity tags page
class _TabletActivityTagsPage extends HookConsumerWidget {
  const _TabletActivityTagsPage({
    Key? key,
    this.tags,
    this.activityId,
    this.activityNotifier,
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ActivityTags(
        tags: tags,
        activityId: activityId,
      ),
    );
  }
}

// desktop activity tags page
class _DesktopActivityTagsPage extends HookConsumerWidget {
  const _DesktopActivityTagsPage({
    Key? key,
    this.tags,
    this.activityId,
    this.activityNotifier,
  }) : super(key: key);
  final List<String>? tags;
  final String? activityId;
  final ActivityControlNotifier? activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ActivityTags(
        tags: tags,
        activityId: activityId,
      ),
    );
  }
}

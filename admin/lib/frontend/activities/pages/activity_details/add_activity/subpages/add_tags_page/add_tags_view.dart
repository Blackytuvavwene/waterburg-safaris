import 'package:admin/lib.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

// add tags view hook consumer widget with app layout
class AddTagsView extends HookConsumerWidget {
  const AddTagsView({
    super.key,
    required this.tagData,
    required this.activityNotifier,
  });
  final List<String> tagData;
  final AddActivityNotifier activityNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // tag controller
    final tagController = useTextEditingController();

    return AppLayout(
      mobile: _MobileAddTagsView(
        tagData: tagData,
        tagController: tagController,
        activityNotifier: activityNotifier,
      ),
      tablet: _TabletAddTagsView(
        tagData: tagData,
        tagController: tagController,
        activityNotifier: activityNotifier,
      ),
      desktop: _DesktopAddTagsView(
        tagData: tagData,
        tagController: tagController,
        activityNotifier: activityNotifier,
      ),
    );
  }
}

// mobile add tags view
class _MobileAddTagsView extends HookConsumerWidget {
  const _MobileAddTagsView({
    required this.tagData,
    this.tagController,
    required this.activityNotifier,
  });
  final List<String> tagData;
  final TextEditingController? tagController;
  final AddActivityNotifier activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    // update list
                    activityNotifier.updateTags(
                      tag: tagController!.text,
                    );
                    // clear controller
                    tagController!.clear();
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
                  if (tagData != null)
                    if (tagData.isNotEmpty || tagData != [])
                      ...tagData.map(
                        (tag) {
                          return Chip(
                            label: DText(
                              text: tag,
                            ),
                            onDeleted: () {
                              activityNotifier.removeTagFromList(
                                tag: tag,
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

// tablet add tags view
class _TabletAddTagsView extends HookConsumerWidget {
  const _TabletAddTagsView({
    required this.tagData,
    this.tagController,
    required this.activityNotifier,
  });
  final List<String> tagData;
  final TextEditingController? tagController;
  final AddActivityNotifier activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// desktop add tags view
class _DesktopAddTagsView extends HookConsumerWidget {
  const _DesktopAddTagsView({
    required this.tagData,
    this.tagController,
    required this.activityNotifier,
  });
  final List<String> tagData;
  final TextEditingController? tagController;
  final AddActivityNotifier activityNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

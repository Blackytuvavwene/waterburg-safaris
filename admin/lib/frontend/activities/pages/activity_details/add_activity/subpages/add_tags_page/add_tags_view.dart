import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

// add tags view hook consumer widget with app layout
class AddTagsView extends HookConsumerWidget {
  const AddTagsView({
    super.key,
    this.tagData,
  });
  final ValueNotifier<List<String>>? tagData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // tag controller
    final tagController = useTextEditingController();

    return AppLayout(
      mobile: _MobileAddTagsView(
        tagData: tagData,
        tagController: tagController,
      ),
      tablet: _TabletAddTagsView(
        tagData: tagData,
        tagController: tagController,
      ),
      desktop: _DesktopAddTagsView(
        tagData: tagData,
        tagController: tagController,
      ),
    );
  }
}

// mobile add tags view
class _MobileAddTagsView extends HookConsumerWidget {
  const _MobileAddTagsView({
    this.tagData,
    this.tagController,
  });
  final ValueNotifier<List<String>>? tagData;
  final TextEditingController? tagController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: AddTagField(tagController: tagController!, tags: tagData),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 1.h,
            ),
          ),
          tagData?.value == []
              ? SliverToBoxAdapter(
                  child: Center(
                    child: DText(
                      text: 'No tags added',
                      fontSize: 14.sp,
                    ),
                  ),
                )
              : SliverPersistentHeader(
                  delegate: AddTagTextHeader(
                    text: 'Added tags',
                    tagsLength: tagData?.value.length,
                  ),
                  pinned: true,
                ),
          tagData?.value == []
              ? const SliverToBoxAdapter()
              : SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 12.sp,
                      children: tagData!.value.map(
                        (tag) {
                          return Padding(
                            padding: EdgeInsets.only(
                              right: 1.w,
                              bottom: 1.h,
                            ),
                            child: Chip(
                              label: DText(
                                text: tag,
                                fontSize: 12.sp,
                              ),
                              deleteIcon: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 12.sp,
                              ),
                              onDeleted: () {
                                tagData?.value.remove(tag);
                                tagData?.notifyListeners();
                              },
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

// tablet add tags view
class _TabletAddTagsView extends HookConsumerWidget {
  const _TabletAddTagsView({
    this.tagData,
    this.tagController,
  });
  final ValueNotifier<List<String>>? tagData;
  final TextEditingController? tagController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// desktop add tags view
class _DesktopAddTagsView extends HookConsumerWidget {
  const _DesktopAddTagsView({
    this.tagData,
    this.tagController,
  });
  final ValueNotifier<List<String>>? tagData;
  final TextEditingController? tagController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

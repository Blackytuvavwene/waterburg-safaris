import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddTagField extends SliverPersistentHeaderDelegate {
  AddTagField({
    required this.tagController,
    required this.tags,
  });

  final TextEditingController tagController;
  final ValueNotifier<List<String>>? tags;
  @override
  double minExtent = 50;
  @override
  double maxExtent = 80;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      child: Container(
        width: 100.w,
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.background.withOpacity(
              0.5,
            ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 6,
                child: TextField(
                  controller: tagController,
                  decoration: InputDecoration(
                    hintText: 'Add tags',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.sp),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.sp),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.sp),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .surfaceVariant
                        .withOpacity(
                          0.5,
                        ),
                    minimumSize: Size(
                      100.w,
                      100.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.sp),
                    ),
                  ),
                  onPressed: () {
                    tags?.value = tags?.value != []
                        ? [...tags!.value, tagController.text]
                        : [tagController.text];
                    tagController.clear();
                  },
                  child: DText(
                    text: 'Add',
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}

class AddTagTextHeader extends SliverPersistentHeaderDelegate {
  AddTagTextHeader({
    required this.text,
    this.tagsLength,
  });

  final String text;
  final int? tagsLength;
  @override
  double minExtent = 50;
  @override
  double maxExtent = 50;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      child: Container(
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.background.withOpacity(
              0.5,
            ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Row(
            children: [
              DText(
                text: text,
                fontSize: 14.sp,
              ),
              const Spacer(),
              DText(
                text: '$tagsLength tags',
                fontSize: 12.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}

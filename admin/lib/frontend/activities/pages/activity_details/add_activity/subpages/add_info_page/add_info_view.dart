import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

// add info view hook consumer widget with app layout
class AddInfoView extends HookConsumerWidget {
  const AddInfoView(
      {super.key,
      this.overview,
      this.seoDescription,
      required this.activityData,
      required this.activityNotifier});

  final Activity activityData;
  final String? overview;
  final String? seoDescription;
  final AddActivityNotifier activityNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileAddInfoView(
        activityData: activityData,
        activityNotifier: activityNotifier,
      ),
      tablet: const _TabletAddInfoView(),
      desktop: const _DesktopAddInfoView(),
    );
  }
}

// mobile add info view
class _MobileAddInfoView extends HookConsumerWidget {
  const _MobileAddInfoView({
    this.activityData,
    required this.activityNotifier,
  });

  final Activity? activityData;
  final AddActivityNotifier activityNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overviewController =
        useTextEditingController(text: activityData?.overview);
    final seoDescriptionController =
        useTextEditingController(text: activityData?.seoDescription);
    final editOverview = useState(false);
    final editSeoDescription = useState(false);
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            pinned: true,
            automaticallyImplyLeading: false,
            title: DText(
              text: 'Activity overview',
              fontSize: 14.sp,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  editOverview.value = !editOverview.value;
                },
                child: DText(
                  text: 'Edit',
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 2.h,
              ),
              child: editOverview.value == true
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                editOverview.value = false;
                              },
                              icon: LineIcon.times(),
                            ),
                            IconButton(
                              onPressed: () {
                                activityNotifier.updateOverview(
                                  overview: overviewController.text,
                                );
                                editOverview.value = false;
                              },
                              icon: LineIcon.check(),
                            )
                          ],
                        ),
                        TextField(
                          maxLength: 1200,
                          maxLines: 10,
                          minLines: 1,
                          controller: overviewController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        )
                      ],
                    )
                  : DText(
                      text: activityData?.overview ??
                          'No activity overview given click on \'Edit\'',
                      fontSize: 12.sp,
                    ),
            ),
          ),
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            pinned: true,
            automaticallyImplyLeading: false,
            title: DText(
              text: 'Activity SEO description',
              fontSize: 14.sp,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  editSeoDescription.value = !editSeoDescription.value;
                },
                child: DText(
                  text: 'Edit',
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 2.h,
              ),
              child: editSeoDescription.value == true
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                editOverview.value = false;
                              },
                              icon: LineIcon.times(),
                            ),
                            IconButton(
                              onPressed: () {
                                activityNotifier.updateSeoDescription(
                                  seoDescription: seoDescriptionController.text,
                                );

                                editSeoDescription.value = false;
                              },
                              icon: LineIcon.check(),
                            )
                          ],
                        ),
                        TextField(
                          maxLength: 1200,
                          maxLines: 10,
                          minLines: 1,
                          controller: seoDescriptionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        )
                      ],
                    )
                  : DText(
                      text: activityData?.seoDescription ??
                          'No activity SEO description given given click on \'Edit\'',
                      fontSize: 12.sp,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// tablet add info view
class _TabletAddInfoView extends HookConsumerWidget {
  const _TabletAddInfoView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// desktop add info view
class _DesktopAddInfoView extends HookConsumerWidget {
  const _DesktopAddInfoView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

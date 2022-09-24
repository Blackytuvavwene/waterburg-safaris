import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:sizer/sizer.dart';
import 'package:vrouter/vrouter.dart';

// description notifier class
class DescriptionNotifier extends StateNotifier<AsyncValue<String>> {
  DescriptionNotifier() : super(const AsyncData(''));
  void updateDescription(String value) => state = value as AsyncValue<String>;

  // get firestore instance
  final firestore = FirebaseFirestore.instance;

  // update description in firestore
  Future<void> updateDescriptionInFirestore({
    required String activityId,
    required String description,
    required String field,
  }) async {
    state = const AsyncValue.loading();

    // use async guard to catch errors
    state = AsyncValue.guard<String>(() async {
      // update description in firestore
      await firestore
          .collection('activities')
          .doc(activityId)
          .update({field: description});

      return description;
    }) as AsyncValue<String>;
  }
}

// description notifier provider
final descriptionNotifierProvider =
    StateNotifierProvider<DescriptionNotifier, AsyncValue<String>>(
        (ref) => DescriptionNotifier());

class ActivityDescriptionPopUp extends HookConsumerWidget {
  const ActivityDescriptionPopUp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // listen to description notifier provider
    ref.listen(descriptionNotifierProvider,
        (AsyncValue<String>? previous, AsyncValue<String> next) {
      // show loading indicator
      if (next is AsyncLoading) {
        // show loading indicator
        EasyLoading.show(
          status: 'Updating description...',
          maskType: EasyLoadingMaskType.custom,
        );
      }
      if (next is AsyncData) {
        // show snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Description updated successfully',
              style: GoogleFonts.poppins(),
            ),
          ),
        );
      }
      // show snackbar if error occurs
    }, onError: (Object error, StackTrace stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error updating description',
            style: GoogleFonts.poppins(),
          ),
        ),
      );
    });

    final descriptionController = useTextEditingController();
    final editType = ref.watch(editActivityTypeProvider);
    // text listener on description controller
    useEffect(() {
      descriptionController.addListener(() {
        ref
            .read(descriptionNotifierProvider.notifier)
            .updateDescription(descriptionController.text);
      });
      return () {
        descriptionController.dispose();
      };
    }, [descriptionController]);

    // update description controller
//     final update = useValueListenable();

//     useEffect(() {
//  descriptionController.text = update;
// }, [update]);

    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: context.breakpoint > LayoutBreakpoint.sm ? 30.w : 90.w,
        height: context.breakpoint > LayoutBreakpoint.sm ? 50.h : 70.h,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: DText(
                      text: 'Activity Description',
                      textColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (editType == ActivityEditType.editAll) {
                      Navigator.pop(context, descriptionController.text);
                    } else {
                      context.vRouter.pop();
                    }
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: descriptionController,
                maxLines: 10,
                minLines: 1,
                // build counter for max 150 words
                maxLength: 150,
                decoration: InputDecoration(
                  filled: true,
                  counter: TextFieldCounter(
                    controller: descriptionController.value.text,
                    maxLength: 150,
                  ),
                  fillColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintStyle: GoogleFonts.dosis(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  hintText: 'Enter Activity Description',
                ),
              ),
            ),
            const Spacer(
              flex: 6,
            ),
            CustomElevatedButton(
              text: 'Update',
              width: 25.w,
              primary: Theme.of(context).colorScheme.primary,
              textColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                if (editType == ActivityEditType.editAll) {
                  Navigator.pop(context, descriptionController.text);
                } else {
                  // ref.read(descriptionNotifierProvider.notifier).updateDescription(
                  //     descriptionController.text);
                  context.vRouter.pop();
                }
              },
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class ActivityDescriptionViewCard extends HookConsumerWidget {
  const ActivityDescriptionViewCard({
    Key? key,
    this.onTap,
    this.title,
    this.description,
    this.editType,
  }) : super(key: key);
  final VoidCallback? onTap;
  final String? title;
  final String? description;
  final ActivityEditType? editType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teCtrl = useTextEditingController();
    return Container(
      padding: EdgeInsets.all(
        1.5.w,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DText(
                text: title!,
                textColor: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              const Spacer(),
              IconButton(
                onPressed: onTap,
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          editType == ActivityEditType.editAll
              ? Container(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: teCtrl,
                    maxLines: 10,
                    minLines: 1,
                    // build counter for max 150 words
                    maxLength: 1250,
                    decoration: InputDecoration(
                      filled: true,
                      counter: TextFieldCounter(
                        controller: teCtrl.value.text,
                        maxLength: 1250,
                      ),
                      fillColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: GoogleFonts.dosis(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      hintText: 'Enter Activity Description',
                    ),
                  ),
                )
              : DText(
                  text: description!,
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0,
                ),
        ],
      ),
    );
  }
}

// text field counter
class TextFieldCounter extends HookConsumerWidget {
  const TextFieldCounter({
    Key? key,
    required this.controller,
    required this.maxLength,
  }) : super(key: key);
  final String controller;
  final int maxLength;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DText(
          text: '${controller.length}/$maxLength',
          textColor: Theme.of(context).colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
        ),
      ],
    );
  }
}

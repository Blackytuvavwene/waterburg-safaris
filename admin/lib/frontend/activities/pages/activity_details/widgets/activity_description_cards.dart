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
    state = await AsyncValue.guard<String>(() async {
      // update description in firestore
      await firestore
          .collection('activities')
          .doc(activityId)
          .update({field: description});

      return description;
    });
  }
}

// description notifier provider
final descriptionNotifierProvider =
    StateNotifierProvider<DescriptionNotifier, AsyncValue<String>>(
        (ref) => DescriptionNotifier());

class ActivityDescriptionPopUp extends HookConsumerWidget {
  const ActivityDescriptionPopUp({
    Key? key,
    this.description,
    this.field,
    this.activityId,
    this.maxLength,
  }) : super(key: key);
  final String? description;
  final String? field;
  final String? activityId;
  final int? maxLength;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
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

    final descriptionController = useTextEditingController(text: description);
    return AlertDialog(
      title: const DText(
        text: 'Edit Description',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: descriptionController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Description cannot be empty';
            }
            return null;
          },
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: 'Enter description',
            hintStyle: GoogleFonts.dosis(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          maxLines: 8,
          minLines: 1,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.vRouter.pop();
          },
          child: DText(
            text: 'Cancel',
            textColor: Theme.of(context).colorScheme.error,
          ),
        ),
        TextButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              // update description in firestore
              await ref
                  .read(descriptionNotifierProvider.notifier)
                  .updateDescriptionInFirestore(
                    activityId: activityId!,
                    description: descriptionController.text,
                    field: field!,
                  );
              context.vRouter.pop();
            }
          },
          child: DText(
            text: 'Update',
            textColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
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
    final teCtrl = useTextEditingController(text: description);
    // form key
    final formKey = GlobalKey<FormState>();
    return Container(
      padding: EdgeInsets.all(
        context.breakpoint > LayoutBreakpoint.sm ? 1.5.w : 8.w,
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
              ? Form(
                  child: TextFormField(
                    controller: teCtrl,
                    maxLines: 10,
                    minLines: 1,
                    // build counter for max 150 words
                    maxLength: 1250,
                    decoration: InputDecoration(
                      filled: true,
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

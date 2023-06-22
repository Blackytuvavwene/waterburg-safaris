import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:sizer/sizer.dart';

// widget did update hook stateless widget

// description notifier class
class DescriptionNotifier extends StateNotifier<AsyncValue<String>> {
  DescriptionNotifier() : super(const AsyncData(''));
  void updateDescription(String value) => state = value as AsyncValue<String>;

  // get firestore instance
  final firestore = FirebaseFirestore.instance;

  // update description in firestore
  Future<void> updateStringFieldInFirestore({
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
    required this.onSaved,
    this.onCancel,
  }) : super(key: key);
  final String? description;
  final String? field;
  final String? activityId;
  final int? maxLength;
  final Function(String value) onSaved;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    // listen to description notifier provider

    final descriptionController = useTextEditingController(text: description);
    // focus node
    final focusNode = useFocusNode();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: descriptionController,
                autofocus: true,
                focusNode: focusNode,
                onSaved: (newValue) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field cannot be empty';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // close dialog
                      Navigator.of(context).pop();
                    },
                    child: DText(
                      text: 'Cancel',
                      textColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onSaved(descriptionController.text);
                      //clear controller
                      descriptionController.clear();
                      // close dialog
                      Navigator.of(context).pop();
                    },
                    child: DText(
                      text: 'Update',
                      textColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              )
            ],
          ),
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

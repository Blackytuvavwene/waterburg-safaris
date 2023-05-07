import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class DFormTextField extends StatelessWidget {
  const DFormTextField({
    Key? key,
    this.controller,
    this.initialValue,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

// textarea field hook consumer widget
class DFormTextAreaField extends HookConsumerWidget {
  const DFormTextAreaField({
    Key? key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.maxLength,
    this.focus,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final int? maxLength;
  final bool? focus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      maxLines: 6,
      minLines: 1,
      expands: true,
      maxLength: maxLength,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

// chip input field
class ChipInputField<T> extends HookConsumerWidget {
  const ChipInputField({
    super.key,
    this.chips,
    required this.onDelete,
    required this.onSubmit,
    this.textController,
    this.chipFocusNode,
    this.formKey,
    required this.hintText,
    this.validator,
    required this.noChipsMessasge,
  });
  final List<T>? chips;
  final Function(T chip) onDelete;
  final FocusNode? chipFocusNode;
  final TextEditingController? textController;
  final Function(String value) onSubmit;
  final GlobalKey<FormState>? formKey;
  final Function(String? value)? validator;
  final String hintText;
  final String noChipsMessasge;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        borderRadius: BorderRadius.circular(
          4.sp,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Wrap(
              spacing: AppSpacing.smallX,
              children: [
                if (chips != null && chips != [])
                  if (chips!.isNotEmpty)
                    ...chips!.map(
                      (chip) => Chip(
                        label: DText(
                          text: chip.toString(),
                        ),
                        deleteIcon: LineIcon.trash(
                          size: 12.sp,
                        ),
                        onDeleted: () {
                          onDelete(chip);
                        },
                      ),
                    )
                  else
                    DText(
                      text: noChipsMessasge,
                    ),
              ],
            ),
          ),
          Flexible(
            child: TextFormField(
              controller: textController,
              focusNode: chipFocusNode,
              decoration: InputDecoration(
                filled: true,
                hintText: hintText,
                hintStyle: GoogleFonts.dosis(),
              ),
              validator:
                  validator != null ? (value) => validator!(value) : null,
              onChanged: chipFocusNode != null
                  ? (value) {
                      // check if cellphone number input field is focused on
                      if (chipFocusNode!.hasFocus) {
                        // perform form validations on input changes
                        formKey?.currentState?.validate();
                      }
                    }
                  : null,
              onFieldSubmitted: (value) {
                onSubmit(
                  textController!.text.trim(),
                );
                textController!.clear();
                chipFocusNode!.requestFocus();
              },
            ),
          )
        ],
      ),
    );
  }
}

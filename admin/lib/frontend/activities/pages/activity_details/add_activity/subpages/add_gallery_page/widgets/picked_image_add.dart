import 'dart:io';
import 'dart:ui';

import 'package:admin/lib.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class AddPickedImage extends HookConsumerWidget {
  const AddPickedImage({
    super.key,
    this.image,
    this.index,
    required this.addImageNotifier,
  });
  final ImageHelperModel? image;
  final int? index;
  final AddImagesNotifier addImageNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: context.breakpoint > LayoutBreakpoint.xs ? 20.w : 60.w,
      height: context.breakpoint > LayoutBreakpoint.xs ? 10.h : 30.h,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: kIsWeb
                ? ExtendedImage.memory(
                    image!.bytes!,
                    width:
                        context.breakpoint > LayoutBreakpoint.xs ? 20.w : 60.w,
                    height: 20.h,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    loadStateChanged: (ExtendedImageState state) {
                      switch (state.extendedImageLoadState) {
                        case LoadState.loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case LoadState.completed:
                          return ExtendedRawImage(
                            image: state.extendedImageInfo?.image,
                            fit: BoxFit.cover,
                          );
                        case LoadState.failed:
                          return const Center(
                            child: Icon(Icons.error),
                          );
                      }
                    },
                  )
                : ExtendedImage.file(
                    File(image!.path!),
                    width: 40.w,
                    height: 20.h,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    loadStateChanged: (ExtendedImageState state) {
                      switch (state.extendedImageLoadState) {
                        case LoadState.loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case LoadState.completed:
                          return ExtendedRawImage(
                            image: state.extendedImageInfo?.image,
                            fit: BoxFit.cover,
                            width: 40.w,
                            height: 20.h,
                          );
                        case LoadState.failed:
                          return const Center(
                            child: Icon(Icons.error),
                          );
                      }
                    },
                  ),
          ),
          Positioned(
            right: 0,
            top: 0,
            left: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.background,
                    Theme.of(context).colorScheme.background.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [
                    0.0,
                    1.0,
                  ],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(9),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: LineIcon.trash(),
                    onPressed: () {
                      addImageNotifier.removeImageFromList(image: image!);
                    },
                  ),
                  IconButton(
                    icon: LineIcon.editAlt(),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddImageEditDialog(
                          image: image!,
                          index: index!,
                          addImageNotifier: addImageNotifier,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(10)),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DText(
                        text: '''Image Size : '''
                            '''${(image!.imageFile!.sizeInBytes / 1024 / 1024).toStringAsFixed(2)} MB '''
                            '''/ (${image?.imageFile?.width} x ${image?.imageFile?.height})''',
                        fontSize: 12.sp,
                      ),
                      DText(
                        text: image?.imageDetails?.imageTitle != ''
                            ? '''Image Name : ${image?.imageDetails?.imageTitle}'''
                            : 'Choose a name for this image',
                        fontSize: 12.sp,
                      ),
                      Flexible(
                        child: DText(
                          text: image?.imageDetails?.imageDescription != ''
                              ? '''Image Description : ${image?.imageDetails?.imageDescription}'''
                              : 'Choose a description for this image',
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// image details edit dialog box
class AddImageEditDialog extends HookConsumerWidget {
  const AddImageEditDialog({
    Key? key,
    required this.image,
    this.index,
    required this.addImageNotifier,
  }) : super(key: key);
  final ImageHelperModel image;
  final int? index;
  final AddImagesNotifier addImageNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageTitleController =
        useTextEditingController(text: image.imageDetails?.imageTitle);
    final imageDescriptionController =
        useTextEditingController(text: image.imageDetails?.imageDescription);
    final imageTitleFocusNode = useFocusNode();
    final imageDescriptionFocusNode = useFocusNode();
    final formKey = GlobalKey<FormState>();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Form(
          key: formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            // image title
            TextFormField(
              controller: imageTitleController,
              focusNode: imageTitleFocusNode,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter image title';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Image Title',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // image description
            TextFormField(
              controller: imageDescriptionController,
              focusNode: imageDescriptionFocusNode,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter image description';
                }
                return null;
              },
              maxLength: 200,
              maxLines: 6,
              minLines: 1,
              decoration: InputDecoration(
                labelText: 'Image Description',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // save button
            SizedBox(
              width: 100.w,
              height: 6.h,
              child: CustomElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    addImageNotifier.updateImageDetailsInList(
                      gallery: Gallery(
                        imageTitle: imageTitleController.text,
                        imageDescription: imageDescriptionController.text,
                        imageUrl: image.imageDetails!.imageUrl,
                      ),
                      index: index!,
                    );

                    GoRouter.of(context).pop();
                  }
                },
                borderRadius: BorderRadius.circular(10),
                text: 'Save',
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

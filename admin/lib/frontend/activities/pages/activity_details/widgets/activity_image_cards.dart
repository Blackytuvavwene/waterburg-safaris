import 'dart:io';

import 'package:admin/lib.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_image/extended_image.dart' as ei;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:layout/layout.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';
import 'package:vrouter/vrouter.dart';

// final imaFileProvider = Provider((ref)=>(XFile im) {
//  ImageFile file;

//   im.asImageFile.then((value) {
//   return  file = value;
//   }).whenComplete(() => null);

//   return file;
// });

class GalleryNotifier extends StateNotifier<AsyncValue<List<Gallery>>> {
  GalleryNotifier() : super(const AsyncData([]));

  // add to firestore
  Future<AsyncValue<List<Gallery>>> addImagesToFirestore({
    required Gallery gallery,
    required String activityId,
    required String query,
  }) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() async {
      final imagesD = await FirestoreHelper.updateDataInDocList<Gallery>(
          data: [gallery],
          docId: activityId,
          query: query,
          docPath: 'activities');
      return imagesD;
    });
  }

  // add to state
  void addImagesToState({required List<Gallery> images}) {
    state = state.asData!.value != null
        ? AsyncValue.data([...state.asData!.value, ...images])
        : AsyncValue.data(images) ?? const AsyncData([]);
  }
}

// gallery notifier provider
final galleryNotifierProvider =
    StateNotifierProvider<GalleryNotifier, AsyncValue<List<Gallery>>>((ref) {
  return GalleryNotifier();
});

class ActivityImageCard extends HookConsumerWidget {
  const ActivityImageCard({
    Key? key,
    this.image,
  }) : super(key: key);
  final Gallery? image;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ei.ExtendedImage.network(
      image!.imageUrl!,
      fit: BoxFit.cover,
      width: 40.w,
      height: 20.h,
      cache: true,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(10),
      loadStateChanged: (ei.ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case ei.LoadState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ei.LoadState.completed:
            return ei.ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              fit: BoxFit.cover,
              width: 40.w,
              height: 20.h,
            );
          case ei.LoadState.failed:
            return const Center(
              child: Icon(Icons.error),
            );
        }
      },
    );
  }
}

class AddImagesDialog extends HookConsumerWidget {
  const AddImagesDialog({
    Key? key,
    this.activityId,
  }) : super(key: key);
  final String? activityId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final galleryState = ref.watch(galleryNotifierProvider.notifier);

    // show states
    ref.listen(galleryNotifierProvider,
        (AsyncValue<List<Gallery>>? previous, AsyncValue<List<Gallery>> next) {
      next.when(
        data: (data) {
          EasyLoading.showSuccess('Uploaded Successfully');
        },
        loading: () {
          EasyLoading.show(status: 'Uploading...');
        },
        error: (error, stackTrace) {
          EasyLoading.showError('Error Uploading');
        },
      );
    });
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: 70.h,
        width: 90.w,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10),
            const DText(
              text: 'Add Images',
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    ImagePickerWidget(
                      activityId: activityId!,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'Cancel',
                      primary: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'Upload Images',
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// image picker widget
class ImagePickerWidget extends HookConsumerWidget {
  const ImagePickerWidget({
    Key? key,
    this.activityId,
    this.galleryNotifier,
  }) : super(key: key);
  final String? activityId;
  final GalleryNotifier? galleryNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // access image picker helpers
    final imageHelper = ref.watch(imageHelperNotifierProvider);
    final galleryHelper = ref.watch(galleryImageControllerNotifierProvider);
    final imageHelperWeb = ref.watch(imageFileHelperControllerNotifierProvider);
    final multiHelper =
        ref.watch(multipleImageHelperControllerNotifierProvider);

    getImage() async {
      try {
        ImagePicker picker = ImagePicker();
        XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if (image == null) {
          return null;
        }

        return image;
      } catch (e) {
        throw e.toString();
      }
    }

    // show toast on error for picking image
    ref.listen(multipleImageHelperControllerNotifierProvider,
        (AsyncValue<List<ImageHelperModel>?>? previous,
            AsyncValue<List<ImageHelperModel>?> next) {
      next.when(
        data: (data) {
          if (data!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Successfully added ${data.length} images'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No images selected'),
              ),
            );
          }
        },
        loading: () {},
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
            ),
          );
        },
      );

      if (next.asData?.value == previous) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Operation failed'),
          ),
        );
      }
    });

    // listen to adding images to gallery and show toast
    ref.listen(addImagesNotifierProvider,
        (AsyncValue<List<String>?>? previous, AsyncValue<List<String>?> next) {
      next.when(
        data: (data) {
          final oldData = data;
          if (data!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Successfully added ${data.length} images to storage'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No images selected'),
              ),
            );
          }
        },
        loading: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Adding images to storage'),
            ),
          );
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
            ),
          );
        },
      );
    });

    // access image picker state
    final imagePickerState = ref.read(imageHelperNotifierProvider.notifier);
    final multiImagepicker =
        ref.read(multipleImageHelperControllerNotifierProvider.notifier);
    // final galleryImageState =
    //     ref.watch(galleryImageControllerNotifierProvider.notifier);
    // final imagePickerWebState =
    //     ref.watch(imageFileHelperControllerNotifierProvider.notifier);

    return Center(
        child: Container(
      color: Theme.of(context).colorScheme.onBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(),
        child: Column(
          children: [
            Row(
              children: [
                // pick image button
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () async {
                      // await ImageHelpers.webPickImage();
                      if (multiHelper.asData?.value != null) {
                        await multiImagepicker.pickAndAddMultipleImagesToList(
                            storagePath: 'activities/$activityId');
                      } else {
                        await multiImagepicker.pickMultipleImages(
                            storagePath: 'activities/$activityId');
                      }
                      // convert xfile to imagefile
                    },
                    text: 'Pick Images',
                  ),
                ),

                // clear images
                multiHelper.maybeMap(orElse: () {
                  return const SizedBox.shrink();
                }, data: (value) {
                  return Expanded(
                    child: CustomElevatedButton(
                      primary: Theme.of(context).colorScheme.errorContainer,
                      onPressed: () async {
                        await multiImagepicker.clearList();
                      },
                      text: 'Clear Images',
                    ),
                  );
                })
              ],
            ),
            const SizedBox(height: 10),
            multiHelper.when(
              data: (image) {
                return image!.isNotEmpty
                    ? SizedBox(
                        width: 100.w,
                        child: Center(
                          child: Wrap(
                            spacing: 2.w,
                            children: [
                              ...image.map((e) {
                                return Center(
                                  child: ImageCard(
                                    image: e,
                                    index: image.indexOf(e),
                                  ).animate().slide(
                                        begin: const Offset(10, 0),
                                        end: Offset.zero,
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        curve: Curves.easeInOut,
                                      ),
                                );
                              }),
                              Center(
                                child: TextButton(
                                    onPressed: () {},
                                    child: DText(
                                      text: 'Add Image',
                                      textColor: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      fontSize: 16.sp,
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 100.w,
                        height: 50.h,
                        child: Center(
                          child: DText(
                            text: 'Add Images',
                            textColor: Theme.of(context).colorScheme.background,
                            fontSize: context.breakpoint > LayoutBreakpoint.sm
                                ? 3.sp
                                : 16.sp,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => const SizedBox(
                child: ColoredBox(color: Colors.red, child: Text('Error')),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

// image card widget with details, edit and delete buttons
class ImageCard extends HookConsumerWidget {
  const ImageCard({
    Key? key,
    this.image,
    this.index,
  }) : super(key: key);
  final ImageHelperModel? image;
  final int? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileI = kIsWeb ? File(image!.path!) : null;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).colorScheme.onTertiaryContainer,
      child: Column(
        children: [
          SizedBox(
            width: context.breakpoint > LayoutBreakpoint.sm ? 20.w : 90.w,
            height: context.breakpoint > LayoutBreakpoint.sm ? 60.h : 30.h,
            child: Stack(
              children: [
                // image

                kIsWeb
                    ? ei.ExtendedImage.network(
                        image!.path!,
                        fit: BoxFit.cover,
                        width: 100.w,
                        height: 100.h,
                        cache: true,
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.zero,
                        ),
                        loadStateChanged: (ei.ExtendedImageState state) {
                          switch (state.extendedImageLoadState) {
                            case ei.LoadState.loading:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case ei.LoadState.completed:
                              return ei.ExtendedRawImage(
                                image: state.extendedImageInfo?.image,
                                fit: BoxFit.cover,
                                width: 100.w,
                                height: 100.h,
                              );
                            case ei.LoadState.failed:
                              return const Center(
                                child: Icon(Icons.error),
                              );
                          }
                        },
                      )
                    : ei.ExtendedImage.memory(
                        image!.bytes!,
                        fit: BoxFit.cover,
                        width: 100.w,
                        height: 100.h,
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.zero,
                        ),
                        loadStateChanged: (ei.ExtendedImageState state) {
                          switch (state.extendedImageLoadState) {
                            case ei.LoadState.loading:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case ei.LoadState.completed:
                              return ei.ExtendedRawImage(
                                image: state.extendedImageInfo?.image,
                                fit: BoxFit.cover,
                                width: 100.w,
                                height: 100.h,
                              );
                            case ei.LoadState.failed:
                              return const Center(
                                child: Icon(Icons.error),
                              );
                          }
                        },
                      ),
                // edit button and delete button

                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          // show edit image dialog
                          showDialog(
                            context: context,
                            builder: (context) => ImageDetailsEditDialog(
                              image: image!,
                              index: index!,
                            ),
                          );
                        },
                        icon: LineIcon.editAlt(),
                      ),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(
                                  multipleImageHelperControllerNotifierProvider
                                      .notifier)
                              .deleteImageFromList(image: image!);
                        },
                        icon: LineIcon.trash(),
                      ),
                    ],
                  ),
                ),

                // image details
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.background.withOpacity(
                                0.7,
                              ),
                      // borderRadius: const BorderRadius.only(
                      //   bottomLeft: Radius.circular(10),
                      //   bottomRight: Radius.circular(10),
                      // ),
                    ),
                    child: SizedBox(
                      height: 8.h,
                      width: 100.w,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: DText(
                              text: 'Image Details',
                              textColor:
                                  Theme.of(context).colorScheme.onBackground,
                              fontSize: context.breakpoint > LayoutBreakpoint.sm
                                  ? 6.sp
                                  : 16.sp,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: DText(
                              text: 'Image Name : ${image?.name}',
                              textColor:
                                  Theme.of(context).colorScheme.onBackground,
                              fontSize: context.breakpoint > LayoutBreakpoint.sm
                                  ? 4.sp
                                  : 14.sp,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: DText(
                              text:
                                  'Image Size : ${(image!.imageFile!.sizeInBytes / 1024 / 1024).toStringAsFixed(2)} MB / (${image!.imageFile!.width} x ${image!.imageFile!.height})',
                              textColor:
                                  Theme.of(context).colorScheme.onBackground,
                              fontSize: context.breakpoint > LayoutBreakpoint.sm
                                  ? 4.sp
                                  : 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: context.breakpoint > LayoutBreakpoint.sm ? 20.w : 90.w,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    context.breakpoint > LayoutBreakpoint.sm ? 2.w : 5.w,
                vertical: context.breakpoint > LayoutBreakpoint.sm ? 1.h : 2.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DText(
                    text: 'Image title : ${image!.imageDetails?.imageTitle}',
                    textColor: Theme.of(context).colorScheme.onBackground,
                    fontSize:
                        context.breakpoint > LayoutBreakpoint.sm ? 6.sp : 16.sp,
                  ),
                  AutoSizeText.rich(
                    TextSpan(
                      text: 'Image description : ',
                      style: GoogleFonts.dosis(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: context.breakpoint > LayoutBreakpoint.sm
                            ? 6.sp
                            : 16.sp,
                      ),
                      children: [
                        TextSpan(
                          text: image!.imageDetails?.imageDescription,
                          style: GoogleFonts.dosis(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: context.breakpoint > LayoutBreakpoint.sm
                                ? 4.sp
                                : 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DText(
                    text: image!.imageDetails?.imageDescription,
                    textColor: Theme.of(context).colorScheme.onBackground,
                    fontSize:
                        context.breakpoint > LayoutBreakpoint.sm ? 6.sp : 16.sp,
                  ),
                  Expanded(child: CustomElevatedButton(
                    onPressed: () {
                      ref
                          .read(galleryNotifierProvider.notifier)
                          .addImagesToFirestore(
                              gallery: image!.imageDetails!,
                              activityId: 'activityId',
                              query: 'jjhg');
                    },
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// image details edit dialog box
class ImageDetailsEditDialog extends HookConsumerWidget {
  const ImageDetailsEditDialog({Key? key, required this.image, this.index})
      : super(key: key);
  final ImageHelperModel image;
  final int? index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageTitleController = useTextEditingController();
    final imageDescriptionController = useTextEditingController();
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
                    ref
                        .read(multipleImageHelperControllerNotifierProvider
                            .notifier)
                        .updateGalleryInList(
                            gallery: Gallery(
                              imageTitle: imageTitleController.text,
                              imageDescription: imageDescriptionController.text,
                              imageUrl: image.imageDetails!.imageUrl,
                            ),
                            index: index!);
                    context.vRouter.pop();
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

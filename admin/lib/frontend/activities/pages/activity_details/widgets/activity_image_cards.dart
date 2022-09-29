import 'dart:io';

import 'package:admin/lib.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:extended_image/extended_image.dart' as ei;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:layout/layout.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

// final imaFileProvider = Provider((ref)=>(XFile im) {
//  ImageFile file;

//   im.asImageFile.then((value) {
//   return  file = value;
//   }).whenComplete(() => null);

//   return file;
// });

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
  const AddImagesDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: SizedBox(
        height: 70.h,
        width: 80.w,
        child: Center(
          child: Column(
            children: [
              const Text('Add Images'),
              const SizedBox(height: 10),
              const Expanded(
                child: ImagePickerWidget(),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Done'),
              ),
            ],
          ),
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
  }) : super(key: key);
  final String? activityId;
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
      width: 100.w,
      color: Theme.of(context).colorScheme.onBackground,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // pick image button
            ElevatedButton(
              onPressed: () async {
                // await ImageHelpers.webPickImage();
                if (multiHelper.asData?.value != null) {
                  await multiImagepicker.pickAndAddMultipleImagesToList();
                } else {
                  await multiImagepicker.pickMultipleImages();
                }
                // convert xfile to imagefile
              },
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 10),
            // compress image button
            ElevatedButton(
              onPressed: () async {
                // await ref
                //     .read(imageHelperNotifierProvider.notifier)
                //     .compressImage(
                //       imageHelperWeb.value!,
                //     );

                // // convert xfile to imagefile
                // await ref
                //     .read(imageFileHelperControllerNotifierProvider.notifier)
                //     .fileToImageFile(file: imageHelper.value!);
              },
              child: const Text('Compress Image'),
            ),
            const SizedBox(height: 10),
            // add image to gallery button
            ElevatedButton(
              onPressed: () async {
                // add image to gallery
                // ref
                //     .read(galleryImageControllerNotifierProvider.notifier)
                //     .addImageToGalleryList(
                //       gallery: Gallery(
                //         imageUrl: imageHelper.value!.xFile!.path,
                //       ),
                //     );
                await ref
                    .read(addImagesNotifierProvider.notifier)
                    .addImagesToFirebaseStorage(
                      image: multiHelper.asData!.value!
                          .map((e) => e.xFile!)
                          .toList(),
                      activityId: activityId!,
                    );
              },
              child: const Text('Add Image to Gallery'),
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
                        child: Center(
                          child: SizedBox(
                            width: context.breakpoint > LayoutBreakpoint.sm
                                ? 60.w
                                : 90.w,
                            child: DottedBorder(
                              padding: EdgeInsets.all(
                                10.w,
                              ),
                              strokeWidth: 4.sp,
                              borderType: BorderType.RRect,
                              dashPattern: const [6, 10, 4],
                              radius: const Radius.circular(10),
                              color: Theme.of(context).colorScheme.background,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: LineIcon.plusSquareAlt(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        size: context.breakpoint >
                                                LayoutBreakpoint.sm
                                            ? 10.sp
                                            : 34.sp,
                                      ),
                                    ),
                                    Center(
                                      child: DText(
                                        text: 'Add Images',
                                        textColor: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        fontSize: context.breakpoint >
                                                LayoutBreakpoint.sm
                                            ? 3.sp
                                            : 16.sp,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
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
            const SizedBox(height: 10),
            // show gallery
            galleryHelper.when(
              data: (gallery) {
                return gallery != null
                    ? SizedBox(
                        width: 50.w,
                        height: 30.h,
                        child: ListView.builder(
                          itemCount: gallery.length,
                          itemBuilder: (context, index) {
                            return ActivityImageCard(
                              image: gallery[index],
                            );
                          },
                        ),
                      )
                    : const SizedBox();
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => const SizedBox(),
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
  }) : super(key: key);
  final ImageHelperModel? image;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileI = kIsWeb ? File(image!.path!) : null;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: SizedBox(
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
            // edit button
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
            ),
            // delete button
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                onPressed: () {
                  ref
                      .read(multipleImageHelperControllerNotifierProvider
                          .notifier)
                      .deleteImageFromList(image: image!);
                },
                icon: const Icon(Icons.delete),
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
                  color: Theme.of(context).colorScheme.background.withOpacity(
                        0.7,
                      ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
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
                          textColor: Theme.of(context).colorScheme.onBackground,
                          fontSize: context.breakpoint > LayoutBreakpoint.sm
                              ? 6.sp
                              : 16.sp,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: DText(
                          text: 'Image Name : ${image?.name}',
                          textColor: Theme.of(context).colorScheme.onBackground,
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
                          textColor: Theme.of(context).colorScheme.onBackground,
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
    );
  }
}

import 'package:admin/lib.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
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
    return ExtendedImage.network(
      image!.imageUrl!,
      fit: BoxFit.cover,
      width: 40.w,
      height: 20.h,
      cache: true,
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
  const ImagePickerWidget({Key? key}) : super(key: key);
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

    //

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
                  await multiImagepicker.pickMultipleImages();

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
                  ref
                      .read(galleryImageControllerNotifierProvider.notifier)
                      .addImageToGalleryList(
                        gallery: Gallery(
                          imageUrl: imageHelper.value!.xFile!.path,
                        ),
                      );
                },
                child: const Text('Add Image to Gallery'),
              ),
              const SizedBox(height: 10),
              // show image
              // imageHelper.when(
              //   data: (image) {
              //     return image != null
              //         ? SizedBox(
              //             width: 100.w,
              //             child: ImageCard(
              //               image: image.xFile,
              //               imageFile: image.imageFile,
              //             ),)
              //         : SizedBox(
              //             width: 100.w,
              //             child: Center(
              //               child: SizedBox(
              //                 width: 60.w,
              //                 child: DottedBorder(
              //                   padding: EdgeInsets.all(
              //                     10.w,
              //                   ),
              //                   borderType: BorderType.RRect,
              //                   dashPattern: const [6, 10, 4],
              //                   radius: const Radius.circular(10),
              //                   color: Theme.of(context).colorScheme.background,
              //                   child: Center(
              //                     child: Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.center,
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       mainAxisSize: MainAxisSize.min,
              //                       children: [
              //                         IconButton(
              //                           onPressed: () {},
              //                           icon: LineIcon.plusSquareAlt(
              //                             color: Theme.of(context)
              //                                 .colorScheme
              //                                 .background,
              //                             size: 10.sp,
              //                           ),
              //                         ),
              //                         Center(
              //                           child: DText(
              //                             text: 'Add Image',
              //                             textColor: Theme.of(context)
              //                                 .colorScheme
              //                                 .background,
              //                             fontSize: 3.sp,
              //                             textAlign: TextAlign.center,
              //                           ),
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           );
              //   },
              //   loading: () => const Center(
              //     child: CircularProgressIndicator(),
              //   ),
              //   error: (error, stackTrace) => const SizedBox(
              //     child: Text('Error'),
              //   ),
              // ),
              multiHelper.when(
                data: (image) {
                  return image!.isNotEmpty
                      ? SizedBox(
                          width: 100.w,
                          child: Center(
                            child: Wrap(
                              spacing: 2.w,
                              children: image.map((e) {
                                return ImageCard(
                                  image: e.xFile,
                                  imageFile: e.imageFile,
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 100.w,
                          child: Center(
                            child: SizedBox(
                              width: 60.w,
                              child: DottedBorder(
                                padding: EdgeInsets.all(
                                  10.w,
                                ),
                                borderType: BorderType.RRect,
                                dashPattern: const [6, 10, 4],
                                radius: const Radius.circular(10),
                                color: Theme.of(context).colorScheme.background,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: LineIcon.plusSquareAlt(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          size: 10.sp,
                                        ),
                                      ),
                                      Center(
                                        child: DText(
                                          text: 'Add Image',
                                          textColor: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          fontSize: 3.sp,
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
      ),
    );
  }
}

// image card widget with details, edit and delete buttons
class ImageCard extends HookConsumerWidget {
  const ImageCard({
    Key? key,
    this.image,
    this.imageFile,
  }) : super(key: key);
  final XFile? image;
  final ImageFile? imageFile;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: SizedBox(
        width: 20.w,
        height: 60.h,
        child: Stack(
          children: [
            // image
            ExtendedImage.network(
              image!.path.toString(),
              fit: BoxFit.cover,
              width: 100.w,
              height: 100.h,
              cache: true,
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
                      width: 100.w,
                      height: 100.h,
                    );
                  case LoadState.failed:
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
                onPressed: () {},
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
                  horizontal: 5,
                  vertical: 5,
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
                child: Column(
                  children: [
                    DText(
                      text: 'Image Details',
                      textColor: Theme.of(context).colorScheme.onBackground,
                      fontSize: context.breakpoint > LayoutBreakpoint.sm
                          ? 6.sp
                          : 10.sp,
                    ),
                    DText(
                      text: 'Image Name : ${image!.name}',
                      textColor: Theme.of(context).colorScheme.onBackground,
                      fontSize: context.breakpoint > LayoutBreakpoint.sm
                          ? 4.sp
                          : 8.sp,
                    ),
                    DText(
                      text:
                          'Image Size : ${(imageFile!.sizeInBytes / 1024 / 1024).toStringAsFixed(2)} MB - (${imageFile!.width} x ${imageFile!.height})',
                      textColor: Theme.of(context).colorScheme.onBackground,
                      fontSize: context.breakpoint > LayoutBreakpoint.sm
                          ? 4.sp
                          : 8.sp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
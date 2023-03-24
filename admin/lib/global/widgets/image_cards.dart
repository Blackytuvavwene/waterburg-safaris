import 'package:admin/lib.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

// picked image cards
class PickedImageCard extends HookConsumerWidget {
  const PickedImageCard({
    super.key,
    this.imageData,
    this.onRemoveImage,
    this.onUpdateImageDetails,
  });
  final ImageHelperModel? imageData;
  final VoidCallback? onRemoveImage;
  final Function(
    ImageHelperModel image,
    Gallery imageDetails,
  )? onUpdateImageDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _PickedMobileImageCard(
        imageData: imageData,
        onRemoveImage: onRemoveImage,
        onUpdateImageDetails: onUpdateImageDetails,
      ),
      tablet: _PickedTabletImageCard(
        imageData: imageData,
      ),
      desktop: _PickedDesktopImageCard(
        imageData: imageData,
      ),
    );
  }
}

// mobile company gallery card
class _PickedMobileImageCard extends HookConsumerWidget {
  const _PickedMobileImageCard({
    this.imageData,
    this.onRemoveImage,
    this.onUpdateImageDetails,
  });
  final ImageHelperModel? imageData;
  final VoidCallback? onRemoveImage;
  final Function(
    ImageHelperModel image,
    Gallery imageDetails,
  )? onUpdateImageDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageTitleTextCtrl = useTextEditingController(
      text: imageData?.imageDetails?.imageTitle,
    );
    final imageDescTextCtrl = useTextEditingController(
      text: imageData?.imageDetails?.imageDescription,
    );
    final imageTitleFocusNode = useFocusNode();
    final imageDescFocusNode = useFocusNode();
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: kIsWeb
                ? ExtendedImage.network(
                    '${imageData?.imageFile?.filePath}',
                    width: 100.w,
                    height: 10.h,
                    fit: BoxFit.cover,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        5.sp,
                      ),
                    ),
                    loadStateChanged: (state) {
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
                            height: 10.h,
                          );
                        case LoadState.failed:
                          return const Center(
                            child: DText(
                              text: 'Failed to load image',
                            ),
                          );
                      }
                    },
                  )
                : ExtendedImage.memory(
                    imageData!.bytes!,
                    width: 100.w,
                    height: 15.h,
                    fit: BoxFit.cover,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        5.sp,
                      ),
                    ),
                    loadStateChanged: (state) {
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
                            height: 15.h,
                          );
                        case LoadState.failed:
                          return const Center(
                            child: DText(
                              text: 'Failed to load image',
                            ),
                          );
                      }
                    },
                  ),
          ),
          Flexible(
            child: ListTile(
              title: DText(
                text: imageData!.imageDetails!.imageTitle != ''
                    ? imageData!.imageDetails!.imageTitle
                    : 'Edit image title',
              ),
              subtitle: DText(
                text: imageData?.imageDetails?.imageDescription ??
                    'Edit image description',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: IconButton(
                      onPressed: () async {
                        // show edit image dialog
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: imageTitleTextCtrl,
                                        focusNode: imageTitleFocusNode,
                                        decoration: InputDecoration(
                                          labelText: 'Image name',
                                          labelStyle: GoogleFonts.dosis(),
                                          border: const OutlineInputBorder(),
                                        ),
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (value) {
                                          // update image title
                                          imageTitleFocusNode.unfocus();
                                          imageDescFocusNode.requestFocus();
                                        },
                                      ),
                                      SizedBoxAppSpacing.smallY(),
                                      TextFormField(
                                        maxLength: 120,
                                        maxLines: 3,
                                        minLines: 1,
                                        focusNode: imageDescFocusNode,
                                        controller: imageDescTextCtrl,
                                        decoration: InputDecoration(
                                          labelText: 'Image description',
                                          labelStyle: GoogleFonts.dosis(),
                                          border: const OutlineInputBorder(),
                                        ),
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (value) {
                                          // update image description
                                          imageDescFocusNode.unfocus();
                                        },
                                      ),
                                      SizedBoxAppSpacing.smallY(),
                                      CustomElevatedButton(
                                        onPressed: () {
                                          // update image details
                                          onUpdateImageDetails!(
                                            imageData!,
                                            Gallery(
                                              imageTitle:
                                                  imageTitleTextCtrl.text,
                                              imageDescription:
                                                  imageDescTextCtrl.text,
                                            ),
                                          );

                                          // clear controllers
                                          imageTitleTextCtrl.clear();
                                          imageDescTextCtrl.clear();
                                          // close dialog
                                          Navigator.pop(context);
                                        },
                                        text: 'Update',
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      color: Theme.of(context).colorScheme.primaryContainer,
                      icon: LineIcon.editAlt(),
                    ),
                  ),
                  Flexible(
                    child: IconButton(
                      onPressed: onRemoveImage,
                      color: Theme.of(context).colorScheme.errorContainer,
                      icon: LineIcon.trash(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// tablet company gallery card
class _PickedTabletImageCard extends HookConsumerWidget {
  const _PickedTabletImageCard({
    this.imageData,
  });
  final ImageHelperModel? imageData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            imageData!.path!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(imageData!.imageDetails!.imageTitle!),
            subtitle: Text(imageData!.imageDetails!.imageDescription!),
          ),
        ],
      ),
    );
  }
}

// desktop company gallery card
class _PickedDesktopImageCard extends HookConsumerWidget {
  const _PickedDesktopImageCard({
    this.imageData,
  });
  final ImageHelperModel? imageData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            imageData!.path!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(imageData!.imageDetails!.imageTitle!),
            subtitle: Text(imageData!.imageDetails!.imageDescription!),
          ),
        ],
      ),
    );
  }
}

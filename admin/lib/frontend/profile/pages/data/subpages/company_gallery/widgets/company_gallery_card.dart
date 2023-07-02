import 'package:admin/lib.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class CompanyGalleryCard extends HookConsumerWidget {
  const CompanyGalleryCard({
    super.key,
    this.companyGallery,
    this.companyId,
  });
  final Gallery? companyGallery;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyGalleryCard(
        companyGallery: companyGallery,
        companyId: companyId,
      ),
      tablet: _TabletCompanyGalleryCard(
        companyGallery: companyGallery,
        companyId: companyId,
      ),
      desktop: _DesktopCompanyGalleryCard(
        companyGallery: companyGallery,
        companyId: companyId,
      ),
    );
  }
}

// mobile company gallery card
class _MobileCompanyGalleryCard extends HookConsumerWidget {
  const _MobileCompanyGalleryCard({
    this.companyGallery,
    this.companyId,
  });
  final Gallery? companyGallery;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          ExtendedImage.network(
            '${companyGallery?.imageUrl.toString()}',
            width: 100.w,
            height: 20.h,
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
                    height: 20.h,
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
          ListTile(
            title: DText(
              text: companyGallery!.imageTitle!,
            ),
            subtitle: DText(
              text: companyGallery!.imageDescription!,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: IconButton(
                    onPressed: () {},
                    color: Theme.of(context).colorScheme.primaryContainer,
                    icon: LineIcon.editAlt(),
                  ),
                ),
                Flexible(
                  child: IconButton(
                    onPressed: () async {
                      // delete image from firebase storage

                      await ref
                          .read(companyFirestoreControllerProvider.notifier)
                          .deleteGalleryImageFromFirestore(
                            gallery: companyGallery!,
                            companyId: companyId,
                          );
                    },
                    color: Theme.of(context).colorScheme.errorContainer,
                    icon: LineIcon.trash(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// tablet company gallery card
class _TabletCompanyGalleryCard extends HookConsumerWidget {
  const _TabletCompanyGalleryCard({
    this.companyGallery,
    this.companyId,
  });
  final Gallery? companyGallery;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            companyGallery!.imageUrl!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(companyGallery!.imageTitle!),
            subtitle: Text(companyGallery!.imageDescription!),
          ),
        ],
      ),
    );
  }
}

// desktop company gallery card
class _DesktopCompanyGalleryCard extends HookConsumerWidget {
  const _DesktopCompanyGalleryCard({
    this.companyGallery,
    this.companyId,
  });
  final Gallery? companyGallery;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            companyGallery!.imageUrl!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(companyGallery!.imageTitle!),
            subtitle: Text(companyGallery!.imageDescription!),
          ),
        ],
      ),
    );
  }
}

// picked image cards
class PickedCompanyGalleryCard extends HookConsumerWidget {
  const PickedCompanyGalleryCard({
    super.key,
    this.companyGallery,
  });
  final ImageHelperModel? companyGallery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _PickedMobileCompanyGalleryCard(
        companyGallery: companyGallery,
      ),
      tablet: _PickedTabletCompanyGalleryCard(
        companyGallery: companyGallery,
      ),
      desktop: _PickedDesktopCompanyGalleryCard(
        companyGallery: companyGallery,
      ),
    );
  }
}

// mobile company gallery card
class _PickedMobileCompanyGalleryCard extends HookConsumerWidget {
  const _PickedMobileCompanyGalleryCard({
    this.companyGallery,
  });
  final ImageHelperModel? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageTitleTextCtrl = useTextEditingController(
      text: companyGallery?.imageDetails?.imageTitle,
    );
    final imageDescTextCtrl = useTextEditingController(
      text: companyGallery?.imageDetails?.imageDescription,
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
                    '${companyGallery?.imageFile?.filePath}',
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
                    companyGallery!.bytes!,
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
                text: companyGallery!.imageDetails!.imageTitle != ''
                    ? companyGallery!.imageDetails!.imageTitle
                    : 'Edit image title',
              ),
              subtitle: DText(
                text: companyGallery?.imageDetails?.imageDescription ??
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
                                          ref
                                              .read(
                                                  imageControllerNotifierProvider
                                                      .notifier)
                                              .updateImageGalleryDetails(
                                                galleryDetails: Gallery(
                                                  imageTitle:
                                                      imageTitleTextCtrl.text,
                                                  imageDescription:
                                                      imageDescTextCtrl.text,
                                                ),
                                                theImage: companyGallery!,
                                              );
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
                      onPressed: () async {
                        // remove from list
                        ref
                            .read(imageControllerNotifierProvider.notifier)
                            .removeImageFromState(image: companyGallery!);
                      },
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
class _PickedTabletCompanyGalleryCard extends HookConsumerWidget {
  const _PickedTabletCompanyGalleryCard({
    this.companyGallery,
  });
  final ImageHelperModel? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            companyGallery!.path!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(companyGallery!.imageDetails!.imageTitle!),
            subtitle: Text(companyGallery!.imageDetails!.imageDescription!),
          ),
        ],
      ),
    );
  }
}

// desktop company gallery card
class _PickedDesktopCompanyGalleryCard extends HookConsumerWidget {
  const _PickedDesktopCompanyGalleryCard({
    this.companyGallery,
  });
  final ImageHelperModel? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            companyGallery!.path!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(companyGallery!.imageDetails!.imageTitle!),
            subtitle: Text(companyGallery!.imageDetails!.imageDescription!),
          ),
        ],
      ),
    );
  }
}

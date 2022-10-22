import 'dart:io';
import 'dart:ui';

import 'package:admin/lib.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class AddPickedImage extends HookConsumerWidget {
  const AddPickedImage({
    super.key,
    this.image,
  });
  final ImageHelperModel? image;
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
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: LineIcon.editAlt(),
                        onPressed: () {},
                      )
                    ]),
              )),
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
                            '''/ (${image!.imageFile!.width} x ${image!.imageFile!.height})''',
                        fontSize: 12.sp,
                      ),
                      DText(
                        text: image!.imageDetails!.imageTitle != ''
                            ? '''Image Name : ${image!.imageDetails!.imageTitle}'''
                            : 'Choose a name for this image',
                        fontSize: 12.sp,
                      ),
                      Flexible(
                        child: DText(
                          text: image!.imageDetails!.imageDescription != ''
                              ? '''Image Description : ${image!.imageDetails!.imageDescription}'''
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

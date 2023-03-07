import 'dart:io';

import 'package:admin/lib.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

// add company staff page consumer hook widget with app layout
class ManageLocalCompanyStaffPage extends HookConsumerWidget {
  const ManageLocalCompanyStaffPage({
    super.key,
    this.staffDetails,
  });
  final LocalCompanyStaffModel? staffDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localStaffState =
        ref.watch(companyStaffLocalControllerProvider(staffDetails));
    final imageState = ref.watch(imageHelperNotifierProvider);
    final localController =
        ref.read(companyStaffLocalControllerProvider(staffDetails).notifier);
    final imageController = ref.read(imageHelperNotifierProvider.notifier);
    return AppLayout(
      mobile: _MobileManageLocalCompanyStaffPage(
        staffDetails: staffDetails,
        localController: localController,
        imageController: imageController,
        imageState: imageState,
        localStaffState: localStaffState,
      ),
      tablet: _TabletManageLocalCompanyStaffPage(
        staffDetails: staffDetails,
        localController: localController,
        imageController: imageController,
        imageState: imageState,
        localStaffState: localStaffState,
      ),
      desktop: _DesktopManageLocalCompanyStaffPage(
        staffDetails: staffDetails,
        localController: localController,
        imageController: imageController,
        imageState: imageState,
        localStaffState: localStaffState,
      ),
    );
  }
}

// mobile add company staff page
class _MobileManageLocalCompanyStaffPage extends HookConsumerWidget {
  const _MobileManageLocalCompanyStaffPage({
    this.staffDetails,
    this.localController,
    this.imageController,
    this.imageState,
    this.localStaffState,
  });
  final LocalCompanyStaffModel? staffDetails;
  final CompanyStaffLocalControllerNotifier? localController;
  final ImageHelperNotifier? imageController;
  final AsyncValue<ImageHelperModel?>? imageState;
  final LocalCompanyStaffModel? localStaffState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cellNoFocusNode = useFocusNode();
    final formKey = GlobalKey<FormState>();
    final cellNoTextController = useTextEditingController();
    final editImageDetails = useState(false);
    // focus nodes for image editing
    final imageTitleFocusNode = useFocusNode();
    final imageDescriptionFocusNode = useFocusNode();

    return Scaffold(
      appBar: AppBar(
        title: DText(
          text:
              localStaffState?.isEditing == false ? 'Add Staff' : 'Edit Staff',
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Stack(
                        children: [
                          // image picker
                          if (imageState?.asData?.value != null)
                            imageState!.when(
                              data: (data) {
                                return data?.path != null
                                    ? Image.file(
                                        File(data!.path!),
                                        fit: BoxFit.fill,
                                        height: 200,
                                        width: 100.w,
                                      )
                                    : SizedBox(
                                        height: 200,
                                        width: 100.w,
                                        child: ColoredBox(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                          child: Center(
                                            child: DText(
                                              text:
                                                  'No image selected\n Please select an image',
                                              textAlign: TextAlign.center,
                                              textColor: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer,
                                            ),
                                          ),
                                        ),
                                      );
                              },
                              loading: () => SizedBox(
                                height: 200,
                                width: 100.w,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              error: (error, stack) => SizedBox(
                                height: 200,
                                width: 100.w,
                                child: ColoredBox(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                  child: Center(
                                    child: DText(
                                      text: error.toString(),
                                      textColor: Theme.of(context)
                                          .colorScheme
                                          .onErrorContainer,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else if (localStaffState?.image?.path != null &&
                              localStaffState?.image?.path != '')
                            ExtendedImage.file(
                              File(localStaffState?.image?.path ?? ''),
                              height: 200,
                              width: 100.w,
                            )
                          else
                            SizedBox(
                              height: 200,
                              width: 100.w,
                              child: ColoredBox(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                child: Center(
                                  child: DText(
                                    text:
                                        'No image selected\n Please select an image',
                                    textAlign: TextAlign.center,
                                    textColor: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                                ),
                              ),
                            ),
                          // image picker button
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: TextButton.icon(
                              onPressed: () async {
                                // pick image
                                final image = await imageController?.pickImage(
                                  imageSource: ImageSource.gallery,
                                );
                                if (image != null) {
                                  // update image
                                  localController
                                      ?.setCompanyStaffImage(image.value);
                                }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.6),
                              ),
                              icon: LineIcon.image(
                                color: Theme.of(context).colorScheme.background,
                              ),
                              label: DText(
                                text: 'Select Image',
                                textColor:
                                    Theme.of(context).colorScheme.background,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (imageState != null)
                            if (imageState?.value != null)
                              if (imageState!.value?.path != null)
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  child: TextButton.icon(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.6),
                                    ),
                                    onPressed: () async {
                                      // remove image
                                      // localController?.removeCompanyStaffImage();

                                      // show edit image details dialog
                                      // editImageDetails.value = true;
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    focusNode:
                                                        imageTitleFocusNode,
                                                    initialValue:
                                                        localStaffState
                                                                ?.image
                                                                ?.imageDetails
                                                                ?.imageTitle ??
                                                            '',
                                                    decoration: InputDecoration(
                                                      labelText: 'Image name',
                                                      labelStyle:
                                                          GoogleFonts.dosis(),
                                                      border:
                                                          const OutlineInputBorder(),
                                                    ),
                                                    onChanged: (value) {
                                                      // update image title
                                                      localController
                                                          ?.updateImageTitle(
                                                              value);
                                                    },
                                                  ),
                                                  SizedBoxAppSpacing.smallY(),
                                                  TextFormField(
                                                    initialValue: localStaffState
                                                            ?.image
                                                            ?.imageDetails
                                                            ?.imageDescription ??
                                                        '',
                                                    maxLength: 120,
                                                    maxLines: 3,
                                                    minLines: 1,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Image description',
                                                      labelStyle:
                                                          GoogleFonts.dosis(),
                                                      border:
                                                          const OutlineInputBorder(),
                                                    ),
                                                    onChanged: (value) {
                                                      // update image description
                                                      localController
                                                          ?.updateImageDescription(
                                                              value);
                                                    },
                                                  ),
                                                  // SizedBoxAppSpacing.smallY(),
                                                  // CustomElevatedButton(
                                                  //   onPressed: () {
                                                  //     // update image details
                                                  //     localController?.updateImageTitle(imageTitle)
                                                  //   },
                                                  //   text: 'Update',
                                                  //   height: 50,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    label: DText(
                                      text: 'Edit image',
                                      textColor: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    icon: LineIcon.editAlt(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBoxAppSpacing.smallY(),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: 100.w,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // drop down button with title values e.g Mr, Mrs, Miss
                                Flexible(
                                  child: DropdownButton<String>(
                                    itemHeight: 76,
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'Choose title',
                                        child: DText(
                                          text: 'Choose title',
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Mr',
                                        child: DText(
                                          text: 'Mr',
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Mrs',
                                        child: DText(
                                          text: 'Mrs',
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Miss',
                                        child: DText(
                                          text: 'Miss',
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      // update company staff title
                                      localController?.updateTittle(value);
                                    },
                                    value:
                                        localStaffState?.staffDetails?.title ??
                                            'Choose title',
                                    alignment: AlignmentDirectional.centerStart,
                                    isExpanded: true,
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: TextFormField(
                                    initialValue: localStaffState
                                            ?.staffDetails?.fullName ??
                                        '',
                                    decoration: InputDecoration(
                                      labelText: 'Full Name',
                                      border: const OutlineInputBorder(),
                                      labelStyle: GoogleFonts.dosis(),
                                    ),
                                    onChanged: (value) {
                                      // update company staff name
                                      localController
                                          ?.updateCompanyStaffName(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBoxAppSpacing.smallY(),
                          TextFormField(
                            initialValue:
                                localStaffState?.staffDetails?.email ?? '',
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: const OutlineInputBorder(),
                              labelStyle: GoogleFonts.dosis(),
                            ),
                            onChanged: (value) {
                              // update email
                              localController?.updateCompanyStaffEmail(value);
                            },
                          ),
                          SizedBoxAppSpacing.smallY(),
                          TextFormField(
                            initialValue:
                                localStaffState?.staffDetails?.jobTitle ?? '',
                            decoration: InputDecoration(
                              labelStyle: GoogleFonts.dosis(),
                              labelText: 'Job title',
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              // update job title
                              localController
                                  ?.updateCompanyStaffJobTitle(value);
                            },
                          ),
                          SizedBoxAppSpacing.smallY(),
                          TextFormField(
                            initialValue:
                                localStaffState?.staffDetails?.jobDescription ??
                                    '',
                            decoration: InputDecoration(
                              labelStyle: GoogleFonts.dosis(),
                              labelText: 'Job description',
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              // update job description
                              localController?.updateJobDescription(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBoxAppSpacing.smallY(),
                    Container(
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
                                if (localStaffState?.staffDetails?.phoneNos !=
                                    null)
                                  ...localStaffState!.staffDetails!.phoneNos!
                                      .map(
                                    (phoneNo) => Chip(
                                      label: DText(
                                        text: phoneNo,
                                      ),
                                      deleteIcon: LineIcon.trash(
                                        size: 12.sp,
                                      ),
                                      onDeleted: () {
                                        // delete from list flutter object
                                        //TODO: delete phone no from list
                                        localController?.deletePhoneNo(phoneNo);
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: TextFormField(
                              controller: cellNoTextController,
                              focusNode: cellNoFocusNode,
                              decoration: InputDecoration(
                                filled: true,
                                hintText: 'Input cellphone number here',
                                hintStyle: GoogleFonts.dosis(),
                              ),
                              validator: (value) {
                                if (cellNoTextController.text.trim().isEmpty) {
                                  return 'Please enter cellphone number';
                                }
                                // check if input matches a phone number
                                if (!RegExp(r'^\+?\d+$').hasMatch(
                                  cellNoTextController.text.trim(),
                                )) {
                                  return 'Please enter valid number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                // check if cellphone number input field is focused on
                                if (cellNoFocusNode.hasFocus) {
                                  // perform form validations on input changes
                                  formKey.currentState?.validate();
                                }
                              },
                              onFieldSubmitted: (value) {
                                // submit only if text controller is not empty
                                localController?.updateCompanyStaffPhoneNumbers(
                                  cellNoTextController.text.trim(),
                                );

                                value = '';
                                cellNoTextController.clear();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBoxAppSpacing.smallY(),
                    CustomElevatedButton(
                      text: localStaffState?.isEditing == true
                          ? 'Update Staff'
                          : 'Save staff',
                      onPressed: () {
                        // add company staff to database
                        localStaffState?.isEditing == true
                            ? ref
                                .read(
                                    multipleCompanyStaffLocalControllerProvider
                                        .notifier)
                                .updateCompanyStaff(
                                  companyStaff: staffDetails,
                                  newCompanyStaff: localStaffState,
                                  index: localStaffState!.index!,
                                )
                            : ref
                                .read(
                                    multipleCompanyStaffLocalControllerProvider
                                        .notifier)
                                .addCompanyStaff(
                                  companyStaff: localStaffState,
                                );
                        // navigate to company staff page
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// tablet add company staff page
class _TabletManageLocalCompanyStaffPage extends HookConsumerWidget {
  const _TabletManageLocalCompanyStaffPage({
    this.staffDetails,
    this.localController,
    this.imageController,
    this.imageState,
    this.localStaffState,
  });
  final LocalCompanyStaffModel? staffDetails;
  final CompanyStaffLocalControllerNotifier? localController;
  final ImageHelperNotifier? imageController;
  final AsyncValue<ImageHelperModel?>? imageState;
  final LocalCompanyStaffModel? localStaffState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          staffDetails == null ? 'Add Staff' : 'Edit Staff',
        ),
      ),
      //TODO: fix tablet layout
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       // image
      //       _Image(
      //         imageController: imageController,
      //         imageState: imageState,
      //         localStaffState: localStaffState,
      //       ),
      //       // name
      //       _Name(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // email
      //       _Email(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // phone
      //       _Phone(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // role
      //       _Role(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // save button
      //       _SaveButton(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

// desktop add company staff page
class _DesktopManageLocalCompanyStaffPage extends HookConsumerWidget {
  const _DesktopManageLocalCompanyStaffPage({
    this.staffDetails,
    this.localController,
    this.imageController,
    this.imageState,
    this.localStaffState,
  });
  final LocalCompanyStaffModel? staffDetails;
  final CompanyStaffLocalControllerNotifier? localController;
  final ImageHelperNotifier? imageController;
  final AsyncValue<ImageHelperModel?>? imageState;
  final LocalCompanyStaffModel? localStaffState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          staffDetails == null ? 'Add Staff' : 'Edit Staff',
        ),
      ),
      //TODO: fix this
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       // image
      //       _Image(
      //         imageController: imageController,
      //         imageState: imageState,
      //         localStaffState: localStaffState,
      //       ),
      //       // name
      //       _Name(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // email
      //       _Email(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // phone
      //       _Phone(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // role
      //       _Role(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // save button
      //       _SaveButton(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

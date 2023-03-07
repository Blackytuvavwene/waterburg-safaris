import 'dart:io';

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class EditStaffControllerNotifier extends StateNotifier<CompanyStaff?> {
  EditStaffControllerNotifier({
    this.initialStaffDetails,
  }) : super(initialStaffDetails);

  //initial staff details
  final CompanyStaff? initialStaffDetails;

  void setStaff(CompanyStaff? staff) {
    state = staff;
  }

  // update staff full name
  void updateStaffFullName(String? fullName) {
    state = state?.copyWith(
      fullName: fullName,
    );
  }

  // update staff email
  void updateStaffEmail(String? email) {
    state = state?.copyWith(
      email: email,
    );
  }

  // update staff phone nos
  void updateStaffPhoneNos(String phoneNos) {
    state = state?.copyWith(
      phoneNos: [
        ...state?.phoneNos ?? [],
        phoneNos,
      ],
    );
  }

  // update staff job title
  void updateStaffJobTitle(String? jobTitle) {
    state = state?.copyWith(
      jobTitle: jobTitle,
    );
  }

  // update staff job description
  void updateStaffJobDescription(String? jobDescription) {
    state = state?.copyWith(
      jobDescription: jobDescription,
    );
  }

  // update staff title
  void updateStaffTitle(String? title) {
    state = state?.copyWith(
      title: title,
    );
  }

  // delete phoneNo from list of phoneNos
  void deletePhoneNoFromList(String phoneNo) {
    state = state?.copyWith(
      phoneNos: [
        ...state?.phoneNos?.where((element) => element != phoneNo).toList() ??
            [],
      ],
    );
  }
}

// staff firestore update controller provider
class StaffUpdateControllerNotifier
    extends StateNotifier<AsyncValue<CompanyStaff>> {
  StaffUpdateControllerNotifier()
      : super(
          AsyncData(
            CompanyStaff(),
          ),
        );

// update staff details in firestore
  Future<AsyncValue<CompanyStaff?>?> updateStaffDetails({
    required CompanyStaff staff,
    required CompanyStaff newStaff,
    required ImageHelperModel? image,
    required String docId,
  }) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() async {
      // update image only if new image is not null
      if (image != null) {
// first delete old image from firebase storage
        await ImageHelpers.deleteImageFromFirebaseStorageByDownloadUrl(
            imageUrl: staff.imageUrl!);
        // upload new image to firebase storage
        final newImageUrl = await ImageHelpers.addImageToFirebaseStorage(
          image: image.xFile!,
          path: '$docId/staff/${newStaff.fullName}}',
        );

        // create new staff details
        final newStaffData = CompanyStaff(
          fullName: newStaff.fullName,
          email: newStaff.email,
          phoneNos: newStaff.phoneNos,
          imageUrl: newImageUrl,
          jobDescription: newStaff.jobDescription,
          jobTitle: newStaff.jobTitle,
          title: newStaff.title,
        );

        // update staff details in firestore
        final data = await FirestoreHelper.deleteAndUpdateInDocList<
            Map<String, dynamic>>(
          docId: docId,
          docPath: 'aboutCompany',
          data: staff.toJson(),
          newData: newStaffData.toJson(),
          query: 'companyStaff',
        );
        return CompanyStaff.fromJson(data);
      } else {
        // create new staff details
        final newStaffData = CompanyStaff(
          fullName: newStaff.fullName,
          email: newStaff.email,
          phoneNos: newStaff.phoneNos,
          imageUrl: staff.imageUrl,
          jobDescription: newStaff.jobDescription,
          jobTitle: newStaff.jobTitle,
          title: newStaff.title,
        );

        // update staff details in firestore
        final data = await FirestoreHelper.deleteAndUpdateInDocList<
            Map<String, dynamic>>(
          docId: docId,
          docPath: 'aboutCompany',
          data: staff.toJson(),
          newData: newStaffData.toJson(),
          query: 'companyStaff',
        );

        return CompanyStaff.fromJson(data);
      }
    });
  }
}

// staff firestore update controller provider
final staffUpdateControllerProvider = StateNotifierProvider.autoDispose<
    StaffUpdateControllerNotifier, AsyncValue<CompanyStaff>>(
  (ref) => StaffUpdateControllerNotifier(),
);

// staff image control provider
final imageControlProvider =
    StateProvider.autoDispose<ImageHelperModel?>((ref) {
  // get image helper notifier
  // final imageHelperNotifier = ref.watch(imageHelperNotifierProvider.notifier);

  // get image from gallery
  // final newImage =imageHelperNotifier.pickImage(imageSource: ImageSource.gallery).then((value) => value.asData?.value);
  return null;
});

// edit staff controller provider
final editStaffControllerProvider = StateNotifierProvider.autoDispose
    .family<EditStaffControllerNotifier, CompanyStaff?, CompanyStaff?>(
  (ref, staff) => EditStaffControllerNotifier(
    initialStaffDetails: staff,
  ),
);

// edit staff details hook consumer widget with app layout
class EditStaffDetails extends HookConsumerWidget {
  const EditStaffDetails({
    Key? key,
    this.companyStaff,
    this.companyId,
  }) : super(key: key);
  final CompanyStaff? companyStaff;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStaff = ref.watch(
      editStaffControllerProvider(
        companyStaff,
      ),
    );
    final formKey = GlobalKey<FormState>();
    final editImage = useState(false);
    final imageNotifier = ref.read(imageHelperNotifierProvider.notifier);
    final imageState = ref.watch(imageHelperNotifierProvider);

    final staffController = ref.read(
      editStaffControllerProvider(
        companyStaff,
      ).notifier,
    );

    ref.listen<AsyncValue<CompanyStaff?>>(
      staffUpdateControllerProvider,
      (AsyncValue<CompanyStaff?>? previous, AsyncValue<CompanyStaff?> next) {
        next.when(data: (data) {
          return EasyLoading.showSuccess('${data?.fullName} updated');
        }, error: (error, stackTrace) {
          return EasyLoading.showError('Error updating staff details');
        }, loading: () {
          return EasyLoading.show(status: 'Updating staff...');
        });
      },
    );

    return AppLayout(
      mobile: _MobileEditStaffDetails(
        companyStaff: currentStaff,
        formKey: formKey,
        imageNotifier: imageNotifier,
        companyId: companyId,
        oldStaffDetails: companyStaff,
        imageState: imageState,
        staffController: staffController,
      ),
      tablet: _TabletEditStaffDetails(
        companyStaff: currentStaff,
        formKey: formKey,
        imageNotifier: imageNotifier,
        companyId: companyId,
        imageState: imageState,
        staffController: staffController,
      ),
      desktop: _DesktopEditStaffDetails(
        companyStaff: currentStaff,
        formKey: formKey,
        imageNotifier: imageNotifier,
        companyId: companyId,
        imageState: imageState,
        staffController: staffController,
      ),
    );
  }
}

// mobile edit staff details
class _MobileEditStaffDetails extends HookConsumerWidget {
  const _MobileEditStaffDetails({
    Key? key,
    this.companyStaff,
    this.formKey,
    this.imageNotifier,
    this.companyId,
    this.oldStaffDetails,
    this.imageState,
    this.staffController,
  }) : super(key: key);
  final CompanyStaff? companyStaff;
  final GlobalKey<FormState>? formKey;
  final ImageHelperNotifier? imageNotifier;
  final String? companyId;
  final CompanyStaff? oldStaffDetails;
  final AsyncValue<ImageHelperModel?>? imageState;
  final EditStaffControllerNotifier? staffController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cellNoTextController = useTextEditingController();
    final fullNameFocusNode = useFocusNode();
    final emailFocusNode = useFocusNode();
    final jobTitleFocusNode = useFocusNode();
    final jobDescriptionFocusNode = useFocusNode();
    final cellNoFocusNode = useFocusNode();

    // formkey
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const DText(
          text: 'Edit Staff Details',
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              //TODO: update staff details in mobile view
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey,
                  backgroundImage: imageState?.when(
                    data: (data) {
                      // final image = data?.path != null
                      //     ?  Image(
                      //         File(data!.path.toString()),
                      //       )
                      //     : Image(
                      //         '${companyStaff?.value?.imageUrl.toString()}');
                      if (data?.path != null) {
                        return FileImage(
                          File(
                            data!.path.toString(),
                          ),
                        );
                      } else {
                        return NetworkImage(
                            '${companyStaff?.imageUrl.toString()}');
                      }
                    },
                    error: (error, stackTrace) {
                      return const AssetImage('assets/images/error.png');
                    },
                    loading: () {
                      return const AssetImage('assets/images/loading.png');
                    },
                  ),
                  child: IconButton(
                    color: Theme.of(context).colorScheme.onBackground,
                    iconSize: 32.sp,
                    onPressed: () async {
                      // TODO: add image in mobile view
                      await ref
                          .read(imageHelperNotifierProvider.notifier)
                          .pickImage(imageSource: ImageSource.gallery);
                    },
                    icon: LineIcon.camera(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                          staffController?.updateStaffTitle(value);
                        },
                        value: companyStaff?.title ?? 'Choose title',
                        alignment: AlignmentDirectional.centerStart,
                        isExpanded: true,
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: TextFormField(
                        focusNode: fullNameFocusNode,
                        initialValue: companyStaff?.fullName,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: const OutlineInputBorder(),
                          labelStyle: GoogleFonts.dosis(),
                        ),
                        onChanged: (value) {
                          // update company staff name
                          staffController?.updateStaffFullName(value);
                        },
                        onFieldSubmitted: (value) {
                          // move to email field
                          emailFocusNode.requestFocus();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBoxAppSpacing.smallY(),
              TextFormField(
                initialValue: companyStaff?.email,
                focusNode: emailFocusNode,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: const OutlineInputBorder(),
                  labelStyle: GoogleFonts.dosis(),
                ),
                onChanged: (value) {
                  // update email
                  staffController?.updateStaffEmail(value);
                },
                onFieldSubmitted: (value) {
                  // move to job title field
                  jobTitleFocusNode.requestFocus();
                },
              ),
              SizedBoxAppSpacing.smallY(),
              TextFormField(
                initialValue: companyStaff?.jobTitle,
                focusNode: jobTitleFocusNode,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.dosis(),
                  labelText: 'Job title',
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // update job title
                  staffController?.updateStaffJobTitle(value);
                },
                onFieldSubmitted: (value) {
                  // move to job description field
                  jobDescriptionFocusNode.requestFocus();
                },
              ),
              SizedBoxAppSpacing.smallY(),
              TextFormField(
                focusNode: jobDescriptionFocusNode,
                maxLines: 5,
                maxLength: 100,
                minLines: 1,
                initialValue: companyStaff?.jobDescription,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.dosis(),
                  labelText: 'Job description',
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // update job description
                  staffController?.updateStaffJobDescription(value);
                },
                onFieldSubmitted: (value) {
                  // change focus to cell no
                  cellNoFocusNode.requestFocus();
                },
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
                          if (companyStaff?.phoneNos != null)
                            ...companyStaff!.phoneNos!.map(
                              (phoneNo) => Chip(
                                label: DText(
                                  text: phoneNo,
                                ),
                                deleteIcon: LineIcon.trash(
                                  size: 12.sp,
                                ),
                                onDeleted: () {
                                  // delete from list f phoneNos
                                  staffController
                                      ?.deletePhoneNoFromList(phoneNo);
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
                        textInputAction: TextInputAction.done,
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
                          staffController?.updateStaffPhoneNos(
                            cellNoTextController.text.trim(),
                          );

                          // value = '';
                          cellNoTextController.clear();
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBoxAppSpacing.smallY(),
              DText(
                text: companyStaff?.toJson().toString(),
              ),
              CustomElevatedButton(
                text: 'Update staff',
                onPressed: () async {
                  // add company staff to database
                  await ref
                      .read(staffUpdateControllerProvider.notifier)
                      .updateStaffDetails(
                        staff: oldStaffDetails!,
                        newStaff: companyStaff!,
                        docId: companyId!,
                        image: imageState?.asData?.value,
                      );
                  // navigate to company staff page
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// tablet edit staff details
class _TabletEditStaffDetails extends HookConsumerWidget {
  const _TabletEditStaffDetails({
    Key? key,
    this.companyStaff,
    this.formKey,
    this.imageNotifier,
    this.companyId,
    this.imageState,
    this.staffController,
  }) : super(key: key);
  final CompanyStaff? companyStaff;
  final GlobalKey<FormState>? formKey;
  final ImageHelperNotifier? imageNotifier;
  final String? companyId;
  final AsyncValue<ImageHelperModel?>? imageState;
  final EditStaffControllerNotifier? staffController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Staff Details'),
        actions: [
          IconButton(
            onPressed: () {
              //TODO: update staff details in tablet view
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    backgroundImage: companyStaff?.imageUrl == null
                        ? null
                        : NetworkImage(companyStaff?.imageUrl ?? ''),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        // TODO: add image in tablet view
                      },
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: companyStaff?.fullName,
                onChanged: (value) {
                  companyStaff?.copyWith(fullName: value);
                },
                decoration: const InputDecoration(
                  labelText: 'Staff Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: companyStaff?.jobTitle,
                onChanged: (value) {
                  companyStaff?.copyWith(jobTitle: value);
                },
                decoration: const InputDecoration(
                  labelText: 'Staff Role',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// desktop edit staff details
class _DesktopEditStaffDetails extends HookConsumerWidget {
  const _DesktopEditStaffDetails({
    Key? key,
    this.companyStaff,
    this.formKey,
    this.imageNotifier,
    this.companyId,
    this.imageState,
    this.staffController,
  }) : super(key: key);
  final CompanyStaff? companyStaff;
  final GlobalKey<FormState>? formKey;
  final ImageHelperNotifier? imageNotifier;
  final String? companyId;
  final AsyncValue<ImageHelperModel?>? imageState;
  final EditStaffControllerNotifier? staffController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Staff Details'),
        actions: [
          IconButton(
            onPressed: () {
              //TODO: update staff details in desktop view
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            DText(
              text: companyStaff?.fullName,
            ),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    backgroundImage: companyStaff?.imageUrl == null
                        ? null
                        : NetworkImage(companyStaff?.imageUrl.toString() ?? ''),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        // TODO: pick image
                      },
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: companyStaff?.fullName,
                onChanged: (value) {
                  // update staff name
                  staffController?.updateStaffFullName(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Staff Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: companyStaff?.jobTitle,
                onChanged: (value) {
                  // update staff job title
                  staffController?.updateStaffJobTitle(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Staff Role',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

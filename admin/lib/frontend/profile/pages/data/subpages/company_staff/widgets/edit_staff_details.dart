import 'dart:io';

import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class EditStaffControllerNotifier
    extends StateNotifier<AsyncValue<CompanyStaff>> {
  EditStaffControllerNotifier() : super(AsyncData(CompanyStaff()));

  void setStaff(CompanyStaff? staff) {
    state = AsyncValue.data(staff!);
  }

  // update staff details in firestore
  Future<AsyncValue<CompanyStaff>?> updateStaffDetails({
    required CompanyStaff staff,
    required CompanyStaff newStaff,
    required ImageHelperModel image,
    required String docId,
  }) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() async {
      // upload new image to firebase storage
      final newImageUrl = await ImageHelpers.addImageToFirebaseStorage(
          image: image.xFile!, path: 'staffImages');

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
      final db = FirebaseFirestore.instance;
      final docRef = db.collection('aboutCompany').doc(docId);
      return db.runTransaction((transaction) {
        return transaction.get(docRef).then((value) {
          transaction.update(docRef, {
            'companyStaff': FieldValue.arrayRemove([staff.toJson()]),
          });
          transaction.update(docRef, {
            'companyStaff': FieldValue.arrayUnion([newStaffData.toJson()]),
          });
          return newStaff;
        });
      });
    });
  }
}

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
final editStaffControllerProvider = StateNotifierProvider<
    EditStaffControllerNotifier,
    AsyncValue<CompanyStaff>>((ref) => EditStaffControllerNotifier());

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
    final currentStaff = useState(companyStaff);
    final formKey = GlobalKey<FormState>();
    final editImage = useState(false);
    final imageNotifier = ref.watch(imageHelperNotifierProvider);
    final newImage = ref.watch(imageControlProvider);

    final staffController = ref.read(editStaffControllerProvider.notifier);

    ref.listen<AsyncValue<CompanyStaff>>(
      editStaffControllerProvider,
      (AsyncValue<CompanyStaff>? previous, AsyncValue<CompanyStaff> next) {
        next.when(data: (data) {
          return EasyLoading.showSuccess('${data.fullName} updated');
        }, error: (error, stackTrace) {
          return EasyLoading.showError('Error updating staff details');
        }, loading: () {
          return EasyLoading.show(status: 'Updating staff...');
        });
      },
    );

    void updateStaffDetails() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        staffController.updateStaffDetails(
          staff: companyStaff!,
          newStaff: currentStaff.value!,
          image: newImage!,
          docId: 'companyStaff',
        );
      }
    }

    return AppLayout(
      mobile: _MobileEditStaffDetails(
        companyStaff: currentStaff,
        formKey: formKey,
        updateStaffDetails: updateStaffDetails,
        imageNotifier: imageNotifier,
        companyId: companyId,
      ),
      tablet: _TabletEditStaffDetails(
        companyStaff: currentStaff,
        formKey: formKey,
        updateStaffDetails: updateStaffDetails,
        imageNotifier: imageNotifier,
        companyId: companyId,
      ),
      desktop: _DesktopEditStaffDetails(
        companyStaff: currentStaff,
        formKey: formKey,
        updateStaffDetails: updateStaffDetails,
        imageNotifier: imageNotifier,
        companyId: companyId,
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
    this.updateStaffDetails,
    this.imageNotifier,
    this.companyId,
  }) : super(key: key);
  final ValueNotifier<CompanyStaff?>? companyStaff;
  final GlobalKey<FormState>? formKey;
  final VoidCallback? updateStaffDetails;
  final AsyncValue<ImageHelperModel?>? imageNotifier;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey,
                backgroundImage: imageNotifier?.when(
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
                          '${companyStaff?.value?.imageUrl.toString()}');
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: companyStaff?.value?.fullName,
                onChanged: (value) {
                  companyStaff?.value?.copyWith(fullName: value);
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
                initialValue: companyStaff?.value?.jobTitle,
                onChanged: (value) {
                  companyStaff?.value = companyStaff?.value?.copyWith(
                    jobTitle: value,
                  );
                },
                onFieldSubmitted: (value) {
                  companyStaff?.value?.copyWith(jobTitle: 'CEO');
                  companyStaff?.notifyListeners();
                },
                onEditingComplete: () {
                  companyStaff?.value?.copyWith(jobTitle: 'CEO');
                },
                decoration: const InputDecoration(
                  labelText: 'Staff Role',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            DText(
              text: companyStaff?.value?.jobTitle,
            )
          ],
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
    this.updateStaffDetails,
    this.imageNotifier,
    this.companyId,
  }) : super(key: key);
  final ValueNotifier<CompanyStaff?>? companyStaff;
  final GlobalKey<FormState>? formKey;
  final VoidCallback? updateStaffDetails;
  final AsyncValue<ImageHelperModel?>? imageNotifier;
  final String? companyId;
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
                    backgroundImage: companyStaff?.value?.imageUrl == null
                        ? null
                        : NetworkImage(companyStaff?.value?.imageUrl ?? ''),
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
                initialValue: companyStaff?.value?.fullName,
                onChanged: (value) {
                  companyStaff?.value?.copyWith(fullName: value);
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
                initialValue: companyStaff?.value?.jobTitle,
                onChanged: (value) {
                  companyStaff?.value?.copyWith(jobTitle: value);
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
    this.updateStaffDetails,
    this.imageNotifier,
    this.companyId,
  }) : super(key: key);
  final ValueNotifier<CompanyStaff?>? companyStaff;
  final GlobalKey<FormState>? formKey;
  final VoidCallback? updateStaffDetails;
  final AsyncValue<ImageHelperModel?>? imageNotifier;
  final String? companyId;
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
              text: companyStaff?.value?.fullName,
            ),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    backgroundImage: companyStaff?.value?.imageUrl == null
                        ? null
                        : NetworkImage(
                            companyStaff?.value?.imageUrl.toString() ?? ''),
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
                initialValue: companyStaff?.value?.fullName,
                onChanged: (value) {
                  companyStaff?.value = companyStaff?.value?.copyWith(
                    fullName: value,
                  );
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
                initialValue: companyStaff?.value?.jobTitle,
                onChanged: (value) {
                  companyStaff?.value = companyStaff?.value?.copyWith(
                    jobTitle: value,
                  );
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

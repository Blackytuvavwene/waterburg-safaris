import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    required String docId,
  }) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() {
      final db = FirebaseFirestore.instance;
      final docRef = db.collection('aboutCompany').doc(docId);
      return db.runTransaction((transaction) {
        return transaction.get(docRef).then((value) {
          transaction.update(docRef, {
            'companyStaff': FieldValue.arrayRemove([staff.toJson()]),
          });
          transaction.update(docRef, {
            'companyStaff': FieldValue.arrayUnion([newStaff.toJson()]),
          });
          return newStaff;
        });
      });
    });
  }
}

// edit staff controller provider
final editStaffControllerProvider = StateNotifierProvider<
    EditStaffControllerNotifier,
    AsyncValue<CompanyStaff>>((ref) => EditStaffControllerNotifier());

// edit staff details hook consumer widget with app layout
class EditStaffDetails extends HookConsumerWidget {
  const EditStaffDetails({
    Key? key,
    this.companyStaff,
  }) : super(key: key);
  final CompanyStaff? companyStaff;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStaff = useState(companyStaff);
    final formKey = GlobalKey<FormState>();

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
          docId: 'companyStaff',
        );
      }
    }

    return AppLayout(
      mobile: _MobileEditStaffDetails(
        companyStaff: currentStaff,
        formKey: formKey,
        updateStaffDetails: updateStaffDetails,
      ),
      tablet: _TabletEditStaffDetails(
        companyStaff: currentStaff,
        formKey: formKey,
        updateStaffDetails: updateStaffDetails,
      ),
      desktop: _DesktopEditStaffDetails(
        companyStaff: currentStaff,
        formKey: formKey,
        updateStaffDetails: updateStaffDetails,
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
  }) : super(key: key);
  final ValueNotifier<CompanyStaff?>? companyStaff;
  final GlobalKey<FormState>? formKey;
  final VoidCallback? updateStaffDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Staff Details'),
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
                        // TODO: add image in mobile view
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
  }) : super(key: key);
  final ValueNotifier<CompanyStaff?>? companyStaff;
  final GlobalKey<FormState>? formKey;
  final VoidCallback? updateStaffDetails;
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
  }) : super(key: key);
  final ValueNotifier<CompanyStaff?>? companyStaff;
  final GlobalKey<FormState>? formKey;
  final VoidCallback? updateStaffDetails;
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
                  companyStaff?.value?.fullName = value;
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
                  companyStaff?.value?.jobTitle = value;
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

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';

class ProfileDataPage extends HookConsumerWidget {
  const ProfileDataPage({
    Key? key,
    this.company,
  }) : super(key: key);
  final Company? company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch company details state from firestore
    final companyDetails = ref.watch(companyNotifierProvider(company));
    // watch edit company details state
    final editCompanyDetails = ref.watch(editCompanyProvider.notifier);
    // watch company details state notifier
    final companyDetailsState =
        ref.watch(companyNotifierProvider(company).notifier);
    // watch image controller notifier
    final imageControllerNotifier =
        ref.watch(imageControllerNotifierProvider.notifier);
    // watch image database controller notifier
    final newImages = ref.watch(imageControllerNotifierProvider);
    // watch multiple local company staff state
    final localStaffState =
        ref.watch(multipleCompanyStaffLocalControllerProvider);
    return AppLayout(
      mobile: _MobileProfileDataPage(
        company: companyDetails,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
        oldDetails: company,
        imageControllerNotifier: imageControllerNotifier,
        newImages: newImages,
        localStaffState: localStaffState,
      ),
      tablet: _TabletProfileDataPage(
        company: companyDetails,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
        oldDetails: company,
        imageControllerNotifier: imageControllerNotifier,
        newImages: newImages,
        localStaffState: localStaffState,
      ),
      desktop: _DesktopProfileDataPage(
        company: companyDetails,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
        oldDetails: company,
        imageControllerNotifier: imageControllerNotifier,
        newImages: newImages,
        localStaffState: localStaffState,
      ),
    );
  }
}

// mobile profile page
class _MobileProfileDataPage extends HookConsumerWidget {
  const _MobileProfileDataPage({
    Key? key,
    this.company,
    this.companyDetailsState,
    this.editCompanyDetails,
    this.oldDetails,
    this.imageControllerNotifier,
    this.newImages,
    this.localStaffState,
  }) : super(key: key);
  final Company? company;
  final CompanyNotifier? companyDetailsState;
  final StateController<bool>? editCompanyDetails;
  final Company? oldDetails;
  final ImageControllerNotifier? imageControllerNotifier;
  final AsyncValue<List<ImageHelperModel>?>? newImages;
  final List<LocalCompanyStaffModel?>? localStaffState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // listen to image database changes
    ref.listen(imageDatabaseControllerNotifierProvider,
        (AsyncValue<List<Gallery>?>? previous,
            AsyncValue<List<Gallery>?>? next) {
      return next?.whenOrNull(
        data: (data) {
          // show upload success easyloading toast when data is not null
          if (data != null) {
            EasyLoading.showSuccess('Upload successful');
          }
        },
        loading: () {
          // show upload progress easyloading toast when loading
          EasyLoading.showInfo('Uploading images...');
        },
        error: (e, s) {
          // show error on upload fail
          EasyLoading.showError('Upload failed');
        },
      );
    });

    ref.listen(companyFirestoreControllerProvider,
        (AsyncValue<Company>? previous, AsyncValue<Company> next) {
      return next.when(
        data: (data) {
          // show upload success easyloading toast when data is not null
          EasyLoading.showSuccess('Updating company details successful');
        },
        loading: () {
          // show upload progress easyloading toast when loading
          EasyLoading.showInfo('Updating company details...');
        },
        error: (e, s) {
          // show error on upload fail
          EasyLoading.showError(
              'Updating company details failed ${e.toString()}');
          debugPrintStack(stackTrace: s, label: 'Error stack trace: $e');
        },
      );
    });

    // tabs for the profile page
    final tabs = [
      {
        'title': 'Details',
        'icon': LineIcon.infoCircle(),
      },
      {
        'title': 'Staff',
        'icon': LineIcon.users(),
      },
      {
        'title': 'Gallery',
        'icon': LineIcon.images(),
      }
    ];

    // tab controller for the profile page
    final tabController = useTabController(
      initialLength: tabs.length,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const DText(
          text: 'Profile',
        ),
        actions: [
          if (editCompanyDetails?.state != false)
            TextButton(
              onPressed: () {
                // TODO:implement cancellation of any changes made to company
                // TODO: reset company details state
                companyDetailsState?.updateCompany(company: oldDetails);
                editCompanyDetails?.update((state) => state = false);
              },
              child: DText(
                text: 'Discard changes',
                textColor: Theme.of(context).colorScheme.error,
              ),
            ),
          if (editCompanyDetails?.state != false)
            TextButton(
              onPressed: () async {
                //TODO : implement updating of company details to firestore

                // make a new list of gallery and add current gallery to it
                final newGallery = <Gallery>[
                  ...companyDetailsState?.company?.companyGallery ?? []
                ];

                // if new images are not null, upload them to firebase storage
                if (newImages?.value != null) {
                  // upload images to firebase storage and return a list of gallery
                  final newUploadedImages = await ref
                      .read(imageDatabaseControllerNotifierProvider.notifier)
                      .uploadImagesToFirebaseStorage(
                        images: newImages?.value ?? [],
                        path:
                            companyDetailsState!.company!.companyId.toString(),
                      );
                  // add the returned gallery to the new gallery list
                  newGallery.addAll(newUploadedImages.asData!.value!);
                }

                // make a new list of company staff and add current staff to it
                final newStaff = <CompanyStaff>[
                  ...companyDetailsState?.company?.companyStaff ?? []
                ];

                // if local staff state is not null, add the new staff to the new staff list
                if (localStaffState != null) {
                  final newLocalStaff = localStaffState!.map((e) async {
                    // first upload staff image to firebase storage
                    final newStaffImage = await ref
                        .read(imageDatabaseControllerNotifierProvider.notifier)
                        .uploadImageToFirebaseStorage(
                          image: e!.image!,
                          path:
                              '${companyDetailsState!.company!.companyId.toString()}/staff/${e.staffDetails!.fullName}',
                        );

                    // create a new company staff object with the new image
                    final newStaffData = CompanyStaff(
                      imageUrl: newStaffImage.value?.first.imageUrl,
                      fullName: e.staffDetails?.fullName,
                      email: e.staffDetails?.email,
                      phoneNos: e.staffDetails?.phoneNos,
                      jobDescription: e.staffDetails?.jobDescription,
                      jobTitle: e.staffDetails?.jobTitle,
                      title: e.staffDetails?.title,
                    );

                    // return the new company staff object
                    return newStaffData;
                  }).toList();

                  // wait for all the staff to be uploaded
                  final awaitedList = await Future.wait(newLocalStaff);
                  // add the new staff to the new staff list
                  newStaff.addAll(awaitedList);
                }

                print(
                    'company new name: ${company?.companyDetails?.companyName}');

                // create a new company object with the new gallery
                final newCompanyData = Company(
                  companyDetails: company?.companyDetails,
                  companyId: company?.companyId,
                  companyStaff: newStaff,
                  // TODO: fix updating gallery
                  companyGallery: newGallery,
                  createdAt: company?.createdAt,
                  updatedAt: DateTime.now(),
                );

                // update the company details state with the new company object
                await ref
                    .read(companyFirestoreControllerProvider.notifier)
                    .updateCompanyInFirestore(
                      company: newCompanyData,
                    );
                // clear our controller state
                imageControllerNotifier?.clearState();
                ref
                    .read(multipleCompanyStaffLocalControllerProvider.notifier)
                    .clearCompanyStaff();

                editCompanyDetails?.update((state) => state = false);
              },
              child: DText(
                text: 'Save changes',
                textColor: Theme.of(context).colorScheme.primary,
              ),
            )
        ],
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: tabController,
          labelStyle: GoogleFonts.dosis(),
          tabs: tabs
              .map((e) => Tab(
                    text: e['title'].toString(),
                    icon: e['icon'] as Widget,
                  ))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          CompanyDetailsPage(
            companyDetails: company!.companyDetails,
            companyId: company!.companyId,
            companyDetailsState: companyDetailsState,
            editCompanyDetails: editCompanyDetails,
          ),
          CompanyStaffPage(
            companyStaff: company!.companyStaff,
            companyId: company!.companyId,
            companyDetailsState: companyDetailsState,
            localStaffState: localStaffState,
            editCompanyDetails: editCompanyDetails,
          ),
          CompanyGalleryPage(
            companyGallery: company!.companyGallery,
            companyId: company!.companyId,
            companyDetailsState: companyDetailsState,
            imageControllerNotifier: imageControllerNotifier,
            newImages: newImages,
            editCompanyDetails: editCompanyDetails,
          ),
        ],
      ),
    );
  }
}

// tablet profile page
class _TabletProfileDataPage extends HookConsumerWidget {
  const _TabletProfileDataPage({
    Key? key,
    this.company,
    this.companyDetailsState,
    this.editCompanyDetails,
    this.oldDetails,
    this.imageControllerNotifier,
    this.newImages,
    this.localStaffState,
  }) : super(key: key);
  final Company? company;
  final CompanyNotifier? companyDetailsState;
  final StateController<bool>? editCompanyDetails;
  final Company? oldDetails;
  final ImageControllerNotifier? imageControllerNotifier;
  final AsyncValue<List<ImageHelperModel>?>? newImages;
  final List<LocalCompanyStaffModel?>? localStaffState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: const Center(
        child: Text(
          'Tablet Profile',
        ),
      ),
    );
  }
}

// desktop profile page
class _DesktopProfileDataPage extends HookConsumerWidget {
  const _DesktopProfileDataPage({
    Key? key,
    this.company,
    this.companyDetailsState,
    this.editCompanyDetails,
    this.oldDetails,
    this.imageControllerNotifier,
    this.newImages,
    this.localStaffState,
  }) : super(key: key);
  final Company? company;
  final CompanyNotifier? companyDetailsState;
  final StateController<bool>? editCompanyDetails;
  final Company? oldDetails;
  final ImageControllerNotifier? imageControllerNotifier;
  final AsyncValue<List<ImageHelperModel>?>? newImages;
  final List<LocalCompanyStaffModel?>? localStaffState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: const Center(
        child: Text(
          'Desktop Profile',
        ),
      ),
    );
  }
}

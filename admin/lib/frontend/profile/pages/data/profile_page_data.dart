import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final companyDetails = ref.watch(companyNotifierProvider(company));
    final editCompanyDetails = useState(false);
    final companyDetailsState =
        ref.watch(companyNotifierProvider(company).notifier);
    final imageControllerNotifier =
        ref.watch(imageControllerNotifierProvider.notifier);
    final newImages = ref.watch(imageControllerNotifierProvider);
    return AppLayout(
      mobile: _MobileProfileDataPage(
        company: companyDetails,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
        oldDetails: company,
        imageControllerNotifier: imageControllerNotifier,
        newImages: newImages,
      ),
      tablet: _TabletProfileDataPage(
        company: companyDetails,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
        oldDetails: company,
        imageControllerNotifier: imageControllerNotifier,
        newImages: newImages,
      ),
      desktop: _DesktopProfileDataPage(
        company: companyDetails,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
        oldDetails: company,
        imageControllerNotifier: imageControllerNotifier,
        newImages: newImages,
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
  }) : super(key: key);
  final Company? company;
  final CompanyNotifier? companyDetailsState;
  final ValueNotifier<bool>? editCompanyDetails;
  final Company? oldDetails;
  final ImageControllerNotifier? imageControllerNotifier;
  final AsyncValue<List<ImageHelperModel>?>? newImages;
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
          if (editCompanyDetails?.value != false)
            TextButton(
              onPressed: () {
                // TODO:implement cancellation of any changes made to company
                // TODO: reset company details state
                companyDetailsState?.updateCompany(company: oldDetails);
                editCompanyDetails?.value = false;
              },
              child: DText(
                text: 'Discard changes',
                textColor: Theme.of(context).colorScheme.error,
              ),
            ),
          if (editCompanyDetails?.value != false)
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

                // create a new company object with the new gallery
                final newCompanyData = Company(
                  companyDetails: companyDetailsState?.company?.companyDetails,
                  companyId: companyDetailsState?.company?.companyId,
                  companyStaff: companyDetailsState?.company?.companyStaff,
                  // TODO: fix updating gallery
                  companyGallery: newGallery,
                  createdAt: companyDetailsState?.company?.createdAt,
                  updatedAt: DateTime.now(),
                );
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
          ),
          CompanyGalleryPage(
            companyGallery: company!.companyGallery,
            companyId: company!.companyId,
            companyDetailsState: companyDetailsState,
            imageControllerNotifier: imageControllerNotifier,
            newImages: newImages,
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
  }) : super(key: key);
  final Company? company;
  final CompanyNotifier? companyDetailsState;
  final ValueNotifier<bool>? editCompanyDetails;
  final Company? oldDetails;
  final ImageControllerNotifier? imageControllerNotifier;
  final AsyncValue<List<ImageHelperModel>?>? newImages;
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
  }) : super(key: key);
  final Company? company;
  final CompanyNotifier? companyDetailsState;
  final ValueNotifier<bool>? editCompanyDetails;
  final Company? oldDetails;
  final ImageControllerNotifier? imageControllerNotifier;
  final AsyncValue<List<ImageHelperModel>?>? newImages;
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

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
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
    return AppLayout(
      mobile: _MobileProfileDataPage(
        company: companyDetails,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
        oldDetails: company,
      ),
      tablet: _TabletProfileDataPage(
        company: companyDetails,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
        oldDetails: company,
      ),
      desktop: _DesktopProfileDataPage(
        company: companyDetails,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
        oldDetails: company,
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
  }) : super(key: key);
  final Company? company;
  final CompanyNotifier? companyDetailsState;
  final ValueNotifier<bool>? editCompanyDetails;
  final Company? oldDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              onPressed: () {
                //TODO : implement updating of company details to firestore
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
  }) : super(key: key);
  final Company? company;
  final CompanyNotifier? companyDetailsState;
  final ValueNotifier<bool>? editCompanyDetails;
  final Company? oldDetails;
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
  }) : super(key: key);
  final Company? company;
  final CompanyNotifier? companyDetailsState;
  final ValueNotifier<bool>? editCompanyDetails;
  final Company? oldDetails;
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

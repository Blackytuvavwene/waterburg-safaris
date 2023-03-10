import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

// company about details page hook consumer widget with app layout
class CompanyAboutDetailsPage extends HookConsumerWidget {
  const CompanyAboutDetailsPage({
    Key? key,
    this.companyId,
    this.companyDetails,
    this.companyDetailsState,
    this.editCompanyDetails,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final StateController<bool>? editCompanyDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);
    final error = useState('');
    return AppLayout(
      mobile: _MobileCompanyAboutDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
      ),
      tablet: _TabletCompanyAboutDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
      ),
      desktop: _DesktopCompanyAboutDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
      ),
    );
  }
}

// mobile company about details page
class _MobileCompanyAboutDetailsPage extends HookConsumerWidget {
  const _MobileCompanyAboutDetailsPage({
    Key? key,
    this.companyDetails,
    this.companyId,
    this.companyDetailsState,
    this.editCompanyDetails,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final StateController<bool>? editCompanyDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const DText(
            text: 'Company About Details',
          ),
          pinned: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: LineIcon.editAlt(),
              onPressed: () async {
                if (editCompanyDetails?.state != true) {
                  editCompanyDetails?.update(
                    (state) => state = true,
                  );
                }
                final result = await Navigator.push<CompanyDetails>(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CompanyEditAbout(
                        companyDetails: companyDetails,
                      );
                    },
                  ),
                );

                if (result != null) {
                  print('result: $result');
                  companyDetailsState?.editCompanyDetails(
                      companyDetails: result);
                } else {
                  print('result: $result');
                }

                // if (result != companyDetails) {
                //   print('result: $result');
                //   companyDetailsState?.editCompanyDetails(
                //       companyDetails: result);
                // }
              },
            ),
          ],
        ),
        SliverPadding(
          padding: EdgeInsets.all(
            10.sp,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                InfoTile(
                  title: 'Company name',
                  subtitle: companyDetails?.companyName.toString(),
                ),
                SizedBoxAppSpacing.smallY(),
                InfoTile(
                  title: 'Company registration',
                  subtitle: companyDetails?.registrationNumber.toString(),
                ),
                SizedBoxAppSpacing.mediumY(),
                TextInfoCard(
                  title: 'Overview',
                  text: companyDetails?.overview,
                ),
                SizedBoxAppSpacing.mediumY(),
                TextInfoCard(
                  title: 'SEO Description',
                  text: companyDetails?.seoDescription,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// tablet company about details page
class _TabletCompanyAboutDetailsPage extends HookConsumerWidget {
  const _TabletCompanyAboutDetailsPage({
    Key? key,
    this.companyDetails,
    this.companyId,
    this.companyDetailsState,
    this.editCompanyDetails,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final StateController<bool>? editCompanyDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Tablet Company About Details Page'),
    );
  }
}

// desktop company about details page
class _DesktopCompanyAboutDetailsPage extends HookConsumerWidget {
  const _DesktopCompanyAboutDetailsPage({
    Key? key,
    this.companyDetails,
    this.companyId,
    this.companyDetailsState,
    this.editCompanyDetails,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final StateController<bool>? editCompanyDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Desktop Company About Details Page'),
    );
  }
}

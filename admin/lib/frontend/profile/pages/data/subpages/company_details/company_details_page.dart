import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

// company details page hook consumer widget with app layout
class CompanyDetailsPage extends HookConsumerWidget {
  const CompanyDetailsPage({
    Key? key,
    this.comapnyId,
    this.companyDetails,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? comapnyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyDetailsPage(
        companyDetails: companyDetails,
        comapnyId: comapnyId,
      ),
      tablet: _TabletCompanyDetailsPage(
        companyDetails: companyDetails,
        comapnyId: comapnyId,
      ),
      desktop: _DesktopCompanyDetailsPage(
        companyDetails: companyDetails,
        comapnyId: comapnyId,
      ),
    );
  }
}

// mobile company details page
class _MobileCompanyDetailsPage extends HookConsumerWidget {
  const _MobileCompanyDetailsPage({
    Key? key,
    this.companyDetails,
    this.comapnyId,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? comapnyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageViewController = usePageController();
    final pageViewIndex = useState(0);

    final pages = [
      CompanyAboutDetailsPage(
        companyDetails: companyDetails,
        companyId: comapnyId,
      ),
      CompanyAddressDetailsPage(
        companyDetails: companyDetails,
        companyId: comapnyId,
      ),
      CompanyExtraDetailsPage(
        companyDetails: companyDetails,
        companyId: comapnyId,
      ),
    ];

    // on page change function
    void onPageChange(int index) {
      pageViewIndex.value = index;
      pageViewController.jumpToPage(index);
    }

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: CompanyDetailsTabbar(
            pageViewController: pageViewController,
            pageViewIndex: pageViewIndex.value,
            onPageChange: onPageChange,
          ),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 68.h,
            child: PageView(
              controller: pageViewController,
              onPageChanged: onPageChange,
              children: pages,
            ),
          ),
        )
      ],
    );
  }
}

// tablet company details page
class _TabletCompanyDetailsPage extends HookConsumerWidget {
  const _TabletCompanyDetailsPage({
    Key? key,
    this.companyDetails,
    this.comapnyId,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? comapnyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          children: const [
            DText(
              text: 'Tablet Company Details',
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

// desktop company details page
class _DesktopCompanyDetailsPage extends HookConsumerWidget {
  const _DesktopCompanyDetailsPage({
    Key? key,
    this.companyDetails,
    this.comapnyId,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? comapnyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          children: const [
            DText(
              text: 'Desktop Company Details',
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
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
    return Container(
      height: 100.h,
      width: 100.w,
      color: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 2.h,
          bottom: 2.h,
          left: 3.w,
          right: 3.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DText(
              text: 'Mobile Company Details',
            ),
            TextInfoCard(
              companyId: comapnyId,
              title: 'Company SEO Description',
              text: companyDetails?.seoDescription,
            ),
          ],
        ),
      ),
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

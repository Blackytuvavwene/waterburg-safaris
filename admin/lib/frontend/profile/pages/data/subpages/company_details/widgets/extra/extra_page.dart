import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// company extra details page hook consumer widget with app layout
class CompanyExtraDetailsPage extends HookConsumerWidget {
  const CompanyExtraDetailsPage({
    Key? key,
    this.companyId,
    this.companyDetails,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyExtraDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
      ),
      tablet: _TabletCompanyExtraDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
      ),
      desktop: _DesktopCompanyExtraDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
      ),
    );
  }
}

// mobile company extra details page
class _MobileCompanyExtraDetailsPage extends HookConsumerWidget {
  const _MobileCompanyExtraDetailsPage({
    Key? key,
    this.companyDetails,
    this.companyId,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Mobile Company Extra Details Page'),
    );
  }
}

// tablet company extra details page
class _TabletCompanyExtraDetailsPage extends HookConsumerWidget {
  const _TabletCompanyExtraDetailsPage({
    Key? key,
    this.companyDetails,
    this.companyId,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Tablet Company Extra Details Page'),
    );
  }
}

// desktop company extra details page
class _DesktopCompanyExtraDetailsPage extends HookConsumerWidget {
  const _DesktopCompanyExtraDetailsPage({
    Key? key,
    this.companyDetails,
    this.companyId,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Desktop Company Extra Details Page'),
    );
  }
}

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// company address details page hook consumer widget with app layout
class CompanyAddressDetailsPage extends HookConsumerWidget {
  const CompanyAddressDetailsPage({
    Key? key,
    this.companyId,
    this.companyDetails,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyAddressDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
      ),
      tablet: _TabletCompanyAddressDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
      ),
      desktop: _DesktopCompanyAddressDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
      ),
    );
  }
}

// mobile company address details page
class _MobileCompanyAddressDetailsPage extends HookConsumerWidget {
  const _MobileCompanyAddressDetailsPage({
    Key? key,
    this.companyDetails,
    this.companyId,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Mobile Company Address Details Page'),
    );
  }
}

// tablet company address details page
class _TabletCompanyAddressDetailsPage extends HookConsumerWidget {
  const _TabletCompanyAddressDetailsPage({
    Key? key,
    this.companyDetails,
    this.companyId,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Tablet Company Address Details Page'),
    );
  }
}

// desktop company address details page
class _DesktopCompanyAddressDetailsPage extends HookConsumerWidget {
  const _DesktopCompanyAddressDetailsPage({
    Key? key,
    this.companyDetails,
    this.companyId,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Desktop Company Address Details Page'),
    );
  }
}

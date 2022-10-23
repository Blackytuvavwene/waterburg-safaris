import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// company staff page hook consumer widget with app layout
class CompanyStaffPage extends HookConsumerWidget {
  const CompanyStaffPage({
    Key? key,
    this.companyId,
    this.companyStaff,
  }) : super(key: key);
  final List<CompanyStaff>? companyStaff;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyStaffPage(
        companyStaff: companyStaff,
        companyId: companyId,
      ),
      tablet: _TabletCompanyStaffPage(
        companyStaff: companyStaff,
        companyId: companyId,
      ),
      desktop: _DesktopCompanyStaffPage(
        companyStaff: companyStaff,
        companyId: companyId,
      ),
    );
  }
}

// mobile company staff page
class _MobileCompanyStaffPage extends HookConsumerWidget {
  const _MobileCompanyStaffPage({
    Key? key,
    this.companyStaff,
    this.companyId,
  }) : super(key: key);
  final List<CompanyStaff>? companyStaff;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          children: const [
            DText(
              text: 'Mobile Company Staff',
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

// tablet company staff page
class _TabletCompanyStaffPage extends HookConsumerWidget {
  const _TabletCompanyStaffPage({
    Key? key,
    this.companyStaff,
    this.companyId,
  }) : super(key: key);
  final List<CompanyStaff>? companyStaff;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          children: const [
            DText(
              text: 'Tablet Company Staff',
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

// desktop company staff page
class _DesktopCompanyStaffPage extends HookConsumerWidget {
  const _DesktopCompanyStaffPage({
    Key? key,
    this.companyStaff,
    this.companyId,
  }) : super(key: key);
  final List<CompanyStaff>? companyStaff;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          children: const [
            DText(
              text: 'Desktop Company Staff',
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
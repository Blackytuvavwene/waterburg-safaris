import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// about company data dashboard
class AboutCompanyDataDashboard extends HookConsumerWidget {
  const AboutCompanyDataDashboard({
    Key? key,
    this.companyData,
  }) : super(key: key);
  final Company? companyData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileAboutCompanyDataDashboard(
        companyData: companyData,
      ),
      tablet: _TabletAboutCompanyDataDashboard(
        companyData: companyData,
      ),
      desktop: _DesktopAboutCompanyDataDashboard(
        companyData: companyData,
      ),
    );
  }
}

// about company data dashboard for mobile
class _MobileAboutCompanyDataDashboard extends HookConsumerWidget {
  const _MobileAboutCompanyDataDashboard({
    Key? key,
    this.companyData,
  }) : super(key: key);
  final Company? companyData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// about company data dashboard for tablet
class _TabletAboutCompanyDataDashboard extends HookConsumerWidget {
  const _TabletAboutCompanyDataDashboard({
    Key? key,
    this.companyData,
  }) : super(key: key);
  final Company? companyData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// about company data dashboard for desktop
class _DesktopAboutCompanyDataDashboard extends HookConsumerWidget {
  const _DesktopAboutCompanyDataDashboard({
    Key? key,
    this.companyData,
  }) : super(key: key);
  final Company? companyData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

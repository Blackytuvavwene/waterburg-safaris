import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// company about details page hook consumer widget with app layout
class CompanyAboutDetailsPage extends HookConsumerWidget {
  const CompanyAboutDetailsPage({
    Key? key,
    this.companyId,
    this.companyDetails,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyDetailsState = useState(companyDetails);
    final loading = useState(false);
    final error = useState('');
    return AppLayout(
      mobile: _MobileCompanyAboutDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
      ),
      tablet: _TabletCompanyAboutDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
      ),
      desktop: _DesktopCompanyAboutDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
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
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  final ValueNotifier<CompanyDetails?>? companyDetailsState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              ListTile(
                title: const DText(
                  text: 'Company name',
                ),
                subtitle: DText(text: companyDetails?.companyName.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
              ),
              SizedBoxAppSpacing.smallY(),
              ListTile(
                title: const DText(
                  text: 'Company registrations',
                ),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DText(
                      text: companyDetails?.registrationNumber.toString(),
                    ),
                    SizedBoxAppSpacing.smallY(),
                    DText(
                      text: companyDetails?.vatNo.toString(),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
              ),
              SizedBoxAppSpacing.mediumY(),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.mediumX,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const DText(
                          text: 'Company descriptions',
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.mediumX,
                    ),
                    child: TextInfoCard(
                      title: 'Overview',
                      text: companyDetails?.overview,
                    ),
                  ),
                  SizedBoxAppSpacing.mediumY(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.mediumX,
                    ),
                    child: TextInfoCard(
                      title: 'Overview',
                      text: companyDetails?.seoDescription,
                    ),
                  ),
                ],
              )
            ],
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
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  final ValueNotifier<CompanyDetails?>? companyDetailsState;
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
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  final ValueNotifier<CompanyDetails?>? companyDetailsState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Desktop Company About Details Page'),
    );
  }
}

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';

// company address details page hook consumer widget with app layout
class CompanyAddressDetailsPage extends HookConsumerWidget {
  const CompanyAddressDetailsPage({
    Key? key,
    this.companyId,
    this.companyDetails,
    this.companyDetailsState,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyAddressDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
      ),
      tablet: _TabletCompanyAddressDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
      ),
      desktop: _DesktopCompanyAddressDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
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
    this.companyDetailsState,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const DText(
            text: 'Company Address Details',
          ),
          pinned: true,
          floating: true,
          snap: true,
          actions: [
            IconButton(
              icon: LineIcon.editAlt(),
              onPressed: () async {
                // ref.read(companyDetailsProvider.notifier).editCompanyDetails(
                //       companyId: companyId,
                //       companyDetails: companyDetails,
                //     );
                final AddressAndContact addressAndContact = AddressAndContact(
                  address: companyDetails?.companyAddress,
                  email: companyDetails?.email,
                  telNo: companyDetails?.telNo,
                  cellPhoneNos: companyDetails?.cellPhoneNos,
                );

                await context
                    .pushNamed<AddressAndContact>(
                      'editAddress',
                      extra: addressAndContact,
                    )
                    .then((value) => print(value));

                // print(newAddressAndContact);

                // if (newAddressAndContact != null) {
                //   companyDetailsState?.editCompanyDetails(
                //     companyDetails: companyDetails?.copyWith(
                //       companyAddress: newAddressAndContact.address,
                //       email: newAddressAndContact.email,
                //       telNo: newAddressAndContact.telNo,
                //       cellPhoneNos: newAddressAndContact.cellPhoneNos,
                //     ),
                //   );
                // }
              },
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
              child: Column(
            children: [
              InfoTile(
                title: 'Email',
                subtitle: companyDetails?.email,
              ),
              SizedBoxAppSpacing.smallY(),
              InfoTile(
                title: 'Address',
                subtitle: companyDetails?.companyAddress,
              ),
              SizedBoxAppSpacing.smallY(),
              InfoTile(
                title: 'Telephone',
                subtitle: companyDetails?.telNo,
              ),
              SizedBoxAppSpacing.smallY(),
            ],
          )),
        )
      ],
    );
  }
}

// tablet company address details page
class _TabletCompanyAddressDetailsPage extends HookConsumerWidget {
  const _TabletCompanyAddressDetailsPage({
    Key? key,
    this.companyDetails,
    this.companyId,
    this.companyDetailsState,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
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
    this.companyDetailsState,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Desktop Company Address Details Page'),
    );
  }
}

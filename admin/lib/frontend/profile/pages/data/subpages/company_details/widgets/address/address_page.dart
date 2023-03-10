import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

// company address details page hook consumer widget with app layout
class CompanyAddressDetailsPage extends HookConsumerWidget {
  const CompanyAddressDetailsPage({
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
    return AppLayout(
      mobile: _MobileCompanyAddressDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
      ),
      tablet: _TabletCompanyAddressDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
      ),
      desktop: _DesktopCompanyAddressDetailsPage(
        companyDetails: companyDetails,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
        editCompanyDetails: editCompanyDetails,
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
            text: 'Company Address Details',
          ),
          pinned: true,
          floating: true,
          automaticallyImplyLeading: false,
          snap: true,
          actions: [
            IconButton(
              icon: LineIcon.editAlt(),
              onPressed: () async {
                if (editCompanyDetails?.state != true) {
                  editCompanyDetails?.update(
                    (state) => state = false,
                  );
                }

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

                final newDetails = await dataRoutePush<AddressAndContact>(
                  context: context,
                  target: EditAddressContactPage(
                    addressAndContact: addressAndContact,
                  ),
                );

                // print(newAddressAndContact);

                if (newDetails != null) {
                  companyDetailsState?.editCompanyDetails(
                    companyDetails: companyDetails?.copyWith(
                      companyAddress: newDetails.address,
                      email: newDetails.email,
                      telNo: newDetails.telNo,
                      cellPhoneNos: newDetails.cellPhoneNos,
                    ),
                  );
                }
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
              DText(
                text: 'Cellphone Numbers',
                fontSize: 16.sp,
                fontWeight: FontWeight.w900,
              ),
              Wrap(
                spacing: 2.w,
                children: [
                  for (final cellPhoneNo in companyDetails?.cellPhoneNos ?? [])
                    Chip(
                      label: DText(
                        text: cellPhoneNo,
                      ),
                    ),
                ],
              ),
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
    this.editCompanyDetails,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final StateController<bool>? editCompanyDetails;
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
    this.editCompanyDetails,
  }) : super(key: key);
  final CompanyDetails? companyDetails;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final StateController<bool>? editCompanyDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('Desktop Company Address Details Page'),
    );
  }
}

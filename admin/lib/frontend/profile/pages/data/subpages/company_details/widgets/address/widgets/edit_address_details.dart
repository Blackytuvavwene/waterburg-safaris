import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';

// edit address and contact company details hook consumer page widget with app layout
class EditAddressContactPage extends HookConsumerWidget {
  const EditAddressContactPage({
    super.key,
    this.addressAndContact,
  });
  final AddressAndContact? addressAndContact;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileEditAddressContactPage(
        addressAndContact: addressAndContact,
      ),
      tablet: _TabletEditAddressContactPage(
        addressAndContact: addressAndContact,
      ),
      desktop: _DesktopEditAddressContactPage(
        addressAndContact: addressAndContact,
      ),
    );
  }
}

// mobile edit address and contact page
class _MobileEditAddressContactPage extends HookConsumerWidget {
  const _MobileEditAddressContactPage({
    this.addressAndContact,
  });
  final AddressAndContact? addressAndContact;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const DText(
              text: 'Edit Address and Contact',
            ),
            leading: IconButton(
              icon: LineIcon.arrowLeft(),
              onPressed: () {
                context.pop(addressAndContact);
              },
            ),
            pinned: true,
            floating: true,
            snap: true,
            actions: [
              IconButton(
                icon: LineIcon.save(),
                onPressed: () async {
                  // ref.read(companyDetailsProvider.notifier).editCompanyDetails(
                  //       companyId: companyId,
                  //       companyDetails: companyDetails,
                  //     );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: addressAndContact?.address,
                    decoration: const InputDecoration(
                      labelText: 'Company Address',
                    ),
                  ),
                  TextFormField(
                    initialValue: addressAndContact?.address,
                    decoration: const InputDecoration(
                      labelText: 'Company Address',
                    ),
                  ),
                  TextFormField(
                    initialValue: addressAndContact?.address,
                    decoration: const InputDecoration(
                      labelText: 'Company Address',
                    ),
                  ),
                  SizedBoxAppSpacing.smallY(),
                  Wrap(
                    children: addressAndContact?.cellPhoneNos
                            ?.map(
                              (e) => DText(
                                text: e,
                              ),
                            )
                            .toList() ??
                        [],
                  ),
                  TextFormField(
                    initialValue: addressAndContact?.address,
                    decoration: const InputDecoration(
                      labelText: 'Company Address',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// tablet edit address and contact page
class _TabletEditAddressContactPage extends HookConsumerWidget {
  const _TabletEditAddressContactPage({
    this.addressAndContact,
  });
  final AddressAndContact? addressAndContact;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// desktop edit address and contact page
class _DesktopEditAddressContactPage extends HookConsumerWidget {
  const _DesktopEditAddressContactPage({
    this.addressAndContact,
  });
  final AddressAndContact? addressAndContact;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

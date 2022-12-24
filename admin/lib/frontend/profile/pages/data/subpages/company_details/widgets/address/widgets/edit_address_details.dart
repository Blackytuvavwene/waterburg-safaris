import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final detailsState = useState(addressAndContact);
    return AppLayout(
      mobile: _MobileEditAddressContactPage(
        addressAndContact: detailsState.value,
        state: detailsState,
      ),
      tablet: _TabletEditAddressContactPage(
        addressAndContact: detailsState.value,
        state: detailsState,
      ),
      desktop: _DesktopEditAddressContactPage(
        addressAndContact: detailsState.value,
        state: detailsState,
      ),
    );
  }
}

// mobile edit address and contact page
class _MobileEditAddressContactPage extends HookConsumerWidget {
  const _MobileEditAddressContactPage({
    this.addressAndContact,
    this.state,
  });
  final AddressAndContact? addressAndContact;
  final ValueNotifier<AddressAndContact?>? state;
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
                final newAddress = AddressAndContact(
                  address: 'new address',
                  cellPhoneNos: addressAndContact?.cellPhoneNos,
                  email: addressAndContact?.email,
                );
                Navigator.of(context).pop(newAddress);
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
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.smallX,
              ),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: addressAndContact?.email,
                      decoration: const InputDecoration(
                        labelText: 'Company Email Address',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {},
                    ),
                    TextFormField(
                      initialValue: addressAndContact?.address,
                      decoration: const InputDecoration(
                        labelText: 'Company Physical/Postal Address',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Wrap(
                            children: [
                              ...addressAndContact?.cellPhoneNos?.map(
                                    (e) => Chip(
                                      label: DText(
                                        text: e,
                                      ),
                                    ),
                                  ) ??
                                  [],
                            ],
                          ),
                          Flexible(
                            child: TextFormField(
                              // expands: true,
                              // minLines: null,
                              // maxLines: null,
                              onFieldSubmitted: (value) {
                                final List<String> newCellPhoneNos = [
                                  ...addressAndContact?.cellPhoneNos ?? [],
                                  value,
                                ];
                                state?.value = addressAndContact?.copyWith(
                                  cellPhoneNos: newCellPhoneNos,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    TextFormField(
                      initialValue: addressAndContact?.address,
                      decoration: const InputDecoration(
                        labelText: 'Cellphone Numbers',
                        border: OutlineInputBorder(),
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
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
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
    this.state,
  });
  final AddressAndContact? addressAndContact;
  final ValueNotifier<AddressAndContact?>? state;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

// desktop edit address and contact page
class _DesktopEditAddressContactPage extends HookConsumerWidget {
  const _DesktopEditAddressContactPage({
    this.addressAndContact,
    this.state,
  });
  final AddressAndContact? addressAndContact;
  final ValueNotifier<AddressAndContact?>? state;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

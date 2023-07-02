import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

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
    final cellNoTextController = useTextEditingController();
    final emailTextController = useTextEditingController(
      text: addressAndContact?.email,
    );
    final addressTextController = useTextEditingController(
      text: addressAndContact?.address,
    );
    final telNoTextController = useTextEditingController(
      text: addressAndContact?.telNo,
    );
    final cellNoFocusNode = useFocusNode();
    final emailFocusNode = useFocusNode();
    final formKey = GlobalKey<FormState>();
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
                  address: addressAndContact?.address,
                  cellPhoneNos: addressAndContact?.cellPhoneNos,
                  telNo: addressAndContact?.telNo,
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
                vertical: AppSpacing.smallY,
              ),
              child: Column(
                children: [
                  TextFormField(
                    // controller: emailTextController,
                    // focusNode: emailFocusNode,

                    initialValue: addressAndContact?.email,
                    decoration: const InputDecoration(
                      labelText: 'Company Email Address ',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // change the value only if the field is focused

                      state?.value = state?.value?.copyWith(email: value);

                      // emailFocusNode.requestFocus();
                    },
                  ),
                  SizedBoxAppSpacing.smallY(),
                  TextFormField(
                    // controller: addressTextController,
                    initialValue: addressAndContact?.address,
                    onChanged: (value) {
                      state?.value = addressAndContact?.copyWith(
                        address: value,
                      );
                    },
                    decoration: const InputDecoration(
                      labelText: 'Company Physical/Postal Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBoxAppSpacing.smallY(),
                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      borderRadius: BorderRadius.circular(
                        4.sp,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Wrap(
                            spacing: AppSpacing.smallX,
                            children: [
                              if (addressAndContact?.cellPhoneNos != null)
                                ...addressAndContact!.cellPhoneNos!.map(
                                  (phoneNo) => Chip(
                                    label: DText(
                                      text: phoneNo,
                                    ),
                                    deleteIcon: LineIcon.trash(
                                      size: 12.sp,
                                    ),
                                    onDeleted: () {
                                      // delete from list flutter object
                                      final newCellNos =
                                          addressAndContact?.cellPhoneNos
                                              ?.where(
                                                (element) => element != phoneNo,
                                              )
                                              .toList();

                                      state?.value =
                                          addressAndContact?.copyWith(
                                        cellPhoneNos: newCellNos,
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: cellNoTextController,
                            focusNode: cellNoFocusNode,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Input cellphone number here',
                              hintStyle: GoogleFonts.dosis(),
                            ),
                            validator: (value) {
                              if (cellNoTextController.text.trim().isEmpty) {
                                return 'Please enter cellphone number';
                              }
                              // check if input matches a phone number
                              if (!RegExp(r'^\+?\d+$')
                                  .hasMatch(cellNoTextController.text.trim())) {
                                return 'Please enter valid number';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              // check if cellphone number input field is focused on
                              if (cellNoFocusNode.hasFocus) {
                                // perform form validations on input changes
                                formKey.currentState?.validate();
                              }
                            },
                            onFieldSubmitted: (value) {
                              // submit only if text controller is not empty
                              if (cellNoTextController.text.trim().isNotEmpty) {
                                // create a new copy of cell no list
                                final List<String> newCellPhoneNos = [
                                  ...addressAndContact?.cellPhoneNos ?? [],
                                  cellNoTextController.text.trim(),
                                ];

                                // update the state with new list of cell nos
                                state?.value = addressAndContact?.copyWith(
                                  cellPhoneNos: newCellPhoneNos,
                                );

                                // clear text controller
                                cellNoTextController.clear();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBoxAppSpacing.smallY(),
                  TextFormField(
                    // controller: telNoTextController,
                    initialValue: addressAndContact?.telNo,
                    onChanged: (value) {
                      state?.value = addressAndContact?.copyWith(
                        telNo: value,
                      );
                    },
                    decoration: const InputDecoration(
                      labelText: 'Company Telephone Number',
                      border: OutlineInputBorder(),
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

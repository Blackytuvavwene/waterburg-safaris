import 'dart:convert';

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// add company staff page consumer hook widget with app layout
class ManageLocalCompanyStaffPage extends HookConsumerWidget {
  const ManageLocalCompanyStaffPage({
    super.key,
    this.staffDetails,
  });
  final LocalCompanyStaffModel? staffDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localStaffState =
        ref.watch(companyStaffLocalControllerProvider(staffDetails));
    final imageState = ref.watch(imageHelperNotifierProvider);
    final localController =
        ref.watch(companyStaffLocalControllerProvider(staffDetails).notifier);
    final imageController = ref.read(imageHelperNotifierProvider.notifier);
    return AppLayout(
      mobile: _MobileManageLocalCompanyStaffPage(
        staffDetails: staffDetails,
        localController: localController,
        imageController: imageController,
        imageState: imageState,
        localStaffState: localStaffState,
      ),
      tablet: _TabletManageLocalCompanyStaffPage(
        staffDetails: staffDetails,
        localController: localController,
        imageController: imageController,
        imageState: imageState,
        localStaffState: localStaffState,
      ),
      desktop: _DesktopManageLocalCompanyStaffPage(
        staffDetails: staffDetails,
        localController: localController,
        imageController: imageController,
        imageState: imageState,
        localStaffState: localStaffState,
      ),
    );
  }
}

// mobile add company staff page
class _MobileManageLocalCompanyStaffPage extends HookConsumerWidget {
  const _MobileManageLocalCompanyStaffPage({
    this.staffDetails,
    this.localController,
    this.imageController,
    this.imageState,
    this.localStaffState,
  });
  final LocalCompanyStaffModel? staffDetails;
  final CompanyStaffLocalControllerNotifier? localController;
  final ImageHelperNotifier? imageController;
  final AsyncValue<ImageHelperModel?>? imageState;
  final LocalCompanyStaffModel? localStaffState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          staffDetails == null ? 'Add Staff' : 'Edit Staff',
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Placeholder(
                      fallbackHeight: 200,
                      fallbackWidth: 200,
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                            ),
                            onChanged: (value) {
                              // update company staff name
                              localController?.updateCompanyStaffName(value);
                            },
                          ),
                          const TextField(),
                          const TextField(),
                          const TextField(),
                        ],
                      ),
                    ),
                    const CustomElevatedButton(
                      text: 'Save staff',
                    ),
                    DText(
                      text: jsonEncode(
                        localStaffState?.staffDetails?.toJson(),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// tablet add company staff page
class _TabletManageLocalCompanyStaffPage extends HookConsumerWidget {
  const _TabletManageLocalCompanyStaffPage({
    this.staffDetails,
    this.localController,
    this.imageController,
    this.imageState,
    this.localStaffState,
  });
  final LocalCompanyStaffModel? staffDetails;
  final CompanyStaffLocalControllerNotifier? localController;
  final ImageHelperNotifier? imageController;
  final AsyncValue<ImageHelperModel?>? imageState;
  final LocalCompanyStaffModel? localStaffState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          staffDetails == null ? 'Add Staff' : 'Edit Staff',
        ),
      ),
      //TODO: fix tablet layout
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       // image
      //       _Image(
      //         imageController: imageController,
      //         imageState: imageState,
      //         localStaffState: localStaffState,
      //       ),
      //       // name
      //       _Name(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // email
      //       _Email(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // phone
      //       _Phone(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // role
      //       _Role(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // save button
      //       _SaveButton(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

// desktop add company staff page
class _DesktopManageLocalCompanyStaffPage extends HookConsumerWidget {
  const _DesktopManageLocalCompanyStaffPage({
    this.staffDetails,
    this.localController,
    this.imageController,
    this.imageState,
    this.localStaffState,
  });
  final LocalCompanyStaffModel? staffDetails;
  final CompanyStaffLocalControllerNotifier? localController;
  final ImageHelperNotifier? imageController;
  final AsyncValue<ImageHelperModel?>? imageState;
  final LocalCompanyStaffModel? localStaffState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          staffDetails == null ? 'Add Staff' : 'Edit Staff',
        ),
      ),
      //TODO: fix this
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       // image
      //       _Image(
      //         imageController: imageController,
      //         imageState: imageState,
      //         localStaffState: localStaffState,
      //       ),
      //       // name
      //       _Name(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // email
      //       _Email(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // phone
      //       _Phone(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // role
      //       _Role(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //       // save button
      //       _SaveButton(
      //         localController: localController,
      //         localStaffState: localStaffState,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

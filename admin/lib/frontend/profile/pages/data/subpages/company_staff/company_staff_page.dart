import 'package:admin/lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:line_icons/line_icon.dart';

// company staff page hook consumer widget with app layout
class CompanyStaffPage extends HookConsumerWidget {
  const CompanyStaffPage({
    Key? key,
    this.companyId,
    this.companyStaff,
    this.companyDetailsState,
    this.localStaffState,
    this.editCompanyDetails,
  }) : super(key: key);
  final List<CompanyStaff>? companyStaff;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final List<LocalCompanyStaffModel?>? localStaffState;
  final StateController<bool>? editCompanyDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyStaffPage(
        companyStaff: companyStaff,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
        localStaffState: localStaffState,
        editCompanyDetails: editCompanyDetails,
      ),
      tablet: _TabletCompanyStaffPage(
        companyStaff: companyStaff,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
        localStaffState: localStaffState,
      ),
      desktop: _DesktopCompanyStaffPage(
        companyStaff: companyStaff,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
        localStaffState: localStaffState,
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
    this.companyDetailsState,
    this.localStaffState,
    this.editCompanyDetails,
  }) : super(key: key);
  final List<CompanyStaff>? companyStaff;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final List<LocalCompanyStaffModel?>? localStaffState;
  final StateController<bool>? editCompanyDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // tab pages
    final tabPages = [
      // company staff
      {
        'pageName': 'Company Staff',
        'icon': LineIcon.userFriends(),
      },
      // add staff
      {
        'pageName': 'New Staff',
        'icon': LineIcon.userPlus(),
      },
    ];

    // tab bar controller
    final tabController = useTabController(
      initialLength: 2,
    );

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const DText(text: 'Company Staff'),
          automaticallyImplyLeading: false,
          pinned: false,
          bottom: localStaffState != null &&
                  localStaffState!.isNotEmpty &&
                  companyStaff != null &&
                  companyStaff!.isNotEmpty
              ? TabBar(
                  controller: tabController,
                  tabs: tabPages
                      .map(
                        (e) => Tab(
                          icon: e['icon'] as Widget?,
                          child: DText(
                            text: e['pageName'].toString(),
                          ),
                        ),
                      )
                      .toList(),
                )
              : null,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                //TODO: add company staff
                // ref.read(companyStaffProvider.notifier).createCompanyStaff(
                //       companyId: companyId,
                //     );
                // set edit company details to true if it is false
                if (editCompanyDetails?.state == false) {
                  editCompanyDetails?.update(
                    (state) => state = false,
                  );
                }

                // push to add staff page
                final params = LocalCompanyStaffModel(
                  image: ImageHelperModel(
                    xFile: XFile(''),
                    name: '',
                    path: '',
                    bytes: Uint8List(0),
                    imageDetails: Gallery(),
                    imageFile: ImageFile(
                      filePath: '',
                      rawBytes: Uint8List(0),
                    ),
                  ),
                  index: null,
                  staffDetails: CompanyStaff(
                    fullName: '',
                  ),
                  isEditing: false,
                );
                context.pushNamed(
                  'addStaff',
                  extra: params,
                );
              },
            ),
          ],
        ),
        if (localStaffState != null && companyStaff != null)
          if (localStaffState!.isNotEmpty && companyStaff!.isNotEmpty)
            SliverFillRemaining(
              child: TabBarView(
                controller: tabController,
                children: [
                  GridView.custom(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
                    childrenDelegate: SliverChildListDelegate(companyStaff
                        ?.map(
                          (e) => CompanyStaffCard(
                            companyStaff: e,
                            companyId: companyId,
                            onTap: () async {
                              // pass company staff data & company ID to edit page as arguments
                              final args = EditStaffRouteArguments(
                                staff: e,
                                companyId: companyId,
                              );
                              context.pushNamed(
                                'editStaffDetails',
                                extra: args,
                              );
                            },
                            onDelete: () async {
                              // delete company staff
                              await ref
                                  .read(companyFirestoreControllerProvider
                                      .notifier)
                                  .deleteStaffFromFirestore(
                                    companyId: companyId,
                                    staff: e,
                                  );
                            },
                          ),
                        )
                        .toList() as List<Widget>),
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) {
                      return CompanyStaffCard(
                        localStaff: localStaffState?[index],
                        companyId: companyId,
                        onDelete: () {
                          ref
                              .read(multipleCompanyStaffLocalControllerProvider
                                  .notifier)
                              .removeCompanyStaff(
                                companyStaff: localStaffState?[index],
                              );
                        },
                        onTap: () {
                          // navigate to edit staff page
                          final params = LocalCompanyStaffModel(
                            image: localStaffState?[index]?.image,
                            staffDetails: localStaffState?[index]?.staffDetails,
                            isEditing: true,
                            index: index,
                          );
                          context.pushNamed(
                            'addStaff',
                            extra: params,
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: localStaffState!.length,
                  ),
                ],
              ),
            )
          else if (companyStaff != null && companyStaff!.isNotEmpty)
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemBuilder: (context, index) => CompanyStaffCard(
                    companyStaff: companyStaff![index],
                    companyId: companyId,
                    onTap: () async {
                      // pass company staff data & company ID to edit page as arguments
                      final args = EditStaffRouteArguments(
                        staff: companyStaff![index],
                        companyId: companyId,
                      );
                      context.pushNamed(
                        'editStaffDetails',
                        extra: args,
                      );
                    },
                    onDelete: () async {
                      // delete company staff
                      await ref
                          .read(companyFirestoreControllerProvider.notifier)
                          .deleteStaffFromFirestore(
                            companyId: companyId,
                            staff: companyStaff![index],
                          );
                    },
                  ),
                  itemCount: companyStaff!.length,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ),
              ),
            )
          else if (localStaffState != null &&
                  localStaffState!.isNotEmpty &&
                  companyStaff == null ||
              companyStaff!.isEmpty)
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  localStaffState!
                      .map(
                        (e) => CompanyStaffCard(
                          localStaff: e,
                          onTap: () async {
                            // navigate to edit staff page
                            final params = LocalCompanyStaffModel(
                              image: e?.image,
                              staffDetails: e?.staffDetails,
                              isEditing: true,
                              index: localStaffState!.indexOf(e),
                            );
                            context.pushNamed(
                              'addStaff',
                              extra: params,
                            );
                          },
                          onDelete: () async {
                            // delete company staff
                            ref
                                .read(
                                    multipleCompanyStaffLocalControllerProvider
                                        .notifier)
                                .removeCompanyStaff(
                                  companyStaff: e,
                                );
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            )
      ],
    );
  }
}

// tablet company staff page
class _TabletCompanyStaffPage extends HookConsumerWidget {
  const _TabletCompanyStaffPage({
    Key? key,
    this.companyStaff,
    this.companyId,
    this.companyDetailsState,
    this.localStaffState,
  }) : super(key: key);
  final List<CompanyStaff>? companyStaff;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final List<LocalCompanyStaffModel?>? localStaffState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: const Center(
        child: Column(
          children: [
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
    this.companyDetailsState,
    this.localStaffState,
  }) : super(key: key);
  final List<CompanyStaff>? companyStaff;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final List<LocalCompanyStaffModel?>? localStaffState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: const Center(
        child: Column(
          children: [
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

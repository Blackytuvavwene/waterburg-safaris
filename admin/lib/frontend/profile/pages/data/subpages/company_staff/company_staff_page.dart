import 'package:admin/lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';

// company staff page hook consumer widget with app layout
class CompanyStaffPage extends HookConsumerWidget {
  const CompanyStaffPage({
    Key? key,
    this.companyId,
    this.companyStaff,
    this.companyDetailsState,
    this.localStaffState,
  }) : super(key: key);
  final List<CompanyStaff>? companyStaff;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final List<LocalCompanyStaffModel?>? localStaffState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyStaffPage(
        companyStaff: companyStaff,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
        localStaffState: localStaffState,
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
  }) : super(key: key);
  final List<CompanyStaff>? companyStaff;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final List<LocalCompanyStaffModel?>? localStaffState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Company Staff'),
          automaticallyImplyLeading: false,
          pinned: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                //TODO: add company staff
                // ref.read(companyStaffProvider.notifier).createCompanyStaff(
                //       companyId: companyId,
                //     );
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
                  staffDetails: CompanyStaff(
                    fullName: '',
                  ),
                );
                context.pushNamed(
                  'addStaff',
                  extra: params,
                );
              },
            ),
          ],
        ),
        if (localStaffState != null)
          localStaffState!.isNotEmpty
              ? SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ListTile(
                          title: DText(
                            text:
                                localStaffState?[index]?.staffDetails?.fullName,
                          ),
                        );
                      },
                      childCount: localStaffState!.length,
                    ),
                  ),
                )
              : const SliverToBoxAdapter(
                  child: SizedBox.shrink(),
                ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return CompanyStaffCard(
                  companyStaff: companyStaff![index],
                );
              },
              childCount: companyStaff!.length,
            ),
          ),
        ),
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

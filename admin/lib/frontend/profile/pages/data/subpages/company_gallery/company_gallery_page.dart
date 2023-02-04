import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// company gallery page hook consumer widget with app layout
class CompanyGalleryPage extends HookConsumerWidget {
  const CompanyGalleryPage({
    Key? key,
    this.companyId,
    this.companyGallery,
    this.companyDetailsState,
  }) : super(key: key);
  final List<Gallery>? companyGallery;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyGalleryPage(
        companyGallery: companyGallery,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
      ),
      tablet: _TabletCompanyGalleryPage(
        companyGallery: companyGallery,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
      ),
      desktop: _DesktopCompanyGalleryPage(
        companyGallery: companyGallery,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
      ),
    );
  }
}

// mobile company gallery page
class _MobileCompanyGalleryPage extends HookConsumerWidget {
  const _MobileCompanyGalleryPage({
    Key? key,
    this.companyGallery,
    this.companyId,
    this.companyDetailsState,
  }) : super(key: key);
  final List<Gallery>? companyGallery;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Company Gallery'),
          automaticallyImplyLeading: false,
          pinned: true,
          actions: [
            IconButton(
              onPressed: () {
                // ref.read(companyGalleryProvider.notifier).addGallery(
                //       companyId: companyId,
                //     );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SliverAppBar(
          title: DText(
            text: 'New images',
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return CompanyGalleryCard(
                companyGallery: companyGallery![index],
              );
            },
            childCount: companyGallery!.length,
          ),
        ),
      ],
    );
  }
}

// tablet company gallery page
class _TabletCompanyGalleryPage extends HookConsumerWidget {
  const _TabletCompanyGalleryPage({
    Key? key,
    this.companyGallery,
    this.companyId,
    this.companyDetailsState,
  }) : super(key: key);
  final List<Gallery>? companyGallery;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          children: const [
            DText(
              text: 'Tablet Company Gallery',
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

// desktop company gallery page
class _DesktopCompanyGalleryPage extends HookConsumerWidget {
  const _DesktopCompanyGalleryPage({
    Key? key,
    this.companyGallery,
    this.companyId,
    this.companyDetailsState,
  }) : super(key: key);
  final List<Gallery>? companyGallery;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Column(
          children: const [
            DText(
              text: 'Desktop Company Gallery',
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

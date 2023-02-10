import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';

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
    final imageControllerNotifier =
        ref.watch(imageControllerNotifierProvider.notifier);
    final newImages = ref.watch(imageControllerNotifierProvider);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Company Gallery'),
          automaticallyImplyLeading: false,
          pinned: true,
          actions: [
            IconButton(
                onPressed: () async {
                  // ref.read(companyGalleryProvider.notifier).addGallery(
                  //       companyId: companyId,
                  //     );
                  await imageControllerNotifier.pickImages();
                },
                icon: LineIcon.plusCircle()),
          ],
        ),
        newImages.when(data: (images) {
          return images != null
              ? images.isNotEmpty
                  ? SliverAppBar(
                      title: DText(
                        text: '${images.length} new images picked',
                      ),
                      pinned: true,
                      automaticallyImplyLeading: false,
                    )
                  : const SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    )
              : const SliverToBoxAdapter();
        }, error: (error, stackTrace) {
          return SliverToBoxAdapter(
            child: DText(
              text: error.toString(),
            ),
          );
        }, loading: () {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }),
        newImages.asData?.value != null
            ? newImages.asData!.value!.isNotEmpty
                ? SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return PickedCompanyGalleryCard(
                        companyGallery: newImages.asData?.value?[index],
                      );
                    },
                    itemCount: newImages.value?.length,
                  )
                : const SliverToBoxAdapter()
            : const SliverToBoxAdapter(),
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

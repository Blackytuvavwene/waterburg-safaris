import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';

// company gallery page hook consumer widget with app layout
class CompanyGalleryPage extends HookConsumerWidget {
  const CompanyGalleryPage({
    Key? key,
    this.companyId,
    this.companyGallery,
    this.companyDetailsState,
    this.imageControllerNotifier,
    this.newImages,
    this.editCompanyDetails,
  }) : super(key: key);
  final List<Gallery>? companyGallery;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final ImageControllerNotifier? imageControllerNotifier;
  final AsyncValue<List<ImageHelperModel>?>? newImages;
  final StateController<bool>? editCompanyDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyGalleryPage(
        companyGallery: companyGallery,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
        imageControllerNotifier: imageControllerNotifier,
        newImages: newImages,
        editCompanyDetails: editCompanyDetails,
      ),
      tablet: _TabletCompanyGalleryPage(
        companyGallery: companyGallery,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
        imageControllerNotifier: imageControllerNotifier,
        newImages: newImages,
      ),
      desktop: _DesktopCompanyGalleryPage(
        companyGallery: companyGallery,
        companyId: companyId,
        companyDetailsState: companyDetailsState,
        imageControllerNotifier: imageControllerNotifier,
        newImages: newImages,
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
    this.imageControllerNotifier,
    this.newImages,
    this.editCompanyDetails,
  }) : super(key: key);
  final List<Gallery>? companyGallery;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final ImageControllerNotifier? imageControllerNotifier;
  final AsyncValue<List<ImageHelperModel>?>? newImages;
  final StateController<bool>? editCompanyDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // tab pages for gallery
    final tabPages = [
      const Tab(
        icon: LineIcon.imagesAlt(),
        child: DText(
          text: 'Gallery',
        ),
      ),
      const Tab(
        icon: LineIcon.boxes(),
        child: DText(
          text: 'New images',
        ),
      ),
    ];

    // tab controller
    final tabController = useTabController(initialLength: tabPages.length);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Company Gallery'),
          automaticallyImplyLeading: false,
          pinned: true,
          bottom: newImages?.asData?.value != null
              ? newImages!.asData!.value!.isNotEmpty
                  ? TabBar(
                      controller: tabController,
                      tabs: tabPages,
                    )
                  : null
              : null,
          actions: [
            IconButton(
                onPressed: () async {
                  if (editCompanyDetails?.state != true) {
                    editCompanyDetails?.update(
                      (state) => state = true,
                    );
                  }
                  // ref.read(companyGalleryProvider.notifier).addGallery(
                  //       companyId: companyId,
                  //     );
                  await imageControllerNotifier?.pickImages();
                },
                icon: const LineIcon.plusCircle()),
          ],
        ),
        if (newImages != null)
          if (newImages!.value != [] && newImages!.value!.isNotEmpty)
            SliverFillRemaining(
              child: TabBarView(
                controller: tabController,
                children: [
                  ListView.separated(
                    itemCount: companyGallery!.length,
                    itemBuilder: (context, index) {
                      return CompanyGalleryCard(
                        companyGallery: companyGallery![index],
                        companyId: companyId,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
                  ),
                  ListView.separated(
                    itemCount: newImages!.asData!.value!.length,
                    itemBuilder: (context, index) {
                      return PickedCompanyGalleryCard(
                        companyGallery: newImages?.asData?.value?[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 4,
                      );
                    },
                  ),
                ],
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return CompanyGalleryCard(
                    companyGallery: companyGallery![index],
                    companyId: companyId,
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
    this.imageControllerNotifier,
    this.newImages,
  }) : super(key: key);
  final List<Gallery>? companyGallery;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final ImageControllerNotifier? imageControllerNotifier;
  final AsyncValue<List<ImageHelperModel>?>? newImages;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: const Center(
        child: Column(
          children: [
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
    this.imageControllerNotifier,
    this.newImages,
  }) : super(key: key);
  final List<Gallery>? companyGallery;
  final String? companyId;
  final CompanyNotifier? companyDetailsState;
  final ImageControllerNotifier? imageControllerNotifier;
  final AsyncValue<List<ImageHelperModel>?>? newImages;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: const Center(
        child: Column(
          children: [
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

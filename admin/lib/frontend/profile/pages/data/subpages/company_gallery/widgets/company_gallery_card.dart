import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompanyGalleryCard extends HookConsumerWidget {
  const CompanyGalleryCard({
    super.key,
    this.companyGallery,
  });
  final Gallery? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileCompanyGalleryCard(
        companyGallery: companyGallery,
      ),
      tablet: _TabletCompanyGalleryCard(
        companyGallery: companyGallery,
      ),
      desktop: _DesktopCompanyGalleryCard(
        companyGallery: companyGallery,
      ),
    );
  }
}

// mobile company gallery card
class _MobileCompanyGalleryCard extends HookConsumerWidget {
  const _MobileCompanyGalleryCard({
    this.companyGallery,
  });
  final Gallery? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            companyGallery!.imageUrl!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(companyGallery!.imageTitle!),
            subtitle: Text(companyGallery!.imageDescription!),
          ),
        ],
      ),
    );
  }
}

// tablet company gallery card
class _TabletCompanyGalleryCard extends HookConsumerWidget {
  const _TabletCompanyGalleryCard({
    this.companyGallery,
  });
  final Gallery? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            companyGallery!.imageUrl!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(companyGallery!.imageTitle!),
            subtitle: Text(companyGallery!.imageDescription!),
          ),
        ],
      ),
    );
  }
}

// desktop company gallery card
class _DesktopCompanyGalleryCard extends HookConsumerWidget {
  const _DesktopCompanyGalleryCard({
    this.companyGallery,
  });
  final Gallery? companyGallery;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          Image.network(
            companyGallery!.imageUrl!,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(companyGallery!.imageTitle!),
            subtitle: Text(companyGallery!.imageDescription!),
          ),
        ],
      ),
    );
  }
}

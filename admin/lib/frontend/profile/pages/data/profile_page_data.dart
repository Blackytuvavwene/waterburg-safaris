import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';

class ProfileDataPage extends HookConsumerWidget {
  const ProfileDataPage({
    Key? key,
    this.company,
  }) : super(key: key);
  final Company? company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileProfileDataPage(
        company: company,
      ),
      tablet: _TabletProfileDataPage(
        company: company,
      ),
      desktop: _DesktopProfileDataPage(
        company: company,
      ),
    );
  }
}

// mobile profile page
class _MobileProfileDataPage extends HookConsumerWidget {
  const _MobileProfileDataPage({
    Key? key,
    this.company,
  }) : super(key: key);
  final Company? company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabs = [
      {
        'title': 'Details',
        'icon': LineIcon.infoCircle(),
      },
      {
        'title': 'Staff',
        'icon': LineIcon.users(),
      },
      {
        'title': 'Gallery',
        'icon': LineIcon.images(),
      }
    ];
    final tabController = useTabController(
      initialLength: tabs.length,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const DText(
          text: 'Profile',
        ),
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: tabController,
          tabs: tabs
              .map((e) => Tab(
                    text: e['title'].toString(),
                    icon: e['icon'] as Widget,
                  ))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          CompanyDetailsPage(
            companyDetails: company!.companyDetails,
            comapnyId: company!.companyId,
          ),
          CompanyStaffPage(
            companyStaff: company!.companyStaff,
            companyId: company!.companyId,
          ),
          CompanyGalleryPage(
            companyGallery: company!.companyGallery,
            companyId: company!.companyId,
          ),
        ],
      ),
    );
  }
}

// tablet profile page
class _TabletProfileDataPage extends HookConsumerWidget {
  const _TabletProfileDataPage({
    Key? key,
    this.company,
  }) : super(key: key);
  final Company? company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: const Center(
        child: Text(
          'Tablet Profile',
        ),
      ),
    );
  }
}

// desktop profile page
class _DesktopProfileDataPage extends HookConsumerWidget {
  const _DesktopProfileDataPage({
    Key? key,
    this.company,
  }) : super(key: key);
  final Company? company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: const Center(
        child: Text(
          'Desktop Profile',
        ),
      ),
    );
  }
}

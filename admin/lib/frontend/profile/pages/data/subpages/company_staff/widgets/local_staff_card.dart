import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// local staff company card hook consumer widget with app layout
class LocalStaffCard extends HookConsumerWidget {
  const LocalStaffCard({
    super.key,
    this.controller,
    this.initialData,
  });
  final MultipleCompanyStaffLocalControllerNotifier? controller;
  final LocalCompanyStaffModel? initialData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileLocalStaffCard(
        controller: controller,
        initialData: initialData,
      ),
      tablet: _TabletLocalStaffCard(
        controller: controller,
        initialData: initialData,
      ),
      desktop: _DesktopLocalStaffCard(
        controller: controller,
        initialData: initialData,
      ),
    );
  }
}

// mobile local staff company card hook consumer widget
class _MobileLocalStaffCard extends HookConsumerWidget {
  const _MobileLocalStaffCard({
    this.controller,
    this.initialData,
  });
  final MultipleCompanyStaffLocalControllerNotifier? controller;
  final LocalCompanyStaffModel? initialData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // staff image
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Image',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // staff name
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Staff Name',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // staff email
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Staff Email',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // staff phone numbers
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Staff Phone Numbers',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // staff job title
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Staff Job Title',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// tablet local staff company card hook consumer widget
class _TabletLocalStaffCard extends HookConsumerWidget {
  const _TabletLocalStaffCard({
    this.controller,
    this.initialData,
  });
  final MultipleCompanyStaffLocalControllerNotifier? controller;
  final LocalCompanyStaffModel? initialData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // staff image
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Image',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // staff name
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Staff Name',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // staff email
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Staff Email',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // staff phone numbers
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Staff Phone Numbers',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // staff job title
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Staff Job Title',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// desktop local staff company card hook consumer widget
class _DesktopLocalStaffCard extends HookConsumerWidget {
  const _DesktopLocalStaffCard({
    this.controller,
    this.initialData,
  });
  final MultipleCompanyStaffLocalControllerNotifier? controller;
  final LocalCompanyStaffModel? initialData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // staff image
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Image',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // staff name
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Staff Name',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // staff email
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Staff Email',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // staff phone numbers
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Staff Phone Numbers',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // staff job title
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Staff Job Title',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// edit staff details hook consumer widget with app layout
class EditStaffDetails extends HookConsumerWidget {
  const EditStaffDetails({
    Key? key,
    this.companyStaff,
  }) : super(key: key);
  final CompanyStaff? companyStaff;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStaff = useState(companyStaff);
    return AppLayout(
      mobile: _MobileEditStaffDetails(
        companyStaff: currentStaff,
      ),
      tablet: _TabletEditStaffDetails(
        companyStaff: currentStaff,
      ),
      desktop: _DesktopEditStaffDetails(
        companyStaff: currentStaff,
      ),
    );
  }
}

// mobile edit staff details
class _MobileEditStaffDetails extends HookConsumerWidget {
  const _MobileEditStaffDetails({
    Key? key,
    this.companyStaff,
  }) : super(key: key);
  final ValueNotifier<CompanyStaff?>? companyStaff;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Staff Details'),
        actions: [
          IconButton(
            onPressed: () {
              //TODO: update staff details in mobile view
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    backgroundImage: companyStaff?.value?.imageUrl == null
                        ? null
                        : NetworkImage(companyStaff?.value?.imageUrl ?? ''),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        // TODO: add image in mobile view
                      },
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: companyStaff?.value?.fullName,
                onChanged: (value) {
                  companyStaff?.value?.copyWith(fullName: value);
                },
                decoration: const InputDecoration(
                  labelText: 'Staff Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: companyStaff?.value?.jobTitle,
                onChanged: (value) {
                  companyStaff?.value = companyStaff?.value?.copyWith(
                    jobTitle: value,
                  );
                },
                onFieldSubmitted: (value) {
                  companyStaff?.value?.copyWith(jobTitle: 'CEO');
                  companyStaff?.notifyListeners();
                },
                onEditingComplete: () {
                  companyStaff?.value?.copyWith(jobTitle: 'CEO');
                },
                decoration: const InputDecoration(
                  labelText: 'Staff Role',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            DText(
              text: companyStaff?.value?.jobTitle,
            )
          ],
        ),
      ),
    );
  }
}

// tablet edit staff details
class _TabletEditStaffDetails extends HookConsumerWidget {
  const _TabletEditStaffDetails({
    Key? key,
    this.companyStaff,
  }) : super(key: key);
  final ValueNotifier<CompanyStaff?>? companyStaff;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Staff Details'),
        actions: [
          IconButton(
            onPressed: () {
              //TODO: update staff details in tablet view
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    backgroundImage: companyStaff?.value?.imageUrl == null
                        ? null
                        : NetworkImage(companyStaff?.value?.imageUrl ?? ''),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        // TODO: add image in tablet view
                      },
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: companyStaff?.value?.fullName,
                onChanged: (value) {
                  companyStaff?.value?.copyWith(fullName: value);
                },
                decoration: const InputDecoration(
                  labelText: 'Staff Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: companyStaff?.value?.jobTitle,
                onChanged: (value) {
                  companyStaff?.value?.copyWith(jobTitle: value);
                },
                decoration: const InputDecoration(
                  labelText: 'Staff Role',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// desktop edit staff details
class _DesktopEditStaffDetails extends HookConsumerWidget {
  const _DesktopEditStaffDetails({
    Key? key,
    this.companyStaff,
  }) : super(key: key);
  final ValueNotifier<CompanyStaff?>? companyStaff;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Staff Details'),
        actions: [
          IconButton(
            onPressed: () {
              //TODO: update staff details in desktop view
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    backgroundImage: companyStaff?.value?.imageUrl == null
                        ? null
                        : NetworkImage(
                            companyStaff?.value?.imageUrl.toString() ?? ''),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        // TODO: pick image
                      },
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: companyStaff?.value?.fullName,
                onChanged: (value) {
                  companyStaff?.value?.fullName = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Staff Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: companyStaff?.value?.jobTitle,
                onChanged: (value) {
                  companyStaff?.value?.jobTitle = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Staff Role',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

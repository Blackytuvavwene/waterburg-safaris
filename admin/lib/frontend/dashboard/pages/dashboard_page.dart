import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //access providers for the dashboard
    final activitiesList = ref.watch(activitiesStreamProvider);
    final userDataStream = ref.watch(userDataStreamProvider);

    return AppLayout(
      mobile: _MobileDashboardPage(
        activitiesList: activitiesList,
        userDataStream: userDataStream,
      ),
      tablet: _TabletDashboardPage(
        activitiesList: activitiesList,
        userDataStream: userDataStream,
      ),
      desktop: _DesktopDashboardPage(
        activitiesList: activitiesList,
        userDataStream: userDataStream,
      ),
    );
  }
}

// mobile dashboard page
class _MobileDashboardPage extends HookConsumerWidget {
  const _MobileDashboardPage({
    Key? key,
    required this.activitiesList,
    required this.userDataStream,
  }) : super(key: key);
  final AsyncValue<List<Activity>>? activitiesList;
  final AsyncValue<UserModel>? userDataStream;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const DText(
          text: '',
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: const [
            DText(
              text: 'Hello',
            )
          ],
        ),
      )),
    );
  }
}

// tablet dashboard page
class _TabletDashboardPage extends HookConsumerWidget {
  const _TabletDashboardPage({
    Key? key,
    required this.activitiesList,
    required this.userDataStream,
  }) : super(key: key);
  final AsyncValue<List<Activity>>? activitiesList;
  final AsyncValue<UserModel>? userDataStream;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.amberAccent,
      child: const Center(
        child: Text(
          'Tablet Dashboard',
        ),
      ),
    );
  }
}

// desktop dashboard page
class _DesktopDashboardPage extends HookConsumerWidget {
  const _DesktopDashboardPage({
    Key? key,
    required this.activitiesList,
    required this.userDataStream,
  }) : super(key: key);
  final AsyncValue<List<Activity>>? activitiesList;
  final AsyncValue<UserModel>? userDataStream;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.amberAccent,
      child: const Center(
        child: Text(
          'Desktop Dashboard',
        ),
      ),
    );
  }
}

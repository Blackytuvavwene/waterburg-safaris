import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //access providers for the dashboard
    final activitiesList = ref.watch(activitiesStreamProvider);
    final userDataStream = ref.watch(userDataStreamProvider);

    return const AppLayout(
      mobile: _MobileDashboardPage(),
      tablet: _TabletDashboardPage(),
      desktop: _DesktopDashboardPage(),
    );
  }
}

// mobile dashboard page
class _MobileDashboardPage extends HookConsumerWidget {
  const _MobileDashboardPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //access providers for the dashboard
    final activitiesList = ref.watch(activitiesStreamProvider);
    final userDataStream = ref.watch(userDataStreamProvider);
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
          children: [
            const DText(
              text: 'Hello',
            ),
            SizedBox(
              height: 30.h,
              child: activitiesList.when(
                data: (data) {
                  return ListView(
                    children: data
                        .map(
                          (e) => ListTile(
                            title: DText(
                              text: e.activityName,
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
                error: (error, stackTrace) {
                  print(stackTrace);
                  return Container(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: DText(
                      text: error.toString(),
                      textColor: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
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
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //access providers for the dashboard
    final activitiesList = ref.watch(activitiesStreamProvider);
    final userDataStream = ref.watch(userDataStreamProvider);
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
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //access providers for the dashboard
    final activitiesList = ref.watch(activitiesStreamProvider);
    final userDataStream = ref.watch(userDataStreamProvider);
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

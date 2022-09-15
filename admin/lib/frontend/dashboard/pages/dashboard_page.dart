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

    return userDataStream.when(
      data: (data) {
        return AppLayout(
          mobile: _MobileDashboardPage(
            userData: data,
            activitiesWidget: activitiesList.when(
              data: (activities) {
                return DashBoardActivitiesData(
                  activitiesData: activities,
                );
              },
              error: (error, stackTrace) {
                return DashBoardActivitiesError(
                  error: error.toString(),
                );
              },
              loading: () {
                return const DashBoardActivitiesLoading();
              },
            ),
          ),
          tablet: _TabletDashboardPage(
            userData: data,
            activitiesWidget: activitiesList.when(
              data: (activities) {
                return DashBoardActivitiesData(
                  activitiesData: activities,
                );
              },
              error: (error, stackTrace) {
                return DashBoardActivitiesError(
                  error: error.toString(),
                );
              },
              loading: () {
                return const DashBoardActivitiesLoading();
              },
            ),
          ),
          desktop: _DesktopDashboardPage(
            userData: data,
            activitiesWidget: activitiesList.when(
              data: (activities) {
                return DashBoardActivitiesData(
                  activitiesData: activities,
                );
              },
              error: (error, stackTrace) {
                return DashBoardActivitiesError(
                  error: error.toString(),
                );
              },
              loading: () {
                return const DashBoardActivitiesLoading();
              },
            ),
          ),
        );
      },
      loading: () {
        return const DashBoardLoadingPage();
      },
      error: (error, stack) {
        return DashBoardErrorPage(
          errorText: error.toString(),
        );
      },
    );
  }
}

// mobile dashboard page
class _MobileDashboardPage extends HookConsumerWidget {
  const _MobileDashboardPage({
    Key? key,
    this.userData,
    this.activitiesWidget,
  }) : super(key: key);
  final UserModel? userData;
  final Widget? activitiesWidget;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //access providers for the dashboard
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
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 45.h,
              width: 100.w,
              child: activitiesWidget!,
            ),
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
    this.userData,
    this.activitiesWidget,
  }) : super(key: key);
  final UserModel? userData;
  final Widget? activitiesWidget;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: ListView(
          children: [
            Expanded(
              child: activitiesWidget!,
            ),
          ],
        ),
      ),
    );
  }
}

// desktop dashboard page
class _DesktopDashboardPage extends HookConsumerWidget {
  const _DesktopDashboardPage({
    Key? key,
    this.userData,
    this.activitiesWidget,
  }) : super(key: key);
  final UserModel? userData;
  final Widget? activitiesWidget;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: ListView(
          children: [
            Expanded(
              child: activitiesWidget!,
            ),
          ],
        ),
      ),
    );
  }
}

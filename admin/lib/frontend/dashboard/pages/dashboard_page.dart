import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
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
            bookingsWidget: const BookingDashboard(),
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
            bookingsWidget: const BookingDashboard(),
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
  }) : super(key: key);
  final UserModel? userData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //access providers for the dashboard
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const DText(
          text: 'Dashboard',
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                ref.read(authProvider).logout();
              },
              icon: LineIcon.doorOpen())
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.largeX,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Placeholder(
                          fallbackHeight: 10.h,
                          fallbackWidth: 10.h,
                        ),
                        const Spacer(),
                        const DText(
                          text: 'Welcome back',
                          fontSize: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DText(
                          text: '${userData?.username}',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: GridView(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 4.h,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: [
                  InkWell(
                    child: SizedBox(
                      height: 5.h,
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: DText(
                              text: 'Activities',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    child: SizedBox(
                      height: 5.h,
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: DText(
                              text: 'Bookings',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    child: SizedBox(
                      height: 5.h,
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: DText(
                              text: 'Company info',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    child: SizedBox(
                      height: 5.h,
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: DText(
                              text: 'Destinations',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// tablet dashboard page
class _TabletDashboardPage extends HookConsumerWidget {
  const _TabletDashboardPage({
    Key? key,
    this.userData,
    this.activitiesWidget,
    this.bookingsWidget,
  }) : super(key: key);
  final UserModel? userData;
  final Widget? activitiesWidget;
  final Widget? bookingsWidget;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const DText(
          text: 'Dashboard',
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                ref.read(authProvider).logout();
              },
              icon: LineIcon.doorOpen())
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            activitiesWidget!,
            bookingsWidget!,
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
    this.bookingsWidget,
  }) : super(key: key);
  final UserModel? userData;
  final Widget? activitiesWidget;
  final Widget? bookingsWidget;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: ListView(
          children: [
            activitiesWidget!,
            bookingsWidget!,
          ],
        ),
      ),
    );
  }
}

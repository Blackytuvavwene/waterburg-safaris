import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = useState(0);
    var pageController = usePageController(
      initialPage: pageIndex.value,
    );

    // function to animate the page controller to the next page
    void _onItemTapped(int index) {
      pageIndex.value = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      pageController.jumpToPage(index);
    }

    //list of pages
    final pages = [
      const DashboardPage(),
      const ActivitiesPage(),
      const BookingsPage(),
      const ProfilePage(),
    ];

    return AppLayout(
      mobile: _MobileHomePage(
        onNavItemPressed: _onItemTapped,
        pageIndex: pageIndex.value,
        pages: pages,
        pageController: pageController,
      ),
      tablet: _TabletHomePage(
        onNavItemPressed: _onItemTapped,
        pageIndex: pageIndex.value,
        pages: pages,
        pageController: pageController,
      ),
      desktop: _DesktopHomePage(
        onNavItemPressed: _onItemTapped,
        pageIndex: pageIndex.value,
        pages: pages,
        pageController: pageController,
      ),
    );
  }
}

// mobile home page
class _MobileHomePage extends HookConsumerWidget {
  const _MobileHomePage({
    Key? key,
    required this.onNavItemPressed,
    required this.pageIndex,
    required this.pages,
    this.pageController,
  }) : super(key: key);
  final Function? onNavItemPressed;
  final int? pageIndex;
  final List<HookConsumerWidget>? pages;
  final PageController? pageController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: PageView(
          controller: pageController,
          children: pages!,
          onPageChanged: (value) {
            onNavItemPressed!(value);
          },
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          iconTheme: MaterialStateProperty.all(
            IconThemeData(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          labelTextStyle: MaterialStateProperty.all(
            GoogleFonts.dosis(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          selectedIndex: pageIndex!,
          destinations: [
            NavigationDestination(
              icon: LineIcon.alternateTachometer(
                color: pageIndex == 0
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: LineIcon.archive(
                color: pageIndex == 1
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              label: 'Activities',
            ),
            NavigationDestination(
              icon: LineIcon.comments(
                color: pageIndex == 2
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              label: 'Bookings',
            ),
            NavigationDestination(
              icon: LineIcon.user(
                color: pageIndex == 3
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              label: 'Profile',
            ),
          ],
          onDestinationSelected: (index) {
            onNavItemPressed!(index);
          },
        ),
      ),
    );
  }
}

// tablet home page
class _TabletHomePage extends HookConsumerWidget {
  const _TabletHomePage({
    Key? key,
    required this.onNavItemPressed,
    required this.pageIndex,
    required this.pages,
    this.pageController,
  }) : super(key: key);
  final Function? onNavItemPressed;
  final int? pageIndex;
  final List<HookConsumerWidget>? pages;
  final PageController? pageController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: LineIcon.alternateTachometer(
                    color: pageIndex == 0
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  label: const DText(text: 'Dashboard'),
                ),
                NavigationRailDestination(
                  icon: LineIcon.archive(
                    color: pageIndex == 1
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  label: const DText(text: 'Activities'),
                ),
                NavigationRailDestination(
                  icon: LineIcon.comments(
                    color: pageIndex == 2
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  label: const DText(text: 'Bookings'),
                ),
                NavigationRailDestination(
                  icon: LineIcon.user(
                    color: pageIndex == 3
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  label: const DText(text: 'Profile'),
                ),
              ],
              onDestinationSelected: (index) {
                onNavItemPressed!(index);
              },
              selectedIndex: pageIndex,
            ),
            const VerticalDivider(
              width: 0,
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: pages!,
                onPageChanged: (value) {
                  onNavItemPressed!(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// desktop home page
class _DesktopHomePage extends HookConsumerWidget {
  const _DesktopHomePage({
    Key? key,
    required this.onNavItemPressed,
    required this.pageIndex,
    required this.pages,
    this.pageController,
  }) : super(key: key);
  final Function? onNavItemPressed;
  final int? pageIndex;
  final List<HookConsumerWidget>? pages;
  final PageController? pageController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Row(
        children: [
          NavigationRail(
            extended: true,
            destinations: [
              NavigationRailDestination(
                icon: LineIcon.alternateTachometer(
                  color: pageIndex == 0
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                label: const DText(text: 'Dashboard'),
              ),
              NavigationRailDestination(
                icon: LineIcon.archive(
                  color: pageIndex == 1
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                label: const DText(text: 'Activities'),
              ),
              NavigationRailDestination(
                icon: LineIcon.comments(
                  color: pageIndex == 2
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                label: const DText(text: 'Bookings'),
              ),
              NavigationRailDestination(
                icon: LineIcon.user(
                  color: pageIndex == 3
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                label: const DText(text: 'Profile'),
              ),
            ],
            onDestinationSelected: (index) {
              onNavItemPressed!(index);
            },
            selectedIndex: pageIndex,
          ),
          const VerticalDivider(
            width: 0,
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: pages!,
              onPageChanged: (value) {
                onNavItemPressed!(value);
              },
            ),
          ),
        ],
      )),
    );
  }
}

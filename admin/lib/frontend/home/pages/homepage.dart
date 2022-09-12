import 'package:admin/lib.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({
    Key? key,
    required this.index,
    required this.child,
  }) : super(key: key);
  final int index;
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = useState(index);

    // set current index
    useEffect(() {
      pageIndex.value = index;
      return null;
    }, [index]);

    // function to animate the page controller to the next page
    void _onItemTapped(int index) {
      pageIndex.value = index;
      final route = ref.read(nestedRoutesProvider)[index];
      context.go(route.path.toString());
    }

    // animate page change
    Widget child = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => FadeThroughTransition(
        animation: animation,
        secondaryAnimation: ReverseAnimation(animation),
        fillColor: Colors.transparent,
        child: child,
      ),
      child: this.child,
    );

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
        page: child,
      ),
      tablet: _TabletHomePage(
        onNavItemPressed: _onItemTapped,
        pageIndex: pageIndex.value,
        page: child,
      ),
      desktop: _DesktopHomePage(
        onNavItemPressed: _onItemTapped,
        pageIndex: pageIndex.value,
        page: child,
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
    required this.page,
  }) : super(key: key);
  final Function? onNavItemPressed;
  final int? pageIndex;
  final Widget? page;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newRouteMap = RouteMap(
      index: pageIndex!,
      context: context,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: page!,
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
          destinations: ref
              .read(nestedRoutesNavProvider(pageIndex!))
              .map(
                (e) => NavigationDestination(
                  icon: e.icon!,
                  label: e.label.toString(),
                ),
              )
              .toList(),
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
    required this.page,
  }) : super(key: key);
  final Function? onNavItemPressed;
  final int? pageIndex;
  final Widget? page;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newRouteMap = RouteMap(
      index: pageIndex!,
      context: context,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              extended: false,
              destinations: ref
                  .read(nestedRoutesNavProvider(pageIndex!))
                  .map(
                    (e) => NavigationRailDestination(
                      icon: e.icon!,
                      label: DText(
                        text: e.label,
                      ),
                    ),
                  )
                  .toList(),
              onDestinationSelected: (index) {
                onNavItemPressed!(index);
              },
              selectedIndex: pageIndex,
            ),
            const VerticalDivider(
              width: 0,
            ),
            Expanded(
              child: page!,
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
    required this.page,
  }) : super(key: key);
  final Function? onNavItemPressed;
  final int? pageIndex;
  final Widget? page;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  color: pageIndex == 0
    //                   ? Theme.of(context).colorScheme.onPrimary
    //                   : Theme.of(context).colorScheme.onPrimaryContainer,

    final newRouteMap = RouteMap(
      index: pageIndex!,
      context: context,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Row(
        children: [
          NavigationRail(
            extended: true,
            destinations: ref
                .read(nestedRoutesNavProvider(pageIndex!))
                .map(
                  (e) => NavigationRailDestination(
                    icon: e.icon!,
                    label: DText(
                      text: e.label,
                    ),
                  ),
                )
                .toList(),
            onDestinationSelected: (index) {
              onNavItemPressed!(index);
            },
            selectedIndex: pageIndex,
          ),
          const VerticalDivider(
            width: 0,
          ),
          Expanded(
            child: page!,
          ),
        ],
      )),
    );
  }
}

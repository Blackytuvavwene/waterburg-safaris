import 'package:admin/lib.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrouter/vrouter.dart';

final appRouterProvider = Provider.autoDispose<List<VRouteElement>>(
  (ref) {
    final user = ref.watch(currentUserProvider);
    final firstOpen = ref.read(firstLoadProvider);
    return [
      VWidget(
        path: '/',
        name: 'welcome',
        widget: const WelcomePage(),
        // redirect: (state) {
        //   // if first open app navigate to welcome screen
        //   final isFirstOpen = firstOpen.value;

        //   final loggingIn = state.subloc == '/login';

        //   if (isFirstOpen == AppAuthStatus.firstLoad &&
        //       user.value?.uid == null) {
        //     print('hello');
        //     return '/';
        //   }

        //   if (isFirstOpen == AppAuthStatus.loaded &&
        //       user.value?.uid == null) {
        //     print('login');
        //     return '/login';
        //   }

        //   if (isFirstOpen == AppAuthStatus.loaded &&
        //       user.value?.uid != null &&
        //       loggingIn) {
        //     print('home');
        //     return '/home';
        //   }

        //   return null;
        // },
        stackedRoutes: [
          VWidget(
            path: 'login',
            name: 'login',
            widget: const LoginPage(),
          ),
          VWidget(
            path: 'signup',
            name: 'signup',
            widget: const SignUpPage(),
          ),
          VNester(
            path: '/home',
            name: 'home',
            widgetBuilder: (child) => HomePage(
              child: child,
            ),
            nestedRoutes: [
              VWidget(
                path: null,
                name: 'dashboard',
                widget: const DashboardPage(),
              ),
              VWidget(
                path: '/activities',
                name: 'activities',
                widget: const ActivitiesPage(),
                stackedRoutes: [
                  VWidget(
                    path: ':activityId/',
                    name: 'activityDetails',
                    widget: const ActivityPage(),
                    stackedRoutes: [
                      VWidget(
                        path: '/edit',
                        name: 'editActivity',
                        widget: EditActivityPage(
                          activity:
                              ref.watch(activityToEditActivityPageProvider),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              VWidget(
                path: '/bookings',
                name: 'bookings',
                widget: const BookingsPage(),
              ),
              VWidget(
                path: '/profile',
                name: 'profile',
                widget: const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      VWidget(
        path: '/404',
        widget: const NotFoundPage(),
      ),
      VRouteRedirector(
        path: r':_(.+)',
        redirectTo: '/404',
      ),
    ];
  },
);

// get params path
// String? path = state.params['id'];
// //set initial index
// int pageIndex = 0;
// // set initial page
// Widget initialPage =
//     ref.read(nestedRoutesProvider).first.widget!;

// if (path != null) {
//   // set initial index
//   pageIndex = ref
//       .read(nestedRoutesProvider)
//       .indexWhere((element) => element.path == path);

//   // set initial page
//   initialPage = ref
//       .read(nestedRoutesProvider)
//       .firstWhere((element) => element.path == path)
//       .widget!;
// }

// routing with flutter modular
class AppRoutingModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const WelcomePage(),
          transition: TransitionType.rightToLeftWithFade,
          children: [
            ChildRoute(
              '/login',
              child: (context, args) => const LoginPage(),
              transition: TransitionType.rightToLeftWithFade,
            ),
            ChildRoute(
              '/signup',
              child: (context, args) => const SignUpPage(),
              transition: TransitionType.rightToLeftWithFade,
            ),
            ChildRoute(
              '/home',
              child: (context, args) => const HomePage(),
              transition: TransitionType.rightToLeftWithFade,
              children: [
                ChildRoute(
                  '/dashboard',
                  child: (context, args) => const DashboardPage(),
                  transition: TransitionType.rightToLeftWithFade,
                ),
                ChildRoute(
                  '/activities',
                  child: (context, args) => const ActivitiesPage(),
                  transition: TransitionType.rightToLeftWithFade,
                ),
                ChildRoute(
                  '/bookings',
                  child: (context, args) => const BookingsPage(),
                  transition: TransitionType.rightToLeftWithFade,
                ),
                ChildRoute(
                  '/profile',
                  child: (context, args) => const ProfilePage(),
                  transition: TransitionType.rightToLeftWithFade,
                ),
              ],
            )
          ],
        ),
        WildcardRoute(
          child: (context, args) => const NotFoundPage(),
        ),
      ];
}

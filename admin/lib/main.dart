import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:sizer/sizer.dart';

import 'lib.dart';

// navigator keys
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // use url path strategy
// usePathUrlStrategy();
  // initialize firebase_core
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: Layout(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigatorKey = GlobalKey<NavigatorState>();
    final goRouter = ref.watch(goroutingProvider);

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.from(
            colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: Color(0xFF92ccff),
              onPrimary: Color(0xFF003351),
              primaryContainer: Color(0xFF004b73),
              onPrimaryContainer: Color(0xFFcce5ff),
              secondary: Color(0xFF71dba6),
              onSecondary: Color(0xFF003823),
              secondaryContainer: Color(0xFF005235),
              onSecondaryContainer: Color(0xFF8df7c1),
              error: Color(0xFFffb4ab),
              onError: Color(0xFF690005),
              errorContainer: Color(0xFF93000a),
              onErrorContainer: Color(0xFFffdad6),
              background: Color(0xFF1a1c1e),
              onBackground: Color(0xFFe2e2e5),
              surface: Color(0xFF1a1c1e),
              onSurface: Color(0xFFe2e2e5),
              surfaceVariant: Color(0xFF42474e),
              onSurfaceVariant: Color(0xFFc2c7ce),
              outline: Color(0xFF8c9198),
            ),
          ),
          builder: EasyLoading.init(),
          routerConfig: goRouter,
        );
      },
    );

    // return Sizer(
    //   builder: (context, orientation, deviceType) {
    //     return VRouter(
    //       title: 'Waterburg Safaris Admin',
    //       // This transition will be applied to every route
    //       buildTransition: (animation1, _, child) {
    //         return FadeTransition(opacity: animation1, child: child);
    //       },
    //       // beforeEnter: (vRedirector) async => getRedirect(vRedirector),
    //       // You can specify a transition duration (default 300)
    //       transitionDuration: const Duration(milliseconds: 500),
    //       debugShowCheckedModeBanner: false,
    //       theme: ThemeData.from(
    //         colorScheme: const ColorScheme(
    //             brightness: Brightness.dark,
    //             primary: Color(0xFF92ccff),
    //             onPrimary: Color(0xFF003351),
    //             primaryContainer: Color(0xFF004b73),
    //             onPrimaryContainer: Color(0xFFcce5ff),
    //             secondary: Color(0xFF71dba6),
    //             onSecondary: Color(0xFF003823),
    //             secondaryContainer: Color(0xFF005235),
    //             onSecondaryContainer: Color(0xFF8df7c1),
    //             error: Color(0xFFffb4ab),
    //             onError: Color(0xFF690005),
    //             errorContainer: Color(0xFF93000a),
    //             onErrorContainer: Color(0xFFffdad6),
    //             background: Color(0xFF1a1c1e),
    //             onBackground: Color(0xFFe2e2e5),
    //             surface: Color(0xFF1a1c1e),
    //             onSurface: Color(0xFFe2e2e5),
    //             surfaceVariant: Color(0xFF42474e),
    //             onSurfaceVariant: Color(0xFFc2c7ce),
    //             outline: Color(0xFF8c9198)),
    //       ),
    //       routes: [
    //         VGuard(
    //             // beforeEnter: (vRedirector) async =>
    //             //     await getRedirect(vRedirector),
    //             stackedRoutes: [
    //               VWidget(
    //                 path: '/',
    //                 name: 'welcome',
    //                 widget: const WelcomePage(),
    //                 stackedRoutes: [
    //                   VWidget(
    //                     path: 'login',
    //                     name: 'login',
    //                     widget: const LoginPage(),
    //                   ),
    //                   VWidget(
    //                     path: 'signup',
    //                     name: 'signup',
    //                     widget: const SignUpPage(),
    //                   ),
    //                   VNester(
    //                     path: '/home',
    //                     name: 'home',
    //                     widgetBuilder: (child) => HomePage(
    //                       child: child,
    //                     ),
    //                     navigatorKey: navigatorKey,
    //                     nestedRoutes: [
    //                       VWidget(
    //                         path: null,
    //                         name: 'dashboard',
    //                         widget: const DashboardPage(),
    //                       ),
    //                       VWidget(
    //                         path: '/activities',
    //                         name: 'activities',
    //                         widget: const ActivitiesPage(),
    //                         stackedRoutes: [
    //                           VWidget(
    //                             path: ':activityId',
    //                             name: 'activityDetails',
    //                             widget: const ActivityPage(),
    //                             stackedRoutes: [
    //                               VWidget(
    //                                 path: 'edit',
    //                                 name: 'editActivity',
    //                                 widget: EditActivityPage(
    //                                   activity: ref.watch(
    //                                       activityToEditActivityPageProvider),
    //                                 ),
    //                               ),
    //                               VWidget(
    //                                 path: 'package/edit/:activityId/:package',
    //                                 name: 'editPackage',
    //                                 widget: const PackageEditPage(),
    //                               ),
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                       VWidget(
    //                         path: '/bookings',
    //                         name: 'bookings',
    //                         widget: const BookingsPage(),
    //                       ),
    //                       VWidget(
    //                         path: '/profile',
    //                         name: 'profile',
    //                         widget: const ProfilePage(),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ]),
    //         VWidget(
    //           path: '/404',
    //           widget: const NotFoundPage(),
    //         ),
    //         VRouteRedirector(
    //           path: r':_(.+)',
    //           redirectTo: '/404',
    //         ),
    //       ],
    //       builder: EasyLoading.init(),
    //     );
    //   },
    // );
  }
}

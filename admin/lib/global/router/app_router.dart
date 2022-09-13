import 'package:admin/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider.autoDispose(
  (ref) {
    final user = ref.watch(currentUserProvider);
    final firstOpen = ref.read(firstLoadProvider);
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const WelcomePage();
          },
          redirect: (state) {
            // if first open app navigate to welcome screen
            final isFirstOpen = firstOpen.value;

            final loggingIn = state.subloc == '/login';

            if (isFirstOpen == AppAuthStatus.firstLoad &&
                user.value?.uid == null) {
              print('hello');
              return '/';
            }

            if (isFirstOpen == AppAuthStatus.loaded &&
                user.value?.uid == null) {
              print('login');
              return '/login';
            }

            if (isFirstOpen == AppAuthStatus.loaded &&
                user.value?.uid != null &&
                loggingIn) {
              print('home');
              return '/home';
            }

            return null;
          },
          routes: [
            GoRoute(
              path: 'login',
              name: 'login',
              builder: (context, state) {
                return const LoginPage();
              },
            ),
            GoRoute(
              path: 'signup',
              name: 'signup',
              builder: (context, state) {
                return const SignUpPage();
              },
            ),
            GoRoute(
              path: 'home/:id',
              name: 'home',
              redirect: (_) => 'home',
              builder: (context, state) {
                // get params path
                String? path = state.params['id'];
                //set initial index
                int pageIndex = 0;
                // set initial page
                Widget initialPage =
                    ref.read(nestedRoutesProvider).first.widget!;

                if (path != null) {
                  // set initial index
                  pageIndex = ref
                      .read(nestedRoutesProvider)
                      .indexWhere((element) => element.path == path);

                  // set initial page
                  initialPage = ref
                      .read(nestedRoutesProvider)
                      .firstWhere((element) => element.path == path)
                      .widget!;
                }

                return const HomePage();
              },
            ),
          ],
        ),
      ],
      redirectLimit: 15,
    );
  },
);

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

import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider.autoDispose(
  (ref) {
    final user = ref.watch(currentUserProvider);
    final firstOpen = ref.watch(firstLoadProvider);
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const WelcomePage();
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
              path: 'home',
              name: 'home',
              builder: (context, state) {
                return const HomePage();
              },
            ),
          ],
        ),
      ],
      redirect: (state) {
        // if first open app navigate to welcome screen
        final isFirstOpen = firstOpen;

        final loggingIn = state.subloc == '/login';

        String redirectPath() {
          if (isFirstOpen == AppAuthStatus.firstLoad && user.value == null) {
            print('hello');
            return '/home';
          } else if (isFirstOpen == AppAuthStatus.loaded &&
              user.value == null) {
            return '/login';
          }

          if (isFirstOpen == AppAuthStatus.loaded && user.value != null) {
            return '/home';
          }
          return '/';
        }

        return redirectPath();
      },
    );
  },
);

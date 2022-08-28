import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const WelcomePage();
        },
        routes: [
          GoRoute(
            path: 'signup',
            builder: (context, state) {
              return const SignUpPage();
            },
          ),
        ],
      ),
    ],
  ),
);

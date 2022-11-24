// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// navigator keys
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppOpen {
  final AppAuthStatus? status;
  final String? user;

  AppOpen({
    required this.status,
    required this.user,
  });

  @override
  String toString() => 'AppOpen(status: $status, user: $user)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'user': user,
    };
  }

  factory AppOpen.fromMap(Map<String, dynamic> map) {
    return AppOpen(
      status: map['status'] as AppAuthStatus,
      user: map['user'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppOpen.fromJson(String source) =>
      AppOpen.fromMap(json.decode(source) as Map<String, dynamic>);
}

// go router
final goroutingProvider = Provider<GoRouter>(
  (ref) {
    return ref.watch(firstLoadProvider).when(
          data: (dataLoad) {
            return ref.watch(currentUserProvider).when(
              data: (dataUser) {
                return GoRouter(
                  debugLogDiagnostics: true,
                  redirectLimit: 50,
                  redirect: (context, state) {
                    final welcomeLoc = state.subloc == '/';

                    String _getRoutePath() {
                      final route = ref.read(nestedRoutesProvider)[
                          ref.read(routeIndexProvider.notifier).state];
                      return route.path.toString();
                    }

                    final routePath = _getRoutePath();
                    // print(' welcomeLoc: $welcomeLoc');
                    // print('{user: $dataUser, status: $dataLoad}');
                    if (dataLoad == AppAuthStatus.firstLoad &&
                        dataUser == null &&
                        welcomeLoc &&
                        routePath != '') {
                      return null;
                    } else if (dataLoad == AppAuthStatus.loaded &&
                        dataUser == null &&
                        welcomeLoc &&
                        routePath != '') {
                      return '/login';
                    } else if (dataLoad == AppAuthStatus.loaded &&
                        welcomeLoc &&
                        dataUser != null &&
                        routePath == '/home') {
                      return '/home';
                    } else if (dataLoad == AppAuthStatus.loaded &&
                        welcomeLoc &&
                        dataUser != null &&
                        routePath != '/home') {
                      return routePath;
                    } else {
                      return null;
                    }
                  },
                  routes: <GoRoute>[
                    GoRoute(
                      path: '/',
                      name: 'welcome',
                      builder: (context, state) => const WelcomePage(),
                      // redirect: (context, state) {
                      //   print('hello welcome ${state.location}');
                      //   final welcomeLoc = state.location == '/';

                      //   if (data.status == AppAuthStatus.loaded &&
                      //       data.user != null &&
                      //       welcomeLoc) {
                      //     print('home');
                      //     return '/home';
                      //   } else if (data.status == AppAuthStatus.loaded &&
                      //       data.user == null &&
                      //       welcomeLoc) {
                      //     print('login');
                      //     return '/login';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      routes: <RouteBase>[
                        GoRoute(
                          path: 'login',
                          name: 'login',
                          builder: (context, state) => LoginPage(
                            key: state.pageKey,
                          ),
                        ),
                        GoRoute(
                          path: 'signup',
                          name: 'signup',
                          builder: (context, state) => SignUpPage(
                            key: state.pageKey,
                          ),
                        ),
                        ShellRoute(
                          builder: (context, state, child) => HomePage(
                            key: state.pageKey,
                            child: child,
                          ),
                          routes: <GoRoute>[
                            GoRoute(
                              path: 'home',
                              name: 'dashboard',
                              builder: (context, state) => DashboardPage(
                                key: state.pageKey,
                              ),
                            ),
                            GoRoute(
                              path: 'activities',
                              name: 'activities',
                              builder: (context, state) => ActivitiesPage(
                                key: state.pageKey,
                              ),
                              routes: [
                                GoRoute(
                                  path: 'add-activity',
                                  name: 'addActivity',
                                  builder: (context, state) => AddActivityPage(
                                    key: state.pageKey,
                                  ),
                                  routes: [
                                    GoRoute(
                                      path: 'pick-images',
                                      name: 'pickImages',
                                      builder: (context, state) =>
                                          PickImagesPage(
                                        key: state.pageKey,
                                      ),
                                    ),
                                  ],
                                ),
                                GoRoute(
                                  path: ':activityId',
                                  name: 'activityDetails',
                                  builder: (context, state) {
                                    return ActivityPage(
                                      activityId:
                                          state.params['activityId'].toString(),
                                      key: state.pageKey,
                                    );
                                  },
                                  routes: [
                                    GoRoute(
                                      path: 'edit-package/:packageName',
                                      name: 'editPackage',
                                      builder: (context, state) {
                                        final EditPackageModel
                                            packageEditModel =
                                            state.extra as EditPackageModel;

                                        return PackageEditPage(
                                          key: state.pageKey,
                                          editPackageModel: packageEditModel,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            GoRoute(
                              path: 'bookings',
                              name: 'bookings',
                              builder: (context, state) => BookingsPage(
                                key: state.pageKey,
                              ),
                            ),
                            GoRoute(
                                path: 'profile',
                                name: 'profile',
                                builder: (context, state) => ProfilePage(
                                      key: state.pageKey,
                                    ),
                                routes: [
                                  GoRoute(
                                    path: 'edit-staff',
                                    name: 'editStaffDetails',
                                    builder: (context, state) {
                                      final CompanyStaff editStaffModel =
                                          state.extra as CompanyStaff;

                                      return EditStaffDetails(
                                        key: state.pageKey,
                                        companyStaff: editStaffModel,
                                      );
                                    },
                                  ),
                                ]),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
              loading: () {
                return GoRouter(
                  routes: [
                    GoRoute(
                      path: '/',
                      builder: (context, state) {
                        return const SplashScreen();
                      },
                    ),
                  ],
                );
              },
              error: (error, stackTrace) {
                return GoRouter(
                  routes: [
                    GoRoute(
                      path: '/',
                      builder: (context, state) {
                        return const SplashScreen();
                      },
                    ),
                  ],
                );
              },
            );
          },
          loading: () => GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) {
                  return const SplashScreen();
                },
              ),
            ],
          ),
          error: (error, stackTrace) {
            return GoRouter(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) {
                    return const SplashScreen();
                  },
                ),
              ],
            );
          },
        );
  },
);

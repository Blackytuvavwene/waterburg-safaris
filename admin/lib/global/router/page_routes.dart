// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icon.dart';

class RouteModel {
  Widget? widget;
  String? path;
  String? name;
  Icon? icon;
  String? label;
  RouteModel({
    this.widget,
    this.path,
    this.name,
    this.icon,
    this.label,
  });

  RouteModel copyWith({
    Widget? widget,
    String? path,
    String? name,
    Icon? icon,
    String? label,
  }) {
    return RouteModel(
      widget: widget ?? this.widget,
      path: path ?? this.path,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      label: label ?? this.label,
    );
  }
}

List<RouteModel> nestedMainAppRoutes({int? iconColor}) => [
      RouteModel(
        widget: const DashboardPage(),
        path: '/home',
        name: 'dashboard',
        label: 'Dashboard',
        icon: LineIcon.alternateTachometer(
          color: iconColor == 0
              ? const Color(0xFF003351)
              : const Color(0xFFcce5ff),
        ),
      ),
      RouteModel(
        widget: const ActivitiesPage(),
        path: '/activities',
        name: 'activities',
        label: 'Activities',
        icon: LineIcon.archive(
          color: iconColor == 1
              ? const Color(0xFF003351)
              : const Color(0xFFcce5ff),
        ),
      ),
      RouteModel(
        widget: const GalleryPage(),
        path: '/gallery',
        name: 'gallery',
        label: 'Gallery',
        icon: LineIcon.imagesAlt(
          color: iconColor == 2
              ? const Color(0xFF003351)
              : const Color(0xFFcce5ff),
        ),
      ),
      RouteModel(
        widget: const BookingsPage(),
        path: '/bookings',
        name: 'bookings',
        label: 'Bookings',
        icon: LineIcon.comments(
          color: iconColor == 3
              ? const Color(0xFF003351)
              : const Color(0xFFcce5ff),
        ),
      ),
      RouteModel(
        widget: const ProfilePage(),
        path: '/profile',
        name: 'profile',
        label: 'Profile',
        icon: LineIcon.user(
          color: iconColor == 4
              ? const Color(0xFF003351)
              : const Color(0xFFcce5ff),
        ),
      ),
    ];

final nestedRoutesProvider = Provider<List<RouteModel>>((ref) {
  return nestedMainAppRoutes();
});

class RouteMap {
  final BuildContext context;
  final int index;
  RouteMap({
    required this.context,
    required this.index,
  });
}

final nestedRoutesNavProvider =
    Provider.family<List<RouteModel>, int>((ref, index) {
  return nestedMainAppRoutes(
    iconColor: index,
  );
});

class HomePageRouterNotifier extends StateNotifier<int> {
  HomePageRouterNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }

  void setIndexFromPath(String pathName) {
    state =
        nestedMainAppRoutes().indexWhere((element) => element.name == pathName);
  }
}

final routeIndexProvider =
    StateNotifierProvider<HomePageRouterNotifier, int>((ref) {
  return HomePageRouterNotifier();
});

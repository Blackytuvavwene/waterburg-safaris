// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icon.dart';

class RouteModel {
  final Widget? widget;
  final String? path;
  final String? name;
  final Icon? icon;
  final String? label;
  RouteModel({
    this.widget,
    this.path,
    this.name,
    this.icon,
    this.label,
  });
}

List<RouteModel> nestedMainAppRoutes({int? iconColor}) => [
      RouteModel(
        widget: const DashboardPage(),
        path: '/dashboard',
        name: 'dashboard',
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
        icon: LineIcon.archive(
          color: iconColor == 1
              ? const Color(0xFF003351)
              : const Color(0xFFcce5ff),
        ),
      ),
      RouteModel(
        widget: const BookingsPage(),
        path: '/bookings',
        name: 'bookings',
        icon: LineIcon.comments(
          color: iconColor == 2
              ? const Color(0xFF003351)
              : const Color(0xFFcce5ff),
        ),
      ),
      RouteModel(
        widget: const ProfilePage(),
        path: '/profile',
        name: 'profile',
        icon: LineIcon.user(
          color: iconColor == 3
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

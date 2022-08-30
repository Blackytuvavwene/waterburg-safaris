import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookingsPage extends HookConsumerWidget {
  const BookingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileBookingsPage(),
      tablet: _TabletBookingsPage(),
      desktop: _DesktopBookingsPage(),
    );
  }
}

// mobile bookings page
class _MobileBookingsPage extends HookConsumerWidget {
  const _MobileBookingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.greenAccent,
      child: const Center(
        child: Text(
          'Mobile Bookings',
        ),
      ),
    );
  }
}

// tablet bookings page
class _TabletBookingsPage extends HookConsumerWidget {
  const _TabletBookingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.greenAccent,
      child: const Center(
        child: Text(
          'Tablet Bookings',
        ),
      ),
    );
  }
}

// desktop bookings page
class _DesktopBookingsPage extends HookConsumerWidget {
  const _DesktopBookingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.greenAccent,
      child: const Center(
        child: Text(
          'Desktop Bookings',
        ),
      ),
    );
  }
}

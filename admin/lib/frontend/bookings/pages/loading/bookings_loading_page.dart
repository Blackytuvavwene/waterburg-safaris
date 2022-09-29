import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// bookings loading page with applayout hook consumer widget
class BookingsLoadingPage extends HookConsumerWidget {
  const BookingsLoadingPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _BookingsMobileLoadingPage(),
      tablet: _BookingsTabletLoadingPage(),
      desktop: _BookingsDesktopLoadingPage(),
    );
  }
}

// mobile bookings loading page
class _BookingsMobileLoadingPage extends HookConsumerWidget {
  const _BookingsMobileLoadingPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.greenAccent,
      child: const Center(
        child: Text(
          'Mobile Bookings Loading',
        ),
      ),
    );
  }
}

// tablet bookings loading page
class _BookingsTabletLoadingPage extends HookConsumerWidget {
  const _BookingsTabletLoadingPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.greenAccent,
      child: const Center(
        child: Text(
          'Tablet Bookings Loading',
        ),
      ),
    );
  }
}

// desktop bookings loading page
class _BookingsDesktopLoadingPage extends HookConsumerWidget {
  const _BookingsDesktopLoadingPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.greenAccent,
      child: const Center(
        child: Text(
          'Desktop Bookings Loading',
        ),
      ),
    );
  }
}

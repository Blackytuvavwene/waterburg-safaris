import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// bookings error page with applayout hook consumer widget
class BookingsErrorPage extends HookConsumerWidget {
  const BookingsErrorPage({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _BookingsMobileErrorPage(
        error: error,
      ),
      tablet: _BookingsTabletErrorPage(
        error: error,
      ),
      desktop: _BookingsDesktopErrorPage(
        error: error,
      ),
    );
  }
}

// mobile bookings error page
class _BookingsMobileErrorPage extends HookConsumerWidget {
  const _BookingsMobileErrorPage({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
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

// tablet bookings error page
class _BookingsTabletErrorPage extends HookConsumerWidget {
  const _BookingsTabletErrorPage({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
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

// desktop bookings error page
class _BookingsDesktopErrorPage extends HookConsumerWidget {
  const _BookingsDesktopErrorPage({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
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

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class BookingsDataPage extends HookConsumerWidget {
  const BookingsDataPage({
    Key? key,
    this.bookingModel,
  }) : super(key: key);
  final List<BookingModel>? bookingModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileBookingsDataPage(
        bookingModel: bookingModel,
      ),
      tablet: _TabletBookingsDataPage(
        bookingModel: bookingModel,
      ),
      desktop: _DesktopBookingsDataPage(
        bookingModel: bookingModel,
      ),
    );
  }
}

// mobile bookings page
class _MobileBookingsDataPage extends HookConsumerWidget {
  const _MobileBookingsDataPage({
    Key? key,
    this.bookingModel,
  }) : super(key: key);
  final List<BookingModel>? bookingModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookings',
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // search bar
              Container(
                padding: const EdgeInsets.all(8.0),
                width: 100.w,
                height: 8.h,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: GoogleFonts.dosis(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                                onPressed: () {}, icon: LineIcon.search())),
                      ),
                    ),
                  ],
                ),
              ),
              // filter bar
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                ),
                width: 100.w,
                child: Row(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: DText(
                        text: 'Filter',
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(
                            value: 'all',
                            child: Text(
                              'All',
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'pending',
                            child: Text(
                              'Pending',
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'confirmed',
                            child: Text(
                              'Confirmed',
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'cancelled',
                            child: Text(
                              'Cancelled',
                            ),
                          ),
                        ],
                        onChanged: (value) {},
                        value: 'all',
                      ),
                    ),
                  ],
                ),
              ),
              DataTable(
                dataRowHeight: 6.h,
                columnSpacing: 8.w,
                columns: [
                  DataColumn(
                    label: SizedBox(
                      width: 24.w,
                      child: const DText(
                        text: 'Booking code',
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 20.w,
                      child: const DText(
                        text: 'Customer email',
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 30.w,
                      child: const DText(
                        text: 'Booked package name',
                      ),
                    ),
                  ),
                ],
                rows: bookingModel!
                    .map(
                      (bookingModel) => DataRow(
                        cells: [
                          DataCell(
                            SizedBox(
                              width: 24.w,
                              child: DText(
                                text: bookingModel.bookingCode.toString(),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 20.w,
                              child: DText(
                                text: bookingModel.customerDetails?.email,
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 30.w,
                              child: DText(
                                text: bookingModel.activityDetails
                                    ?.bookedPackage?.packageName,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// tablet bookings page
class _TabletBookingsDataPage extends HookConsumerWidget {
  const _TabletBookingsDataPage({
    Key? key,
    this.bookingModel,
  }) : super(key: key);
  final List<BookingModel>? bookingModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: const DText(
                  text: 'Bookings',
                ),
                floating: true,
                snap: true,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: LineIcon.search(),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  width: 100.w,
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: DText(
                          text: 'Filter',
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                              value: 'all',
                              child: Text(
                                'All',
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'pending',
                              child: Text(
                                'Pending',
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'confirmed',
                              child: Text(
                                'Confirmed',
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'cancelled',
                              child: Text(
                                'Cancelled',
                              ),
                            ),
                          ],
                          onChanged: (value) {},
                          value: 'all',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: DataTable(
                  dataRowHeight: 6.h,
                  columnSpacing: 8.w,
                  columns: [
                    DataColumn(
                      label: SizedBox(
                        width: 24.w,
                        child: const DText(
                          text: 'Booking code',
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 20.w,
                        child: const DText(
                          text: 'Customer email',
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 30.w,
                        child: const DText(
                          text: 'Booked package name',
                        ),
                      ),
                    ),
                  ],
                  rows: bookingModel!
                      .map(
                        (bookingModel) => DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                width: 24.w,
                                child: DText(
                                  text: bookingModel.bookingCode.toString(),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 20.w,
                                child: DText(
                                  text: bookingModel.customerDetails?.email,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 30.w,
                                child: DText(
                                  text: bookingModel.activityDetails
                                      ?.bookedPackage?.packageName,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// desktop bookings page
class _DesktopBookingsDataPage extends HookConsumerWidget {
  const _DesktopBookingsDataPage({
    Key? key,
    this.bookingModel,
  }) : super(key: key);
  final List<BookingModel>? bookingModel;
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

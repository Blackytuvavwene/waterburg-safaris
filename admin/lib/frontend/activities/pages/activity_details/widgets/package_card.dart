import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class PackageCard extends HookConsumerWidget {
  const PackageCard({
    Key? key,
    this.package,
  }) : super(key: key);
  final Package? package;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: context.breakpoint > LayoutBreakpoint.sm ? 20.w : 80.w,
      height: context.breakpoint > LayoutBreakpoint.sm ? 70.h : 50.h,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100.w,
              color: Theme.of(context).colorScheme.secondary,
              padding: EdgeInsets.all(
                2.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 100.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DText(
                          text: package!.packageName,
                          textColor: Theme.of(context).colorScheme.onPrimary,
                          fontSize: context.breakpoint > LayoutBreakpoint.sm
                              ? 6.sp
                              : 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        IconButton(onPressed: () {}, icon: LineIcon.editAlt()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    width: 100.w,
                    child: DText(
                      text: '\$ ${package!.price.toString()}',
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      fontSize: context.breakpoint > LayoutBreakpoint.sm
                          ? 4.sp
                          : 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.all(
                  2.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DText(
                      text: 'Package offers:',
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      fontSize: context.breakpoint > LayoutBreakpoint.sm
                          ? 4.sp
                          : 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    package!.packageOffers!.isNotEmpty
                        ? Expanded(
                            flex: 6,
                            child: ListView.separated(
                              itemCount: package!.packageOffers!.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 2.h,
                                );
                              },
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: 20.w,
                                  height: 3.h,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      LineIcon.checkCircleAlt(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Expanded(
                                        child: DText(
                                          text: package?.packageOffers![index],
                                          textColor: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: context.breakpoint >
                                                  LayoutBreakpoint.sm
                                              ? 6.sp
                                              : 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : Expanded(
                            child: DText(
                              text: 'No offers',
                              textColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              fontSize: 6.sp,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// package edit page
class PackageEditPage extends HookConsumerWidget {
  const PackageEditPage({
    Key? key,
    this.package,
  }) : super(key: key);
  final Package? package;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // controllers
    final packageName = useTextEditingController(text: package?.packageName);
    final keywords = useRef(package?.keywords);
    final keywordsController = useTextEditingController();
    final description = useTextEditingController(text: package?.description);
    final price = useTextEditingController(text: package?.price.toString());
    final lastPrice =
        useTextEditingController(text: package?.lastPrice.toString());

    final discountPercentage =
        useTextEditingController(text: package?.discountPercentage.toString());
    final coupon = useTextEditingController(text: package?.coupon);
    final packageOffers = useRef(package?.packageOffers);
    final packageOffersController = useTextEditingController();
    return AppLayout(
      mobile: _MobilePackageEditPage(
        package: package,
        packageName: packageName,
        keywords: keywords,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
        packageOffers: packageOffers,
        packageOffersController: packageOffersController,
      ),
      tablet: _TabletPackageEditPage(
        package: package,
        packageName: packageName,
        keywords: keywords,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
        packageOffers: packageOffers,
        packageOffersController: packageOffersController,
      ),
      desktop: _DesktopPackageEditPage(
        package: package,
        packageName: packageName,
        keywords: keywords,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
        packageOffers: packageOffers,
        packageOffersController: packageOffersController,
      ),
    );
  }
}

// mobile package edit page
class _MobilePackageEditPage extends HookConsumerWidget {
  const _MobilePackageEditPage({
    Key? key,
    this.package,
    this.packageName,
    this.keywords,
    this.keywordsController,
    this.description,
    this.price,
    this.lastPrice,
    this.discountPercentage,
    this.coupon,
    this.packageOffers,
    this.packageOffersController,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final ObjectRef<List<String>?>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ObjectRef<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: DText(
          text: 'Edit Package',
          textColor: Theme.of(context).colorScheme.onPrimary,
          fontSize: 16.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 2.h,
            ),
            PackageEditForm(
              package: package,
              packageName: packageName,
              keywords: keywords,
              keywordsController: keywordsController,
              description: description,
              price: price,
              lastPrice: lastPrice,
              discountPercentage: discountPercentage,
              coupon: coupon,
              packageOffers: packageOffers,
              packageOffersController: packageOffersController,
            ),
          ],
        ),
      ),
    );
  }
}

// tablet package edit page
class _TabletPackageEditPage extends HookConsumerWidget {
  const _TabletPackageEditPage({
    Key? key,
    this.package,
    this.packageName,
    this.keywords,
    this.keywordsController,
    this.description,
    this.price,
    this.lastPrice,
    this.discountPercentage,
    this.coupon,
    this.packageOffers,
    this.packageOffersController,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final ObjectRef<List<String>?>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ObjectRef<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: DText(
          text: 'Edit Package',
          textColor: Theme.of(context).colorScheme.onPrimary,
          fontSize: 16.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 2.h,
            ),
            PackageEditForm(
              package: package,
              packageName: packageName,
              keywords: keywords,
              keywordsController: keywordsController,
              description: description,
              price: price,
              lastPrice: lastPrice,
              discountPercentage: discountPercentage,
              coupon: coupon,
              packageOffers: packageOffers,
              packageOffersController: packageOffersController,
            ),
          ],
        ),
      ),
    );
  }
}

// desktop package edit page
class _DesktopPackageEditPage extends HookConsumerWidget {
  const _DesktopPackageEditPage({
    Key? key,
    this.package,
    this.packageName,
    this.keywords,
    this.keywordsController,
    this.description,
    this.price,
    this.lastPrice,
    this.discountPercentage,
    this.coupon,
    this.packageOffers,
    this.packageOffersController,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final ObjectRef<List<String>?>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ObjectRef<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: DText(
          text: 'Edit Package',
          textColor: Theme.of(context).colorScheme.onPrimary,
          fontSize: 16.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 2.h,
            ),
            PackageEditForm(
              package: package,
              packageName: packageName,
              keywords: keywords,
              keywordsController: keywordsController,
              description: description,
              price: price,
              lastPrice: lastPrice,
              discountPercentage: discountPercentage,
              coupon: coupon,
              packageOffers: packageOffers,
              packageOffersController: packageOffersController,
            ),
          ],
        ),
      ),
    );
  }
}

// package edit form with app layout
class PackageEditForm extends HookConsumerWidget {
  const PackageEditForm({
    Key? key,
    this.package,
    this.packageName,
    this.keywords,
    this.keywordsController,
    this.description,
    this.price,
    this.lastPrice,
    this.discountPercentage,
    this.coupon,
    this.packageOffers,
    this.packageOffersController,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final ObjectRef<List<String>?>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ObjectRef<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobilePackageEditForm(
        package: package,
        packageName: packageName,
        keywords: keywords,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
        packageOffers: packageOffers,
        packageOffersController: packageOffersController,
      ),
      tablet: _TabletPackageEditForm(
        package: package,
        packageName: packageName,
        keywords: keywords,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
        packageOffers: packageOffers,
        packageOffersController: packageOffersController,
      ),
      desktop: _DesktopPackageEditForm(
        package: package,
        packageName: packageName,
        keywords: keywords,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
        packageOffers: packageOffers,
        packageOffersController: packageOffersController,
      ),
    );
  }
}

// mobile package edit form with all fields
class _MobilePackageEditForm extends HookConsumerWidget {
  const _MobilePackageEditForm({
    Key? key,
    this.package,
    this.packageName,
    this.keywords,
    this.keywordsController,
    this.description,
    this.price,
    this.lastPrice,
    this.discountPercentage,
    this.coupon,
    this.packageOffers,
    this.packageOffersController,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final ObjectRef<List<String>?>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ObjectRef<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: packageName,
            decoration: const InputDecoration(
              labelText: 'Package Name',
              hintText: 'Enter Package Name',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: keywordsController,
            decoration: const InputDecoration(
              labelText: 'Keywords',
              hintText: 'Enter Keywords',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: description,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Enter Description',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: price,
            decoration: const InputDecoration(
              labelText: 'Price',
              hintText: 'Enter Price',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: lastPrice,
            decoration: const InputDecoration(
              labelText: 'Last Price',
              hintText: 'Enter Last Price',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: discountPercentage,
            decoration: const InputDecoration(
              labelText: 'Discount Percentage',
              hintText: 'Enter Discount Percentage',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: coupon,
            decoration: const InputDecoration(
              labelText: 'Coupon',
              hintText: 'Enter Coupon',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: packageOffersController,
            decoration: const InputDecoration(
              labelText: 'Package Offers',
              hintText: 'Enter Package Offers',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          ElevatedButton(
            onPressed: () {},
            child: DText(
              text: 'Update Package',
              textColor: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

// tablet package edit form with all fields
class _TabletPackageEditForm extends HookConsumerWidget {
  const _TabletPackageEditForm({
    Key? key,
    this.package,
    this.packageName,
    this.keywords,
    this.keywordsController,
    this.description,
    this.price,
    this.lastPrice,
    this.discountPercentage,
    this.coupon,
    this.packageOffers,
    this.packageOffersController,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final ObjectRef<List<String>?>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ObjectRef<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: packageName,
            decoration: const InputDecoration(
              labelText: 'Package Name',
              hintText: 'Enter Package Name',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: keywordsController,
            decoration: const InputDecoration(
              labelText: 'Keywords',
              hintText: 'Enter Keywords',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: description,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Enter Description',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: price,
            decoration: const InputDecoration(
              labelText: 'Price',
              hintText: 'Enter Price',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: lastPrice,
            decoration: const InputDecoration(
              labelText: 'Last Price',
              hintText: 'Enter Last Price',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: discountPercentage,
            decoration: const InputDecoration(
              labelText: 'Discount Percentage',
              hintText: 'Enter Discount Percentage',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: coupon,
            decoration: const InputDecoration(
              labelText: 'Coupon',
              hintText: 'Enter Coupon',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: packageOffersController,
            decoration: const InputDecoration(
              labelText: 'Package Offers',
              hintText: 'Enter Package Offers',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          ElevatedButton(
            onPressed: () {},
            child: DText(
              text: 'Update Package',
              textColor: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

// desktop package edit form with all fields
class _DesktopPackageEditForm extends HookConsumerWidget {
  const _DesktopPackageEditForm({
    Key? key,
    this.package,
    this.packageName,
    this.keywords,
    this.keywordsController,
    this.description,
    this.price,
    this.lastPrice,
    this.discountPercentage,
    this.coupon,
    this.packageOffers,
    this.packageOffersController,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final ObjectRef<List<String>?>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ObjectRef<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: packageName,
            decoration: const InputDecoration(
              labelText: 'Package Name',
              hintText: 'Enter Package Name',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: keywordsController,
            decoration: const InputDecoration(
              labelText: 'Keywords',
              hintText: 'Enter Keywords',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: description,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Enter Description',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: price,
            decoration: const InputDecoration(
              labelText: 'Price',
              hintText: 'Enter Price',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: lastPrice,
            decoration: const InputDecoration(
              labelText: 'Last Price',
              hintText: 'Enter Last Price',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: discountPercentage,
            decoration: const InputDecoration(
              labelText: 'Discount Percentage',
              hintText: 'Enter Discount Percentage',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: coupon,
            decoration: const InputDecoration(
              labelText: 'Coupon',
              hintText: 'Enter Coupon',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          TextFormField(
            controller: packageOffersController,
            decoration: const InputDecoration(
              labelText: 'Package Offers',
              hintText: 'Enter Package Offers',
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          ElevatedButton(
            onPressed: () {},
            child: DText(
              text: 'Update Package',
              textColor: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

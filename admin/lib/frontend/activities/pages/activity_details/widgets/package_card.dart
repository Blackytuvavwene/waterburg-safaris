import 'dart:convert';

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';
import 'package:vrouter/vrouter.dart';

// package update controller
class PackageControllerNotifier extends StateNotifier<AsyncValue<Package>?> {
  PackageControllerNotifier()
      : super(
          AsyncData(
            Package(),
          ),
        );

  // set package
  void setPackage(Package package) {
    state = AsyncData(package);
  }

  // update package
  void updatePackage(Package package) {
    state = AsyncData(package);
  }

  // save package to firestore
  // Future<void> savePackage(BuildContext context) async {
  //   final package = state?.data?.value;
  //   final activityId = context.vRouter.pathParameters['activityId'];
  //   final packageRef =
  //       FirebaseFirestore.instance.collection('activities/$activityId').where();
  //   final packageData = package?.toJson();
  //   await packageRef.update(packageData);
  // }
}

// keywords state controller
class KeywordsControllerNotifier extends StateNotifier<List<String>> {
  KeywordsControllerNotifier({
    this.keywords,
  }) : super(keywords!);

  // initial keywords
  List<String>? keywords;

  // set keywords
  void setKeywords(List<String> keywords) {
    state = keywords;
  }

  // update keywords
  void updateKeywords(List<String> keywords) {
    state = keywords;
  }

  // add keyword to state
  void addKeyword(String keyword) {
    // final keywords = state;
    // keywords.add(keyword);
    print('new keyword: $keyword');
    state = [...state, keyword];
    print('keywords: $state');
  }
}

// initial keywords
final intialKeywordsProvider =
    Provider.family<List<String>, BuildContext>((ref, context) {
  //TODO: get keywords from path
  final package =
      Package.fromJson(jsonDecode('package') as Map<String, dynamic>);
  final List<String> keywords = package.keywords!;
  return keywords;
});

// kewords state notifier
final keywordsControllerProvider = StateNotifierProvider.family<
    KeywordsControllerNotifier, List<String>, BuildContext>(
  (ref, context) => KeywordsControllerNotifier(
      keywords: ref.read<List<String>>(intialKeywordsProvider(context))),
);

class PackageCard extends HookConsumerWidget {
  const PackageCard({
    Key? key,
    this.package,
    this.activityId,
  }) : super(key: key);
  final Package? package;
  final String? activityId;

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
                        IconButton(
                            onPressed: () async {
                              // navigate to edit package page
                              context.pushNamed('editPackage', params: {
                                'activityId': activityId!,
                                'package': jsonEncode(package?.toJson())
                              });
                            },
                            icon: LineIcon.editAlt()),
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
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final package = Package.fromJson(
        jsonDecode(context.vRouter.pathParameters['package']!)
            as Map<String, dynamic>);
    final activityId = context.vRouter.pathParameters['activityId']!;

    // controllers
    final packageName = useTextEditingController(text: package.packageName);
    final keywords = ref.watch(keywordsControllerProvider(context));
    final keywordsController = useTextEditingController();
    final description = useTextEditingController(text: package.description);
    final price = useTextEditingController(text: package.price.toString());
    final lastPrice =
        useTextEditingController(text: package.lastPrice.toString());

    final discountPercentage =
        useTextEditingController(text: package.discountPercentage.toString());
    final coupon = useTextEditingController(text: package.coupon);
    final packageOffers = useRef(package.packageOffers);
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
        activityId: activityId,
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
        activityId: activityId,
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
        activityId: activityId,
      ),
    );
  }
}

// mobile package edit page
class _MobilePackageEditPage extends HookConsumerWidget {
  _MobilePackageEditPage({
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
    this.activityId,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  List<String>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ObjectRef<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  final String? activityId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: DText(
          text: 'Edit Package',
          fontSize: 16.sp,
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: LineIcon.chevronCircleLeft(),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final packageD = Package(
                packageId: package!.packageId,
                packageName: packageName!.text,
                keywords: keywords!,
                description: description!.text,
                price: double.parse(price!.text),
                lastPrice: double.parse(lastPrice!.text),
                discountPercentage: double.parse(discountPercentage!.text),
                coupon: coupon!.text,
                packageOffers: packageOffers!.value,
              );
              // final result = await ref.read(packageProvider.notifier).update(
              //       activityId: activityId!,
              //       package: package,
              //       packageId: package.packageId,
              //     );
              // if (result) {
              //   context.vRouter.pop();
              // }
            },
            icon: LineIcon.save(),
          ),
        ],
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
              activityId: activityId,
            ),
          ],
        ),
      ),
    );
  }
}

// tablet package edit page
class _TabletPackageEditPage extends HookConsumerWidget {
  _TabletPackageEditPage({
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
    this.activityId,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  List<String>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ObjectRef<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  final String? activityId;
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
              activityId: activityId,
            ),
          ],
        ),
      ),
    );
  }
}

// desktop package edit page
class _DesktopPackageEditPage extends HookConsumerWidget {
  _DesktopPackageEditPage({
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
    this.activityId,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  List<String>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ObjectRef<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  final String? activityId;
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
              activityId: activityId,
            ),
          ],
        ),
      ),
    );
  }
}

// package edit form with app layout
class PackageEditForm extends HookConsumerWidget {
  PackageEditForm({
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
    this.activityId,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  List<String>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ObjectRef<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  final String? activityId;
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
        activityId: activityId,
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
        activityId: activityId,
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
        activityId: activityId,
      ),
    );
  }
}

// mobile package edit form with all fields
class _MobilePackageEditForm extends HookConsumerWidget {
  _MobilePackageEditForm({
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
    this.activityId,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  List<String>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ObjectRef<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  final String? activityId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: packageName,
              decoration: const InputDecoration(
                labelText: 'Package Name',
                hintText: 'Enter Package Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Column(
              children: [
                DText(
                  text: 'Keywords',
                  fontSize: 14.sp,
                ),
                Wrap(
                  spacing: 2.w,
                  children: [
                    ...keywords!
                        .map((keyword) => Chip(
                              label: Text(keyword),
                            ))
                        .toList()
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              height: 8.h,
              child: TextFormField(
                controller: keywordsController,
                onSaved: (newValue) {
                  keywords!.add(newValue!);
                },
                decoration: InputDecoration(
                  labelText: 'Keywords',
                  hintText: 'Enter Keyword',
                  border: const OutlineInputBorder(),
                  hintStyle: GoogleFonts.dosis(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  suffix: TextButton.icon(
                    style: TextButton.styleFrom(
                        minimumSize: Size(
                      6.w,
                      4.h,
                    )),
                    onPressed: () {
                      ref
                          .read(keywordsControllerProvider(context).notifier)
                          .addKeyword(keywordsController!.text);
                      keywordsController!.clear();
                    },
                    icon: LineIcon.plus(),
                    label: const DText(
                      text: 'Add',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            TextFormField(
              controller: description,
              minLines: 1,
              maxLines: 10,
              maxLength: 1000,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              controller: price,
              keyboardType: TextInputType.number,
              validator: (value) {
                CustomFormValidators.onlyDouble(value!);
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Price',
                hintText: 'Enter Price',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              controller: lastPrice,
              keyboardType: TextInputType.number,
              validator: (value) {
                CustomFormValidators.onlyDouble(value!);
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Last Price',
                hintText: 'Enter Last Price',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              controller: discountPercentage,
              keyboardType: TextInputType.number,
              validator: (value) {
                CustomFormValidators.onlyDouble(value!);
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Discount Percentage',
                hintText: 'Enter Discount Percentage',
                border: OutlineInputBorder(),
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
                border: OutlineInputBorder(),
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
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Column(
              children: [
                DText(
                  text: 'Package Offers',
                  fontSize: 14.sp,
                ),
                Wrap(
                  spacing: 2.w,
                  children: [
                    ...packageOffers!.value!
                        .map((keyword) => Chip(
                              label: Text(keyword),
                            ))
                        .toList()
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            CustomElevatedButton(
              onPressed: () {},
              text: 'Update Package',
              fontSize: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}

// tablet package edit form with all fields
class _TabletPackageEditForm extends HookConsumerWidget {
  _TabletPackageEditForm({
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
    this.activityId,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  List<String>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ObjectRef<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  final String? activityId;
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
  _DesktopPackageEditForm({
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
    this.activityId,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  List<String>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ObjectRef<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  final String? activityId;
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

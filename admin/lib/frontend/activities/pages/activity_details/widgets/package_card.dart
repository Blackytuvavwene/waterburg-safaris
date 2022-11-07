// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class EditPackageModel {
  final Package package;
  final String activityId;
  final Package packageCopy;
  final List<Package> packages;
  EditPackageModel({
    required this.package,
    required this.activityId,
    required this.packageCopy,
    required this.packages,
  });
}

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
  Future<void> savePackage({
    EditPackageModel? editPackageModel,
    Package? newPackage,
  }) async {
    final activityId = editPackageModel?.activityId;
    final packageRef =
        FirebaseFirestore.instance.collection('activities').doc(activityId);

    // update package from list where it equals old package
    final packages = editPackageModel?.packages;
    final oldPackage = editPackageModel?.package;
    final newPackages = packages?.map((e) {
      if (e == oldPackage) {
        return newPackage;
      } else {
        return e;
      }
    }).toList();

    print('newPackages: ${newPackages?.map((e) => e?.toJson()).toList()}');

    // final packageData = package?.toJson();
    await packageRef.update({
      'packages': newPackages?.map((e) => e?.toJson()).toList(),
    });
  }
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
    Provider.family<List<String>, List<String>>((ref, keywords) {
  return keywords;
});

// kewords state notifier
final keywordsControllerProvider = StateNotifierProvider.family<
    KeywordsControllerNotifier, List<String>, List<String>>(
  (ref, keywords) => KeywordsControllerNotifier(
    keywords: ref.read<List<String>>(
      intialKeywordsProvider(keywords),
    ),
  ),
);

// package controller notifier
final packageControllerProvider =
    StateNotifierProvider<PackageControllerNotifier, AsyncValue<Package>?>(
  (ref) => PackageControllerNotifier(),
);

class PackageCard extends HookConsumerWidget {
  const PackageCard({
    Key? key,
    this.package,
    this.activityId,
    this.packages,
  }) : super(key: key);
  final Package? package;
  final String? activityId;
  final List<Package>? packages;

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
                          text: package?.packageName,
                          textColor: Theme.of(context).colorScheme.onPrimary,
                          fontSize: context.breakpoint > LayoutBreakpoint.sm
                              ? 6.sp
                              : 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        IconButton(
                            onPressed: () async {
                              // navigate to edit package page
                              context.pushNamed('editPackage',
                                  extra: EditPackageModel(
                                      package: package!,
                                      activityId: activityId!,
                                      packageCopy: package!,
                                      packages: packages!),
                                  params: {
                                    'activityId': activityId!,
                                    'packageName': package!.packageName!,
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
                      text: '\$ ${package?.price.toString()}',
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
                    package?.packageOffers != null
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
                        : const SizedBox.shrink(),
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
    this.editPackageModel,
  }) : super(key: key);
  final EditPackageModel? editPackageModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // controllers
    final tryState = useState(editPackageModel!.package.keywords);
    final packageName =
        useTextEditingController(text: editPackageModel!.package.packageName);

    final keywordsController = useTextEditingController();
    final description =
        useTextEditingController(text: editPackageModel!.package.description);
    final price = useTextEditingController(
        text: editPackageModel!.package.price.toString());
    final lastPrice = useTextEditingController(
        text: editPackageModel!.package.lastPrice.toString());

    final discountPercentage = useTextEditingController(
        text: editPackageModel!.package.discountPercentage.toString());
    final coupon =
        useTextEditingController(text: editPackageModel!.package.coupon);
    final packageOffers = useState(editPackageModel!.package.packageOffers);
    final packageOffersController = useTextEditingController();

    return AppLayout(
      mobile: _MobilePackageEditPage(
        package: editPackageModel!.package,
        packageName: packageName,
        keywords: tryState,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
        packageOffers: packageOffers,
        packageOffersController: packageOffersController,
        activityId: editPackageModel!.activityId,
        editPackageModel: editPackageModel,
      ),
      tablet: _TabletPackageEditPage(
        package: editPackageModel!.package,
        packageName: packageName,
        keywords: tryState,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
        packageOffers: packageOffers,
        packageOffersController: packageOffersController,
        activityId: editPackageModel!.activityId,
      ),
      desktop: _DesktopPackageEditPage(
        package: editPackageModel!.package,
        packageName: packageName,
        keywords: tryState,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
        packageOffers: packageOffers,
        packageOffersController: packageOffersController,
        activityId: editPackageModel!.activityId,
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
    this.activityId,
    this.editPackageModel,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final ValueNotifier<List<String>?>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ValueNotifier<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  final String? activityId;
  final EditPackageModel? editPackageModel;
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
                keywords: keywords!.value,
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

              ref.read(packageControllerProvider.notifier).savePackage(
                    editPackageModel: editPackageModel!,
                    newPackage: packageD,
                  );
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
    this.activityId,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final ValueNotifier<List<String>?>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ValueNotifier<List<String>?>? packageOffers;
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
    this.activityId,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final ValueNotifier<List<String>?>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ValueNotifier<List<String>?>? packageOffers;
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
    this.activityId,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final ValueNotifier<List<String>?>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ValueNotifier<List<String>?>? packageOffers;
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
    this.activityId,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final ValueNotifier<List<String>?>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ValueNotifier<List<String>?>? packageOffers;
  final TextEditingController? packageOffersController;
  final String? activityId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tryDOOOList = useState<List<String>?>(['hekeke', 'dhdbc']);
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
                    ...keywords!.value!
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
                  keywords!.value = [...keywords!.value!, newValue!];
                },
                decoration: InputDecoration(
                  labelText: 'Keywords',
                  hintText: 'Enter Keyword',
                  border: const OutlineInputBorder(),
                  hintStyle: GoogleFonts.dosis(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  suffixIconConstraints: BoxConstraints(
                    minHeight: 2.h,
                    minWidth: 26.w,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size(
                          6.w,
                          7.h,
                        ),
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .surfaceVariant
                            .withOpacity(0.2),
                      ),
                      onPressed: () {
                        keywords!.value = [
                          ...keywords!.value!,
                          keywordsController!.text
                        ];
                        keywordsController!.clear();
                      },
                      child: const DText(
                        text: 'Add',
                      ),
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
              decoration: InputDecoration(
                labelText: 'Package Offers',
                hintText: 'Enter Package Offers',
                border: const OutlineInputBorder(),
                suffixIconConstraints: BoxConstraints(
                  minHeight: 2.h,
                  minWidth: 26.w,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(
                        6.w,
                        7.h,
                      ),
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .surfaceVariant
                          .withOpacity(0.2),
                    ),
                    onPressed: () {
                      packageOffers!.value = [
                        ...packageOffers!.value!,
                        packageOffersController!.text
                      ];
                      packageOffersController!.clear();
                    },
                    child: const DText(
                      text: 'Add',
                    ),
                  ),
                ),
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
                        .map(
                          (keyword) => Chip(
                            label: DText(text: keyword),
                            padding: EdgeInsets.all(
                              10.sp,
                            ),
                            deleteIcon: LineIcon.trash(
                              color: Theme.of(context).colorScheme.error,
                            ),
                            onDeleted: () {
                              packageOffers!.value =
                                  packageOffers!.value!.where((element) {
                                return element != keyword;
                              }).toList();
                            },
                          ),
                        )
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
    this.activityId,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final ValueNotifier<List<String>?>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ValueNotifier<List<String>?>? packageOffers;
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
    this.activityId,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final ValueNotifier<List<String>?>? keywords;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final ValueNotifier<List<String>?>? packageOffers;
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

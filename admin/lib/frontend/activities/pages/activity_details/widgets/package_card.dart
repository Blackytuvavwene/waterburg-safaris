// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:admin/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class EditPackageModel {
  final Package package;
  final String activityId;
  final Package packageCopy;
  final List<Package> packages;
  final ActivityControlNotifier activityNotifier;
  final int? index;
  EditPackageModel({
    required this.package,
    required this.activityId,
    required this.packageCopy,
    required this.packages,
    required this.activityNotifier,
    this.index,
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
    this.activityNotifier,
    this.index,
  }) : super(key: key);
  final Package? package;
  final String? activityId;
  final List<Package>? packages;
  final ActivityControlNotifier? activityNotifier;
  final int? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        onLongPress: () async {
          // show delete dialog
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const DText(
                    text: 'Delete Package',
                  ),
                  content: const DText(
                    text: 'Are you sure you want to delete this package?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const DText(
                        text: 'No',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // delete package
                        activityNotifier?.deletePackageFromList(index: index!);

                        // pop dialog
                        context.pop();
                      },
                      child: const DText(
                        text: 'Yes',
                      ),
                    ),
                  ],
                );
              });
          // QuickAlert.show(
          //   context: context,
          //   type: QuickAlertType.confirm,
          //   title: 'Delete Package',
          //   cancelBtnText: 'No',
          //   confirmBtnText: 'Yes',
          //   onCancelBtnTap: () {
          //     Navigator.pop(context);
          //   },
          //   onConfirmBtnTap: () {
          //     // delete package
          //     activityNotifier?.deletePackageFromList(index: index!);

          //     // pop dialog
          //     Navigator.pop(context);
          //   },
          // );
        },
        onTap: () {
          // navigate to package edit page with push named
          context.pushNamed(
            'editPackage',
            pathParameters: {
              'activityId': activityId!,
              'packageName': package!.packageName.toString(),
            },
            extra: EditPackageModel(
              package: package!,
              activityId: activityId!,
              packageCopy: package!,
              packages: packages!,
              index: index!,
              activityNotifier: activityNotifier!,
            ),
          );
        },
        tileColor: Theme.of(context).colorScheme.secondaryContainer.withOpacity(
              0.1,
            ),
        title: DText(
          text: package?.packageName,
          fontWeight: FontWeight.w600,
        ),
        subtitle: DText(
          text: package?.description,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          minFontSize: 14,
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(
            5,
          ),
          child: ColoredBox(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: SizedBox(
              height: 10.h,
              width: 14.w,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DText(
                      text: 'Price',
                      fontWeight: FontWeight.bold,
                      textColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    DText(
                      text: '\$ ${package?.price.toString()}',
                      textColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        isThreeLine: true,
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
    final package = ref.watch(
      packageControlNotifierProvider(
        editPackageModel?.package,
      ),
    );
    final packageNotifier = ref.read(
      packageControlNotifierProvider(
        editPackageModel?.package,
      ).notifier,
    );

    // text editing controllers
    final packageName =
        useTextEditingController(text: editPackageModel!.package.packageName);

    final keywordsController = useTextEditingController();
    final description = useTextEditingController(
      text: editPackageModel?.package.description,
    );
    final price = useTextEditingController(
      text: editPackageModel?.package.price.toString(),
    );
    final lastPrice = useTextEditingController(
      text: editPackageModel?.package.lastPrice.toString(),
    );

    final discountPercentage = useTextEditingController(
      text: editPackageModel?.package.discountPercentage.toString(),
    );
    final coupon = useTextEditingController(
      text: editPackageModel!.package.coupon,
    );
    final packageOffersController = useTextEditingController();

    return AppLayout(
      mobile: _MobilePackageEditPage(
        package: package,
        packageName: packageName,
        packageNotifier: packageNotifier,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
        packageOffersController: packageOffersController,
        activityId: editPackageModel!.activityId,
        editPackageModel: editPackageModel,
      ),
      tablet: _TabletPackageEditPage(
        package: package,
        packageName: packageName,
        packageNotifier: packageNotifier,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
        packageOffersController: packageOffersController,
        activityId: editPackageModel!.activityId,
      ),
      desktop: _DesktopPackageEditPage(
        package: package,
        packageName: packageName,
        packageNotifier: packageNotifier,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
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
    this.keywordsController,
    this.description,
    this.price,
    this.lastPrice,
    this.discountPercentage,
    this.coupon,
    this.packageNotifier,
    this.packageOffersController,
    this.activityId,
    this.editPackageModel,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final PackageControlNotifier? packageNotifier;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final TextEditingController? packageOffersController;
  final String? activityId;
  final EditPackageModel? editPackageModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // focus nodes
    final packageNameFocusNode = useFocusNode();
    final keywordsFocusNode = useFocusNode();
    final descriptionFocusNode = useFocusNode();
    final priceFocusNode = useFocusNode();
    final lastPriceFocusNode = useFocusNode();
    final discountPercentageFocusNode = useFocusNode();
    final couponFocusNode = useFocusNode();
    final packageOffersFocusNode = useFocusNode();

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
          icon: const LineIcon.chevronCircleLeft(),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final packageD = Package(
                packageId: package!.packageId,
                packageName: package!.packageName,
                keywords: package!.keywords,
                description: package!.description,
                price: package!.price,
                lastPrice: package!.lastPrice,
                discountPercentage: package!.discountPercentage,
                coupon: package!.coupon,
                packageOffers: package?.packageOffers,
              );
              // final result = await ref.read(packageProvider.notifier).update(
              //       activityId: activityId!,
              //       package: package,
              //       packageId: package.packageId,
              //     );
              // if (result) {
              //   context.vRouter.pop();
              // }

              packageNotifier?.setInitialPackageData(
                package: packageD,
              );

              if (editPackageModel?.index == null) {
                // add new package to list
                editPackageModel?.activityNotifier.addPackage(
                  package: packageD,
                );
              } else {
                // update package in activity
                editPackageModel?.activityNotifier.updatePackageInList(
                  package: packageD,
                  index: editPackageModel!.index!,
                );
              }

              // pop page
              context.pop();
            },
            icon: const LineIcon.save(),
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
            Form(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: packageName,
                      focusNode: packageNameFocusNode,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Package Name',
                        hintText: 'Enter Package Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        packageNotifier?.updatePackageName(
                          packageName: packageName!.text,
                        );
                      },
                      onFieldSubmitted: (value) {
                        packageNotifier?.updatePackageName(
                          packageName: packageName!.text,
                        );
                        // clear controller
                        packageName!.clear();
                        // move to next focus
                        packageNameFocusNode.nextFocus();
                        keywordsFocusNode.requestFocus();
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ChipInputField<String>(
                      chips: package?.keywords,
                      textController: keywordsController,
                      chipFocusNode: keywordsFocusNode,
                      onDelete: (keyword) {
                        packageNotifier?.removePackageKeyword(
                          keyword: keyword,
                        );
                      },
                      onSubmit: (keyword) {
                        packageNotifier?.updatePackageKeywords(
                          keyword: keyword,
                        );
                      },
                      hintText: 'Input keywords here',
                      noChipsMessasge: 'There are no keywords',
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    TextFormField(
                      controller: description,
                      focusNode: descriptionFocusNode,
                      minLines: 1,
                      maxLines: 10,
                      maxLength: 1000,
                      textInputAction: TextInputAction.next,
                      style: GoogleFonts.dosis(),
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter Description',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        packageNotifier?.updatePackageDescription(
                          packageDescription: description!.text,
                        );
                      },
                      onFieldSubmitted: (value) {
                        // update package description
                        packageNotifier?.updatePackageDescription(
                          packageDescription: description!.text,
                        );
                        // clear controller
                        description!.clear();
                        // next focus node
                        descriptionFocusNode.nextFocus();
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormField(
                      controller: price,
                      keyboardType: TextInputType.number,
                      focusNode: priceFocusNode,
                      style: GoogleFonts.dosis(),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        CustomFormValidators.onlyDouble(value!);
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        hintText: 'Enter Price',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        // packageNotifier?.updatePackagePrice(
                        //   packagePrice: double.parse(
                        //     price!.text,
                        //   ),
                        // );
                      },
                      onFieldSubmitted: (value) {
                        // update package price
                        packageNotifier?.updatePackagePrice(
                          packagePrice: double.parse(
                            price!.text,
                          ),
                        );
                        // clear controller
                        price!.clear();
                        // next focus
                        priceFocusNode.nextFocus();
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormField(
                      controller: lastPrice,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.dosis(),
                      textInputAction: TextInputAction.next,
                      focusNode: lastPriceFocusNode,
                      validator: (value) {
                        CustomFormValidators.onlyDouble(value!);
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Last Price',
                        hintText: 'Enter Last Price',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        //TODO: add on changed functionality
                        // packageNotifier?.updateLastPrice(
                        //   lastPrice: double.parse(
                        //     lastPrice!.text,
                        //   ),
                        // );
                      },
                      onFieldSubmitted: (value) {
                        // update package last price
                        packageNotifier?.updateLastPrice(
                          lastPrice: double.parse(
                            lastPrice!.text,
                          ),
                        );

                        // clear controller
                        lastPrice!.clear();

                        // next focus
                        lastPriceFocusNode.nextFocus();
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormField(
                      controller: discountPercentage,
                      focusNode: discountPercentageFocusNode,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.dosis(),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        CustomFormValidators.onlyDouble(value!);
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Discount Percentage',
                        hintText: 'Enter Discount Percentage',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        // packageNotifier?.updatePackageDiscount(
                        //   packageDiscount: double.parse(
                        //     discountPercentage!.text,
                        //   ),
                        // );
                      },
                      onFieldSubmitted: (value) {
                        packageNotifier?.updatePackageDiscount(
                          packageDiscount: double.parse(
                            discountPercentage!.text,
                          ),
                        );

                        // clear controller
                        discountPercentage!.clear();
                        // remove focus and focus on next focus node
                        discountPercentageFocusNode.nextFocus();
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const DText(
                      text: 'Package offers',
                      textAlign: TextAlign.start,
                    ),
                    ChipInputField<String>(
                      chips: package?.packageOffers,
                      textController: packageOffersController,
                      chipFocusNode: packageOffersFocusNode,
                      onDelete: (value) {
                        packageNotifier?.removePackageOffer(
                          packageOffer: value,
                        );
                      },
                      onSubmit: (value) {
                        packageNotifier?.updatePackageOffers(
                          packageOffer: value,
                        );
                      },
                      hintText: 'Please enter offer here',
                      noChipsMessasge: 'No package offers',
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    // CustomElevatedButton(
                    //   onPressed: () {},
                    //   text: 'Update Package',
                    //   fontSize: 16.sp,
                    // ),
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

// tablet package edit page
class _TabletPackageEditPage extends HookConsumerWidget {
  const _TabletPackageEditPage({
    Key? key,
    this.package,
    this.packageName,
    this.keywordsController,
    this.description,
    this.price,
    this.lastPrice,
    this.discountPercentage,
    this.coupon,
    this.packageOffersController,
    this.activityId,
    this.packageNotifier,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final TextEditingController? packageOffersController;
  final String? activityId;
  final PackageControlNotifier? packageNotifier;
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
              keywordsController: keywordsController,
              description: description,
              price: price,
              lastPrice: lastPrice,
              discountPercentage: discountPercentage,
              coupon: coupon,
              packageOffersController: packageOffersController,
              activityId: activityId,
              packageNotifier: packageNotifier,
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
    this.keywordsController,
    this.description,
    this.price,
    this.lastPrice,
    this.discountPercentage,
    this.coupon,
    this.packageOffersController,
    this.activityId,
    this.packageNotifier,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final TextEditingController? packageOffersController;
  final String? activityId;
  final PackageControlNotifier? packageNotifier;
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
              keywordsController: keywordsController,
              description: description,
              price: price,
              lastPrice: lastPrice,
              discountPercentage: discountPercentage,
              coupon: coupon,
              packageOffersController: packageOffersController,
              activityId: activityId,
              packageNotifier: packageNotifier,
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
    this.keywordsController,
    this.description,
    this.price,
    this.lastPrice,
    this.discountPercentage,
    this.coupon,
    this.packageOffersController,
    this.activityId,
    this.packageNotifier,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final TextEditingController? packageOffersController;
  final String? activityId;
  final PackageControlNotifier? packageNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobilePackageEditForm(
        package: package,
        packageName: packageName,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
        packageOffersController: packageOffersController,
        activityId: activityId,
        packageNotifier: packageNotifier,
      ),
      tablet: _TabletPackageEditForm(
        package: package,
        packageName: packageName,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
        packageOffersController: packageOffersController,
        activityId: activityId,
        packageNotifier: packageNotifier,
      ),
      desktop: _DesktopPackageEditForm(
        package: package,
        packageName: packageName,
        keywordsController: keywordsController,
        description: description,
        price: price,
        lastPrice: lastPrice,
        discountPercentage: discountPercentage,
        coupon: coupon,
        packageOffersController: packageOffersController,
        activityId: activityId,
        packageNotifier: packageNotifier,
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
    this.keywordsController,
    this.description,
    this.price,
    this.lastPrice,
    this.discountPercentage,
    this.coupon,
    this.packageOffersController,
    this.activityId,
    this.packageNotifier,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final TextEditingController? packageOffersController;
  final String? activityId;
  final PackageControlNotifier? packageNotifier;
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
                package?.keywords != null
                    ? Wrap(
                        spacing: 2.w,
                        children: [
                          ...package!.keywords!
                              .map((keyword) => Chip(
                                    label: Text(keyword),
                                  ))
                              .toList()
                        ],
                      )
                    : const SizedBox.shrink(),
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
                  // keywords!.value = [...keywords!.value!, newValue!];
                  //TODO: add keyword to list
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
                        //TODO: add keyword to list
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
                      packageNotifier?.updatePackageOffers(
                        packageOffer: packageOffersController!.text,
                      );
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
                    if (package?.packageOffers != null)
                      ...package!.packageOffers!
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
                                packageNotifier?.removePackageOffer(
                                  packageOffer: keyword,
                                );
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
    this.keywordsController,
    this.description,
    this.price,
    this.lastPrice,
    this.discountPercentage,
    this.coupon,
    this.packageOffersController,
    this.activityId,
    this.packageNotifier,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final TextEditingController? packageOffersController;
  final String? activityId;
  final PackageControlNotifier? packageNotifier;
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
    this.keywordsController,
    this.description,
    this.price,
    this.lastPrice,
    this.discountPercentage,
    this.coupon,
    this.packageOffersController,
    this.activityId,
    this.packageNotifier,
  }) : super(key: key);
  final Package? package;
  final TextEditingController? packageName;
  final TextEditingController? keywordsController;
  final TextEditingController? description;
  final TextEditingController? price;
  final TextEditingController? lastPrice;
  final TextEditingController? discountPercentage;
  final TextEditingController? coupon;
  final TextEditingController? packageOffersController;
  final String? activityId;
  final PackageControlNotifier? packageNotifier;
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

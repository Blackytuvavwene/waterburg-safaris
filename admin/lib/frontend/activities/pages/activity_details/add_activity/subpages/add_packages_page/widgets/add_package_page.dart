import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class AddPackageModel {
  final Package package;
  final String activityId;
  final Package packageCopy;
  final List<Package> packages;
  final AddActivityNotifier activityNotifier;
  final int? index;
  AddPackageModel({
    required this.package,
    required this.activityId,
    required this.packageCopy,
    required this.packages,
    required this.activityNotifier,
    this.index,
  });
}

class AddPackageNotifier extends StateNotifier<Package> {
  AddPackageNotifier() : super(Package());

  // update package offers in package
  void updatePackageOffers(String packageOffer) {
    state = state.copyWith(
      packageOffers: [
        ...state.packageOffers ?? [],
        packageOffer,
      ],
    );
  }

  // update package name in package
  void updatePackageName(String packageName) {
    state = state.copyWith(packageName: packageName);
  }

  // update package price in package
  void updatePackagePrice(double packagePrice) {
    state = state.copyWith(price: packagePrice);
  }

  // update package description in package
  void updatePackageDescription(String packageDescription) {
    state = state.copyWith(description: packageDescription);
  }

  // update package discount percentage in package
  void updatePackageDiscountPercentage(double packageDiscountPercentage) {
    state = state.copyWith(discountPercentage: packageDiscountPercentage);
  }

  // update package coupon in package
  void updatePackageCoupon(String packageCoupon) {
    state = state.copyWith(coupon: packageCoupon);
  }

  // update package keywords in package
  void updatePackageKeywords(String packageKeyword) {
    state = state.copyWith(
      keywords: [
        ...state.keywords ?? [],
        packageKeyword,
      ],
    );
  }
}

// add package state provider
final addPackageProvider =
    StateNotifierProvider.autoDispose<AddPackageNotifier, Package>(
  (ref) => AddPackageNotifier(),
);

// add package page hook consumer widget with app layout
class AddPackagePage extends HookConsumerWidget {
  const AddPackagePage({
    super.key,
    required this.model,
  });
  final AddPackageModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageNotifier = ref.read(
      packageControlNotifierProvider(
        model.package,
      ).notifier,
    );
    final packageState = ref.watch(
      packageControlNotifierProvider(
        model.package,
      ),
    );

    return AppLayout(
      mobile: _MobileAddPackagePage(
        packageNotifier: packageNotifier,
        packageState: packageState,
      ),
      tablet: _TabletAddPackagePage(
        packageState: packageState,
        packageNotifier: packageNotifier,
      ),
      desktop: _DesktopAddPackagePage(
        packageState: packageState,
        packageNotifier: packageNotifier,
      ),
    );
  }
}

// mobile add package page with child container
class _MobileAddPackagePage extends HookConsumerWidget {
  const _MobileAddPackagePage({
    required this.packageNotifier,
    required this.packageState,
  });

  final Package? packageState;
  final PackageControlNotifier packageNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();

    // controllers and focus nodes
    // package name controller and focus node
    final packageNameController = useTextEditingController(
      text: packageState?.packageName,
    );
    final packageNameFocus = useFocusNode();

    // package keywords controller and focus node
    final keywordsController = useTextEditingController();
    final keywordsFocus = useFocusNode();

    // package description controller and focus node
    final descriptionController = useTextEditingController(
      text: packageState?.description,
    );
    final descriptionFocus = useFocusNode();

    // package price controller and focus node
    final priceController = useTextEditingController(
      text: packageState?.price.toString() ?? '0.0',
    );
    final priceFocus = useFocusNode();

    // package discount controller and focus node
    final discountController = useTextEditingController(
      text: packageState?.discountPercentage.toString() ?? '0.0',
    );
    final discountFocus = useFocusNode();

    // package last price controller and focus node
    final lastPriceController = useTextEditingController(
      text: packageState?.lastPrice.toString() ?? '0.0',
    );
    final lastPriceFocus = useFocusNode();

    // package coupon controller and focus node
    final couponController = useTextEditingController(
      text: packageState?.coupon,
    );
    final couponFocus = useFocusNode();

    // package offers controller and focus node
    final packageOffersController = useTextEditingController();
    final packageOffersFocus = useFocusNode();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: DText(
            text: 'Add package',
            fontSize: 14.sp,
          ),
          pinned: true,
          leading: IconButton(
            onPressed: () {
              final package = packageState?.copyWith(
                slug: createSlug(
                  text: packageState!.packageName.toString(),
                ),
              );
              context.pop<Package>(package);
            },
            icon: const LineIcon.arrowLeft(),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 2.h,
          ),
        ),
        SliverToBoxAdapter(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: packageNameController,
                    focusNode: packageNameFocus,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Package Name',
                      hintText: 'Enter Package Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      packageNotifier.updatePackageName(
                        packageName: packageNameController.text,
                      );
                    },
                    onFieldSubmitted: (value) {
                      packageNotifier.updatePackageName(
                        packageName: packageNameController.text,
                      );
                      // clear controller
                      // packageNameController.clear();
                      // move to next focus
                      packageNameFocus.nextFocus();
                      keywordsFocus.requestFocus();
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  ChipInputField<String>(
                    chips: packageState?.keywords,
                    textController: keywordsController,
                    chipFocusNode: keywordsFocus,
                    onDelete: (keyword) {
                      packageNotifier.removePackageKeyword(
                        keyword: keyword,
                      );
                    },
                    onSubmit: (keyword) {
                      packageNotifier.updatePackageKeywords(
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
                    controller: descriptionController,
                    focusNode: descriptionFocus,
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
                      packageNotifier.updatePackageDescription(
                        packageDescription: descriptionController.text,
                      );
                    },
                    onFieldSubmitted: (value) {
                      // update package description
                      packageNotifier.updatePackageDescription(
                        packageDescription: descriptionController.text,
                      );
                      // clear controller
                      // descriptionController.clear();
                      // next focus node
                      descriptionFocus.nextFocus();
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    focusNode: priceFocus,
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
                      packageNotifier.updatePackagePrice(
                        packagePrice: double.parse(
                          priceController.text,
                        ),
                      );
                      // clear controller
                      // priceController.clear();
                      // next focus
                      priceFocus.nextFocus();
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextFormField(
                    controller: lastPriceController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.dosis(),
                    textInputAction: TextInputAction.next,
                    focusNode: lastPriceFocus,
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
                      packageNotifier.updateLastPrice(
                        lastPrice: double.parse(
                          lastPriceController.text,
                        ),
                      );

                      // clear controller
                      // lastPriceController.clear();

                      // next focus
                      lastPriceFocus.nextFocus();
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextFormField(
                    controller: discountController,
                    focusNode: discountFocus,
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
                      packageNotifier.updatePackageDiscount(
                        packageDiscount: double.parse(
                          discountController.text,
                        ),
                      );

                      // clear controller
                      // discountController.clear();
                      // remove focus and focus on next focus node
                      discountFocus.nextFocus();
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
                    chips: packageState?.packageOffers,
                    textController: packageOffersController,
                    chipFocusNode: packageOffersFocus,
                    onDelete: (value) {
                      packageNotifier.removePackageOffer(
                        packageOffer: value,
                      );
                    },
                    onSubmit: (value) {
                      packageNotifier.updatePackageOffers(
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
        )
      ],
    );
  }
}

// tablet add package page with child container
class _TabletAddPackagePage extends HookConsumerWidget {
  const _TabletAddPackagePage({
    required this.packageState,
    required this.packageNotifier,
  });

  final Package? packageState;
  final PackageControlNotifier packageNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final packageNameController = useTextEditingController(
      text: packageState?.packageName,
    );
    final keywordsController = useTextEditingController();
    final descriptionController = useTextEditingController(
      text: packageState?.description,
    );
    final priceController = useTextEditingController(
      text: packageState?.price.toString(),
    );
    final discountController = useTextEditingController(
      text: packageState?.discountPercentage.toString(),
    );
    final couponController = useTextEditingController(
      text: packageState?.coupon,
    );
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: DText(
              text: 'Add package',
              fontSize: 14.sp,
            ),
            automaticallyImplyLeading: false,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100.h,
              width: 100.w,
            ),
          ),
        ],
      ),
    );
  }
}

// desktop add package page with child container
class _DesktopAddPackagePage extends HookConsumerWidget {
  const _DesktopAddPackagePage({
    required this.packageNotifier,
    required this.packageState,
  });

  final Package? packageState;
  final PackageControlNotifier packageNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final packageNameController = useTextEditingController(
      text: packageState?.packageName,
    );
    final keywordsController = useTextEditingController();
    final descriptionController = useTextEditingController(
      text: packageState?.description,
    );
    final priceController = useTextEditingController(
      text: packageState?.price.toString(),
    );
    final discountController = useTextEditingController(
      text: packageState?.discountPercentage.toString(),
    );
    final couponController = useTextEditingController(
      text: packageState?.coupon,
    );
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: DText(
              text: 'Add package',
              fontSize: 14.sp,
            ),
            automaticallyImplyLeading: false,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100.h,
              width: 100.w,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

class AddPackageNotifier extends StateNotifier<Package> {
  AddPackageNotifier() : super(Package());

  // update package offers in package
  void updatePackageOffers(List<String> packageOffers) {
    state = state.copyWith(packageOffers: packageOffers);
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
  void updatePackageKeywords(List<String> packageKeywords) {
    state = state.copyWith(keywords: packageKeywords);
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
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageNotifier = ref.watch(addPackageProvider.notifier);
    final packageState = ref.watch(addPackageProvider);
    final tryKeywords = useState<List<String>>([]);

    return AppLayout(
      mobile: _MobileAddPackagePage(
        packageNotifier: packageNotifier,
        tryKeywords: tryKeywords,
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
    required this.tryKeywords,
    required this.packageState,
  });

  final Package packageState;
  final AddPackageNotifier packageNotifier;
  final ValueNotifier<List<String>> tryKeywords;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final formFocus = useFocusNode();
    final packageNameController = useTextEditingController(
      text: packageState.packageName,
    );
    final keywordsController = useTextEditingController();
    final descriptionController = useTextEditingController(
      text: packageState.description,
    );
    final priceController = useTextEditingController(
      text: packageState.price.toString(),
    );
    final discountController = useTextEditingController(
      text: packageState.discountPercentage.toString(),
    );
    final couponController = useTextEditingController(
      text: packageState.coupon,
    );

    final packageOffersController = useTextEditingController();
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
            pinned: true,
            leading: IconButton(
              onPressed: () {
                packageState.packageName != null
                    ? Navigator.pop(context, packageState)
                    : Navigator.pop(context);
              },
              icon: LineIcon.arrowLeft(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 2.h,
            ),
          ),
          SliverToBoxAdapter(
            child: Form(
              key: formKey,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: packageNameController,
                          decoration: const InputDecoration(
                            labelText: 'Package Name',
                            hintText: 'Enter Package Name',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (newValue) {
                            packageNotifier.updatePackageName(newValue!);
                          },
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
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
                              children: packageState.keywords != null
                                  ? packageState.keywords!
                                      .map(
                                        (keyword) => Chip(
                                          label: DText(
                                            text: keyword,
                                            fontSize: 12.sp,
                                          ),
                                          // onDeleted: () {
                                          //   packageNotifier.updatePackageKeywords(
                                          //     packageState.keywords!
                                          //         .where(
                                          //             (element) => element != keyword)
                                          //         .toList(),
                                          //   );
                                          // },
                                        ),
                                      )
                                      .toList()
                                  : [],
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
                              final newKeywords = [
                                if (packageState.keywords != null)
                                  ...packageState.keywords!,
                                newValue!
                              ];

                              packageNotifier
                                  .updatePackageKeywords(newKeywords);

                              // tryKeywords.value = [
                              //   ...tryKeywords.value,
                              //   newValue!,
                              // ];
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
                                    final newKeywords = [
                                      if (packageState.keywords != null)
                                        ...packageState.keywords!,
                                      keywordsController.text
                                    ];

                                    packageNotifier
                                        .updatePackageKeywords(newKeywords);

                                    // tryKeywords.value = [
                                    //   ...tryKeywords.value,
                                    //   keywordsController.text
                                    // ];
                                    keywordsController.clear();
                                  },
                                  child: const DText(
                                    text: 'Add',
                                  ),
                                ),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        TextFormField(
                          controller: descriptionController,
                          minLines: 1,
                          maxLines: 10,
                          maxLength: 1000,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: 'Enter Description',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (newValue) {
                            packageNotifier.updatePackageDescription(newValue!);
                          },
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TextFormField(
                          controller: priceController,
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
                          onSaved: (newValue) {
                            packageNotifier.updatePackagePrice(
                              double.parse(newValue!),
                            );
                          },
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                        // SizedBox(
                        //   height: 2.h,
                        // ),
                        // TextFormField(
                        //   controller: lastPrice,
                        //   keyboardType: TextInputType.number,
                        //   validator: (value) {
                        //     CustomFormValidators.onlyDouble(value!);
                        //     return null;
                        //   },
                        //   decoration: const InputDecoration(
                        //     labelText: 'Last Price',
                        //     hintText: 'Enter Last Price',
                        //     border: OutlineInputBorder(),
                        //   ),
                        // ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TextFormField(
                          controller: discountController,
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
                          onSaved: (newValue) {
                            packageNotifier.updatePackageDiscountPercentage(
                              double.parse(newValue!),
                            );
                          },
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TextFormField(
                          controller: couponController,
                          decoration: const InputDecoration(
                            labelText: 'Coupon',
                            hintText: 'Enter Coupon',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (newValue) {
                            packageNotifier.updatePackageCoupon(newValue!);
                          },
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          onEditingComplete: () {
                            FocusScope.of(context).nextFocus();
                          },
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
                                  final newOffers = [
                                    if (packageState.packageOffers != null)
                                      ...packageState.packageOffers!,
                                    packageOffersController.text
                                  ];
                                  packageNotifier
                                      .updatePackageOffers(newOffers);
                                  packageOffersController.clear();
                                },
                                child: const DText(
                                  text: 'Add',
                                ),
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          autofocus: true,
                          // onEditingComplete: () {
                          //   FocusScope.of(context).unfocus();
                          // },
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
                              children: packageState.packageOffers != null
                                  ? packageState.packageOffers!
                                      .map(
                                        (keyword) => Chip(
                                          label: DText(text: keyword),
                                          padding: EdgeInsets.all(
                                            10.sp,
                                          ),
                                          deleteIcon: LineIcon.trash(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                          ),
                                          onDeleted: () {
                                            packageState.copyWith(
                                              packageOffers: packageState
                                                  .packageOffers!
                                                  .where(
                                                (element) {
                                                  return element != keyword;
                                                },
                                              ).toList(),
                                            );
                                          },
                                        ),
                                      )
                                      .toList()
                                  : const [],
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// tablet add package page with child container
class _TabletAddPackagePage extends HookConsumerWidget {
  const _TabletAddPackagePage({
    required this.packageState,
    required this.packageNotifier,
  });

  final Package packageState;
  final AddPackageNotifier packageNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final packageNameController = useTextEditingController(
      text: packageState.packageName,
    );
    final keywordsController = useTextEditingController();
    final descriptionController = useTextEditingController(
      text: packageState.description,
    );
    final priceController = useTextEditingController(
      text: packageState.price.toString(),
    );
    final discountController = useTextEditingController(
      text: packageState.discountPercentage.toString(),
    );
    final couponController = useTextEditingController(
      text: packageState.coupon,
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

  final Package packageState;
  final AddPackageNotifier packageNotifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final packageNameController = useTextEditingController(
      text: packageState.packageName,
    );
    final keywordsController = useTextEditingController();
    final descriptionController = useTextEditingController(
      text: packageState.description,
    );
    final priceController = useTextEditingController(
      text: packageState.price.toString(),
    );
    final discountController = useTextEditingController(
      text: packageState.discountPercentage.toString(),
    );
    final couponController = useTextEditingController(
      text: packageState.coupon,
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

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
      width: 20.w,
      height: 40.h,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20.w,
              height: 10.h,
              color: Theme.of(context).colorScheme.secondary.withOpacity(
                    0.5,
                  ),
              padding: EdgeInsets.all(
                2.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 4.h,
                    child: DText(
                      text: package!.packageName,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: DText(
                      text: package!.description,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 6.sp,
                    ),
                  ),
                  Expanded(
                    child: DText(
                      text: '\$ ${package!.price.toString()}',
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primary.withOpacity(
                      0.5,
                    ),
                padding: EdgeInsets.all(
                  2.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 5.h,
                      child: DText(
                        text: 'Package offers:',
                        textColor: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    package!.packageOffers!.isNotEmpty
                        ? Expanded(
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
                                          fontSize: 6.sp,
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

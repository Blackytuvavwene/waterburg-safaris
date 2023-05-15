import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class CustomPackageCard<T> extends HookConsumerWidget {
  const CustomPackageCard({
    Key? key,
    this.package,
    this.activityId,
    this.packages,
    required this.navigateTo,
    required this.deletePackage,
    this.index,
  }) : super(key: key);
  final Package? package;
  final String? activityId;
  final List<Package>? packages;
  final Function navigateTo;
  final Function deletePackage;
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
                        deletePackage();

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
          navigateTo();
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

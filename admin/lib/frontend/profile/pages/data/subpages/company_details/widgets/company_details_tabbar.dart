import 'package:admin/lib.dart';
import 'package:flutter/material.dart';

class CompanyDetailsTabbar extends SliverPersistentHeaderDelegate {
  CompanyDetailsTabbar({
    required this.pageViewController,
    this.onPageChange,
    this.pageViewIndex,
  });

  final PageController pageViewController;
  final Function? onPageChange;
  final int? pageViewIndex;
  @override
  double minExtent = 50;
  @override
  double maxExtent = 50;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () {
                onPageChange!(0);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: pageViewIndex == 0
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onBackground,
                backgroundColor: pageViewIndex == 0
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
                side: BorderSide(
                  color: pageViewIndex == 0
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
              child: DText(
                text: 'About $pageViewIndex',
              ),
            ),
            OutlinedButton(
              onPressed: () {
                onPageChange!(1);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: pageViewIndex == 1
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onBackground,
                backgroundColor: pageViewIndex == 1
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
                side: BorderSide(
                  color: pageViewIndex == 1
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
              child: DText(
                text: 'Address $pageViewIndex',
              ),
            ),
            OutlinedButton(
              onPressed: () {
                onPageChange!(2);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: pageViewIndex == 2
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onBackground,
                backgroundColor: pageViewIndex == 2
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
                side: BorderSide(
                  color: pageViewIndex == 2
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
              child: DText(
                text: 'Extra $pageViewIndex',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

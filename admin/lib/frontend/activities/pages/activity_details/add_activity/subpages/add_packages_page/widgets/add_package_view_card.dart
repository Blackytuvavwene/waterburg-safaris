import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class AddPackageViewCard extends HookConsumerWidget {
  const AddPackageViewCard({
    super.key,
    required this.package,
  });
  final Package package;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _MobileAddPackageViewCard(
        package: package,
      ),
      tablet: _TabletAddPackageViewCard(
        package: package,
      ),
      desktop: _DesktopAddPackageViewCard(
        package: package,
      ),
    );
  }
}

// mobile add package view card
class _MobileAddPackageViewCard extends HookConsumerWidget {
  const _MobileAddPackageViewCard({
    required this.package,
  });
  final Package package;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: 20.h,
        decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: const Center(
                child: Text(
                  'Image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DText(
                      text: package.packageName,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    DText(
                      text: package.description,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 10),
                    DText(
                      text: 'Price: ${package.price}',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 10),
                    const DText(
                      text: 'Duration: ',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
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

// tablet add package view card
class _TabletAddPackageViewCard extends HookConsumerWidget {
  const _TabletAddPackageViewCard({
    required this.package,
  });
  final Package package;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: const Center(
              child: Text(
                'Image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DText(
                    text: package.packageName,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  DText(
                    text: package.description,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 10),
                  DText(
                    text: 'Price: ${package.price}',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 10),
                  const DText(
                    text: 'Duration: ',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// desktop add package view card
class _DesktopAddPackageViewCard extends HookConsumerWidget {
  const _DesktopAddPackageViewCard({
    required this.package,
  });
  final Package package;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: const Center(
              child: Text(
                'Image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DText(
                    text: package.packageName,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  DText(
                    text: package.description,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 10),
                  DText(
                    text: 'Price: ${package.price}',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 10),
                  const DText(
                    text: 'Duration: jfjfjfj',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

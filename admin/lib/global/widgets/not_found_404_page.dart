import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class NotFoundPage extends HookConsumerWidget {
  const NotFoundPage({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
          width: 100.w,
          height: 100.h,
          color: Theme.of(context).colorScheme.errorContainer,
          child: Center(
            child: DText(
              text: 'Not Found $error',
              textColor: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

// activities error
class ActivitiesError extends HookConsumerWidget {
  const ActivitiesError({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppLayout(
      mobile: _ActivitiesErrorMobile(
        error: error,
      ),
      tablet: _ActivitiesErrorTablet(
        error: error,
      ),
      desktop: _ActivitiesErrorDesktop(
        error: error,
      ),
    );
  }
}

// activities error for mobile
class _ActivitiesErrorMobile extends HookConsumerWidget {
  const _ActivitiesErrorMobile({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.errorContainer,
      child: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Center(
          child: Column(
            children: [
              DText(
                text: error.toString(),
                textColor: Theme.of(context).colorScheme.onErrorContainer,
              ),
              SizedBox(
                height: 6.h,
              ),
              CustomElevatedButton(
                text: 'Refresh',
                onPressed: () {
                  //TODO: refresh activities
                  // ref.read(activitiesProvider.notifier).getActivities();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// activities error for tablet
class _ActivitiesErrorTablet extends HookConsumerWidget {
  const _ActivitiesErrorTablet({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.errorContainer,
      child: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Center(
          child: Column(
            children: [
              DText(
                text: error.toString(),
                textColor: Theme.of(context).colorScheme.onErrorContainer,
              ),
              SizedBox(
                height: 6.h,
              ),
              CustomElevatedButton(
                text: 'Refresh',
                onPressed: () {
                  //TODO: refresh activities
                  // ref.read(activitiesProvider.notifier).getActivities();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// activities error for desktop
class _ActivitiesErrorDesktop extends HookConsumerWidget {
  const _ActivitiesErrorDesktop({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.errorContainer,
      child: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Center(
          child: Column(
            children: [
              DText(
                text: error.toString(),
                textColor: Theme.of(context).colorScheme.onErrorContainer,
              ),
              SizedBox(
                height: 6.h,
              ),
              CustomElevatedButton(
                text: 'Refresh',
                onPressed: () {
                  //TODO: refresh activities
                  // ref.read(activitiesProvider.notifier).getActivities();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

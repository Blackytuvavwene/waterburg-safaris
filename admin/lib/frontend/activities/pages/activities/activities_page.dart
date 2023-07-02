import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActivitiesPage extends HookConsumerWidget {
  const ActivitiesPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(activitiesStreamProvider).when(
      data: (data) {
        return ActivitiesData(
          activitiesData: data,
        );
      },
      error: (error, stackTrace) {
        return ActivitiesError(
          error: error.toString(),
        );
      },
      loading: () {
        return const ActivitiesLoading();
      },
    );
  }
}

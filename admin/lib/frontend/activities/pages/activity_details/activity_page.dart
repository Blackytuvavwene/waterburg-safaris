import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActivityPage extends HookConsumerWidget {
  const ActivityPage({
    Key? key,
    required this.activityId,
  }) : super(key: key);
  final String activityId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('ActivityPage: $activityId');
    return ref
        .watch(
      activityDataStreamProvider(
        activityId.toString(),
      ),
    )
        .when(
      data: (data) {
        return ActivityDetailsPage(
          activity: data,
        );
      },
      error: (error, stackTrace) {
        return ActivityDetailsPageError(
          error: error.toString(),
        );
      },
      loading: () {
        return const ActivityDetailsPageLoading();
      },
    );
  }
}

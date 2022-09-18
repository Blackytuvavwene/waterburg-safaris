import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vrouter/vrouter.dart';

class ActivityPage extends HookConsumerWidget {
  const ActivityPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(
      activityDataStreamProvider(
        context.vRouter.pathParameters['activityId'].toString(),
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

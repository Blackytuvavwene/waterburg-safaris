import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(companyStreamProvider).when(
      data: (data) {
        return ProfileDataPage(
          company: data,
        );
      },
      error: (error, stackTrace) {
        return ProfileErrorPage(
          error: error.toString(),
        );
      },
      loading: () {
        return const ProfileLoadingPage();
      },
    );
  }
}

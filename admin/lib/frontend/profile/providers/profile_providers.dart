import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String aboutCompanyID = 'ymV8H6FBRjfMBFhAh8o2';

final companyNotifierProvider =
    StateNotifierProvider<CompanyNotifier, Company>((ref) {
  return CompanyNotifier();
});

final currentUserNotifierProvider =
    StateNotifierProvider<CurrentUserNotifier, UserModel>((ref) {
  return CurrentUserNotifier();
});

final companyStreamProvider = StreamProvider<Company>((ref) {
  return ref.watch(companyDbRepositoryProvider).streamCompanyFromFirestore(
        companyId: aboutCompanyID,
      );
});

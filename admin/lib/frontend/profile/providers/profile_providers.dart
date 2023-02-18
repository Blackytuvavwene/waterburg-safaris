import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String aboutCompanyID = 'ymV8H6FBRjfMBFhAh8o2';

final companyNotifierProvider = StateNotifierProvider.family
    .autoDispose<CompanyNotifier, Company?, Company?>((ref, company) {
  return CompanyNotifier(company: company);
});

final currentUserNotifierProvider =
    StateNotifierProvider<CurrentUserNotifier, UserModel>((ref) {
  return CurrentUserNotifier();
});

final companyStreamProvider = StreamProvider.autoDispose<Company>((ref) {
  return ref.watch(companyDbRepositoryProvider).streamCompanyFromFirestore(
        companyId: aboutCompanyID,
      );
});

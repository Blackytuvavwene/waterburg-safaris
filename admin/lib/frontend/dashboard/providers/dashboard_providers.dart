import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// stream company data from firestore
final companyDataStreamProvider = StreamProvider.autoDispose<Company>((ref) {
  return ref
      .watch(companyDbRepositoryProvider)
      .streamCompanyFromFirestore(companyId: 'ymV8H6FBRjfMBFhAh8o2');
});

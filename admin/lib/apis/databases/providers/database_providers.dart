import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// user database repository provider
final userDbRepositoryProvider = Provider<UserDatabaseRepository>((ref) {
  return UserDatabaseRepository();
});

// activity database repository provider
final activityDbRepositoryProvider = Provider<ActivitiesDatabaseRepository>(
    (ref) => ActivitiesDatabaseRepository());

// stream user data from firestore
final userDataStreamProvider = StreamProvider.autoDispose<UserModel>((ref) {
  return ref.watch(userDbRepositoryProvider).getUserFromFirestore();
});
import 'package:admin/lib.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginStateProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, AsyncValue<User?>>((ref) {
  final auth = ref.watch(authProvider);
  return LoginNotifier(
    authRepository: auth,
  );
});

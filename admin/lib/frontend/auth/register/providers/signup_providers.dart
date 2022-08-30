import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpStateProvider =
    StateNotifierProvider.autoDispose<SignUpNotifier, AsyncValue<void>>((ref) {
  final auth = ref.watch(authProvider);
  return SignUpNotifier(
    authRepository: auth,
  );
});

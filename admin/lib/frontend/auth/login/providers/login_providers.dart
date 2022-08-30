import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginStateProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, AsyncValue<void>>((ref) {
  final auth = ref.watch(authProvider);
  return LoginNotifier(
    authRepository: auth,
  );
});

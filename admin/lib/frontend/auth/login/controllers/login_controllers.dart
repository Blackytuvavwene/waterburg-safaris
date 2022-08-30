import 'package:admin/lib.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends StateNotifier<AsyncValue<void>> {
  LoginNotifier({
    required this.authRepository,
    this.ref,
  }) : super(const AsyncData<void>(null));

  // access auth repository
  final AuthRepository authRepository;
  final WidgetRef? ref;

  // function to signup user
  Future<AsyncValue<User>> login({
    required String email,
    required String password,
  }) async {
    // _user.useAuthEmulator('localhost', 1212);

    // let state to be loading
    state = const AsyncValue.loading();

    try {
      final user = await authRepository.login(
        email: email,
        password: password,
      );
      return state = AsyncData<User>(user);
    } catch (e) {
      throw state = AsyncValue.error(e);
    }
  }
}

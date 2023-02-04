import 'package:admin/lib.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends StateNotifier<AsyncValue<User?>> {
  LoginNotifier({
    required this.authRepository,
    this.ref,
  }) : super(const AsyncData<User?>(null));

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

    return state = await AsyncValue.guard<User>(() async {
      final user = await authRepository.login(
        email: email,
        password: password,
      );
      return user;
    });
  }
}

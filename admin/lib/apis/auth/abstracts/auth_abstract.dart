abstract class AuthAbstract {
  // login method
  Future<void> login({
    String? email,
    String? password,
  });

  // logout method
  Future<void> logout();

  // signup method
  Future<void> signup({
    String email,
    String password,
  });
}

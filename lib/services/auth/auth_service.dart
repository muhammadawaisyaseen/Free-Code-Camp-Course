import 'dart:ffi';

import 'package:freecodecampcourse/services/auth/auth_provider.dart';
import 'package:freecodecampcourse/services/auth/auth_user.dart';

// AuthService expose data with outside world by using AuthProvider
class AuthService implements AuthProvider {
  final AuthProvider provider;
  AuthService(this.provider);

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<Void> logOut() => provider.logOut();

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) =>
      provider.login(email: email, password: password);

  @override
  Future<Void> sendEmailVerification() => provider.sendEmailVerification();
}

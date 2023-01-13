import 'dart:ffi';

import 'package:freecodecampcourse/services/auth/auth_provider.dart';
import 'package:freecodecampcourse/services/auth/auth_user.dart';
import 'package:freecodecampcourse/services/auth/firebase_auth_provider.dart';

// AuthService expose data with outside world by using AuthProvider
class AuthService implements AuthProvider {
  final AuthProvider provider;
  AuthService(this.provider);

// By using factory constructor, Now we can access the FirebaseAuthProvider in the AuthService easily
// we will not call it again and again
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) =>
      provider.login(email: email, password: password);

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> initialize() => provider.initialize();
}

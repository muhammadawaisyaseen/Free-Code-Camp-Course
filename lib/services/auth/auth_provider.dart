import 'dart:ffi';

// import 'package:flutter/cupertino.dart';
import 'package:freecodecampcourse/services/auth/auth_user.dart';

// AuthProvider can perform the below responsibilities,
// whether we works with other Authentication providers like (email/pass,twitter,facebook etc)
abstract class AuthProvider {
  AuthUser? get currentUser; // AuthProvider return the current authenticated

  Future<void> initialize();
  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> logOut();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordRest({required String toEmail});
}

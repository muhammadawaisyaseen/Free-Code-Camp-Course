// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:freecodecampcourse/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

// class AuthStateLoading extends AuthState {
//   const AuthStateLoading();
// }

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized();
}

class AuthStateRegistering extends AuthState {
  final Exception exception;
  const AuthStateRegistering(this.exception);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

// here we are handling three states in the same class, we can also make different 3 States
class AuthStateLoggedOut extends AuthState {
  final Exception? exception;
  final bool isLoading;
  const AuthStateLoggedOut({
    required this.exception,
    required this.isLoading,
});
}

// class AuthStateLogOutFailure extends AuthState {
//   final Exception exception;
//   const AuthStateLogOutFailure(this.exception);
// }

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:freecodecampcourse/services/auth/auth_user.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState({
    required this.isLoading,
    this.loadingText = 'Please wait a moment',
  });
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateRegistering extends AuthState {
  final Exception exception;
  const AuthStateRegistering({required this.exception, required isLoading})
      : super(isLoading: isLoading);
}

class AuthStateForgotPassword extends AuthState {
  final Exception? exception;
  final bool hasSentEmail;

  const AuthStateForgotPassword({
    required this.exception,
    required this.hasSentEmail,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user, required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification({required bool isLoading})
      : super(isLoading: isLoading);
}

// here we are handling three states in the same class, we can also make different 3 States
class AuthStateLoggedOut extends AuthState {
  final Exception? exception;
  final bool isLoading;
  const AuthStateLoggedOut(
      {required this.exception, required this.isLoading, String? loadingText})
      : super(
          isLoading: isLoading,
          loadingText: loadingText,
        );
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/cupertino.dart';

// Purpose of AuthUser --> Email is verified or not and (id,email)
@immutable
class AuthUser {
  final String id;
  final String email;
  final bool isEmailVerified;
  const AuthUser(
    this.id,
    this.email,
    this.isEmailVerified,
  );

// Factory constructors might return an instance that already exists, or a sub-class.
  factory AuthUser.fromFirebase(User user) => AuthUser(
        user.uid,
        user.email!,
        user.emailVerified,
      );
}

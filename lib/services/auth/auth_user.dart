import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/cupertino.dart';

// Purpose of AuthUser --> Email is verified or not
@immutable
class AuthUser {
  final bool isEmailVerified;
  const AuthUser(this.isEmailVerified); // isEmailVerified value(TRUE/FALSE) from below factory Constructor 

// Factory constructors might return an instance that already exists, or a sub-class.
  factory AuthUser.fromFirebase(User user) => AuthUser(user.emailVerified);
}

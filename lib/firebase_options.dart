// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBJd3QXzTuJ6MCGO7_lmWA7DBa1x29mVbw',
    appId: '1:755343382706:web:a48ce9c7f1336bd143d1ab',
    messagingSenderId: '755343382706',
    projectId: 'awaisflutter',
    authDomain: 'awaisflutter.firebaseapp.com',
    storageBucket: 'awaisflutter.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBurj05-pFdHBNoqU4WGvMCoF1Tu8rhSe4',
    appId: '1:755343382706:android:2ecb104448cbbb6243d1ab',
    messagingSenderId: '755343382706',
    projectId: 'awaisflutter',
    storageBucket: 'awaisflutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlch2sVU9fgB3TJVbnFJaHg6ifr2MgsDo',
    appId: '1:755343382706:ios:43ba1461c821a35143d1ab',
    messagingSenderId: '755343382706',
    projectId: 'awaisflutter',
    storageBucket: 'awaisflutter.appspot.com',
    iosClientId: '755343382706-gg5dt3896a97qssalffsbkpqkjalg8ql.apps.googleusercontent.com',
    iosBundleId: 'com.example.freecodecampcourse',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDlch2sVU9fgB3TJVbnFJaHg6ifr2MgsDo',
    appId: '1:755343382706:ios:43ba1461c821a35143d1ab',
    messagingSenderId: '755343382706',
    projectId: 'awaisflutter',
    storageBucket: 'awaisflutter.appspot.com',
    iosClientId: '755343382706-gg5dt3896a97qssalffsbkpqkjalg8ql.apps.googleusercontent.com',
    iosBundleId: 'com.example.freecodecampcourse',
  );
}
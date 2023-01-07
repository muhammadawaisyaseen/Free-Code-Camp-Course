import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freecodecampcourse/screens/email_verification_view.dart';
import 'package:freecodecampcourse/screens/home_screen.dart';
import 'package:freecodecampcourse/screens/login_screen.dart';
import 'package:freecodecampcourse/screens/register_screen.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/login/' :(context) => LoginView(),
        '/register/' :(context) => RegisterView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // final user = FirebaseAuth.instance.currentUser;

              // // user?.emailVerified ?? false) means that if user is verified return true then false
              // if (user?.emailVerified ?? false) {
              //   print(user);
              //   return const Text('Done');
              //   print('You are a verified user');
              // } else {
              //   return const EmailVerificationView();
              // }
              return LoginView();

            default:
              return const Text('Loading........');
          }
        },
      ),
    );
  }
}

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Please verify your E-mail address'),
        TextButton(
            onPressed: (() async {
              final user = FirebaseAuth.instance.currentUser;
              // print(user);
              await user?.sendEmailVerification();
            }),
            child: Text('Send email verification'))
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
        '/login/': (context) => LoginView(),
        '/register/': (context) => RegisterView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
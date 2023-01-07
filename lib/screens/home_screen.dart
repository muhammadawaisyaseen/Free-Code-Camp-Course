import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freecodecampcourse/firebase_options.dart';
import 'package:freecodecampcourse/screens/email_verification_view.dart';

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
              final user = FirebaseAuth.instance.currentUser;
              // user?.emailVerified ?? false) means that if user is verified return true then false
              if (user?.emailVerified ?? false) {
                print('You are a verified user');
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmailVerificationView(),
                    ));
              }
              return Text('Done');
            default:
              return Text('Loading........');
          }
        },
      ),
    );
  }
}

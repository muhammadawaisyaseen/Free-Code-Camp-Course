import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freecodecampcourse/firebase_options.dart';

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
              return Text('Done');
            default:
              return Text('Loading........');
          }
          
        },
      ),
    );
  }
}

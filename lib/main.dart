import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freecodecampcourse/screens/home_screen.dart';

// import 'firebase_options.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: FirebaseOptions(
  //     apiKey: "Api key here",
  //     appId: "App id here",
  //     messagingSenderId: "Messaging sender id here",
  //     projectId: "project id here",
  //   ),
  // );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freecodecampcourse/screens/login_screen.dart';
import 'package:freecodecampcourse/screens/register_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: RegisterView(),
    );
  }
}

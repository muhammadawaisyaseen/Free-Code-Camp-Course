import 'package:flutter/material.dart';
import 'package:freecodecampcourse/screens/login_view.dart';
import 'package:freecodecampcourse/screens/notes_view.dart';
import 'package:freecodecampcourse/screens/register_view.dart';
import 'package:freecodecampcourse/screens/verify_email_view.dart';
import 'package:freecodecampcourse/services/auth/auth_service.dart';
import 'constants/routes.dart';
import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    print('My App Init');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => LoginView(),
        registerRoute: (context) => RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const EmailVerificationView()
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    print('Home Init');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        print('Home Future Build');
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                // NotesView is not showing after verifying
                return NotesView();
              } else {
                return const EmailVerificationView();
              }
            } else {
              return LoginView();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
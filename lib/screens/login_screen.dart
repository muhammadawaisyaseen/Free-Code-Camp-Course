import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freecodecampcourse/screens/register_screen.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState

    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _email,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'Enter Your Email'),
        ),
        TextField(
          controller: _password,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(hintText: 'Enter Your Email'),
        ),
        TextButton(
          onPressed: () async {
            try {
              final email = _email.text;
              final password = _password.text;

              final userCredential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password);
              print('HO GYA LOGIN BAI');
              // malikmananyaseen@gmail.com
              print(userCredential);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found')
                print('User Not Found');
              else if (e.code == 'wrong-password') {
                print('Wrong Password');
              }
            }
          },
          child: Text('Login'),
        ),
        TextButton(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) {
              //     return RegisterView();
              //   },
              // ));
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/register/', (route) => false);
            },
            child: Text('Not registered yet? Registered here'))
      ],
    );
  }
}

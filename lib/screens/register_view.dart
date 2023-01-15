import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:freecodecampcourse/constants/routes.dart';
import 'package:freecodecampcourse/services/auth/auth_exceptions.dart';
import 'package:freecodecampcourse/services/auth/auth_service.dart';
import 'package:freecodecampcourse/widgets/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
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
            decoration: const InputDecoration(hintText: 'Enter Your Password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                devtools.log('User Registered Sucessfully');
                // psychologyta1234@gmail.com

                AuthService.firebase().sendEmailVerification();

                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on EmailAlreadyInUseAuthException{
                await showErrorDialog(
                    context,
                    'Email is already in use',
                  );
              } on WeakPasswordAuthException{
                await showErrorDialog(
                    context,
                    'Your Password is Weak',
                  );
              } on InvalidEmailAuthException{
                await showErrorDialog(
                    context,
                    'Invalid Email Address',
                  );
              } on GenericAuthException{
                await showErrorDialog(
                    context,
                    'Failed to register',
                  );
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, loginRoute, (route) => false);
              },
              child: const Text('Already Registered? Login here'))
        ],
      ),
    );
  }
}
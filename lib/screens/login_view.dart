import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:freecodecampcourse/constants/routes.dart';
import 'package:freecodecampcourse/services/auth/auth_exceptions.dart';
import 'package:freecodecampcourse/services/auth/auth_service.dart';
import 'package:freecodecampcourse/widgets/show_error_dialog.dart';
// import '../widgets/show_error_dialog.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
            decoration: const InputDecoration(hintText: 'Enter Password here'),
          ),
          TextButton(
            onPressed: () async {
              try {
                final email = _email.text;
                final password = _password.text;
                await AuthService.firebase().login(email: email, password: password,);
                
                final user = AuthService.firebase().currentUser;
                // If user verified take true otherwise use false in condition
                if (user?.isEmailVerified ?? false) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (_) => false,
                  );
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (_) => false,
                  );
                }
              } on UserNotFoundAuthException{
                await showErrorDialog(
                    context,
                    'User Not Found',
                  );
              }on WrongPasswordAuthException{
                await showErrorDialog(
                    context,
                    'wrong cridential',
                  );
              } on GenericAuthException{
                await showErrorDialog(
                    context,
                    'Authentication error',
                  );
              }
              //  {
              //   if (e.code == 'user-not-found') {
              //     await showErrorDialog(
              //       context,
              //       'User Not Found',
              //     );
              //   } else if (e.code == 'wrong-password') {
              //     await showErrorDialog(
              //       context,
              //       'wrong cridential',
              //     );
              //   } else {
              //     await showErrorDialog(
              //       context,
              //       'Error: ${e.code}',
              //     );
              //   }
              // } catch (e) {
              //   await showErrorDialog(
              //     context,
              //     e.toString(),
              //   );
              // }
            },
            child: const Text('Login'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('Not registered yet? Registered here'))
        ],
      ),
    );
  }
}

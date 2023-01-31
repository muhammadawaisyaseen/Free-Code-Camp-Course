import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freecodecampcourse/constants/routes.dart';
import 'package:freecodecampcourse/services/auth/auth_service.dart';
import 'package:freecodecampcourse/services/auth/bloc/auth_bloc.dart';
import 'package:freecodecampcourse/services/auth/bloc/auth_event.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(
        children: [
          const Text("We've sent you an email, plz verify your account\n"),
          const Text("If you've not yet, press below button\n"),
          TextButton(
              onPressed: (() {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventSendEmailVerification());
              }),
              child: const Text('Send email verification')),
          TextButton(
              onPressed: (() {
                context.read<AuthBloc>().add(
                      const AuthEventLogOut(),
                    );
                // await AuthService.firebase().logOut();
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //   registerRoute,
                //   (route) => false,
                // );
              }),
              child: const Text('Restart')),
        ],
      ),
    );
  }
}

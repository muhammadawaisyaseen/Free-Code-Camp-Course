import 'package:flutter/material.dart';
import 'package:freecodecampcourse/widgets/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSendDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password Reset',
    content:
        'We have now sent you a pasword reset link. Please check your email for more information.',
    optionsBuilder: () => {
      'ok':null,
    },
  );
}

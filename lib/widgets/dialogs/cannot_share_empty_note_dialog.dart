import 'package:flutter/material.dart';
import 'package:freecodecampcourse/widgets/dialogs/generic_dialog.dart';

Future<void> ShowCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Sharing',
    content: 'You cannot share empty note!',
    optionsBuilder: ()=> {
      'Ok':null,
    },
  );
}

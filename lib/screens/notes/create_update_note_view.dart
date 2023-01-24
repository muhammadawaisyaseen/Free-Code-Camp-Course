import 'package:flutter/material.dart';
import 'package:freecodecampcourse/services/auth/auth_service.dart';
import 'package:freecodecampcourse/services/cloud/cloud_note.dart';
import 'package:freecodecampcourse/widgets/generics/get_argument.dart';
import 'package:freecodecampcourse/services/cloud/firebase_cloud_storage.dart';
import 'package:freecodecampcourse/services/cloud/cloud_storage_exception.dart';
import 'package:freecodecampcourse/services/cloud/cloud_storage_exception.dart';
import 'package:path/path.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({super.key});

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
// when build function called again again then our note recreate again and again that is not good,
//We have to keep the record of note creation and make sure should create only one time.
  CloudNote? _note;
  late final FirebaseCloudStorage _noteService;
  late final TextEditingController _textController;

  @override
  void initState() {
    // Here we are getting the singleton instance of FirebaseCloudStorage not creating new instance
    _noteService = FirebaseCloudStorage();
    _textController = TextEditingController();
    super.initState();
  }

// when the user typing note, our _textControllerListener function constantly will send the note in database
  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = _textController.text;
    await _noteService.updateNote(
      documentId: note.documentId,
      text: text,
    );
  }

  // it remove _textControllerListener if already added then add again
  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
    print("CREATE OR GET EXISTING NOTE FUNCTION");

    final widgetNote = context.getArgument<CloudNote>();
    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
      return widgetNote;
    }

    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    //!means we're expecting currUser
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newNote = await _noteService.createNewNote(ownerUserId: userId);
    _note = newNote;
    return newNote;
  }

  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_textController.text.isEmpty && note != null) {
      _noteService.deleteNote(documentId: note.documentId);
    }
  }

  void _saveNoteIfTextNotEmpty() {
    final note = _note;
    final text = _textController.text;
    if (note != null && text.isNotEmpty) {
      _noteService.updateNote(documentId: note.documentId, text: text);
    }
  }

// The dispose method is called when a widget is removed from the screen.
// Here we can go back to previous screen therefore dispose.
  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextNotEmpty();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Note'),
        ),
        body: FutureBuilder(
          future: createOrGetExistingNote(context),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                _setupTextControllerListener();
                return TextField(
                  controller: _textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: ' Start typing your note.......'),
                );
              default:
                return const CircularProgressIndicator();
            }
          },
        ));
  }
}

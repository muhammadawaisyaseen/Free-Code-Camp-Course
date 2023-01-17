import 'package:flutter/material.dart';
import 'package:freecodecampcourse/services/auth/auth_service.dart';
import 'package:freecodecampcourse/services/crud/notes_service.dart';
import 'package:sqflite/sqflite.dart';

class NewNoteView extends StatefulWidget {
  const NewNoteView({super.key});

  @override
  State<NewNoteView> createState() => _NewNoteViewState();
}

class _NewNoteViewState extends State<NewNoteView> {
// when build function called again again then our note recreate again and again that is not good,
//We have to keep the record of note creation and make sure should create only one time.
  DatabaseNote? _note;
  late final NotesService _noteService;
  late final TextEditingController _textController;

  @override
  void initState() {
    // we need to insur that we are creating instance of NotesService & TextEditingController.
    _noteService = NotesService();
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
      note: note,
      text: text,
    );
  }

  // it remove _textControllerListener if already added then add again
  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<DatabaseNote> createNewNote() async {
    print("CREATE NEW NOTE FUNCTION");
    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    //!means we're expecting currUser
    final currentUser = AuthService.firebase().currentUser!;
    final email = currentUser.email!;
    final owner = await _noteService.getUser(email: email);
    return await _noteService.createNote(owner: owner);
  }

  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_textController.text.isEmpty && note != null) {
      _noteService.deleteNote(id: note.id);
    }
  }

  void _saveNoteIfTextNotEmpty() {
    final note = _note;
    final text = _textController.text;
    if (note != null && text.isNotEmpty) {
      _noteService.updateNote(
        note: note,
        text: text,
      );
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
          future: createNewNote(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                _note = snapshot.data as DatabaseNote;
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

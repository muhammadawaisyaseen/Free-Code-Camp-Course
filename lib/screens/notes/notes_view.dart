// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:freecodecampcourse/screens/notes/notes_list_view.dart';
import 'package:freecodecampcourse/services/auth/auth_service.dart';
import 'package:freecodecampcourse/services/auth/bloc/auth_bloc.dart';
import 'package:freecodecampcourse/services/auth/bloc/auth_event.dart';
import 'package:freecodecampcourse/services/cloud/cloud_note.dart';
import 'package:freecodecampcourse/services/cloud/firebase_cloud_storage.dart';
import 'package:freecodecampcourse/widgets/dialogs/logout_dialog.dart';
import '../../constants/routes.dart';
import '../../enums/menu_action.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _noteService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    // Here we are getting the singleton instance of FirebaseCloudStorage not creating new instance
    _noteService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes view'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
              },
              icon: const Icon(Icons.add)),
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    // await AuthService.firebase().logOut();
                    context.read<AuthBloc>().add(
                          const AuthEventLogOut(),
                        );
                  } else {
                    return;
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Logout'),
                ),
              ];
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _noteService.allNotes(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allNotes = snapshot.data as Iterable<CloudNote>;
                // print(allNotes);
                return NotesListView(
                  notes: allNotes,
                  onDeleteNote: (note) async {
                    _noteService.deleteNote(documentId: note.documentId);
                  },
                  onTap: (note) {
                    Navigator.of(context)
                        .pushNamed(createOrUpdateNoteRoute, arguments: note);
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

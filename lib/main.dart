import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freecodecampcourse/screens/login_view.dart';
import 'package:freecodecampcourse/screens/notes/create_update_note_view.dart';
import 'package:freecodecampcourse/screens/notes/notes_view.dart';
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
        verifyEmailRoute: (context) => const EmailVerificationView(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView()
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
  Widget build(BuildContext context) {
    return Container();
  }
}

@immutable
abstract class CounterState {
  final int value;
  const CounterState(this.value);
}

class CounterStateValid extends CounterState {
  const CounterStateValid(int value) : super(value);
}

class CounterStateInvalidNumber extends CounterState {
  final String invalidValue;

  const CounterStateInvalidNumber({
    required this.invalidValue,
    required int previousValue,
  }) : super(previousValue);
}

//String that comes from UI can go directly to CounterEvent
@immutable
abstract class CounterEvent {
  final String value;
  const CounterEvent(this.value);
}

class IncrementEvent extends CounterEvent {
  const IncrementEvent(String value) : super(value);
}

class DecrementEvent extends CounterEvent {
  const DecrementEvent(String value) : super(value);
}

class CounterBloc extends Bloc<CounterEvent, CounterBloc> {
  //Every block has to have initial state, here we start with valid value
  CounterBloc() : super(const CounterStateValid(0)) {
    //To catch Events in our CounterBloc use on<> Function
    on<IncrementEvent>((event, emit) {
      // get the IncrementEvent value
      int integer = int.tryParse(event.value);
      //If value(String)is not converted to int
      if (integer == null) {
        CounterStateInvalidNumber(
            invalidValue: event.value, previousValue: state.value);
      }
    });
    on<DecrementEvent>((event, emit) {});
  }
}



// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     print('Home Init');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: AuthService.firebase().initialize(),
//       builder: (context, snapshot) {
//         print('Home Future Build');
//         switch (snapshot.connectionState) {
//           case ConnectionState.done:
//             final user = AuthService.firebase().currentUser;
//             if (user != null) {
//               if (user.isEmailVerified) {
//                 // NotesView is not showing after verifying
//                 return NotesView();
//               } else {
//                 return const EmailVerificationView();
//               }
//             } else {
//               return LoginView();
//             }

//           default:
//             return const CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }

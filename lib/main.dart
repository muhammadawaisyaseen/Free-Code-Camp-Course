// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freecodecampcourse/screens/login_view.dart';
import 'package:freecodecampcourse/screens/notes/create_update_note_view.dart';
import 'package:freecodecampcourse/screens/notes/notes_view.dart';
import 'package:freecodecampcourse/screens/register_view.dart';
import 'package:freecodecampcourse/screens/verify_email_view.dart';
// import 'package:freecodecampcourse/services/auth/auth_service.dart';
import 'package:freecodecampcourse/services/auth/bloc/auth_bloc.dart';
import 'package:freecodecampcourse/services/auth/bloc/auth_event.dart';
import 'package:freecodecampcourse/services/auth/bloc/auth_state.dart';
import 'package:freecodecampcourse/services/auth/firebase_auth_provider.dart';
import 'constants/routes.dart';

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
      home: BlocProvider(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
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
  void initState() {
    super.initState();
    print('Home Init');
  }

  @override
  Widget build(BuildContext context) {
    //Read Bloc and convey an event to it
    //add() is a way to communicate with Bloc about various Events that you are sending
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const EmailVerificationView();
        } else if (state is AuthStateLoggedOut) {
          return LoginView();
        } else if (State is AuthStateRegistering) {
          return RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  //   return FutureBuilder(
  //     future: AuthService.firebase().initialize(),
  //     builder: (context, snapshot) {
  //       print('Home Future Build');
  //       switch (snapshot.connectionState) {
  //         case ConnectionState.done:
  //           final user = AuthService.firebase().currentUser;
  //           if (user != null) {
  //             if (user.isEmailVerified) {
  //               // NotesView is not showing after verifying
  //               return NotesView();
  //             } else {
  //               return const EmailVerificationView();
  //             }
  //           } else {
  //             return LoginView();
  //           }

  //         default:
  //           return const CircularProgressIndicator();
  //       }
  //     },
  //   );
  // }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late final TextEditingController _controller;

//   @override
//   void initState() {
//     _controller = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // To access Block in UI we will use BlockProvider
//     return BlocProvider(
//       create: (context) => CounterBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Testing bloc'),
//         ),
//         body: BlocConsumer<CounterBloc, CounterState>(
//           listener: (context, state) {
//             //upon any state produce by CounterBloc, we want to clear the textfield
//             _controller.clear();
//           },
//           // The [builder] takes the BuildContext and current state and must return a widget.
//           builder: (context, state) {
//             final invalidValue =
//                 (state is CounterStateInvalidNumber) ? state.invalidValue : '';
//             return Column(
//               children: [
//                 Text('Current Value=> ${state.value}'),
//                 Visibility(
//                   child: Text('Invalid input: $invalidValue'),
//                   visible: state is CounterStateInvalidNumber,
//                 ),
//                 TextField(

//                   controller: _controller,
//                   decoration:
//                       const InputDecoration(hintText: 'Enter a number here'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 Row(
//                   children: [
//                     TextButton(
//                       // after pressing - button send text to bloc(means sending Event to block)
//                       onPressed: () {
//                         context
//                             .read<CounterBloc>()
//                             .add(DecrementEvent(_controller.text));
//                       },
//                       child: const Text('-'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         context
//                             .read<CounterBloc>()
//                             .add(IncrementEvent(_controller.text));
//                       },
//                       child: const Text('+'),
//                     ),
//                   ],
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// @immutable
// abstract class CounterState {
//   final int value;
//   const CounterState(this.value);
// }

// class CounterStateValid extends CounterState {
//   const CounterStateValid(int value) : super(value);
// }

// class CounterStateInvalidNumber extends CounterState {
//   final String invalidValue;

//   const CounterStateInvalidNumber({
//     required this.invalidValue,
//     required int previousValue,
//   }) : super(previousValue);
// }

// //String that comes from UI can go directly to CounterEvent
// @immutable
// abstract class CounterEvent {
//   final String value;
//   const CounterEvent(this.value);
// }

// class IncrementEvent extends CounterEvent {
//   const IncrementEvent(String value) : super(value);
// }

// class DecrementEvent extends CounterEvent {
//   const DecrementEvent(String value) : super(value);
// }

// class CounterBloc extends Bloc<CounterEvent, CounterState> {
//   //Every block has to have initial state, here we start with valid value
//   CounterBloc() : super(const CounterStateValid(0)) {
//     //To catch Events in our CounterBloc use on<> Function
//     on<IncrementEvent>((event, emit) {
//       // get the IncrementEvent value
//       final integer = int.tryParse(event.value);
//       //If value(String)is not converted to int
//       if (integer == null) {
//         CounterStateInvalidNumber(
//             invalidValue: event.value, previousValue: state.value);
//       } else {
//         CounterStateValid(state.value + integer);
//       }
//     });
//     on<DecrementEvent>((event, emit) {
//       final integer = int.tryParse(event.value);
//       if (integer == null) {
//         CounterStateInvalidNumber(
//             invalidValue: event.value, previousValue: state.value);
//       } else {
//         emit(CounterStateValid(state.value - integer));
//       }
//     });
//   }
// }

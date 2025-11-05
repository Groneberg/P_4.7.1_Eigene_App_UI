import 'dart:developer';

import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/repositories/firebase_auth_repository.dart';
import 'package:box_this/src/data/repositories/shared_preferences_repository.dart';
import 'package:box_this/src/features/organization/presentation/screens/home_screen.dart';
import 'package:box_this/src/theme/app_theme.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'firebase_options.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final FirestoreDatabaseRepository repository = FirestoreDatabaseRepository();
  // final MockDatabaseRepository databaseRepository= MockDatabaseRepository();
  final SharedPreferencesRepository databaseRepository =
      SharedPreferencesRepository.instance;
  // await repository.initializePersistence();
  

//Firebase / FireStore Setup
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await runExampleAuthAndInit();

  // final authRepo = FirebaseAuthRepository.instance;
  // final dbRepo = FirestoreDatabaseRepository.instance;


  // final email = 'testuser@example.com';
  // final password = 'password123';


  // try {
  //   await authRepo.signInWithEmailAndPassword(email, password);
  //   log('Anmeldung erfolgreich.');

  // } catch (e) {
  //   log('Fehler bei der Anmeldung: $e');
  // }
  // await dbRepo.initFireStoreDatabase();
  // await dbRepo.createBox(
  // Hier fehlt vermutlich ein Argument, z.B. ein Box-Objekt:
  // await dbRepo.createBox(Box(name: "TestBox", description: "Test box"));

  // Optional: Melde dich nach dem Test ab
  // await authRepo.signOut();
  // log('Nutzer erfolgreich abgemeldet.');
  // log('--- Ende Authentifizierungs- und Initialisierungs-Test ---');

  // runApp(const MainApp());
  runApp(
    MultiProvider(
      providers: [
        // Provider<FirebaseAuthRepository>(
        //   create: (_) => authRepo,
        // ),
        // Provider<FirestoreDatabaseRepository>(
        //   create: (_) => dbRepo,
        // ),
        ChangeNotifierProvider<SharedPreferencesRepository>(
          create: (_) => databaseRepository,
        ),
      ],
      child: MainApp(),
    )
  );
}

// Future<void> runExampleAuthAndInit() async {
//   final authRepo = FirebaseAuthRepository.instance;
//   final dbRepo = FirestoreDatabaseRepository.instance;
//   final email = 'testuser@example.com';
//   final password = 'password123';

//   log('--- Start Authentifizierungs- und Initialisierungs-Test ---');

//   // 1. Registrierung: Versuche, einen neuen Nutzer zu erstellen
//   try {
//     await authRepo.createUserWithEmailAndPassword(email, password);
//     log('Registrierung erfolgreich.');

//     // 2. Initialisierung der MainBox FÜR DEN NEUEN NUTZER
//     await dbRepo.initFireStoreDatabase();
//     await dbRepo.createBox(
//       Box(name: "InitialBox", description: "Initial box after registration"),
//     );
//   } on FirebaseAuthException catch (e) {
//     // Wenn der Nutzer bereits existiert, melde dich stattdessen an
//     if (e.code == 'email-already-in-use') {
//       log('Nutzer existiert bereits. Versuche Anmeldung...');

//       try {
//         await authRepo.signInWithEmailAndPassword(email, password);
//         log('Anmeldung erfolgreich.');

//         // 3. Initialisierung der MainBox FÜR DEN ANGEMELDETEN NUTZER
//         // (Diese Methode erkennt, dass die Box bereits existiert.)
//         await dbRepo.initFireStoreDatabase();
//       } catch (e) {
//         log('Fehler bei der Anmeldung: $e');
//       }
//     } else {
//       log('Fehler bei der Registrierung: $e');
//     }
//   }

//   // Optional: Melde dich nach dem Test ab
//   await authRepo.signOut();
//   log('Nutzer erfolgreich abgemeldet.');
//   log('--- Ende Authentifizierungs- und Initialisierungs-Test ---');
// }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Box This',
      theme: AppTheme.lightTheme,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        child: HomeScreen(),
          //child: CreateBoxScreen(),
          //child: BoxDetailScreen(box: MockDatabaseRepository.instance.mainBox.boxes[0]!),
          //child: CreateItemScreen(),
          //child: BuildWidgetScreen(),
          //child: CreateEventScreen(),
          //child: AuthScreen(),
          //child: FirestoreTestScreen(),
      ),
    );
  }
}

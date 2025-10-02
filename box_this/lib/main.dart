import 'dart:developer';

import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/model/event.dart';
import 'package:box_this/src/data/model/item.dart';
import 'package:box_this/src/data/repositories/firebase_auth_repository.dart';
import 'package:box_this/src/data/repositories/firestore_database_repository.dart';
import 'package:box_this/src/data/repositories/mock_database_repository.dart';
import 'package:box_this/src/data/repositories/shared_preferences_repository.dart';
import 'package:box_this/src/features/login/screens/firestore_test_screen.dart';
import 'package:box_this/src/features/login/screens/login_register_test_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/box_detail_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/build_widget_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_box_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_item_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/home_screen.dart';
import 'package:box_this/src/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final FirestoreDatabaseRepository repository = FirestoreDatabaseRepository();
  final MockDatabaseRepository repository = MockDatabaseRepository();
  // final SharedPreferencesRepository repository =
  //     SharedPreferencesRepository.instance;
  // await repository.initializePersistence();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await runExampleAuthAndInit();

  final authRepo = FirebaseAuthRepository.instance;
  final dbRepo = FirestoreDatabaseRepository.instance;
  final email = 'testuser@example.com';
  final password = 'password123';

  try {
    await authRepo.signInWithEmailAndPassword(email, password);
    log('Anmeldung erfolgreich.');

  } catch (e) {
    log('Fehler bei der Anmeldung: $e');
  }
  await dbRepo.initFireStoreDatabase();
  await dbRepo.createBox(
    Box(name: "testBox2", description: "Iam a test box"),
  );
  await dbRepo.createEvent(Event(name: "test", time: "12:12", date: "12.12.1212", description: ""));
  await dbRepo.createItem(
    Item(name: "testItem2", description: "Iam a test item"),
  );
  log(await dbRepo.readBox("testBox2").toString());
  log(await dbRepo.readEvent("test").toString());
  log(await dbRepo.readItem("testItem2").toString());
  // log(dbRepo.readBox("testBox").toString());
  await dbRepo.updateBox(Box(name: "testBox28", description: "Iam an updated test box"));
  await dbRepo.updateEvent(Event(name: "testupdate", time: "14:14", date: "14.14.1414", description: "updated event"));
  await dbRepo.updateItem(Item(name: "testItem28", description: "Iam an updated test item"));

  await dbRepo.deleteEvent("test");
  await dbRepo.deleteItem("testItem2");
  await dbRepo.deleteBox("testBox2");
  await dbRepo.deleteBox("testBox2");

  // Optional: Melde dich nach dem Test ab
  await authRepo.signOut();
  log('Nutzer erfolgreich abgemeldet.');
  // log('--- Ende Authentifizierungs- und Initialisierungs-Test ---');

  runApp(const MainApp());
}

Future<void> runExampleAuthAndInit() async {
  final authRepo = FirebaseAuthRepository.instance;
  final dbRepo = FirestoreDatabaseRepository.instance;
  final email = 'testuser@example.com';
  final password = 'password123';

  log('--- Start Authentifizierungs- und Initialisierungs-Test ---');

  // 1. Registrierung: Versuche, einen neuen Nutzer zu erstellen
  try {
    await authRepo.createUserWithEmailAndPassword(email, password);
    log('Registrierung erfolgreich.');

    // 2. Initialisierung der MainBox FÜR DEN NEUEN NUTZER
    await dbRepo.initFireStoreDatabase();
    await dbRepo.createBox(
      Box(name: "InitialBox", description: "Initial box after registration"),
    );
  } on FirebaseAuthException catch (e) {
    // Wenn der Nutzer bereits existiert, melde dich stattdessen an
    if (e.code == 'email-already-in-use') {
      log('Nutzer existiert bereits. Versuche Anmeldung...');

      try {
        await authRepo.signInWithEmailAndPassword(email, password);
        log('Anmeldung erfolgreich.');

        // 3. Initialisierung der MainBox FÜR DEN ANGEMELDETEN NUTZER
        // (Diese Methode erkennt, dass die Box bereits existiert.)
        await dbRepo.initFireStoreDatabase();
      } catch (e) {
        log('Fehler bei der Anmeldung: $e');
      }
    } else {
      log('Fehler bei der Registrierung: $e');
    }
  }

  // Optional: Melde dich nach dem Test ab
  await authRepo.signOut();
  log('Nutzer erfolgreich abgemeldet.');
  log('--- Ende Authentifizierungs- und Initialisierungs-Test ---');
}

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
        child: SafeArea(
          // child: HomeScreen(),
          // child: CreateBoxScreen(),
          // child: BoxDetailScreen(),
          // child: CreateItemScreen(),
          // child: BuildWidgetScreen(),
          // child: AuthScreen(),
          child: FirestoreTestScreen(),
        ),
      ),
    );
  }
}

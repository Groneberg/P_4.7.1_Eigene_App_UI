// import 'dart:developer';
// import 'package:box_this/src/data/model/box.dart';
// import 'package:box_this/src/data/model/event.dart';
// import 'package:box_this/src/data/model/item.dart';
// import 'package:box_this/src/data/repositories/database_repository.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:uuid/uuid.dart';

// const uuid = Uuid();

// class FirestoreDatabaseRepository implements DatabaseRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Box mainBox = Box(name: "mainBox", description: "");
//   Box currentBox = Box(name: "currentBox", description: "");

//   String? get currentUserId => _auth.currentUser?.uid;

//   static final FirestoreDatabaseRepository _instance =
//       FirestoreDatabaseRepository._internal();

//   static FirestoreDatabaseRepository get instance => _instance;

//   factory FirestoreDatabaseRepository() {
//     return _instance;
//   }

//   FirestoreDatabaseRepository._internal();

//   bool checkLogin() {
//     return _auth.currentUser != null;
//   }

//   bool checkUserID() {
//     return _auth.currentUser?.uid != null;
//   }

//   Future<void> initFireStoreDatabase() async {
//     if (checkUserID() == false || checkLogin() == false) {
//       log("Fehler: Kein Nutzer angemeldet. Initialisierung abgebrochen.");
//       return;
//     }

//     mainBox.id = uuid.v4();
//     currentBox = mainBox;

//     log(mainBox.toString());
//     log(currentBox.toString());

//     try {
//       await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .doc(mainBox.id)
//           .set(mainBox.toJson());
//     } catch (e) {
//       log("Fehler bei der Initialisierung der Firestore-Datenbank: $e");
//     }
//   }

//   @override
//   Future<void> createBox(Box box) async {
//     if (checkUserID() == false || checkLogin() == false) {
//       log("Fehler: Kein Nutzer angemeldet. Box-Erstellung abgebrochen.");
//       return;
//     }

//     currentBox.boxes[box.name] = box;
//     currentBox.boxes[box.name]!.parentId = currentBox.id;
//     currentBox.boxes[box.name]!.id = uuid.v4();
//     currentBox = currentBox.boxes[box.name]!;

//     log(mainBox.toString());
//     log(currentBox.toString());

//     try {
//       await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .doc(currentBox.id)
//           .set(box.toJson());
//     } catch (e) {
//       log("Fehler bei der Erstellung der Box in Firestore: $e");
//     }
//   }

//   @override
//   Future<void> createEvent(Event event) async {
//     if (checkUserID() == false || checkLogin() == false) {
//       log("Fehler: Kein Nutzer angemeldet. Event-Erstellung abgebrochen.");
//       return;
//     }

//     event.parentId = currentBox.id;
//     event.id = uuid.v4();
//     currentBox.events[event.name] = event;

//     try {
//       await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .doc(event.parentId)
//           .collection('events')
//           .doc(event.id)
//           .set(event.toJson());
//     } catch (e) {
//       log("Fehler bei der Erstellung des Events in Firestore: $e");
//     }
//   }

//   @override
//   Future<void> createItem(Item item) async {
//     if (checkUserID() == false || checkLogin() == false) {
//       log("Fehler: Kein Nutzer angemeldet. Item-Erstellung abgebrochen.");
//       return;
//     }

//     item.parentId = currentBox.id;
//     item.id = uuid.v4();
//     currentBox.items[item.name] = item;

//     try {
//       await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .doc(item.parentId)
//           .collection('items')
//           .doc(item.id)
//           .set(item.toJson());
//     } catch (e) {
//       log("Fehler bei der Erstellung des Items in Firestore: $e");
//     }
//   }

//   @override
//   Future<void> deleteBox(String name) async {
//     if (checkUserID() == false || checkLogin() == false) {
//       log("Fehler: Kein Nutzer angemeldet. Kann Box '$name' nicht löschen.");
//       return;
//     }

//     currentBox.boxes.remove(name);

//     try {
//       QuerySnapshot snapshot = await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .where('name', isEqualTo: name) // Suche nach dem Namen
//           .limit(1)
//           .get();

//       if (snapshot.docs.isEmpty) {
//         log(
//           "Box mit dem Namen '$name' wurde nicht gefunden. Löschvorgang abgebrochen.",
//         );
//         return;
//       }

//       final String boxIdToDelete = snapshot.docs.first.id;

//       await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .doc(boxIdToDelete) // Löschung erfolgt über die ID
//           .delete();

//       log("Box '$name' (ID: $boxIdToDelete) erfolgreich gelöscht.");
//     } catch (e) {
//       log("Fehler beim Löschen der Box '$name' aus Firestore: $e");
//       rethrow;
//     }
//   }

//   @override
//   Future<void> deleteEvent(String name) async {
//     if (checkUserID() == false || checkLogin() == false) {
//       log("Fehler: Kein Nutzer angemeldet. Kann Event '$name' nicht löschen.");
//       return;
//     }

//     currentBox.events.remove(name);

//     try {
//       QuerySnapshot snapshot = await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .doc(currentBox.id)
//           .collection('events')
//           .where('name', isEqualTo: name)
//           .limit(1)
//           .get();

//       if (snapshot.docs.isEmpty) {
//         log(
//           "Event mit dem Namen '$name' wurde nicht gefunden. Löschvorgang abgebrochen.",
//         );
//         return;
//       }

//       final String eventIdToDelete = snapshot.docs.first.id;

//       await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .doc(currentBox.id)
//           .collection('events')
//           .doc(eventIdToDelete)
//           .delete();

//       log("Event '$name' (ID: $eventIdToDelete) erfolgreich gelöscht.");
//     } catch (e) {
//       log("Fehler beim Löschen des Events '$name' aus Firestore: $e");
//       rethrow;
//     }
//   }

//   @override
//   Future<void> deleteItem(String name) async {
//     if (checkUserID() == false || checkLogin() == false) {
//       log("Fehler: Kein Nutzer angemeldet. Kann Item '$name' nicht löschen.");
//       return;
//     }

//     currentBox.items.remove(name);

//     try {
//       QuerySnapshot snapshot = await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .doc(currentBox.id)
//           .collection('items')
//           .where('name', isEqualTo: name)
//           .limit(1)
//           .get();

//       if (snapshot.docs.isEmpty) {
//         log(
//           "Item mit dem Namen '$name' wurde nicht gefunden. Löschvorgang abgebrochen.",
//         );
//         return;
//       }

//       final String itemIdToDelete = snapshot.docs.first.id;

//       await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .doc(currentBox.id)
//           .collection('items')
//           .doc(itemIdToDelete)
//           .delete();

//       log("Item '$name' (ID: $itemIdToDelete) erfolgreich gelöscht.");
//     } catch (e) {
//       log("Fehler beim Löschen des Items '$name' aus Firestore: $e");
//       rethrow;
//     }
  
//   }

//   @override
//   Future<Map<String, Box>> readAllBoxes() async {
//     final String? _currentUserId = currentUserId;

//     if (_currentUserId == null) {
//       log("Fehler: Kein Nutzer angemeldet. Kann keine Boxen lesen.");
//       return {};
//     }

//     try {
//       QuerySnapshot snapshot = await _firestore
//           .collection('users')
//           .doc(_currentUserId)
//           .collection('boxes')
//           .get();
//       log("Boxen erfolgreich aus Firestore gelesen.");
//       Map<String, Box> boxes = {};
//       for (var doc in snapshot.docs) {
//         Box tempBox = Box.fromJson(doc.data() as Map<String, dynamic>);
//         boxes[tempBox.name] = tempBox;
//       }
//       return boxes;
//     } catch (e) {
//       log("Fehler beim Lesen der Boxen aus Firestore: $e");
//       return {};
//     }
//   }

//   @override
//   Future<Map<String, Event>> readAllEvent() {
//     // TODO: implement readAllEvent
//     throw UnimplementedError();
//   }

//   @override
//   Future<Box?> readBox(String name) async {
//     final String? userId = _auth.currentUser?.uid;

//     if (userId == null) {
//       log("Fehler: Kein Nutzer angemeldet. Kann keine Box lesen.");
//       return null;
//     }

//     try {
//       QuerySnapshot snapshot = await _firestore
//           .collection('users')
//           .doc(userId)
//           .collection('boxes')
//           .where('name', isEqualTo: name)
//           .limit(1)
//           .get();

//       if (snapshot.docs.isEmpty) {
//         log("Box mit dem Namen '$name' nicht gefunden.");
//         return null;
//       }

//       DocumentSnapshot doc = snapshot.docs.first;
//       Box foundBox = Box.fromJson(doc.data() as Map<String, dynamic>);
//       foundBox.id = doc.id;

//       log("Box '$name' erfolgreich gelesen (ID: ${doc.id}).");
//       return foundBox;
//     } catch (e) {
//       log("Fehler beim Lesen der Box '$name' aus Firestore: $e");
//       return null;
//     }
//   }

//   @override
//   Future<Event?> readEvent(String name) async {
//     if (checkUserID() == false || checkLogin() == false) {
//       log("Fehler: Kein Nutzer angemeldet. Kann kein Event lesen.");
//       return null;
//     }

//     try {
//       QuerySnapshot snapshot = await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .doc(currentBox.id)
//           .collection('events')
//           .where('name', isEqualTo: name)
//           .limit(1)
//           .get();

//       if (snapshot.docs.isEmpty) {
//         log("Event mit dem Namen '$name' nicht gefunden.");
//         return null;
//       }

//       DocumentSnapshot doc = snapshot.docs.first;
//       Event foundEvent = Event.fromJson(doc.data() as Map<String, dynamic>);
//       foundEvent.id = doc.id;

//       log("Event '$name' erfolgreich gelesen (ID: ${doc.id}).");
//       return foundEvent;
//     } catch (e) {
//       log("Fehler beim Lesen des Events '$name' aus Firestore: $e");
//       return null;
//     }
//   }
  
//   @override
//   Future<Item?> readItem(String name) async {
//     if (checkUserID() == false || checkLogin() == false) {
//       log("Fehler: Kein Nutzer angemeldet. Kann kein Item lesen.");
//       return null;
//     }

//     try {
//       QuerySnapshot snapshot = await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .doc(currentBox.id)
//           .collection('items')
//           .where('name', isEqualTo: name)
//           .limit(1)
//           .get();

//       if (snapshot.docs.isEmpty) {
//         log("Item mit dem Namen '$name' nicht gefunden.");
//         return null;
//       }

//       DocumentSnapshot doc = snapshot.docs.first;
//       Item foundItem = Item.fromJson(doc.data() as Map<String, dynamic>);
//       foundItem.id = doc.id;

//       log("Item '$name' erfolgreich gelesen (ID: ${doc.id}).");
//       return foundItem;
//     } catch (e) {
//       log("Fehler beim Lesen des Items '$name' aus Firestore: $e");
//       return null;
//     }
//   }

//   @override
//   Future<Box> readMainBoxStructure() {
//     // TODO: implement readMainBoxStructure
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> updateBox(Box box) async {
//     if (checkUserID() == false || checkLogin() == false) {
//       log("Fehler: Kein Nutzer angemeldet. Kann Box '${box.name}' nicht aktualisieren.");
//       return Future.value();
//     }

//     if (currentBox.id == null || currentBox.id!.isEmpty) {
//       log("Fehler: Box '${box.name}' hat keine gültige ID. Aktualisierung abgebrochen.");
//       return Future.value();
//     }

//     currentBox.boxes[box.name] = box;

//     try {
//       await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .doc(currentBox.id)
//           .update(box.toJson());
//       log("Box '${box.name}' erfolgreich aktualisiert.");
//     } catch (e) {
//       log("Fehler bei der Aktualisierung der Box '${box.name}' in Firestore: $e");
//     }
//   }

//   @override
//   Future<void> updateEvent(Event event) async {
//     if (checkUserID() == false || checkLogin() == false) {
//       log("Fehler: Kein Nutzer angemeldet. Kann Event '${event.name}' nicht aktualisieren.");
//       return Future.value();
//     }

//     if (currentBox.id == null || currentBox.id!.isEmpty) {
//       log("Fehler: Event '${event.name}' hat keine gültige ID. Aktualisierung abgebrochen.");
//       return Future.value();
//     }

//     currentBox.events[event.name] = event;

//     try {
//       await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .doc(event.parentId)
//           .collection('events')
//           .doc(event.id)
//           .update(event.toJson());
//       log("Event '${event.name}' erfolgreich aktualisiert.");
//     } catch (e) {
//       log("Fehler bei der Aktualisierung des Events '${event.name}' in Firestore: $e");
//     }
//   }

//   @override
//   Future<void> updateItem(Item item) async {
//     if (checkUserID() == false || checkLogin() == false) {
//       log("Fehler: Kein Nutzer angemeldet. Kann Item '${item.name}' nicht aktualisieren.");
//       return Future.value();
//     }

//     if (currentBox.id == null || currentBox.id!.isEmpty) {
//       log("Fehler: Item '${item.name}' hat keine gültige ID. Aktualisierung abgebrochen.");
//       return Future.value();
//     }

//     currentBox.items[item.name] = item;

//     try {
//       await _firestore
//           .collection('users')
//           .doc(currentUserId)
//           .collection('boxes')
//           .doc(item.parentId)
//           .collection('items')
//           .doc(item.id)
//           .update(item.toJson());
//       log("Item '${item.name}' erfolgreich aktualisiert.");
//     } catch (e) {
//       log("Fehler bei der Aktualisierung des Items '${item.name}' in Firestore: $e");
//     }
    
//   }
// }

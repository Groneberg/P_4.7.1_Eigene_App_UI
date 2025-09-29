import 'dart:developer';
import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/model/event.dart';
import 'package:box_this/src/data/model/item.dart';
import 'package:box_this/src/data/repositories/database_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabaseRepository implements DatabaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Box mainBox = Box(name: "mainBox", description: "");
  Box currentBox = Box(name: "currentBox", description: "");

  static final FirestoreDatabaseRepository _instance =
      FirestoreDatabaseRepository._internal();

  static FirestoreDatabaseRepository get instance => _instance;

  /// Factory constructor to return the singleton instance
  factory FirestoreDatabaseRepository() {
    return _instance;
  }

  FirestoreDatabaseRepository._internal();

  @override
  Future<void> createBox(Box box) {
    // TODO: implement createBox
    throw UnimplementedError();
  }

  @override
  Future<void> createEvent(Event event) {
    // TODO: implement createEvent
    throw UnimplementedError();
  }

  @override
  Future<void> createItem(Item item) {
    // TODO: implement createItem
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBox(String name) {
    // TODO: implement deleteBox
    throw UnimplementedError();
  }

  @override
  Future<void> deleteEvent(String name) {
    // TODO: implement deleteEvent
    throw UnimplementedError();
  }

  @override
  Future<void> deleteItem(String name) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<Map<String, Box>> readAllBoxes() {
    // TODO: implement readAllBoxes
    throw UnimplementedError();
  }

  @override
  Future<Map<String, Event>> readAllEvent() {
    // TODO: implement readAllEvent
    throw UnimplementedError();
  }

  @override
  Future<Box?> readBox(String name) {
    // TODO: implement readBox
    throw UnimplementedError();
  }

  @override
  Future<Event?> readEvent(String name) {
    // TODO: implement readEvent
    throw UnimplementedError();
  }

  @override
  Future<Item?> readItem(String name) {
    // TODO: implement readItem
    throw UnimplementedError();
  }

  @override
  Future<Box> readMainBoxStructure() {
    // TODO: implement readMainBoxStructure
    throw UnimplementedError();
  }

  @override
  Future<void> updateBox(Box box) {
    // TODO: implement updateBox
    throw UnimplementedError();
  }

  @override
  Future<void> updateEvent(Event event) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }

  @override
  Future<void> updateItem(Item item) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }
  
}
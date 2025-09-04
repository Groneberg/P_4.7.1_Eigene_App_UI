import 'dart:convert';
import 'dart:developer';

import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/model/event.dart';
import 'package:box_this/src/data/model/item.dart';
import 'package:box_this/src/data/repositories/database_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  Box mainBox = Box(name: "mainBox", description: "");
  Box currentBox = Box(name: "currentBox", description: "");

  static final SharedPreferencesRepository _instance =
      SharedPreferencesRepository._internal();
  SharedPreferencesRepository._internal();

  static SharedPreferencesRepository get instance => _instance;

  late SharedPreferences _prefs;

  factory SharedPreferencesRepository() {
    return _instance;
  }

  Future<void> initializePersistence() async {
    _prefs = await SharedPreferences.getInstance();
    mainBox = await readMainBoxStructure();
    currentBox = mainBox;
  }

  Future<void> _persistBoxes(jsonString) async {
    try {
      _prefs.setString("mainBox", jsonString);
    } catch (e) {
      throw Exception("Error saving boxes: $e");
    }
  }

  String encodeMapToJson(Box box) {
    return jsonEncode(box.toJson());
  }

  @override
  Future<void> createBox(Box box) async {
    currentBox.boxes[box.name] = box;
    // convert Box to JSON-String
    String jsonString = encodeMapToJson(mainBox);
    log("This box will be saved as JSON: $jsonString");
    await _persistBoxes(jsonString);
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
  Future<Box> readMainBoxStructure() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      mainBox = Box.fromJson(
        // TODO könnte probleme machen
        jsonDecode(_prefs.getString("mainBox") ?? encodeMapToJson(Box(name: "mainBox", description: ""))),
      );
    } catch (e) {
      throw Exception("Error reading boxes: $e");
    }
    return mainBox;
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
  Future<void> updateItem(Item item) async {
    // TODO: implement updateItem
  }

  // Future<void> _persistTasks() async {
  //   try {
  //     await _prefs.setStringList('tasks', _tasks);
  //   } catch (e) {
  //     log("Fehler beim Speichern der Task-Liste: $e");
  //   }
  // }
}

import 'dart:convert';
import 'dart:developer';

import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/model/event.dart';
import 'package:box_this/src/data/model/item.dart';
import 'package:box_this/src/data/repositories/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository extends ChangeNotifier implements DatabaseRepository {
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
    notifyListeners();
    await _persistBoxes(jsonString);
  }

  @override
  Future<void> createEvent(Event event) async {
    currentBox.events[event.name] = event;
    String jsonString = encodeMapToJson(mainBox);
    log("This event will be saved as JSON: $jsonString");
    notifyListeners();
    await _persistBoxes(jsonString);
  }

  @override
  Future<void> createItem(Item item) async {
    currentBox.items[item.name] = item;
    String jsonString = encodeMapToJson(mainBox);
    log("This item will be saved as JSON: $jsonString");
    notifyListeners();
    await _persistBoxes(jsonString);
  }

  @override
  Future<void> deleteBox(String name) async {
    Box? parentBox = mainBox.getParentBoxChildBoxName(currentBox.name);

    if (parentBox != null) {
      parentBox.boxes.remove(name);
      currentBox = parentBox;
    } else if (currentBox.name == mainBox.name) {
      mainBox.boxes.remove(name);
      currentBox = mainBox;
    } else {
      log("Parent box not found for current box: ${currentBox.name}");
    }
      String jsonString = encodeMapToJson(mainBox);
      log("This box will be saved as JSON: $jsonString");
      notifyListeners();
      await _persistBoxes(jsonString);
  }

  @override
  Future<void> deleteEvent(String name) async {
    currentBox.events.remove(name);
    String jsonString = encodeMapToJson(mainBox);
    log("This event will be saved as JSON: $jsonString");
    notifyListeners();
    await _persistBoxes(jsonString);
  }

  @override
  Future<void> deleteItem(String name) async {
    currentBox.items.remove(name);
    String jsonString = encodeMapToJson(mainBox);
    log("This item will be saved as JSON: $jsonString");
    notifyListeners();
    await _persistBoxes(jsonString);
  }

  @override
  Future<Map<String, Box>> readAllBoxes() async {
    // TODO erstmal mainBox laden später alle aus box methode
    return mainBox.boxes;
  }

  @override
  Future<Box> readMainBoxStructure() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      mainBox = Box.fromJson(
        // TODO könnte probleme machen
        jsonDecode(
          _prefs.getString("mainBox") ??
              encodeMapToJson(Box(name: "mainBox", description: "")),
        ),
      );
    } catch (e) {
      throw Exception("Error reading boxes: $e");
    }
    return mainBox;
  }

  @override
  Future<Map<String, Event>> readAllEvent() async {
    // TODO erstmal mainBox ebents laden später alle aus box methode
    return currentBox.events;
  }

  @override
  Future<Box?> readBox(String name) async {
    return currentBox.boxes[name];
  }

  @override
  Future<Event?> readEvent(String name) async {
    return currentBox.events[name];
  }

  @override
  Future<Item?> readItem(String name) async {
    return currentBox.items[name];
  }

  @override
  Future<void> updateBox(Box box) async {
    currentBox.boxes[box.name] = box;
    String jsonString = encodeMapToJson(mainBox);
    log("This box will be saved as JSON: $jsonString");
    notifyListeners();
    await _persistBoxes(jsonString);
  }

  @override
  Future<void> updateEvent(Event event) async {
    currentBox.events[event.name] = event;
    String jsonString = encodeMapToJson(mainBox);
    log("This event will be saved as JSON: $jsonString");
    notifyListeners();
    await _persistBoxes(jsonString);
  }

  @override
  Future<void> updateItem(Item item) async {
    currentBox.items[item.name] = item;
    String jsonString = encodeMapToJson(mainBox);
    log("This item will be saved as JSON: $jsonString");
    notifyListeners();
    await _persistBoxes(jsonString);
  }

  // Future<void> _persistTasks() async {
  //   try {
  //     await _prefs.setStringList('tasks', _tasks);
  //   } catch (e) {
  //     log("Fehler beim Speichern der Task-Liste: $e");
  //   }
  // }
}

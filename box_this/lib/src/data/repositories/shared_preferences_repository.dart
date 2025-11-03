import 'dart:convert';
import 'dart:developer';

import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/model/event.dart';
import 'package:box_this/src/data/model/item.dart';
import 'package:box_this/src/data/repositories/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository extends ChangeNotifier
    implements DatabaseRepository {
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

  Future<void> _persistBoxes(String jsonString) async {
    try {
      _prefs.setString("mainBox", jsonString);
    } catch (e) {
      throw Exception("Error saving boxes: $e");
    }
  }

  String encodeMapToJson(Box box) {
    String jsonString = jsonEncode(box.toJson());
    log("This box will be encoded to JSON: $jsonString");
    return jsonString;
  }

  @override
  Future<void> createBox(Box box) async {
    // adds a box to the current box
    currentBox.addBox(box);
    notifyListeners();
    await _persistBoxes(encodeMapToJson(mainBox));
  }

  @override
  Future<void> createEvent(Event event) async {
    currentBox.addEvent(event);
    notifyListeners();
    await _persistBoxes(encodeMapToJson(mainBox));
  }

  Future<void> createEventInItem(Event event, String itemId) async {
    Item? targetItem = mainBox.findItemById(itemId);

    if (targetItem != null) {
      targetItem.addEvent(event);
      notifyListeners();
      await _persistBoxes(encodeMapToJson(mainBox));
    } else {
      log("Error: Item with ID $itemId could not be found in the box tree.");
    }
  }

  @override
  Future<void> createItem(Item item) async {
    currentBox.addItem(item);
    notifyListeners();
    await _persistBoxes(encodeMapToJson(mainBox));
  }

  @override
  Future<void> deleteBox(String id) async {
    Box? parentBox = mainBox.getParentBox(id);

    if (parentBox != null) {
      parentBox.boxes.remove(id);

      if (currentBox.id == id) {
        currentBox = parentBox;
      }
    } else {
      log("Could not find/delete box $id, no parent box found.");
      return;
    }

    notifyListeners();
    await _persistBoxes(encodeMapToJson(mainBox));
  }

  @override
  Future<void> deleteEvent(String id) async {
    Box? parentBox = mainBox.getParentBox(id);
    if (parentBox != null) {
      parentBox.events.remove(id);
    } else {
      log("Could not find/delete event $id. No parent box found.");
      return;
    }
    notifyListeners();
    await _persistBoxes(encodeMapToJson(mainBox));
  }

  Future<void> deleteEventInItem(String eventID, String itemID) async {
    Item? item = currentBox.items[itemID];
    if (item != null) {
      item.events.remove(eventID);
      notifyListeners();
      await _persistBoxes(encodeMapToJson(mainBox));
    } else {
      log("Item not found: $itemID. Event could not be deleted.");
    }
  }

  @override
  Future<void> deleteItem(String id) async {
    Box? parentBox = mainBox.getParentBox(id);
    if (parentBox != null) {
      parentBox.items.remove(id);
    } else {
      log("Could not find/delete item $id. No parent box found.");
      return;
    }
    notifyListeners();
    await _persistBoxes(encodeMapToJson(mainBox));
  }

  @override
  Future<Map<String, Box>> readAllBoxes() async {
    // TODO erstmal mainBox laden später alle aus box methode
    return mainBox.boxes;
  }

  @override
  Future<Box> readMainBoxStructure() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate some delay
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
  Future<Box?> readBox(String id) async {
    return mainBox.findBoxById(id);
  }

  @override
  Future<Event?> readEvent(String id) async {
    return currentBox.events[id];
  }

  @override
  Future<Item?> readItem(String id) async {
    return currentBox.items[id];
  }

  @override
  Future<void> updateBox(Box box) async {
    currentBox.boxes[box.id] = box;
    String jsonString = encodeMapToJson(mainBox);
    log("This box will be saved as JSON: $jsonString");
    notifyListeners();
    await _persistBoxes(jsonString);
  }

  @override
  Future<void> updateEvent(Event event) async {
    currentBox.events[event.id] = event;
    String jsonString = encodeMapToJson(mainBox);
    log("This event will be saved as JSON: $jsonString");
    notifyListeners();
    await _persistBoxes(jsonString);
  }

  @override
  Future<void> updateItem(Item item) async {
    currentBox.items[item.id] = item;
    String jsonString = encodeMapToJson(mainBox);
    log("This item will be saved as JSON: $jsonString");
    notifyListeners();
    await _persistBoxes(jsonString);
  }

  Future<void> updateEventInItem(Event event, String itemID) async {
    Item? item = currentBox.items[itemID];
    if (item != null) {
      item.events[event.id] = event;

      String jsonString = encodeMapToJson(mainBox);
      log("Event in Item updated: $jsonString");
      notifyListeners();
      await _persistBoxes(jsonString);
    } else {
      log("Item not found: $itemID. Event could not be updated.");
    }
  }

  Future<void> updateItemAmount(
    String itemID,
    int newAmount,
    int newMinAmount,
  ) async {
    Item? item = currentBox.items[itemID];
    if (item != null) {
      item.amount = newAmount;
      item.minAmount = newMinAmount;

      String jsonString = encodeMapToJson(mainBox);
      log("Item amount updated: $jsonString");
      notifyListeners();
      await _persistBoxes(jsonString);
    }
  }

}

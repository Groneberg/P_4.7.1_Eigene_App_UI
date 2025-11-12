import 'dart:convert';
import 'dart:developer';

import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/model/event.dart';
import 'package:box_this/src/data/model/item.dart';
import 'package:box_this/src/data/repositories/database_repository.dart';
import 'package:box_this/src/data/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart'; // Sie müssen 'intl' zu pubspec.yaml hinzufügen

class SharedPreferencesRepository extends ChangeNotifier
    implements DatabaseRepository {
  final NotificationService _notificationService = NotificationService();

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
    log(encodeMapToJson(mainBox));
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

    final DateTime? scheduleTime = _parseEventDateTime(event);
    if (scheduleTime != null) {
      await _notificationService.scheduleNotification(
        id: _getNotificationId(event.id),
        title: event.name,
        body: event.description.isNotEmpty
            ? event.description
            : "Erinnerung für ${event.name}",
        scheduledDateTime: scheduleTime,
        payload: event.id,
      );
    }
  }

  Future<void> createEventInItem(Event event, String itemId) async {
    Item? targetItem = mainBox.findItemById(itemId);

    if (targetItem != null) {
      targetItem.addEvent(event);
      notifyListeners();
      await _persistBoxes(encodeMapToJson(mainBox));

      final DateTime? scheduleTime = _parseEventDateTime(event);
      if (scheduleTime != null) {
        await _notificationService.scheduleNotification(
          id: _getNotificationId(event.id),
          title: event.name,
          body:
              "In ${targetItem.name}: ${event.description}",
          scheduledDateTime: scheduleTime,
          payload: event.id,
        );
      }
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

    await _notificationService.cancelNotification(_getNotificationId(id));
  }

  Future<void> deleteEventInItem(String eventID, String itemID) async {
    Item? item = currentBox.items[itemID];
    if (item != null) {
      item.events.remove(eventID);
      notifyListeners();
      await _persistBoxes(encodeMapToJson(mainBox));

      await _notificationService.cancelNotification(_getNotificationId(eventID));
    } else {
      log("Item not found: $itemID. Event could not be deleted.");
    }
  }

  @override
  Future<void> deleteItem(String id) async {
    Item? itemtoDelete = mainBox.findItemById(id);

    if (itemtoDelete == null) {
      log("Item $id not found, cannot delete.");
      return;
    }
    if (itemtoDelete.parentId == null || itemtoDelete.parentId!.isEmpty) {
      log("Item $id has no parentId, cannot delete.");
      return;
    }
    Box? parentBox = mainBox.findBoxById(itemtoDelete.parentId!);
    if (parentBox != null) {
      parentBox.items.remove(id);
    } else {
      log(
        "Could not find/delete item $id. Parent box ${itemtoDelete.parentId} not found.",
      );
      return;
    }

    notifyListeners();
    await _persistBoxes(encodeMapToJson(mainBox));
  }

  Future<Box> searchAllElements(String query) async {
    Box searchBox = Box(name: "searchResults", description: "Search Results");
    String queryLower = query.toLowerCase();

    final Set<String> foundIds = {};

    void searchBoxRecursive(Box box) {
      // Search boxes
      box.boxes.forEach((id, childBox) {
        if (childBox.name.toLowerCase().contains(queryLower)) {
          if (foundIds.add(id)) {
            searchBox.addBox(childBox);
          }
        }
        searchBoxRecursive(childBox);
      });

      // Search items
      box.items.forEach((id, item) {
        if (item.name.toLowerCase().contains(queryLower)) {
          if (foundIds.add(id)) {
            searchBox.addItem(item);
          }
        }
        // Search events in items
        item.events.forEach((eventId, event) {
          if (event.name.toLowerCase().contains(queryLower)) {
            if (foundIds.add(eventId)) {
              searchBox.addEvent(event);
            }
          }
        });
      });

      // Search events
      box.events.forEach((id, event) {
        if (event.name.toLowerCase().contains(queryLower)) {
          if (foundIds.add(id)) {
            searchBox.addEvent(event);
          }
        }
      });
    }

    // Start recursive search from main box
    searchBoxRecursive(mainBox);
    log("Search completed. Found ${foundIds.length} unique elements.");
    return searchBox;
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
    notifyListeners();
    String jsonString = encodeMapToJson(mainBox);
    log("This box will be saved as JSON: $jsonString");
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

  DateTime? _parseEventDateTime(Event event) {
    try {
      final DateFormat dateFormat = DateFormat('dd.MM.yyyy HH:mm');
      return dateFormat.parse('${event.date} ${event.time}');
    } catch (e) {
      log("Fehler beim Parsen des Event-Datums: $e");
      return null;
    }
  }

  int _getNotificationId(String eventId) {
    return eventId.hashCode.abs() % 2147483647;
  }
}

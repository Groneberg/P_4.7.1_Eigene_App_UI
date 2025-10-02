import 'dart:developer';

import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/model/event.dart';
import 'package:box_this/src/data/model/item.dart';
import 'package:box_this/src/data/repositories/database_repository.dart';

// Mock DB Map
Map<String, Box> boxes = {
  "Garden": Box(name: "Garden", description: ""),
  "Livingroom": Box(name: "Livingroom", description: ""),
  "Bathroom": Box(name: "Bathroom", description: ""),
};

class MockDatabaseRepository implements DatabaseRepository {
  Box mainBox = Box(name: "mainBox", description: "");
  Box currentBox = Box(name: "currentBox", description: "");

  /// Singleton instance of MockDatabaseRepository
  /// This ensures that only one instance of the repository is used throughout the app.
  static final MockDatabaseRepository _instance =
      MockDatabaseRepository._internal();

  static MockDatabaseRepository get instance => _instance;

  /// Factory constructor to return the singleton instance
  /// This allows the repository to be accessed globally without creating multiple instances.
  factory MockDatabaseRepository() {
    return _instance;
  }

  /// Private constructor for the singleton pattern
  /// This constructor initializes the repository with some default boxes if needed.
  MockDatabaseRepository._internal() {
    // Initialize with some default boxes if needed
    mainBox.boxes = boxes;
    currentBox.boxes = boxes;

    mainBox.boxes["Garden"]!.addBox(Box(name: "Tools", description: ""));
    mainBox.boxes["Garden"]!.addItem(Item(name: "Rake", description: "", amount: 0));
  }

  // Future<void> initializePersistence() async {
  //   mainBox = await readMainBoxStructure();
  //   currentBox = mainBox;
  // }

  @override
  Future<void> createBox(Box box) async {
    await Future.delayed(const Duration(seconds: 3));
    currentBox.boxes[box.name] = box;
    log("This box will be saved: $box");
  }

  @override
  Future<void> createEvent(Event event) async {
    await Future.delayed(const Duration(seconds: 3));
    currentBox.events[event.name] = event;
    log("This event will be saved: $event");
  }

  @override
  Future<void> createItem(Item item) async {
    await Future.delayed(const Duration(seconds: 3));
    currentBox.items[item.name] = item;
    log("This item will be saved: $item");
  }

  @override
  Future<Map<String, Box>> readAllBoxes() async {
    await Future.delayed(const Duration(seconds: 3));
    return boxes;
  }

  @override
  Future<Map<String, Event>> readAllEvent() async {
    await Future.delayed(const Duration(seconds: 3));
    Map<String, Event> events = {};
    return events;
  }

  @override
  Future<Box?> readBox(String name) async {
    await Future.delayed(const Duration(seconds: 3));
    Box? box = mainBox.findBoxByName(name);
    log("The box $box will be read.");
    // TODO handle null case
    currentBox = box ?? Box(name: "No Box", description: "No Box found");
    return box;
  }

  @override
  Future<Event?> readEvent(String name) async {
    await Future.delayed(const Duration(seconds: 3));
    Event? event = mainBox.findEventByName(name);
    log("The event $event will be read.");
    return event;
  }

  @override
  Future<Item?> readItem(String name) async {
    await Future.delayed(const Duration(seconds: 3));
    Item? item = mainBox.findItemByName(name);
    log("The item $item will be read.");
    return item;
  }

  @override
  Future<void> updateBox(Box box) async {
    await Future.delayed(const Duration(seconds: 3));
    currentBox.boxes[box.name] = box;
    log("The box $box will be updated.");
  }

  @override
  Future<void> updateEvent(Event event) async {
    await Future.delayed(const Duration(seconds: 3));
    currentBox.boxes.forEach((key, box) {
      if (box.events.containsKey(event.name)) {
        box.events[event.name] = event;
      }
    });
    log("The event $event will be updated.");
  }

  @override
  Future<void> updateItem(Item item) async {
    await Future.delayed(const Duration(seconds: 3));
    currentBox.boxes.forEach((key, box) {
      if (box.items.containsKey(item.name)) {
        box.items[item.name] = item;
      }
    });
    log("The item $item will be updated.");
  }

  @override
  Future<void> deleteBox(String name) async {
    await Future.delayed(const Duration(seconds: 3));

    currentBox.boxes.remove(name);
    log("The box $name will be deleted.");
    log("The List of boxes is $boxes");
  }

  @override
  Future<void> deleteEvent(String name) async {
    await Future.delayed(const Duration(seconds: 3));

    currentBox.boxes.forEach((key, box) {
      if (box.events.containsKey(name)) {
        box.events.remove(name);
      }
    });
    log("The Event $name will be deleted.");
  }

  @override
  Future<void> deleteItem(String name) async {
    await Future.delayed(const Duration(seconds: 3));

    currentBox.boxes.forEach((key, box) {
      if (box.items.containsKey(name)) {
        box.items.remove(name);
      }
    });
    log("The item $name will be deleted.");
  }

  @override
  Future<Box> readMainBoxStructure() async {
    await Future.delayed(const Duration(seconds: 3));
    return mainBox;
  }
}

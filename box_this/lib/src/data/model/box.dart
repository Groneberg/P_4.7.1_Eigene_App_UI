import 'package:box_this/src/data/model/event.dart';
import 'package:box_this/src/data/model/item.dart';

/// Represents a box that can contain other boxes, items, and events.
class Box {
  String name;
  String description;
  Map<String,Box> boxes = {};
  Map<String,Item> items = {};
  Map<String,Event> events = {};

  Box({required this.name, required this.description});

  /// Factory constructor to create a Box instance from a JSON map.
  factory Box.fromJson(Map<String, dynamic> json) {
    var boxesMap = json['boxes'] as Map<String, dynamic>;
    Map<String, Box> reconstructedBoxes = boxesMap.map(
      (key, value) => MapEntry(key, Box.fromJson(value as Map<String, dynamic>)),
    );

    var itemsMap = json['items'] as Map<String, dynamic>;
    Map<String, Item> reconstructedItems = itemsMap.map(
      (key, value) => MapEntry(key, Item.fromJson(value as Map<String, dynamic>)),
    );

    var eventsMap = json['events'] as Map<String, dynamic>;
    Map<String, Event> reconstructedEvents = eventsMap.map(
      (key, value) => MapEntry(key, Event.fromJson(value as Map<String, dynamic>)),
    );

    return Box(
      name: json['name'] as String,
      description: json['description'] as String,
    )..boxes = reconstructedBoxes
     ..items = reconstructedItems
     ..events = reconstructedEvents;
  }


  /// Adds a sub-box to the current box.
  /// This allows for creating a hierarchy of boxes.
  void addBox(Box box) {
    this.boxes[box.name] = box;
  }

  /// Adds an item to the current box.
  /// This allows for associating items with this specific box.
  void addItem(Item item) {
    this.items[name] = item;
  }

  Box? findBoxByName(String boxName) {
    // Check if the current box matches the name
    if (this.name == boxName) {
      return this;
    }
    // Recursively search in child boxes
    for (var boxEntrie in this.boxes.entries) {
      Box childBox = boxEntrie.value;
      var found = childBox.findBoxByName(boxName);
      // If a matching box is found in the child boxes, return it
      if (found != null) {
        return found;
      }
    }
    // If no matching box is found, return null
    return null;
  }

  Event? findEventByName(String eventName) {
    // Check if the current box contains the event
    if (this.events.containsKey(eventName)) {
      return this.events[eventName];
    }
    // Recursively search in child boxes
    for (var boxEntrie in this.boxes.entries) {
      Box childBox = boxEntrie.value;
      var found = childBox.findEventByName(eventName);
      // If a matching event is found in the child boxes, return it
      if (found != null) {
        return found;
      }
    }
    // If no matching event is found, return null
    return null;
  }

  Item? findItemByName(String itemName) {
    // Check if the current box contains the item
    if (this.items.containsKey(itemName)) {
      return this.items[itemName];
    }
    // Recursively search in child boxes
    for (var boxEntrie in this.boxes.entries) {
      Box childBox = boxEntrie.value;
      var found = childBox.findItemByName(itemName);
      // If a matching item is found in the child boxes, return it
      if (found != null) {
        return found;
      }
    }
    // If no matching item is found, return null
    return null;
  }

  void showBoxTree() {
    print(this.toString());
    if (this.boxes.isNotEmpty) {
      this.boxes.forEach((key, box) {
        // print('  ' + box.toString());
        box.showBoxTree(); // Recursively show child boxes
      });
    }
  }

  /// Adds an event to the current box.
  /// This allows for associating events with this specific box.
  void addEvent(Event event) {
    this.events[name] = event;
  }

    Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'boxes': boxes.map((key, value) => MapEntry(key, value.toJson())),
      'items': items.map((key, value) => MapEntry(key, value.toJson())),
      'events': events.map((key, value) => MapEntry(key, value.toJson())),
    };
  }


  // TODO bessere umsetzung der Informationen
  @override
  String toString() {
    return 'Name: ${this.name}\n'
        'Description: ${this.description}';
  }
}

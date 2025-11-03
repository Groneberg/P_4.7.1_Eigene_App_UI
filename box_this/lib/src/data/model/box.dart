import 'package:box_this/src/data/model/event.dart';
import 'package:box_this/src/data/model/item.dart';
import 'package:uuid/uuid.dart';

/// Represents a box that can contain other boxes, items, and events.
class Box {
  final String id;
  String? parentId;
  String name;
  String description;

  Map<String, Box> boxes = {};
  Map<String, Item> items = {};
  Map<String, Event> events = {};

  Box({
    String? id,
    parentId = "",
    required this.name,
    required this.description,
  }) : this.id = id ?? Uuid().v4();

  /// Factory constructor to create a Box instance from a JSON map.
  factory Box.fromJson(Map<String, dynamic> json) {
    String? idFromJason = json['id'] as String?;

    var boxesMap = json['boxes'] as Map<String, dynamic>? ?? {};
    Map<String, Box> reconstructedBoxes = boxesMap.map(
      (key, value) =>
          MapEntry(key, Box.fromJson(value as Map<String, dynamic>)),
    );

    var itemsMap = json['items'] as Map<String, dynamic>? ?? {};
    Map<String, Item> reconstructedItems = itemsMap.map(
      (key, value) =>
          MapEntry(key, Item.fromJson(value as Map<String, dynamic>)),
    );

    var eventsMap = json['events'] as Map<String, dynamic>? ?? {};
    Map<String, Event> reconstructedEvents = eventsMap.map(
      (key, value) =>
          MapEntry(key, Event.fromJson(value as Map<String, dynamic>)),
    );

    return Box(
        id: idFromJason,
        parentId: json['parentId'] as String?,
        name: json['name'] as String,
        description: json['description'] as String,
      )
      ..boxes = reconstructedBoxes
      ..items = reconstructedItems
      ..events = reconstructedEvents;
  }

  /// Adds a sub-box to the current box.
  /// This allows for creating a hierarchy of boxes.
  void addBox(Box box) {
    this.boxes[box.id] = box;
  }

  /// Adds an item to the current box.
  /// This allows for associating items with this specific box.
  void addItem(Item item) {
    this.items[item.id] = item;
  }

  /// Recursively searches for a box by its id within the current box and its sub-boxes.
  /// Returns the Box if found, or null if not found.
  Box? findBoxById(String boxId) {
    // Check if the current box matches the name
    if (this.id == boxId) {
      return this;
    }
    // Check if the current box contains the box
    if (this.boxes.containsKey(boxId)) {
      return this.boxes[boxId];
    }

    // Recursively search in child boxes
    for (var childBox in this.boxes.values) {
      var found = childBox.findBoxById(boxId);
      if (found != null) {
        return found;
      }
    }
    // If no matching box is found, return null
    return null;
  }

  Item? findItemById(String itemId) {
    // Check if the current box contains the item
    if (this.items.containsKey(itemId)) {
      return this.items[itemId];
    }
    
    // Recursively search in child boxes
    for (var childBox in this.boxes.values) {
      var found = childBox.findItemById(itemId);
      if (found != null) {
        return found;
      }
    }
    return null;
  }

  /// Finds the parent box of a given child ID.
  Box? getParentBox(String childId) {
    if (this.boxes.containsKey(childId) ||
        this.items.containsKey(childId) ||
        this.events.containsKey(childId)) {
      return this;
    }

    for (var childBox in this.boxes.values) {
      var parent = childBox.getParentBox(childId);
      if (parent != null) {
        return parent;
      }
    }
    return null;
  }

  Event? findEventById(String eventId) {
    // Check if the current box contains the event
    if (this.events.containsKey(eventId)) {
      return this.events[eventId];
    }
    // Recursively search in child boxes
    for (var childBox in this.boxes.values) {
      var found = childBox.findEventById(eventId);
      if (found != null) {
        return found;
      }
    }
   
    // If no matching event is found, return null
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
    this.events[event.id] = event;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonString = {
      'name': name,
      'description': description,
    };

    if (id.isNotEmpty) {
      jsonString['id'] = id;
    }

    if (parentId != null && parentId!.isNotEmpty) {
      jsonString['parentId'] = parentId;
    }

    if (boxes.isNotEmpty) {
      jsonString['boxes'] = boxes.map(
        (key, value) => MapEntry(key, value.toJson()),
      );
    }

    if (items.isNotEmpty) {
      jsonString['items'] = items.map(
        (key, value) => MapEntry(key, value.toJson()),
      );
    }

    if (events.isNotEmpty) {
      jsonString['events'] = events.map(
        (key, value) => MapEntry(key, value.toJson()),
      );
    }

    return jsonString;
  }

  // TODO bessere umsetzung der Informationen
  @override
  String toString() {
    return 'Box(id: $id, parentId: ${parentId ?? ""}, name: $name, description: $description, boxes: ${boxes.keys.toList()}, items: ${items.keys.toList()}, events: ${events.keys.toList()})';
  }
}

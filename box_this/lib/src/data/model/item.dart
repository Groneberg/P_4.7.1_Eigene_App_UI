import 'Event.dart';

/// Represents an item with a name, description, amount, and associated events.
class Item {
  String? id;
  String? parentId;

  String name;
  String description;
  String? location;
  int amount = 0;
  int minAmount = 0;
  Map<String, Event> events = {};

  Item({
    id = "",
    parentId = "",
    required this.name,
    required this.description,
    this.location,
    this.amount = 0,
    this.minAmount = 0,
  });

  /// Factory constructor to create an Item instance from a JSON map.
  factory Item.fromJson(Map<String, dynamic> json) {
    var eventsMap = json['events'] as Map<String, dynamic>? ?? {};
    Map<String, Event> reconstructedEvents = eventsMap.map(
      (key, value) =>
          MapEntry(key, Event.fromJson(value as Map<String, dynamic>)),
    );

    return Item(
      id: json['id'] as String?,
      parentId: json['parentId'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String?,
      amount: json['amount'] as int,
      minAmount: json['minAmount'] as int,
    )..events = reconstructedEvents; // Fügt die rekonstruierten Events hinzu
  }

  /// Adds an event to the current box.
  /// This allows for associating events with this specific box.
  void addEvent(Event event) {
    this.events[event.name] = event;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonString = {
      'name': name,
      'description': description,
    };

    if (id != null && id!.isNotEmpty) {
      jsonString['id'] = id;
    }
    if (parentId != null && parentId!.isNotEmpty) {
      jsonString['parentId'] = parentId;
    }
    if (location != null && location!.isNotEmpty) {
      jsonString['location'] = location;
    }
    if (amount != 0) {
      jsonString['amount'] = amount;
    }

    if (minAmount != 0) {
      jsonString['minAmount'] = minAmount;
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
    return 'Item('
        'id: $id, '
        'parentId: $parentId, '
        'name: $name, '
        'description: $description, '
        'location: $location, '
        'amount: $amount, '
        'minAmount: $minAmount, '
        'events: ${events.keys.toList()}'
        ')';
  }
}

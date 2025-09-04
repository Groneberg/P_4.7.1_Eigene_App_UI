import 'Event.dart';

/// Represents an item with a name, description, amount, and associated events.
class Item {
  String name;
  String description;
  int amount = 0;
  int minAmount = 0;
  // map vielleicht besser ?
  Map<String, Event> events = {};

  Item(this.name, this.description, this.amount, this.minAmount);

  /// Factory constructor to create an Item instance from a JSON map.
  factory Item.fromJson(Map<String, dynamic> json) {
    var eventsMap = json['events'] as Map<String, dynamic>;
    Map<String, Event> reconstructedEvents = eventsMap.map(
      (key, value) =>
          MapEntry(key, Event.fromJson(value as Map<String, dynamic>)),
    );

    return Item(
      json['name'] as String,
      json['description'] as String,
      json['amount'] as int,
      json['minAmount'] as int,
    )..events = reconstructedEvents; // Fügt die rekonstruierten Events hinzu
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
      'amount': amount,
      'minAmount': minAmount,
      'events': events.map((key, value) => MapEntry(key, value.toJson())),
    };
  }

  // TODO bessere umsetzung der Informationen
  @override
  String toString() {
    return 'Name: ${this.name}\n'
        'Description: ${this.description}\n'
        'Amount: ${this.amount}\n';
  }
}

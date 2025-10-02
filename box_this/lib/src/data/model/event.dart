/// Represents an event with a name, time, date, and description.
class Event {
  String? id;
  String? parentId;
  String name;
  String time;
  String date;
  String description;

  Event({id = "", parentId = "" ,required this.name, required this.time, required this.date, required this.description});

  /// Factory constructor to create an Event instance from a JSON map.
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'] as String,
      time: json['time'] as String,
      date: json['date'] as String,
      description: json['description'] as String,
      id: json['id'] ?? "",
      parentId: json['parentId'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentId': parentId,
      'name': name,
      'time': time,
      'date': date,
      'description': description,
    };
  }

  // TODO bessere umsetzung der Informationen
  @override
  String toString() {
    return 'Event: $name\n'
        'Date: ${this.date}\n'
        'Time: ${this.time}\n'
        'Description: $description';
  }
}

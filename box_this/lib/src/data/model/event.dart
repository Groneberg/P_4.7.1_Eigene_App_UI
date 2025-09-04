/// Represents an event with a name, time, date, and description.
class Event {
  String name;
  String time;
  String date;
  String description;

  Event(this.name, this.time, this.date, this.description);

  /// Factory constructor to create an Event instance from a JSON map.
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      json['name'] as String,
      json['time'] as String,
      json['date'] as String,
      json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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

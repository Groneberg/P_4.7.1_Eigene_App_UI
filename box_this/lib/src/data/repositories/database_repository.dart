import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/model/event.dart';
import 'package:box_this/src/data/model/item.dart';

/// Interface for a database repository.
abstract class DatabaseRepository {
  Future<Map<String, Box>> readAllBoxes();
  Future<Box> readMainBoxStructure();
  Future<Map<String, Event>> readAllEvent();
  Future<Box?> readBox(String name);
  Future<Event?> readEvent(String name);
  Future<Item?> readItem(String name);
  Future<void> createBox(Box box);
  Future<void> createEvent(Event event);
  Future<void> createItem(Item item);
  Future<void> updateBox(Box box);
  Future<void> updateEvent(Event event);
  Future<void> updateItem(Item item);
  Future<void> deleteBox(String name);
  Future<void> deleteEvent(String name);
  Future<void> deleteItem(String name);
}
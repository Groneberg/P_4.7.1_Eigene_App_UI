import 'package:box_this/src/data/model/item.dart';
import 'package:box_this/src/data/model/event.dart';
import 'package:flutter/material.dart';

class ItemCreationProvider extends ChangeNotifier {
  Item _tempItem = Item(name: '', description: '', amount: 0, minAmount: 0, location: '');
  
  Item get item => _tempItem;

  void updateItemDetails({
    required String name,
    required String description,
    required String location,
    required int amount,
    required int minAmount,
  }) {
    _tempItem.name = name;
    _tempItem.description = description;
    _tempItem.location = location;
    _tempItem.amount = amount;
    _tempItem.minAmount = minAmount;
    
    notifyListeners(); 
  }

  void addEvent(Event event) {
    _tempItem.events[event.name] = event;
    notifyListeners();
  }

  void clear() {
    _tempItem = Item(name: '', description: '', amount: 0, minAmount: 0, location: '');
    notifyListeners();
  }
}
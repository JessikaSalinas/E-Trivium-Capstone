import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<ContactStruct> _contacts = [];
  List<ContactStruct> get contacts => _contacts;
  set contacts(List<ContactStruct> _value) {
    _contacts = _value;
  }

  void addToContacts(ContactStruct _value) {
    _contacts.add(_value);
  }

  void removeFromContacts(ContactStruct _value) {
    _contacts.remove(_value);
  }

  void removeAtIndexFromContacts(int _index) {
    _contacts.removeAt(_index);
  }

  void updateContactsAtIndex(
    int _index,
    ContactStruct Function(ContactStruct) updateFn,
  ) {
    _contacts[_index] = updateFn(_contacts[_index]);
  }

  void insertAtIndexInContacts(int _index, ContactStruct _value) {
    _contacts.insert(_index, _value);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

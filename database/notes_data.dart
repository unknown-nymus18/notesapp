import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotesData {
  // Initialize hive
  List notesList = [];
  final _myBox = Hive.box('myBox');

  void createInitialData() {
    notesList = [
      ['Notes', 'Write notes']
    ];
  }

  void loadData() {
    notesList = _myBox.get('NOTESLIST');
    _myBox.listenable();
  }

  void updateDatabase() {
    _myBox.put('NOTESLIST', notesList);
  }

  void addData(String title, String content) {
    _myBox.add([title, content]);
  }

  ValueListenable listenable() {
    return _myBox.listenable();
  }

  void deletenote(index) {
    notesList.removeAt(index);
    updateDatabase();
  }
}

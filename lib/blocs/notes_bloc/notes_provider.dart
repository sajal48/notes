import 'package:flutter/material.dart';
import 'package:notes/Repository/noterepo.dart';
import 'package:notes/models/notesmodel.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class NotesProvider with ChangeNotifier {
  final noterepo = NoteRepo();
  String _title;
  String _content;
  String _entryID;
  String _date;
  var uuid = Uuid();

  String get title => _title;
  String get content => _content;
  String get date => _date;
  Stream<List<NoteModel>> get notes => noterepo.getNotes();

  set changeTitle(String title) {
    _title = title;
    notifyListeners();
  }

  set changeContent(String content) {
    _content = content;
    notifyListeners();
  }

  loadAll(NoteModel noteModel) {
    if (noteModel != null) {
      _title = noteModel.title;
      _content = noteModel.content;
      _entryID = noteModel.entryID;
      _date = noteModel.date;
    } else {
      _title = null;
      _content = null;
      _entryID = null;
      _date = null;
    }
  }

  saveNote() {
    if (_entryID == null) {
      var newNote = NoteModel(
          title: _title,
          content: _content,
          entryID: uuid.v1(),
          date: dateformat());
      noterepo.setNote(newNote);
    } else {
      var updateNote = NoteModel(
          title: _title,
          content: _content,
          entryID: _entryID,
          date: dateformat());
      noterepo.setNote(updateNote);
    }
  }

  String dateformat() {
    var now = DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    return (formattedTime + " " + formattedDate);
  }

  removeNote(String entryID) {
    noterepo.removeNote(entryID);
  }
}

import 'package:flutter/material.dart';
import 'package:notes/Repository/noterepo.dart';
import 'package:notes/models/notesmodel.dart';
import 'package:uuid/uuid.dart';

class NotesProvider with ChangeNotifier {
  final noterepo = NoteRepo();
  String _title;
  String _content;
  String _entryID;
  var uuid = Uuid();

  String get title => _title;
  String get content => _content;
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
    } else {
      _title = null;
      _content = null;
      _entryID = null;
    }
  }

  saveNote() {
    if (_entryID == null) {
      var newNote =
          NoteModel(title: _title, content: _content, entryID: uuid.v1());
      noterepo.setNote(newNote);
    } else {
      var updateNote =
          NoteModel(title: _title, content: _content, entryID: _entryID);
      noterepo.setNote(updateNote);
    }
  }

  removeNote(String entryID) {
    noterepo.removeNote(entryID);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:notes/models/notesmodel.dart';

class NoteRepo {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<NoteModel>> getNotes() {
    return _db
        .collection('notes-${FirebaseAuth.instance.currentUser.uid}')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NoteModel.fromJson(doc.data()))
            .toList());
  }

  Future<void> setNote(NoteModel noteModel) {
    var option = SetOptions(merge: true);
    return _db
        .collection('notes-${FirebaseAuth.instance.currentUser.uid}')
        .doc(noteModel.entryID)
        .set(noteModel.toMap(), option);
  }

  Future<void> removeNote(String entryID) {
    return _db
        .collection('notes-${FirebaseAuth.instance.currentUser.uid}')
        .doc(entryID)
        .delete();
  }
}

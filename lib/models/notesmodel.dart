import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteModel {
  String title;
  String content;
  String entryID;

  NoteModel({this.title, this.content, @required this.entryID});
  Map<String, dynamic> toMap() {
    return {'title': title, 'content': content, 'entryID': entryID};
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
        title: json['title'],
        content: json['content'],
        entryID: json['entryID']);
  }

  NoteModel toNote(DocumentSnapshot doc) => doc.exists
      ? NoteModel(
          title: doc.get('title'),
          content: doc.get('content'),
          entryID: doc.get('entryID'),
        )
      : null;
}

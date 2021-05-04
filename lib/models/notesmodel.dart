import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteModel {
  String title;
  String content;
  String entryID;
  String date;

  NoteModel({this.title, this.content, @required this.entryID, this.date});
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'entryID': entryID,
      'date': date
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
        title: json['title'],
        content: json['content'],
        entryID: json['entryID'],
        date: json['date']);
  }

  NoteModel toNote(DocumentSnapshot doc) => doc.exists
      ? NoteModel(
          title: doc.get('title'),
          content: doc.get('content'),
          entryID: doc.get('entryID'),
          date: doc.get('date'),
        )
      : null;
}

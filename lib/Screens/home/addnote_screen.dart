import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        actions: [
          TextButton(
            onPressed: () {
              ref.add({
                'title': title.text,
                'content': content.text
              }).whenComplete(() => Navigator.pop(context));
            },
            child: Text('save'),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: title,
                decoration: InputDecoration(hintText: 'Title'),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: content,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(hintText: 'Content'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Editnote extends StatefulWidget {
  DocumentSnapshot docs;
  Editnote({this.docs});
  @override
  _EditnoteState createState() => _EditnoteState();
}

class _EditnoteState extends State<Editnote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  //CollectionReference ref = FirebaseFirestore.instance.collection('notes');
  //

  @override
  void initState() {
    title = TextEditingController(text: widget.docs.get('title'));
    content = TextEditingController(text: widget.docs.get('content'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        actions: [
          TextButton(
            onPressed: () {
              widget.docs.reference.update({
                'title': title.text,
                'content': content.text
              }).whenComplete(() => Navigator.pop(context));
              // ref.add({
            },
            child: Text('save'),
          ),
          TextButton(
            onPressed: () {
              widget.docs.reference
                  .delete()
                  .whenComplete(() => Navigator.pop(context));
              // ref.add({
            },
            child: Text('delete'),
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

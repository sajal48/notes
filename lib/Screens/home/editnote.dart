import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/blocs/notes_bloc/notes_provider.dart';
import 'package:notes/models/notesmodel.dart';
import 'package:provider/provider.dart';

class Editnote extends StatefulWidget {
  final NoteModel note;
  Editnote({this.note});
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
    final noteProvider = Provider.of<NotesProvider>(context, listen: false);
    if (widget.note != null) {
      title = TextEditingController(text: widget.note.title);
      content = TextEditingController(text: widget.note.content);
      noteProvider.loadAll(widget.note);
    } else {
      noteProvider.loadAll(null);
    }
    super.initState();
  }

  @override
  void dispose() {
    title.dispose();
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteprovider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        actions: [
          TextButton(
            onPressed: () {
              noteprovider.saveNote();
              Navigator.of(context).pop();
              // ref.add({
            },
            child: Text('save'),
          ),
          TextButton(
            onPressed: () {
              noteprovider.removeNote(widget.note.entryID);
              Navigator.of(context).pop();
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
                onChanged: (value) => noteprovider.changeTitle = value,
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
                  onChanged: (value) => noteprovider.changeContent = value,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

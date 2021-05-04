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
  TextEditingController date = TextEditingController();
  //CollectionReference ref = FirebaseFirestore.instance.collection('notes');
  //

  @override
  void initState() {
    final noteProvider = Provider.of<NotesProvider>(context, listen: false);
    if (widget.note != null) {
      title = TextEditingController(text: widget.note.title);
      content = TextEditingController(text: widget.note.content);
      date = TextEditingController(text: widget.note.date);
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.save_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              noteprovider.saveNote();
              Navigator.of(context).pop();
              // ref.add({
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              noteprovider.removeNote(widget.note.entryID);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                onChanged: (value) => noteprovider.changeTitle = value,
              ),
            ),
            Expanded(
              child: Container(
                child: TextField(
                  controller: content,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    hintText: 'Content',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onChanged: (value) => noteprovider.changeContent = value,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Center(child: Text(date.text)),
            )
          ],
        ),
      ),
    );
  }
}

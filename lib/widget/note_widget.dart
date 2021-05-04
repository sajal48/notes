import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes/models/notesmodel.dart';

class NoteCard extends StatelessWidget {
  NoteCard({this.b});
  NoteModel b;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(color: Colors.white30),
      child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Center(
                  child: Text(
                b.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Text(
                b.content,
                maxLines: 6,
              ))
            ],
          )),
    );
  }
}

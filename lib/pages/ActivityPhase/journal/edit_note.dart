import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditNote extends StatefulWidget {
  EditNote({super.key, required this.docToEdit, required this.docToDate});

  DocumentSnapshot docToEdit;
  String? docToDate;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();

  TextEditingController content = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection("journal");
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  void initState() {
    String? Date = widget.docToDate.toString();
    print("Date" + Date);
    title = TextEditingController(text: widget.docToEdit[Date]['title']);
    print(widget.docToEdit);
    print("my title" + title.toString());
    content = TextEditingController(text: widget.docToEdit[Date]['content']);
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
            onPressed: () {
              widget.docToEdit.reference.update({
                currentDate: {
                  "title": title.text,
                  "currentDate": currentDate,
                  "content": content.text,
                },

                // Map<String, dynamic> feelingData = {
                //   currentDate: {
                //     "title": title.text,
                //     "currentDate": currentDate,
                //     "content": content.text,
                //   },
                // };
              }).whenComplete(() => Navigator.pop(context));
            },
            icon: Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              // Delete the 'currentDate' field from the document
              widget.docToEdit.reference.update({
                widget.docToDate!: FieldValue.delete(),
              }).whenComplete(() => Navigator.pop(context));
            },
            icon: Icon(Icons.delete),
          ),
        ]),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(hintText: 'Title'),
                ),
              ),
              SizedBox(height: 10),
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
        ));
  }
}

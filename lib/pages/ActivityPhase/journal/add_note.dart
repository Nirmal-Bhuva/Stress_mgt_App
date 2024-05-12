import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AddNote extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection("journal");

  @override
  Widget build(BuildContext context) {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
            onPressed: () {
              // Add your button press logic here
              if (userEmail != null) {
                Map<String, dynamic> feelingData = {
                  currentDate: {
                    "title": title.text,
                    "currentDate": currentDate,
                    "content": content.text,
                  },
                };
                // Update the document with the new feeling and timestamp
                DocumentReference<Object?> docRef =
                    ref.doc(userEmail); // Get the DocumentReference

                docRef.set(feelingData, SetOptions(merge: true)).then((_) {
                  Navigator.pop(context);
                }).catchError((error) {
                  print("Failed to add note: $error");
                });
              } else {
                print('User email is null');
              }
              print('Icon Button pressed');
            },
            icon: Icon(Icons.save),
          )
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:relaxio/pages/ActivityPhase/journal/add_note.dart';
import 'package:relaxio/pages/ActivityPhase/journal/edit_note.dart';

class JournalHome extends StatefulWidget {
  const JournalHome({super.key});

  @override
  State<JournalHome> createState() => _JournalHomeState();
}

class _JournalHomeState extends State<JournalHome> {
  final ref = FirebaseFirestore.instance.collection("journal");
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  var userEmail = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddNote()));
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('journal')
            .doc(userEmail.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error.toString()}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('No data found.'),
            );
          }

          print("Snapshot:" + snapshot.data!.runtimeType.toString());

          // print("Snapshot:" + snapshot.data!.get('23-03-2024').toString());

          //print("data" + data.toString());

          // Assuming your document structure has a 'items' field which is a list
          List<Map<String, dynamic>> itemsList = [];
          snapshot.data!.data()?.forEach((key, value) {
            itemsList.add(value);
          });
          print("helloo");
          print("items:" + itemsList.toString());
          print("snapshotdata" + snapshot.data.toString());

          return ListView.builder(
            itemCount: itemsList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditNote(
                                docToEdit: snapshot.data!,
                                docToDate: itemsList[index]['currentDate'],
                              )));
                  // print("snapshot.data!.docs[index]" +
                  //     snapshot.data!.toString());
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 150,
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      Text(itemsList[index]['currentDate']),
                      Text(itemsList[index]['title']),
                      Text(itemsList[index]['content'])
                    ],
                  ),
                  // child: ListTile(
                  //   title: Text(itemsList[index]['title'].toString()),
                  // ),
                ),
              );
            },
          );
        },
      ),
      // body: StreamBuilder<DocumentSnapshot>(
      //     stream: ref.doc(userEmail.toString()).snapshots(),
      //     builder: (context, snapshot) {
      //       if (!snapshot.hasData) {
      //         return CircularProgressIndicator();
      //       }

      //       if (!snapshot.data!.exists) {
      //         return Text("Field doesn't exist");
      //       }

      //       var fieldValue = snapshot.data!['21-03-2024'];

      //       print("my field value" + fieldValue);
      //       return GridView.builder(
      //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 2),
      //           itemCount: fieldValue.length,
      //           itemBuilder: (_, index) {
      //             //print("userEmail" + userEmail.toString());
      //             // print("Ref hello");
      //             // print("snapshot.data = " + snapshot.data.toString());
      //             // print(ref.where('email',
      //             //     isEqualTo: FirebaseAuth.instance.currentUser!.email));
      //             // var documentData = snapshot.data!.data();
      //             // print(documentData);
      //             // print("fieldvalue mine");
      //             //print("snapshot.data" + snapshot.data.toString());
      //             // var fieldValue = snapshot.data![userEmail.toString()];
      //             // print("my field value" + fieldValue);
      //             print("ref docu = " +
      //                 ref.doc(userEmail).snapshots().toString());

      //             // final currentDateMap =
      //             //     documentData!['currentDate']['title'];
      //             // print("currentnirmal" + currentDateMap);

      //             //print("documentData = " + documentData.toString());
      //             // var documentData1 = snapshot.data![index];
      //             // print("documentData1 = " + documentData1.toString());
      //             // print(
      //             //     "documenttitle" + documentData[currentDate]['title'] ??
      //             //         'no titel');
      //             // print("documentData[currentDate]['title']" +
      //             //     documentData[currentDate]['title'][index]);

      //             return GestureDetector(
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (_) => EditNote(
      //                               docToEdit: snapshot.data!,
      //                             )));
      //                 // print("snapshot.data!.docs[index]" +
      //                 //     snapshot.data!.toString());
      //               },
      //               child: Container(
      //                   margin: EdgeInsets.all(10),
      //                   height: 150,
      //                   color: Colors.grey[200],
      //                   child: Column(
      //                     children: [
      //                       // Text(documentData[currentDate]['title']),
      //                       // Text(documentData[currentDate]['content'])
      //                     ],
      //                   )),
      //             );
      //           });
      //     })
    );
  }
}

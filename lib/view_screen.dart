import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ViewVotes extends StatefulWidget {
  const ViewVotes({Key? key}) : super(key: key);

  @override
  _ViewVotesState createState() => _ViewVotesState();
}

class _ViewVotesState extends State<ViewVotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All votes'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('votes').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("Loading...");
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return OneListView(
                      (snapshot.data! as QuerySnapshot).docs[index]);
                },
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
              );
            }
          },
        ));
  }

  ListTile OneListView(DocumentSnapshot snapshot) {
    return ListTile(
      onTap: () => {},
      title: Text("Votes - " + snapshot['votes'].toString()),
      leading: Text(snapshot['name']),
    );
  }
}

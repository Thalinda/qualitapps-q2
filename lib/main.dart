import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:q2/view_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      routes: {'/lst': (context) => ViewVotes()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: Text("Vote"),
                onTap: () => {Navigator.pushNamed(context, '/')},
              ),
              ListTile(
                title: Text("View Vote"),
                onTap: () => {Navigator.pushNamed(context, '/lst')},
              )
            ],
          ),
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
      title: Row(
        children: [
          ElevatedButton(
              onPressed: () => {
                    snapshot.reference.update({'votes': snapshot['votes'] + 1})
                  },
              child: Text('vote')),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
              onPressed: () => {
                    if (snapshot['votes'] > 0)
                      {
                        snapshot.reference
                            .update({'votes': snapshot['votes'] - 1})
                      }
                  },
              child: Text('Devote'))
        ],
      ),
      leading: Text(snapshot['name']),
    );
  }
}

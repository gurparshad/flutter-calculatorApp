import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudHistory extends StatefulWidget {
  @override
  _CloudHistory createState() => _CloudHistory();
}

class _CloudHistory extends State<CloudHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("History from cloud"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: StreamBuilder(
            stream:
                Firestore.instance.collection("calculatedHistory").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Text("loading data.. Please wait..");
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return new ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 0,
                          color: Color(0x11ffffff),
                          child: new ListTile(
                            title: new Text(
                              document['equation'],
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
              }
            }));
  }
}

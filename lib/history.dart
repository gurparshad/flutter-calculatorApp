import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List historyList = [];

  @override
  void initState() {
    getHistory();
  }

  getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> loadedList = prefs.getStringList("history");

    print(loadedList);
    setState(() {
      historyList = loadedList.map((item) => json.decode(item)).toList();
      print("inside history");
      print(historyList);
    });
  }

  Widget myItems() {
    return Column(
      children: historyList.map((item) => Text(item.toString())).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('My Calculator')),
        body: Column(
          children: <Widget>[
            Text("History",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueAccent)),
            myItems()
          ],
        ));
  }
}

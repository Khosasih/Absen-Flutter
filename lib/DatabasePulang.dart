import 'dart:convert';

import 'package:abdig_project/DetailPulang.dart';
import 'package:abdig_project/constans.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Detail.dart';

class DatabasePulangPage extends StatefulWidget {
  DatabasePulangPage({this.username});
  final String username;
  @override
  _DatabasePulangPageState createState() => _DatabasePulangPageState();
}

class _DatabasePulangPageState extends State<DatabasePulangPage> {
  Future<List> getData() async {
    final response = await http
        .get("https://abdig.000webhostapp.com/getpulang.php", headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.orangeAccent,
            automaticallyImplyLeading: false,
            title: new Text("Database Pulang"),
            leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left),
              onPressed: () => (Navigator.popUntil(
                  context, ModalRoute.withName('/AdminPage'))),
            ),
          ),
          body: new FutureBuilder<List>(
            future: getData(),
            builder: (context, snapshoot) {
              if (snapshoot.hasError) print(snapshoot.error);

              return snapshoot.hasData
                  ? new ItemList(
                      list: snapshoot.data,
                    )
                  : new Center(
                      child: new CircularProgressIndicator(),
                    );
            },
          ),
        ));
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new DetailPulang(
                      list: list,
                      index: i,
                    ))),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['nama']),
                leading: new Icon(Icons.account_circle),
                subtitle: new Text("Jabatan : ${list[i]['Jabatan']}"),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
        );
      },
    );
  }
}

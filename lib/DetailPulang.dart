import 'dart:io';

import 'package:abdig_project/AdminPage.dart';
import 'package:abdig_project/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meet_network_image/meet_network_image.dart';

// ignore: must_be_immutable
class DetailPulang extends StatefulWidget {
  List list;
  int index;
  DetailPulang({this.index, this.list});
  @override
  _DetailPulangState createState() => _DetailPulangState();
}

class _DetailPulangState extends State<DetailPulang> {
  File _image;

  void deleteData() {
    var url = "https://abdig.000webhostapp.com/deletepulang.php";
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are you sure want to delete '${widget.list[widget.index]['nama']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "OK DELETE!",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
            deleteData();
            Navigator.popUntil(
              context,
              ModalRoute.withName('/AdminPage'),
            );
          },
        ),
        new RaisedButton(
            child: new Text(
              "CANCLE",
              style: new TextStyle(color: Colors.black),
            ),
            color: Colors.green,
            onPressed: () => Navigator.pop(context)),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.list[widget.index]['nama']}"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: new Container(
        height: 500.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Text(
                  "Waktu : ${widget.list[widget.index]['Waktu']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  widget.list[widget.index]['nama'],
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Text(
                  "Jabatan : ${widget.list[widget.index]['Jabatan']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Status : ${widget.list[widget.index]['Status']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Kehadiran : ${widget.list[widget.index]['Kehadiran']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Padding(padding: const EdgeInsets.all(3.0)),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton.icon(
                        icon: Icon(Icons.delete_outlined),
                        label: new Text("DELETE"),
                        color: Colors.red,
                        onPressed: () => confirm()),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:abdig_project/AdminPage.dart';
import 'package:abdig_project/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meet_network_image/meet_network_image.dart';

// ignore: must_be_immutable
class DetailIzin extends StatefulWidget {
  List list;
  int index;
  DetailIzin({this.index, this.list});
  @override
  _DetailIzinState createState() => _DetailIzinState();
}

class _DetailIzinState extends State<DetailIzin> {
  File _image;

  void deleteData() {
    var url = "https://abdig.000webhostapp.com/deleteizin.php";
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
            Navigator.popUntil(context, ModalRoute.withName('/AdminPage'));
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
                  "Keterangan : ${widget.list[widget.index]['Keterangan']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new Image.network(
                      "http://192.168.0.19/my_store/uploads/${widget.list[widget.index]['image']}",
                      scale: 1.0,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ],
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

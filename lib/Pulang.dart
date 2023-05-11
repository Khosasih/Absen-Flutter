import 'dart:io';
import 'package:abdig_project/constans.dart';
import 'package:abdig_project/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'package:geolocator/geolocator.dart';

class PulangPage extends StatefulWidget {
  PulangPage({this.username});
  final String username;
  @override
  _PulangPageState createState() => _PulangPageState();
}

class _PulangPageState extends State<PulangPage> {
  TextEditingController controllernama = new TextEditingController();
  TextEditingController controllerJabatan = new TextEditingController();
  TextEditingController controllerStatus = new TextEditingController();
  TextEditingController controllerKehadiran = new TextEditingController();

  var locationMessage = "";

  Future<String> getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    var lat = position.latitude;
    var long = position.longitude;
    print("$lat , $long");

    setState(() {
      locationMessage = "$lat + $long";
    });
  }

  Widget _buildLocation() {
    getCurrentLocation();
    return TextField(
        controller: controllerKehadiran,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "$locationMessage",
          prefixIcon: Icon(Icons.gps_fixed),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ));
  }

  void addData() {
    var url = "https://abdig.000webhostapp.com/addpulang.php";
    http.post(url, body: {
      "nama": "$username",
      "Jabatan": controllerJabatan.text,
      "Status": controllerStatus.text,
      "Kehadiran": "$locationMessage",
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Pulang"),
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            new Column(
              children: <Widget>[
                new TextField(
                  readOnly: true,
                  controller: controllernama,
                  decoration: new InputDecoration(
                      hintText: "$username",
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: mainColor,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                new TextField(
                  controller: controllerJabatan,
                  decoration: new InputDecoration(
                    hintText: "Jabatan",
                    prefixIcon: Icon(Icons.work),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                new TextField(
                  controller: controllerStatus,
                  decoration: new InputDecoration(
                      hintText: "Status",
                      labelText: "Status Kerja",
                      prefixIcon: Icon(Icons.info_outline),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                _buildLocation(),
                new Padding(padding: const EdgeInsets.all(5.0)),
                new Padding(padding: const EdgeInsets.all(10.0)),
                new RaisedButton(
                  child: new Text("Save"),
                  color: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    addData();
                    Navigator.popUntil(
                        context, ModalRoute.withName('/MemberPage'));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

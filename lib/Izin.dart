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

class IzinPage extends StatefulWidget {
  IzinPage({
    this.username,
  });
  final String username;
  @override
  _IzinPageState createState() => _IzinPageState();
}

class _IzinPageState extends State<IzinPage> {
  TextEditingController controllernama = new TextEditingController();
  TextEditingController controllerJabatan = new TextEditingController();
  TextEditingController controllerKeterangan = new TextEditingController();
  File _image;

  Future getImageGallery() async {
    var imagefile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    String nama = '$username';
    Img.Image image = Img.decodeImage(imagefile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 500);
    var compressImg = new File("$path/image_$username.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 90));

    setState(() {
      _image = compressImg;
    });
  }

  Future getImageCamera() async {
    var imagefile = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    String nama = '$username';
    Img.Image image = Img.decodeImage(imagefile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 500);
    var compressImg = new File("$path/image_$username.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 90));

    setState(() {
      _image = compressImg;
    });
  }

  Future upload(File imageFile) async {
    var stream = new http.ByteStream(_image.openRead());
    stream.cast();
    var length = await imageFile.length();
    var uri = Uri.parse("https://abdig.000webhostapp.com/addizin.php");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(imageFile.path));
    request.fields['nama'] = '$username';
    request.fields['Jabatan'] = controllerJabatan.text;
    request.fields['Keterangan'] = controllerKeterangan.text;
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Image Uploaded");
    } else {
      print("Upload Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Izin"),
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
                  controller: controllerKeterangan,
                  decoration: new InputDecoration(
                      hintText: "Keterangan",
                      labelText: "Keterangan Izin",
                      prefixIcon: Icon(Icons.info_outline),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                Padding(padding: EdgeInsets.only(top: 5.0)),
                new Padding(padding: const EdgeInsets.all(5.0)),
                Center(
                  child: _image == null
                      ? new Text("No image selected!")
                      : new Image.file(_image),
                ),
                Row(
                  children: [
                    RaisedButton(
                        child: Icon(Icons.image), onPressed: getImageGallery),
                    RaisedButton(
                      child: Icon(Icons.camera_alt),
                      onPressed: getImageCamera,
                    ),
                  ],
                ),
                new Padding(padding: const EdgeInsets.all(10.0)),
                new RaisedButton(
                  child: new Text("Save"),
                  color: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    upload(_image);
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

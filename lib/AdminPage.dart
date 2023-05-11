
import 'package:abdig_project/DatabaseHadir.dart';
import 'package:abdig_project/DatabaseIzin.dart';
import 'package:abdig_project/DatabasePulang.dart';
import 'package:abdig_project/constans.dart';
import 'package:abdig_project/main.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  AdminPage({this.username});
  final String username;
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome Admin"),
        backgroundColor: Colors.orangeAccent,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () =>
                  {Navigator.pushReplacementNamed(context, '/MyApp')}),
        ],
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                'Hallo $username !',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.25,
                minChildSize: 0.12,
                maxChildSize: 0.8,
                builder: (BuildContext c, s) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: ListView(
                      controller: s,
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 8,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Database',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Data Hadir'),
                            leading: Icon(
                              Icons.folder,
                              color: Colors.deepOrange,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DatabaseHadirPage())),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Data Pulang'),
                            leading: Icon(
                              Icons.folder,
                              color: Colors.deepOrange,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DatabasePulangPage())),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Data Izin'),
                            leading: Icon(
                              Icons.folder,
                              color: Colors.deepOrange,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DatabaseIzinPage())),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


import 'package:abdig_project/Hadir.dart';
import 'package:abdig_project/Izin.dart';
import 'package:abdig_project/Pulang.dart';
import 'package:abdig_project/constans.dart';
import 'package:abdig_project/main.dart';
import 'package:flutter/material.dart';

class MemberPage extends StatefulWidget {
  MemberPage({this.username});
  final String username;
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome $username"),
        backgroundColor: mainColor,
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
                          'Jangan Lupa Absen',
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
                            title: Text('Hadir'),
                            leading: Icon(
                              Icons.assignment_outlined,
                              color: mainColor,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HadirPage())),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Pulang'),
                            leading: Icon(
                              Icons.timeline,
                              color: mainColor,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PulangPage())),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text('Izin'),
                            leading: Icon(
                              Icons.contact_support_outlined,
                              color: mainColor,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        IzinPage())),
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

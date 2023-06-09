import 'dart:async';
import 'dart:convert';

import 'package:abdig_project/AdminPage.dart';
import 'package:abdig_project/MemberPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constans.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

String username = '';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: <String, WidgetBuilder>{
        '/AdminPage': (BuildContext context) => new AdminPage(
              username: username,
            ),
        '/MemberPage': (BuildContext context) => new MemberPage(
              username: username,
            ),
        '/MyApp': (BuildContext context) => new MyApp()
      },
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  Future<List> login() async {
    var url = Uri.parse("https://abdig.000webhostapp.com/login.php");
    var response = await http.post(url, body: {
      "username": user.text,
      "password": pass.text,
    });
    print(response.body);

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } else {
      if (datauser[0]['level'] == 'Admin') {
        Navigator.pushReplacementNamed(context, '/AdminPage');
      } else if (datauser[0]['level'] == 'Member') {
        Navigator.pushReplacementNamed(context, '/MemberPage');
      }
      setState(() {
        username = datauser[0]['username'];
      });
    }
    return datauser;
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "ABDIG",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        controller: user,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: mainColor,
            ),
            hintText: 'Username'),
      ),
    );
  }

  Widget _buildPassRow() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        controller: pass,
        obscureText: true,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: mainColor),
            hintText: 'Password'),
      ),
    );
  }

  Widget _buildForgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text("Forgot Password ?"),
        )
      ],
    );
  }

  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            elevation: 5.0,
            color: mainColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () {
              login();
            },
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: MediaQuery.of(context).size.height / 40),
            ),
          ),
        ),
        Text(
          msg,
          style: TextStyle(fontSize: 20.0, color: Colors.red),
        ),
      ],
    );
  }

  Widget _buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
        ),
        Text(
          "-OR-",
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }

  Widget _buildSocialButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0)
              ],
            ),
            child: Icon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Hi!",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 30),
                    )
                  ],
                ),
                _buildEmailRow(),
                _buildPassRow(),
                _buildForgetPasswordButton(),
                _buildButton(),
                _buildOrRow(),
                _buildSocialButton(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSignUpbtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: FlatButton(
            onPressed: () {},
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'Do not have an account?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.height / 40,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                  text: ' Sign Up',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: MediaQuery.of(context).size.height / 40,
                    fontWeight: FontWeight.bold,
                  ))
            ])),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.orangeAccent,
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(70),
                        bottomRight: const Radius.circular(70))),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                _buildContainer(),
                _buildSignUpbtn(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

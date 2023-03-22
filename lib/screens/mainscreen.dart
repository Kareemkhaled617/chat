import 'package:flutter/material.dart';
import 'package:mafqud_project/screens/signup.dart';

import 'login.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          SizedBox(
            height: 200,
          ),
          Center(
            child: ElevatedButton(

                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 18.0),
                )),
          ),
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Text("Don't have an account?"),
          ),
          Center(
            child: ElevatedButton(

                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text(
                  'SIGN UP',
                  style: TextStyle(fontSize: 18.0),
                )),
          ),
        ]),
      ),
    );
  }
}

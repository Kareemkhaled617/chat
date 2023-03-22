import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mafqud_project/screens/chat/screens/home_screen.dart';

import 'homepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
   String? _email;
   String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Login Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                hintText: 'Your Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22.0)),
              ),
              onChanged: (value) => setState(() {
                _email = value;
              }),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22.0))),
              onChanged: (value) => setState(() {
                _password = value;
              }),
            ),
            SizedBox(
              height: 150,
            ),
           ElevatedButton(

                onPressed: () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _email!, password: _password!)
                      .then((user) => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeScreen())))
                      .catchError((e) {
                    print(e);
                  });
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 18.0),
                )),
          ],
        ),
      ),
    );
  }
}

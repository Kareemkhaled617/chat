import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/users.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? _name;
  String? _email;
  String? _password;
  String? _phone;
  String? _idNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Sign Up Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: <Widget>[

            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.numbers),
                hintText: 'Enter your id Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22.0)),
              ),
              onChanged: (value) => setState(() {
                _idNumber = value;
              }),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.verified_user),
                hintText: 'Enter your name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22.0)),
              ),
              onChanged: (value) => setState(() {
                _name = value;
              }),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone),
                hintText: 'Enter your phone',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22.0)),
              ),
              onChanged: (value) => setState(() {
                _phone = value;
              }),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: 'Enter your email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22.0)),
              ),
              onChanged: (value) => setState(() {
                _email = value;
              }),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  hintText: 'Enter password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22.0))),
              onChanged: (value) => setState(() {
                _password = value;
              }),
            ),
            const SizedBox(
              height: 150,
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _email!, password: _password!)
                      .then((signedInUser) {
                    UserManagement().addDataEmail(
                        email: _email!, name: _name!, context: context, phone: _phone!, idNumber: _idNumber!);
                    // UserManagement().storeNewUser(signedInUser.user, context);
                  }).catchError((e) {
                    print(e);
                  });
                },
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(fontSize: 18.0),
                )),
          ],
        ),
      ),
    );
  }
}

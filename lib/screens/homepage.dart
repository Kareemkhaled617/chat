import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import 'chat/api/apis.dart';
import 'chat/screens/profile_screen.dart';
import 'mainscreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool light = true;
  String? name;
  String? myEmail;
  String? myPassword;
  String? myPhoneNum;
  String? myImage;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            size: 40,
            Icons.menu,
            color: Colors.black,
          ),
        ),
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(59, 92, 222, 1.0),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
            },
            icon: const Icon(
              size: 40,
              Icons.notifications_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Text("Loading data...Please wait");
              }
              return Container(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color.fromRGBO(59, 92, 222, 1.0),
                        radius: 80,
                        child: Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 120,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "$name",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      FloatingActionButton(
                        backgroundColor: const Color.fromRGBO(59, 92, 222, 1.0),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProfileScreen(user: APIs.me)));
                        },
                        child: const Icon(
                          Icons.mode_edit_outline,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.local_phone_outlined,
                                color: Colors.black,
                                size: 50,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "$myPhoneNum",
                                style: const TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.mail_outline_outlined,
                            color: Colors.black,
                            size: 50,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "$myEmail",
                            style: const TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.support_agent_outlined,
                            color: Colors.black,
                            size: 50,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Contact Support',
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: Row(
                          children: [
                            const Text(
                              "Notifications",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 80,
                              height: 70,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                  // This bool value toggles the switch.
                                  value: light,

                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      light = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    APIs.getSelfInfo();
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myEmail = ds.get('email') as String;
        myPhoneNum = ds.get('phone') as String;
        name = ds.get('name') as String;
        myPassword = ds.get('password') as String;
        myPhoneNum = ds.get('phone') as String;
        myImage = ds.get('image') as String;

      }).catchError((e) {
        print(e);
      });
    }
  }
}

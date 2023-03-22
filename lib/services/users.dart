import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/chat/screens/home_screen.dart';
import '../screens/homepage.dart';

class UserManagement {
  storeNewUser(user, context) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .set({'email': user.email, 'uid': user.uid})
        .then((value) =>
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home())))
        .catchError((e) {
      print(e);
    });
  }

  addDataEmail(
      {required String email, required String name, required String phone,required String idNumber,context}) async {
    final time = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference addUser =
    FirebaseFirestore.instance.collection('users');
    addUser.doc('${user?.uid}').set({
      'email': email,
      'name': name,
      'id': user?.uid,
      'image': 'null',
      'created_at': time,
      'is_online': false,
      'last_active': time,
      'push_token': '',
      'about': 'Hallo',
      'phone': phone,
      'id_number': idNumber,
    }).then((value) =>
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeScreen())));
  }
}

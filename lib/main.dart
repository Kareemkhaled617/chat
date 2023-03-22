import 'package:flutter/material.dart';
import 'package:mafqud_project/screens/chat/screens/home_screen.dart';
import 'package:mafqud_project/screens/confirmation.dart';
import 'package:mafqud_project/screens/homepage.dart';
import 'package:mafqud_project/screens/login.dart';
import 'package:mafqud_project/screens/mainscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mafqud_project/screens/signup.dart';
late Size mq;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUp(),
    );
  }
}

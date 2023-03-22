import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leadingWidth: 50,
        leading:
        IconButton(
          onPressed: () {},
          icon: Icon(
            size:40,
            Icons.menu,
            color: Colors.black,
          ),
        ),
        toolbarHeight: 80,
        centerTitle: true,
        title: Text('Profile',style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
        backgroundColor: Color.fromRGBO(59, 92, 222, 1.0),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
              icon: Icon(
                size:40,

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
              if (snapshot.connectionState != ConnectionState.done)
                return Text("Loading data...Please wait");
              return Container(
             padding: EdgeInsets.all(20),
                child: Center(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                    CircleAvatar(
                      backgroundColor:Color.fromRGBO(59, 92, 222, 1.0),
                      radius: 80,
                      child:  Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 120,
                    ),
                      ),),
                    SizedBox(height: 10,),

                      Text("$name"
                        ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      FloatingActionButton(
                        backgroundColor:Color.fromRGBO(59, 92, 222, 1.0),
                        onPressed: () {},
                        child: Icon(
                          Icons.mode_edit_outline,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_phone_outlined,
                                color: Colors.black,
                                size: 50,
                              ),

                              SizedBox(width: 20,),
                              Text("$myPhoneNum"
                                ,style: TextStyle(fontSize: 25),),
                            ],
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.mail_outline_outlined,
                          color: Colors.black,
                          size: 50,
                        ),
                        SizedBox(width: 20,),
                        Text("$myEmail"
                        ,style: TextStyle(fontSize: 25),),
                      ],
                    ),
                      SizedBox(height: 20,),

                      Row(      crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.support_agent_outlined,
                            color: Colors.black,
                            size: 50,
                          ),
                          SizedBox(width: 20,),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20,color: Colors.black),
                            ),
                            onPressed: () {},
                            child: const Text('Contact Support',
                              style: const TextStyle(fontSize: 25,  fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,

                                color: Colors.black,),
                            ),
                          )
                        ],
                      ),

                 Container(
                   padding: EdgeInsets.all(30),
                   child: Row(
                     children: [
                       Text("Notifications"
                         ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                       SizedBox(width: 20,),
                       SizedBox(
                         width: 80,
                         height: 70,
                         child: FittedBox(
                           fit: BoxFit.fill,
                     child:Switch(

                         // This bool value toggles the switch.
                         value: light,

                         onChanged: (bool value) {
                           // This is called when the user toggles the switch.
                           setState(() {
                             light = value;
                           });
                         },
                       ),
                         ),),],
                   ),
                 ), ],
                  ),
                ),
              );},
          ),
        ),
      ),
    );
  }

  _fetch() async {
     final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myEmail =ds.get('email') as String;
        myPhoneNum =ds.get('phoneNum') as String;
        name =ds.get('name') as String;
        myPassword =ds.get('password') as String;
        myPhoneNum =ds.get('phoneNum') as String;
        print(myEmail!);
        print(myPassword!);
        print(name!);
        print(myPhoneNum!);
      }).catchError((e) {
        print(e);
      });
    }
  }
}

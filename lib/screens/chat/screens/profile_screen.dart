// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mafqud_project/screens/confirmation.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../main.dart';
import '../api/apis.dart';
import '../helper/dialogs.dart';

import '../models/chat_user.dart';
import 'auth/login_screen.dart';

//profile screen -- to show signed in user info
class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;
  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //app bar
        appBar: AppBar(
          title: const Text('Edit Information',style: TextStyle(color: Colors.black),),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              size: 30,
              color: Colors.black,
            ),
          ),
          backgroundColor: const Color.fromRGBO(59, 92, 222, 1.0),
          actions: const [
            Icon(
              Icons.done,
              color: Colors.black,
              size: 35,
            )
          ],
        ),

        //floating button to log out
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(bottom: 10),
        //   child: FloatingActionButton.extended(
        //       backgroundColor: Colors.redAccent,
        //       onPressed: () async {
        //         //for showing progress dialog
        //         Dialogs.showProgressBar(context);
        //
        //         await APIs.updateActiveStatus(false);
        //
        //         //sign out from app
        //         await APIs.auth.signOut().then((value) async {
        //           await GoogleSignIn().signOut().then((value) {
        //             //for hiding progress dialog
        //             Navigator.pop(context);
        //
        //             //for moving to home screen
        //             Navigator.pop(context);
        //
        //             APIs.auth = FirebaseAuth.instance;
        //
        //             //replacing home screen with login screen
        //             Navigator.pushReplacement(context,
        //                 MaterialPageRoute(builder: (_) => const LoginScreen()));
        //           });
        //         });
        //       },
        //       icon: const Icon(Icons.logout),
        //       label: const Text('Logout')),
        // ),

        //body
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // for adding some space
                  SizedBox(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height * .03),

                  //user profile picture
                  Stack(
                    children: [
                      //profile picture
                      _image != null
                          ?

                          //local image
                          ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(MediaQuery.of(context).size.height * .1),
                              child: Image.file(File(_image!),
                                  width: MediaQuery.of(context).size.height * .2,
                                  height: MediaQuery.of(context).size.height * .2,
                                  fit: BoxFit.cover))
                          :

                          //image from server
                          ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(MediaQuery.of(context).size.height * .1),
                              child: CachedNetworkImage(
                                width: MediaQuery.of(context).size.height * .2,
                                height: MediaQuery.of(context).size.height * .2,
                                fit: BoxFit.cover,
                                imageUrl: widget.user.image,
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                      backgroundColor: Color.fromRGBO(59, 92, 222, 1.0),
                                        child: Icon(CupertinoIcons.person,color: Colors.black,size: 40,)),
                              ),
                            ),

                      //edit image button
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          elevation: 1,
                          onPressed: () {
                            _showBottomSheet();
                          },
                          shape: const CircleBorder(),
                          color: const Color.fromRGBO(59, 92, 222, 1.0),
                          child: const Icon(Icons.download_rounded, color: Colors.black,size: 30,),
                        ),
                      )
                    ],
                  ),

                  // for adding some space
                  SizedBox(height: MediaQuery.of(context).size.height * .03),

                  // user email label
                  Text(widget.user.email,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 16)),

                  // for adding some space
                  SizedBox(height: MediaQuery.of(context).size.height * .05),

                  // about input field
                  TextFormField(
                    initialValue: widget.user.email,
                    onSaved: (val) => APIs.me.email = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.email, color: Color.fromRGBO(59, 92, 222, 1.0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'example@mail.com',
                        label: const Text('Email')),
                  ),

                  // for adding some space
                  SizedBox(height: MediaQuery.of(context).size.height * .02),

                  // name input field
                  TextFormField(
                    initialValue: widget.user.name,
                    onSaved: (val) => APIs.me.name = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.person, color: Color.fromRGBO(59, 92, 222, 1.0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'name',
                        label: const Text('Name')),
                  ),

                  // for adding some space
                  SizedBox(height: MediaQuery.of(context).size.height * .02),

                  // about input field
                  TextFormField(
                    initialValue: widget.user.phone,
                    onSaved: (val) => APIs.me.phone = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.phone, color: Color.fromRGBO(59, 92, 222, 1.0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: '+00 000000000000',
                        label: const Text('phone')),
                  ),

                  // for adding some space
                  SizedBox(height: MediaQuery.of(context).size.height * .05),

                  // update profile button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(59, 92, 222, 1.0),
                        shape: const StadiumBorder(),
                        minimumSize: Size(MediaQuery.of(context).size.width * .5, MediaQuery.of(context).size.height * .06)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        APIs.updateUserInfo().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Confirmation()));
                        });
                      }
                    },
                    child: const Text('Save Changes',
                        style: TextStyle(fontSize: 16,color: Colors.black)),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          color: const Color.fromRGBO(59, 92, 222, 1.0),

          child: SalomonBottomBar(

            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: const Icon(Icons.home,size: 35,),
                title: const Text(""),
                selectedColor: Colors.black,
              ),



            ],
          ),
        ),
      ),
    );
  }

  // bottom sheet for picking a profile picture for user
  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .03, bottom: MediaQuery.of(context).size.height * .05),
            children: [
              //pick profile picture label
              const Text('Pick Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),

              //for adding some space
              SizedBox(height: MediaQuery.of(context).size.height * .02),

              //buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick from gallery button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(MediaQuery.of(context).size.width * .3, MediaQuery.of(context).size.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilePicture(File(_image!));
                          // for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/add_image.png')),

                  //take picture from camera button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(MediaQuery.of(context).size.width * .3, MediaQuery.of(context).size.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilePicture(File(_image!));
                          // for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/camera.png')),
                ],
              )
            ],
          );
        });
  }
}

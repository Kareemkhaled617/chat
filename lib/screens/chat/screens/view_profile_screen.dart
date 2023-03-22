import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../helper/my_date_util.dart';

import '../models/chat_user.dart';

//view profile screen -- to view profile of user
class ViewProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ViewProfileScreen({super.key, required this.user});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          //app bar
          appBar: AppBar(
            title: const Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: const Color.fromRGBO(59, 92, 222, 1.0),
            leading: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              const Icon(
                Icons.notifications_none_outlined,
                size: 35,
                color: Colors.black,
              )
            ],
          ),

          //body
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // for adding some space
                  SizedBox(width: mq.width, height: mq.height * .03),

                  //user profile picture
                  ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .1),
                    child: CachedNetworkImage(
                      width: mq.height * .2,
                      height: mq.height * .2,
                      fit: BoxFit.cover,
                      imageUrl: widget.user.image,
                      errorWidget: (context, url, error) => CircleAvatar(
                          backgroundColor: Colors.blue.shade800,
                          child: const Icon(
                            CupertinoIcons.person,
                            size: 50,
                            color: Colors.black,
                          )),
                    ),
                  ),

                  // for adding some space
                  SizedBox(height: mq.height * .03),

                  // user email label
                  Text(widget.user.name,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 16)),

                  SizedBox(height: mq.height * .03),

                  // user email label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.mail),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(widget.user.email,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 16)),
                    ],
                  ),

                  // for adding some space
                  SizedBox(height: mq.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.support_agent,
                        size: 35,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Contact Support',
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  ),
                  SizedBox(height: mq.height * .02),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Switch(
                          value: isSwitch,
                          onChanged: (value) {
                            setState(() {
                              isSwitch = !isSwitch;
                            });
                          }),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Notification",
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  ),
                  SizedBox(height: mq.height * .02),
                  //user about
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'About: ',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text(widget.user.about,
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../api/apis.dart';
import '../helper/my_date_util.dart';

import '../models/chat_user.dart';
import '../models/message.dart';
import '../screens/chat_screen.dart';
import 'dialogs/profile_dialog.dart';

//card to represent a single user in home screen
class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  //last message info (if null --> no message)
  Message? _message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade500,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: InkWell(
          onTap: () {
            //for navigating to chat screen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(user: widget.user)));
          },
          child: StreamBuilder(
            stream: APIs.getLastMessage(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) _message = list[0];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ListTile(
                  //user profile picture
                  leading: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => ProfileDialog(user: widget.user));
                    },
                    child: widget.user.image == 'null'
                        ? const CircleAvatar(
                            backgroundColor: Color.fromRGBO(59, 92, 222, 1.0),
                            child: Icon(Icons.person))
                        : ClipRRect(
                            borderRadius:
                                BorderRadius.circular(mq.height * .03),
                            child: CachedNetworkImage(
                              width: mq.height * .055,
                              height: mq.height * .055,
                              imageUrl: widget.user.image,
                              errorWidget: (context, url, error) =>
                                  const CircleAvatar(
                                      child: Icon(
                                CupertinoIcons.person,
                                color: Colors.black,
                              )),
                            ),
                          ),
                  ),

                  //user name
                  title: Text(
                    widget.user.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),

                  //last message
                  subtitle: Text(
                      _message != null
                          ? _message!.type == Type.image
                              ? 'image'
                              : _message!.msg
                          : widget.user.about,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),

                  //last message time
                  trailing: _message == null
                      ? null //show nothing when no message is sent
                      : _message!.read.isEmpty &&
                              _message!.fromId != APIs.user.uid
                          ?
                          //show for unread message
                          Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  color: Colors.greenAccent.shade400,
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          :
                          //message sent time
                          Text(
                              MyDateUtil.getLastMessageTime(
                                  context: context, time: _message!.sent),
                              style: const TextStyle(color: Colors.black),
                            ),
                ),
              );
            },
          )),
    );
  }
}

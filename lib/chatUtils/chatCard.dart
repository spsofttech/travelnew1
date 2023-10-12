// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:travelnew_app/chatUtils/chatModel.dart';

import 'IndividualChatScreen.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({
    Key? key,
    required this.chat,
  }) : super(key: key);
  final ChatModel chat;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  String imgURL = '';
  getData() async {
    var x = await FirebaseFirestore.instance.collection('users').doc(widget.chat.sender).get();
    imgURL = x.data()!['profileImg'] ??
        'https://firebasestorage.googleapis.com/v0/b/travelnew-79e2e.appspot.com/o/profileImg?alt=media&token=39dc5e0e-8a3d-41cf-94c0-8ca03147aa7a';
    setState(() {});
  }

  bool isSeen = false;

  isSeenFun() async {
    isSeen = widget.chat.seenBy.contains(FirebaseAuth.instance.currentUser!.uid);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    isSeenFun();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) => IndividualPage(
                      chatModel: widget.chat,
                      img: imgURL,
                    )));
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blueGrey,
          backgroundImage: NetworkImage(imgURL),
        ),
        title: Text(
          widget.chat.senderName,
          style: TextStyle(fontSize: 16, fontWeight: isSeen ? FontWeight.w900 : FontWeight.w500),
        ),
        subtitle: Text(
          widget.chat.message,
          style: TextStyle(fontSize: 13, fontWeight: isSeen ? FontWeight.bold : FontWeight.normal),
        ),

        // DateTime.now().millisecondsSinceEpoch
        trailing: Text(DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.chat.time)))),
      ),
    );
  }
}

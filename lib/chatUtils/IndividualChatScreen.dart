import 'package:flutter/material.dart';
import '../../utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelnew_app/chatUtils/chatModel.dart';
import 'package:travelnew_app/chatUtils/OwnMessageComponent.dart';
import 'package:travelnew_app/chatUtils/ReplyComponent.dart';
import 'package:travelnew_app/chatUtils/MessageModel.dart';

class IndividualPage extends StatefulWidget {
  IndividualPage({
    Key? key,
    required this.chatModel,
    required this.img,
  }) : super(key: key);
  final ChatModel chatModel;
  final String img;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // connect();
    getMessages();
    chatWithDetails();
  }

  String uid = '';
  String myUid = '';
  String userName = '';
  String myName = '';

  chatWithDetails() async {
    myUid = FirebaseAuth.instance.currentUser!.uid;
    if (!widget.chatModel.isGroup) {
      widget.chatModel.chatGroup.forEach((element) {
        if (element != FirebaseAuth.instance.currentUser!.uid) {
          uid = element;
          setState(() {});
        }
      });
      var x = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userName = x.data()!['fullName'];
      setState(() {});
      var y = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      myName = y.data()!['fullName'];
      setState(() {});
    }
  }

  getMessages() async {
    messages.clear();
    print(widget.chatModel.chatId);
    var x = await FirebaseFirestore.instance.collection('chats').doc(widget.chatModel.chatId).collection('allChats').get();
    x.docs.forEach((element) {
      messages.add(MessageModel(time: element.data()['time'], sender: element.data()['sender'], message: element.data()['message']));
      print(element.data());
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/whatsapp_Back.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              backgroundColor: primary,
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.img),
                      radius: 20,
                      backgroundColor: primary,
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                PopupMenuButton<String>(
                  padding: EdgeInsets.all(0),
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext contesxt) {
                    return [
                      PopupMenuItem(
                        child: Text("View Profile"),
                        value: "View Profile",
                      ),
                      PopupMenuItem(
                        child: Text("Clear chat"),
                        value: "Clear chat",
                      ),
                      PopupMenuItem(
                        child: Text("Block user"),
                        value: "Block user",
                      ),
                      PopupMenuItem(
                        child: Text("Report"),
                        value: "Report",
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].sender == FirebaseAuth.instance.currentUser!.uid) {
                          return OwnMessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else {
                          return ReplyCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 5),
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Card(
                                  margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                  left: 1,
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: primary,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      widget.chatModel.sendChat(
                                          myUid,
                                          myName,
                                          DateTime.now().millisecondsSinceEpoch.toString(),
                                          [myUid],
                                          [uid, myUid],
                                          [uid, myUid],
                                          false,
                                          myUid.compareTo(uid) < 0 ? '${myUid}_$uid' : '${uid}_$myUid',
                                          _controller.text,
                                          '${DateTime.now().millisecondsSinceEpoch.toString()}_$myUid');
                                      _controller.clear();
                                      getMessages();
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }
}

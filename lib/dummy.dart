

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emoji_selector/emoji_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ClassroomChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  final String classRoomId;

  const ClassroomChatScreen({
    Key? key,
    required this.classRoomId,
  }) : super(key: key);
  @override
  _ClassroomChatScreenState createState() => _ClassroomChatScreenState();
}

class _ClassroomChatScreenState extends State<ClassroomChatScreen> {
  final messageTextController = TextEditingController();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var participants = 0;
  bool showEmojiPicker = false;
  // SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  var groupName = '';

  /// This has to happen only once per app
  // void _initSpeech() async {
  //   _speechEnabled = await _speechToText.initialize();
  //   setState(() {});
  // }

  Future pickImage() async {
    try {
      FirebaseStorage _storage = FirebaseStorage.instance;
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);

      if (image == null) return;
      final imageTemp = XFile(image.path);
      Reference reference = _storage.ref().child("classroomchatimages/");
      // UploadTask uploadTask = reference.putFile(path));
      // TaskSnapshot snapshot = await uploadTask;
      // String location = await snapshot.ref.getDownloadURL();

      // await FirebaseFirestore.instance
      //     .collection("ClassroomChats")
      //     .doc(widget.classRoomId)
      //     .collection("messeges")
      //     .doc()
      //     .set({
      //   'message': location,
      //   'senderId': FirebaseAuth.instance.currentUser!.uid,
      //   'isImage': true,
      //   'date': Timestamp.now(),
      // });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  /// Each time to start a speech recognition session
  // void _startListening() async {
  //   print('isClicked');
  //   await _speechToText.listen(onResult: _onSpeechResult);
  //   setState(() {});
  // }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  // void _stopListening() async {
  //   await _speechToText.stop();
  //   setState(() {});
  // }

  // /// This is the callback that the SpeechToText plugin calls when
  // /// the platform returns recognized words.
  // void _onSpeechResult(SpeechRecognitionResult result) {
  //   setState(() {
  //     // messageTextController.text = result.recognizedWords;
  //   });
  // }

  _fetchGroupName() async {
    await FirebaseFirestore.instance
        .collection('classroom')
        .where('classroomId', isEqualTo: widget.classRoomId)
        .snapshots()
        .listen((value) {
      setState(() {
        groupName = value.docs[0].data()['groupName'];
      });
    });
  }

  _fetchClassInfo() async {
    await FirebaseFirestore.instance
        .collection('Students')
        .where('classroomId', isEqualTo: widget.classRoomId)
        .get()
        .then((value) {
      setState(() {
        participants = value.size;
      });
    });
  }

  void fetchRequest() async {
    var result = await db
        .collection('classroomRequests')
        .where('receiverUid', isEqualTo: _auth.currentUser?.uid)
        .get();
    if (result.docs.isNotEmpty) {
      // SnackbarService().popupSnackBar(
      //   context: context,
      //   child: BottomPopup(
      //     requests: requests,
      //     div: div,
      //     token: token,
      //   ),
      // );
    }
  }

  List<Map<String, dynamic>> requests = [];
  List<String> div = [];
  List<String> token = [];

  Future<void> fetch() async {
    var result = await db
        .collection('classroomRequests')
        .where('receiverId', isEqualTo: _auth.currentUser?.uid)
        .get();
    for (var request in result.docs) {
      await FirebaseFirestore.instance
          .collection('Students')
          .doc(request.data()['senderId'])
          .get()
          .then((value) {
        requests.add(request.data());
        div.add(value.get('division'));
        token.add(value.get('token'));
      });
    }
    if (requests.isNotEmpty) {
      setState(() {});
    }
  }

  String messageText = '';

  @override
  void initState() {
    setupRequest();
    _fetchClassInfo();
    _fetchGroupName();
    super.initState();
    // _initSpeech();
  }

  void setupRequest() async {
    await fetch();
    if (requests.isEmpty) return;
    // SnackbarService().popupSnackBar(
    //   context: context,
    //   child: BottomPopup(
    //     requests: requests,
    //     div: div,
    //     token: token,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 10,
            ),
            child: Container(
              height: 34,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(17),
                    bottomRight: Radius.circular(17)),
              ),
              child: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ),
        title: GestureDetector(
          onTap: () {
    
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/group.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '$groupName',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 9,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '$participants Participants',
                    style: TextStyle(
                        fontSize: 11,
                        color: Color(0xff939393),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          showEmojiPicker == true
              ? setState(() {
                  showEmojiPicker = false;
                })
              : Navigator.pop(context);
          return Future.value(false);
        },
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpeg'),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("ClassroomChats")
                          .doc(widget.classRoomId)
                          .collection("messeges")
                          .orderBy("date", descending: true)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.docs.length < 1) {
                            return Center(
                              child: Text("hi"),
                            );
                          }

                          // List userData = [];
                          // for (int i = 0; i < snapshot.data.docs.length; i++) {
                          //   FirebaseFirestore.instance
                          //       .collection('Students')
                          //       .doc(snapshot.data.docs[i]['senderId'])
                          //       .get()
                          //       .then((value) {
                          //     setState(() {
                          //       userData.add(value.data());
                          //     });
                          //   });
                          // }

                          return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              reverse: true,
                              physics: BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 20.0),
                              itemBuilder: (context, index) {
                                return StreamBuilder<Object>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Students')
                                        .doc(snapshot.data.docs[index]
                                            ['senderId'])
                                        .snapshots(),
                                    builder:
                                        (context, AsyncSnapshot snapshots) {
                                      if (snapshots.hasData) {
                                        print(snapshots.data);

                                        return MessageBubble(
                                          sender: snapshots.data['name'],
                                          image: snapshots.data['profile'],
                                          isMe: snapshot.data.docs[index]
                                                  ['senderId'] ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid,
                                          text: snapshot.data.docs[index]
                                              ['message'],
                                          isImage: snapshot.data.docs[index]
                                              ['isImage'],
                                          messageId:
                                              snapshot.data.docs[index].id,
                                          classRoomId: widget.classRoomId,
                                        );
                                      } else {
                                        return SizedBox();
                                      }
                                    });
                              });
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white38),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: 40,
                            maxHeight: 74,
                            minWidth: MediaQuery.of(context).size.width * 0.76,
                            maxWidth: MediaQuery.of(context).size.width * 0.76),
                        child: TextField(
                          maxLines: null,
                          onTap: () {
                            setState(() {
                              showEmojiPicker = false;
                            });
                          },
                          controller: messageTextController,
                          onChanged: (value) {
                            setState(() {
                              messageText = value;
                            });
                          },
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  showEmojiPicker = !showEmojiPicker;
                                });
                              },
                              child: Icon(
                                Icons.emoji_emotions_outlined,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            hintText: 'Type a message',
                            hintStyle:
                                TextStyle(color: Colors.black.withOpacity(0.3)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade400, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                        ),
                      ),
                      messageTextController.text == ''
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  onTap: () {
                                    pickImage();
                                  },
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     print(_speechToText.isNotListening);
                                //     _speechToText.isNotListening
                                //         ? _startListening()
                                //         : _stopListening();
                                //   },
                                //   child: Icon(
                                //     _speechToText.isNotListening
                                //         ? Icons.mic_none
                                //         : Icons.mic,
                                //     color: Colors.black.withOpacity(0.6),
                                //   ),
                                // ),
                              ],
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                  left: (MediaQuery.of(context).size.width *
                                      0.08)),
                              child: InkWell(
                                onTap: () async {
                                  if (messageTextController.text != '') {
                                    String message = messageTextController.text;
                                    messageTextController.clear();
                                    await FirebaseFirestore.instance
                                        .collection("ClassroomChats")
                                        .doc(widget.classRoomId)
                                        .collection("messeges")
                                        .doc()
                                        .set({
                                      'message': message,
                                      'senderId': FirebaseAuth
                                          .instance.currentUser!.uid,
                                      'date': Timestamp.now(),
                                      'isImage': false,
                                    }).whenComplete(() {});
                                  }
                                },
                                child: Icon(
                                  Icons.send,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                // Visibility(
                //   visible: showEmojiPicker,
                //   child: Container(
                //     height: 275,
                //     color: Colors.white,
                //     child: EmojiSelector(
                //       onSelected: (emoji) {
                //         setState(() {
                //           messageTextController.text += emoji.char;
                //         });
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatefulWidget {
  MessageBubble(
      {Key? key,
      this.sender = 'Charoo',
      this.text = 'This is a dummy message text',
      this.isMe = true,
      this.image = 'https://i.pravatar.cc/300',
      this.isImage = false,
      required this.classRoomId,
      required this.messageId,
      this.isContinuous = false})
      : super(key: key);

  String sender;
  String text;
  bool isMe;
  bool isContinuous;
  String image;
  bool isImage;
  String messageId;
  String classRoomId;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool messageDelete = false;

  _deleteMessage(String id, String friendId) async {
    await FirebaseFirestore.instance
        .collection("ClassroomChats")
        .doc(widget.classRoomId)
        .collection("messeges")
        .doc(id)
        .update({'message': 'This message has been deleted'}).whenComplete(() {
      setState(() {
        messageDelete = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: !widget.isContinuous
          ? EdgeInsets.all(10.0)
          : const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment:
            widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          !widget.isMe && !widget.isContinuous
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(widget.image != null
                                ? widget.image
                                : 'https://i.pravatar.cc/300'),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            widget.sender,
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.red,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      widget.isImage == false
                          ? Material(
                              borderRadius: BorderRadius.circular(4),
                              elevation: 1.0,
                              color: widget.isMe
                                  ? const Color(0xffBB261C)
                                  : const Color(0xffF1F1F1),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                      ),
                                      child: Text(
                                        widget.text,
                                        style: TextStyle(
                                          color: widget.isMe
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                widget.text,
                                fit: BoxFit.fill,
                                width: 200,
                                height: 200,
                              ),
                            ),
                    ],
                  ),
                )
              : const SizedBox(),
          widget.isMe
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: widget.isImage == false
                          ? InkWell(
                              onLongPress: () {
                                setState(() {
                                  messageDelete = true;
                                });
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(4),
                                elevation: 1.0,
                                color: widget.isMe
                                    ? const Color(0xffBB261C)
                                    : const Color(0xffF1F1F1),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                        ),
                                        child: Text(
                                          widget.text,
                                          style: TextStyle(
                                            color: widget.isMe
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : InkWell(
                              onLongPress: () {
                                setState(() {
                                  messageDelete = true;
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  widget.text,
                                  fit: BoxFit.fill,
                                  width: 200,
                                  height: 200,
                                ),
                              ),
                            ),
                    ),
                    Visibility(
                      visible: messageDelete,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, top: 2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: InkWell(
                              onTap: () {
                                _deleteMessage(
                                    widget.messageId, widget.classRoomId);
                              },
                              child: Icon(
                                CupertinoIcons.trash_fill,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
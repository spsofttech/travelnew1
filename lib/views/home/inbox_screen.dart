import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelnew_app/chatUtils/chatCard.dart';
import 'package:travelnew_app/chatUtils/chatModel.dart';
import 'package:travelnew_app/widget/custom_appbar.dart';
import 'package:travelnew_app/widget/custom_button.dart';

import '../../utils/constant.dart';
import '../../widget/custom_textfield.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  String uid = '';

  List<ChatModel> messageList = [];
  List<ChatModel> searchedList = [];

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    uid = FirebaseAuth.instance.currentUser!.uid;
    getChats();
    initInBox();
    super.initState();
  }

  initInBox() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("inbox").doc("request").get();
    bool docExist = doc.exists;
    //String docExistString = await FirebaseFirestore.instance.collection('users').doc(friendUid).collection("inbox").doc("request").id;

    //print("${{"frdId": friendUid, "userid": FirebaseAuth.instance.currentUser!.uid, "image": friendImg, "name": name, "status": 0}}");
    print(docExist);
    if (!docExist) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("inbox")
          .doc("request")
          .set({"data": FieldValue.arrayUnion([])});
    }
  }

  getChats() async {
    var x = await FirebaseFirestore.instance.collection('chats').get();
    messageList.clear();
    for (var element in x.docs) {
      print(element.data());
      List<dynamic> chatGroup = element.data()['chatGroup'];
      print(chatGroup);
      if (chatGroup.contains(uid)) {
        messageList.add(ChatModel.fromDocument(element));
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController!.dispose();
    super.dispose();
  }

  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(50), child: CustomAppBar(title: 'Inbox')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: TabBar(
                padding: EdgeInsets.zero,
                // labelPadding: EdgeInsets.zero,
                // indicatorPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Colors.grey,
                controller: _tabController,
                onTap: (value) {},
                isScrollable: false,
                indicator: BoxDecoration(
                    // shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: primary),
                indicatorColor: primary,
                labelColor: black,
                labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                tabs: const [
                  Tab(
                    text: 'Messages',
                  ),
                  Tab(
                    text: 'Request',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height(context) * 0.05,
                        width: width(context) * 0.95,
                        child: Theme(
                          data: ThemeData(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
                                  primary: primary,
                                ),
                          ),
                          child: TextField(
                            controller: searchController,
                            onChanged: ((value) {
                              if (searchController.text.isEmpty) {
                                getChats();
                              } else {
                                messageList.forEach(((element) {
                                  searchedList.clear();
                                  if (element.chatGroup.contains(value)) {
                                    searchedList.add(element);
                                  }
                                }));
                                setState(() {
                                  messageList = searchedList;
                                });
                              }
                            }),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search),
                              labelText: 'enter trip friend name to see messages',
                              // labelStyle: bodyText14w600(color: primarhy),

                              focusColor: primary,

                              enabledBorder:
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.black26, width: 1.0), borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primary, width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: messageList.length,
                          itemBuilder: (context, i) {
                            return CustomCard(chat: messageList[i]);
                          })
                    ],
                  ),
                ),
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("inbox")
                      .doc("request")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List frdRequest = snapshot.data!.data()!['data'];
                      return SizedBox(
                        height: height(context) * 0.87,
                        child: ListView.builder(
                            itemCount: frdRequest.length,
                            shrinkWrap: true,
                            itemBuilder: (ctx, i) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                      leading: frdRequest[i]['image'] != ""
                                          ? CircleAvatar(
                                              radius: 20,
                                              backgroundImage: NetworkImage("${frdRequest[i]['image']}"),
                                            )
                                          : CircleAvatar(
                                              radius: 20,
                                              backgroundImage: AssetImage('assets/images/inbox1.png'),
                                            ),
                                      title: Text(
                                        '${frdRequest[i]['name']}',
                                        style: bodyText18w600(color: black),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              accept_friend_request(frdRequest[i]);
                                            },
                                            child: Container(
                                              height: height(context) * 0.03,
                                              width: width(context) * 0.2,
                                              decoration: myFillBoxDecoration(0, primary, 10),
                                              child: Center(
                                                child: Text(
                                                  "Accept",
                                                  style: bodyText12Small(color: black),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              rejectFriendRequest(frdRequest[i], true);
                                            },
                                            child: Container(
                                              height: height(context) * 0.03,
                                              width: width(context) * 0.2,
                                              decoration: myFillBoxDecoration(0, Colors.red, 10),
                                              child: Center(
                                                child: Text(
                                                  "Reject",
                                                  style: bodyText12Small(color: white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  const Divider(
                                    height: 5,
                                    thickness: 1,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              );
                            }),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.yellow),
                      );
                    }
                  },
                )
              ]),
            )
          ],
        ));
  }

  rejectFriendRequest(Map<String, dynamic> removedMap, bool isTostShow) async {
    //String docExistString = await FirebaseFirestore.instance.collection('users').doc(friendUid).collection("inbox").doc("request").id;

    //print("${{"frdId": friendUid, "userid": FirebaseAuth.instance.currentUser!.uid, "image": friendImg, "name": name, "status": 0}}");
    print(removedMap);
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("inbox").doc("request").update({
      "data": FieldValue.arrayRemove([removedMap])
    });

    if (isTostShow) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Friend Request Rejected",
          style: TextStyle(color: white),
        ),
        backgroundColor: primary,
        duration: Duration(seconds: 3),
      ));
    }
  }

  accept_friend_request(Map<String, dynamic> addMap) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("friends").doc("data").get();
    bool docExist = doc.exists;
    DocumentSnapshot<Map<String, dynamic>> doc2 =
        await FirebaseFirestore.instance.collection('users').doc(addMap['id']).collection("friends").doc("data").get();
    bool docExist2 = doc2.exists;
    DocumentSnapshot<Map<String, dynamic>> doc3 =
        await FirebaseFirestore.instance.collection('users').doc(addMap['id']).collection("Prima_Trip_Plan").doc(addMap['id']).get();
    bool docExist3 = doc3.exists;
    //String docExistString = await FirebaseFirestore.instance.collection('users').doc(friendUid).collection("inbox").doc("request").id;

    //print("${{"frdId": friendUid, "userid": FirebaseAuth.instance.currentUser!.uid, "image": friendImg, "name": name, "status": 0}}");
    //print(docExist);
    if (docExist) {
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("friends").doc("data").update({
        "data": FieldValue.arrayUnion([addMap])
      });
    } else {
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("friends").doc("data").set({
        "data": FieldValue.arrayUnion([addMap])
      });
    }

    if (docExist2) {
      await FirebaseFirestore.instance.collection('users').doc(addMap['id']).collection("friends").doc("data").update({
        "data": FieldValue.arrayUnion([addMap])
      });
    } else {
      await FirebaseFirestore.instance.collection('users').doc(addMap['id']).collection("friends").doc("data").set({
        "data": FieldValue.arrayUnion([addMap])
      });
    }

    await FirebaseFirestore.instance.collection('users').doc(addMap['id']).collection("Prima_Trip_Plan").doc(addMap['id']).update({
      "friends": FieldValue.arrayRemove([
        {'id': FirebaseAuth.instance.currentUser!.uid, 'image': USERIMAGE, 'name': USERNAME, 'status': 0, 'host': addMap['host']}
      ])
    });

    await FirebaseFirestore.instance.collection('users').doc(addMap['id']).collection("Prima_Trip_Plan").doc(addMap['id']).update({
      "friends": FieldValue.arrayUnion([
        {'id': FirebaseAuth.instance.currentUser!.uid, 'image': USERIMAGE, 'name': USERNAME, 'status': 1, 'host': addMap['host']}
      ])
    });

    rejectFriendRequest(addMap, false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Now You are Friends",
        style: TextStyle(color: white),
      ),
      backgroundColor: primary,
      duration: Duration(seconds: 3),
    ));
  }
}

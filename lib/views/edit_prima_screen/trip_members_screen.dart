import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/edit_prima_screen/entertainment_of_trip.dart';
import 'package:travelnew_app/views/edit_prima_screen/entertainment_screen.dart';
import 'package:travelnew_app/views/humburger_flow/my_account/report_incorrect_trip_screen.dart';

import '../../widget/custom_button.dart';
import '../humburger_flow/my_account/my_trip_friends.dart';
import '../humburger_flow/my_account/report_incorrect_user_screen.dart';
import '../publish your trip/publish_your_trip.dart';

class TripMembersTabPrimaProfile extends StatefulWidget {
  Map<String, dynamic> tripData;
  bool isHost;
  bool onlyFriends;
  TripMembersTabPrimaProfile({Key? key, required this.tripData, this.isHost = true, this.onlyFriends = false}) : super(key: key);

  @override
  State<TripMembersTabPrimaProfile> createState() => _TripMembersTabPrimaProfileState();
}

class _TripMembersTabPrimaProfileState extends State<TripMembersTabPrimaProfile> {
  final List tripMembers = [
    {'member': '(Host)', 'isShow': false, 'title': 'Requested to join'},
    {'title': 'Members Invited', 'member': '(Member)', 'isShow': true},
  ];

  String allowedMember1 = "";
  String allowedMember2 = "";
  String maxMember = "";
  //List tripFriends = [];
  void getdata() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Prima_Trip_Plan")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      allowedMember2 = profile.data()?['who see trip'] ?? "";
      allowedMember1 = profile.data()?['Inveted Member'] ?? "";
      maxMember = profile.data()?['Max_Member'] ?? "";

      //tripFriends = profile.data()?['friends'] ?? [];
    }
    setState(() {});
  }

  String hostname = "";
  String image = "";

  void getPrimaDeatials() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('primaAccount').doc('profile').get();
      hostname = profile.data()?['fullName'] ?? "";
      image = profile.data()?['imageUrl'] ?? "";
      // print("-------List------${tripFriends.length}");
      setState(() {});
    }
  }

  removeFromFriend(Map<String, dynamic> removMap) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await FirebaseFirestore.instance.collection('users').doc(removMap['id']).collection("friends").doc("data").get();
    bool docExist = doc.exists;
    DocumentSnapshot<Map<String, dynamic>> doc2 =
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("friends").doc("data").get();
    bool docExist2 = doc2.exists;
    DocumentSnapshot<Map<String, dynamic>> doc3 = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Prima_Trip_Plan")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    bool docExist3 = doc3.exists;
    //String docExistString = await FirebaseFirestore.instance.collection('users').doc(friendUid).collection("inbox").doc("request").id;

    //print("${{"frdId": friendUid, "userid": FirebaseAuth.instance.currentUser!.uid, "image": friendImg, "name": name, "status": 0}}");
    //print(docExist);
    if (docExist) {
      await FirebaseFirestore.instance.collection('users').doc(removMap['id']).collection("friends").doc("data").update({
        "data": FieldValue.arrayUnion([removMap])
      });
    } else {
      await FirebaseFirestore.instance.collection('users').doc(removMap['id']).collection("friends").doc("data").set({
        "data": FieldValue.arrayUnion([removMap])
      });
    }

    if (docExist2) {
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("friends").doc("data").update({
        "data": FieldValue.arrayRemove([removMap])
      });
    } else {
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("friends").doc("data").set({
        "data": FieldValue.arrayRemove([removMap])
      });
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Prima_Trip_Plan")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "friends": FieldValue.arrayRemove([removMap])
    });

    // await FirebaseFirestore.instance.collection('users').doc(removMap['id']).collection("Prima_Trip_Plan").doc(removMap['id']).update({
    //   "friends": FieldValue.arrayUnion([
    //     {
    //       'id': FirebaseAuth.instance.currentUser!.uid,
    //       'image': USERIMAGE,
    //       'name': USERNAME,
    //       'status': 1,
    //     }
    //   ])
    // });

    /// rejectFriendRequest(removMap, false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Now You are Friends",
        style: TextStyle(color: white),
      ),
      backgroundColor: primary,
      duration: Duration(seconds: 3),
    ));
  }

  removeFromFriendReuest(Map<String, dynamic> removMap) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Prima_Trip_Plan")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "friends": FieldValue.arrayRemove([removMap])
    });

    // await FirebaseFirestore.instance.collection('users').doc(removMap['id']).collection("Prima_Trip_Plan").doc(removMap['id']).update({
    //   "friends": FieldValue.arrayUnion([
    //     {
    //       'id': FirebaseAuth.instance.currentUser!.uid,
    //       'image': USERIMAGE,
    //       'name': USERNAME,
    //       'status': 1,
    //     }
    //   ])
    // });

    /// rejectFriendRequest(removMap, false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Now You are Friends",
        style: TextStyle(color: white),
      ),
      backgroundColor: primary,
      duration: Duration(seconds: 3),
    ));
  }

  @override
  void initState() {
    getdata();
    getPrimaDeatials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("Prima_Trip_Plan")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String friendDocList = 'friends';
              List tripMember = snapshot.data!.data()![friendDocList];
              List requestMember = snapshot.data!.data()![friendDocList];
              tripMember = tripMember.where((element) => element['status'] == 1).toList();

              requestMember = requestMember.where((element) => element['status'] == 0).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Trip Members',
                        style: bodyText16w600(color: black),
                      ),
                      Spacer(),
                      Text(
                        '${tripMember.length}/ $maxMember have joined',
                      ),
                      addHorizontalySpace(10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyTripFriendsScreen(title: 'add New Member', tripData: [widget.tripData], onlyFriend: true)));
                        },
                        child: Icon(
                          Icons.add_circle,
                          color: primary,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  addVerticalSpace(10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    width: width(context) * 0.95,
                    height: height(context) * 0.13,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: height(context) * 0.13,
                          width: width(context) * 0.27,
                          decoration: USERIMAGE != ""
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(image: NetworkImage(NoUserNetworkImage), fit: BoxFit.fill))
                              : BoxDecoration(color: primary, image: DecorationImage(image: NetworkImage(USERIMAGE))),
                          alignment: Alignment.topRight,
                          // child: InkWell(
                          //     onTap: () {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => MyTripFriendsScreen(
                          //                     title: 'added',
                          //                   )));
                          //     },
                          //     child: Icon(Icons.more_vert))
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${USERNAME}',
                                style: TextStyle(fontSize: width(context) * 0.04),
                              ),
                              Text(
                                '${widget.isHost ? "Host" : "Member"}',
                                style: bodytext12Bold(color: black),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(top: 20.0),
                        //       child: PopupMenuButton<int>(
                        //         itemBuilder: (context) => [
                        //           const PopupMenuItem(
                        //             value: 1,
                        //             child: Text("Send a message"),
                        //           ),
                        //           PopupMenuItem(
                        //             onTap: () {
                        //               removeFromFriend(tripMember[i]);
                        //             },
                        //             value: 2,
                        //             child: Text("Remove trip friend"),
                        //           ),
                        //           // PopupMenuItem(
                        //           //   // value: 3,
                        //           //   child: InkWell(
                        //           //       onTap: () {
                        //           //         Navigator.push(context, MaterialPageRoute(builder: (ctx) => ReportIncorrectTripScreen()));
                        //           //       },
                        //           //       child: Text("Report incorrect")),
                        //           // ),
                        //         ],
                        //         color: white,
                        //         elevation: 2,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  ...List.generate(
                      tripMember.length,
                      (i) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            width: width(context) * 0.95,
                            height: height(context) * 0.13,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: height(context) * 0.13,
                                  width: width(context) * 0.27,
                                  decoration: tripMember[i]['image'] != ""
                                      ? BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: DecorationImage(image: NetworkImage(tripMember[i]['image']), fit: BoxFit.fill))
                                      : BoxDecoration(color: primary, image: DecorationImage(image: AssetImage('assets/images/prima3.png'))),
                                  alignment: Alignment.topRight,
                                  // child: InkWell(
                                  //     onTap: () {
                                  //       Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //               builder: (context) => MyTripFriendsScreen(
                                  //                     title: 'added',
                                  //                   )));
                                  //     },
                                  //     child: Icon(Icons.more_vert))
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${tripMember[i]['name']}',
                                        style: TextStyle(fontSize: width(context) * 0.04),
                                      ),
                                      Text(
                                        '${USER_UID == tripMember[i]['id'] ? "Host" : "Member"}',
                                        style: bodytext12Bold(color: black),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: PopupMenuButton<int>(
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                            value: 1,
                                            child: Text("Send a message"),
                                          ),
                                          PopupMenuItem(
                                            onTap: () {
                                              removeFromFriend(tripMember[i]);
                                            },
                                            value: 2,
                                            child: Text("Remove trip friend"),
                                          ),
                                          // PopupMenuItem(
                                          //   // value: 3,
                                          //   child: InkWell(
                                          //       onTap: () {
                                          //         Navigator.push(context, MaterialPageRoute(builder: (ctx) => ReportIncorrectTripScreen()));
                                          //       },
                                          //       child: Text("Report incorrect")),
                                          // ),
                                        ],
                                        color: white,
                                        elevation: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                  // ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     shrinkWrap: true,
                  //     itemCount: tripFriends.where((element) => (element['status'] == 2)).toList().length,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     padding: EdgeInsets.zero,
                  //     itemBuilder: (ctx, i) {
                  //       return ;
                  //     }),
                  addVerticalSpace(20),
                  Row(
                    children: [
                      Text(
                        tripMembers[0]['title'],
                        style: bodyText16w600(color: black),
                      ),
                      addHorizontalySpace(250),
                    ],
                  ),
                  addVerticalSpace(10),
                  ...List.generate(
                      requestMember.length,
                      (i) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            width: width(context) * 0.95,
                            height: height(context) * 0.13,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: height(context) * 0.13,
                                  width: width(context) * 0.27,
                                  decoration: requestMember[i]['image'] != ""
                                      ? BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: DecorationImage(image: NetworkImage(requestMember[i]['image']), fit: BoxFit.fill))
                                      : BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: white,
                                          image: DecorationImage(image: NetworkImage('${NoUserNetworkImage}'), fit: BoxFit.fill)),
                                  alignment: Alignment.topRight,
                                  // child: InkWell(
                                  //     onTap: () {
                                  //       Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //               builder: (context) => MyTripFriendsScreen(
                                  //                     title: 'added',
                                  //                   )));
                                  //     },
                                  //     child: Icon(Icons.more_vert))
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${requestMember[i]['name']}',
                                        style: TextStyle(fontSize: width(context) * 0.04),
                                      ),
                                      Text(
                                        '(Requested)',
                                        style: bodytext12Bold(color: black),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: PopupMenuButton<int>(
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                            value: 1,
                                            child: Text("Send a message"),
                                          ),
                                          PopupMenuItem(
                                            onTap: () {
                                              removeFromFriendReuest(requestMember[i]);
                                            },
                                            value: 2,
                                            child: Text("Remove trip friend"),
                                          ),
                                          // PopupMenuItem(
                                          //   // value: 3,
                                          //   child: InkWell(
                                          //       onTap: () {
                                          //         Navigator.push(context, MaterialPageRoute(builder: (ctx) => ReportIncorrectTripScreen()));
                                          //       },
                                          //       child: Text("Report incorrect")),
                                          // ),
                                        ],
                                        color: white,
                                        elevation: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                  // SizedBox(
                  //   height: height(context) * 0.4,
                  //   child: ListView.builder(
                  //       // scrollDirection: Axis.horizontal,
                  //       itemCount: tripMembers.length,
                  //       physics: const NeverScrollableScrollPhysics(),
                  //       padding: EdgeInsets.zero,
                  //       itemBuilder: (ctx, i) {
                  //         return Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 Text(
                  //                   tripMembers[i]['title'],
                  //                   style: bodyText16w600(color: black),
                  //                 ),
                  //                 addHorizontalySpace(250),
                  //               ],
                  //             ),
                  //             addVerticalSpace(10),
                  //             ...List.generate(
                  //                 tripFriends.where((element) => (element['status'] == 2)).toList().length,
                  //                 (i) => Container(
                  //                       margin: EdgeInsets.symmetric(horizontal: 15),
                  //                       width: width(context) * 0.95,
                  //                       height: height(context) * 0.13,
                  //                       child: Row(
                  //                         crossAxisAlignment: CrossAxisAlignment.center,
                  //                         mainAxisAlignment: MainAxisAlignment.start,
                  //                         children: [
                  //                           Container(
                  //                             height: height(context) * 0.13,
                  //                             width: width(context) * 0.27,
                  //                             decoration: image != ""
                  //                                 ? BoxDecoration(
                  //                                     borderRadius: BorderRadius.circular(12),
                  //                                     image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill))
                  //                                 : BoxDecoration(color: primary, image: DecorationImage(image: AssetImage('assets/images/prima3.png'))),
                  //                             alignment: Alignment.topRight,
                  //                             // child: InkWell(
                  //                             //     onTap: () {
                  //                             //       Navigator.push(
                  //                             //           context,
                  //                             //           MaterialPageRoute(
                  //                             //               builder: (context) => MyTripFriendsScreen(
                  //                             //                     title: 'added',
                  //                             //                   )));
                  //                             //     },
                  //                             //     child: Icon(Icons.more_vert))
                  //                           ),
                  //                           Padding(
                  //                             padding: const EdgeInsets.all(8.0),
                  //                             child: Column(
                  //                               mainAxisAlignment: MainAxisAlignment.start,
                  //                               crossAxisAlignment: CrossAxisAlignment.start,
                  //                               children: [
                  //                                 Text(
                  //                                   '$hostname',
                  //                                   style: TextStyle(fontSize: width(context) * 0.04),
                  //                                 ),
                  //                                 Text(
                  //                                   '(Host)',
                  //                                   style: bodytext12Bold(color: black),
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                           Spacer(),
                  //                           Column(
                  //                             mainAxisAlignment: MainAxisAlignment.start,
                  //                             children: [
                  //                               Padding(
                  //                                 padding: const EdgeInsets.only(top: 20.0),
                  //                                 child: PopupMenuButton<int>(
                  //                                   itemBuilder: (context) => [
                  //                                     const PopupMenuItem(
                  //                                       value: 1,
                  //                                       child: Text("Send a message"),
                  //                                     ),
                  //                                     const PopupMenuItem(
                  //                                       value: 2,
                  //                                       child: Text("Remove trip friend"),
                  //                                     ),
                  //                                     PopupMenuItem(
                  //                                       // value: 3,
                  //                                       child: InkWell(
                  //                                           onTap: () {
                  //                                             Navigator.push(context, MaterialPageRoute(builder: (ctx) => ReportIncorrectTripScreen()));
                  //                                           },
                  //                                           child: Text("Report incorrect")),
                  //                                     ),
                  //                                   ],
                  //                                   color: white,
                  //                                   elevation: 2,
                  //                                 ),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     )),
                  //             //addVerticalSpace(100),
                  //             // Row(
                  //             //   crossAxisAlignment: CrossAxisAlignment.start,
                  //             //   children: [
                  //             //     Column(
                  //             //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             //       children: [
                  //             //         Text('Ajay Sharma'),
                  //             addVerticalSpace(10),
                  //             //         SizedBox(
                  //             //           height: height(context) * 0.13,
                  //             //           width: width(context) * 0.27,
                  //             //           child: Image.asset(
                  //             //             'assets/images/man.png',
                  //             //             fit: BoxFit.fill,
                  //             //           ),
                  //             //         ),
                  //             // addVerticalSpace(10),
                  //             //         Text(
                  //             //           "Host",
                  //             //           style: bodytext12Bold(color: black),
                  //             //         ),
                  //             //       ],
                  //             //     ),
                  //             //     // addHorizontalySpace(15),
                  //             //     Padding(
                  //             //       padding: const EdgeInsets.only(top: 20.0),
                  //             //       child: PopupMenuButton<int>(
                  //             //         itemBuilder: (context) => [
                  //             //           const PopupMenuItem(
                  //             //             value: 1,
                  //             //             child: Text("Send a message"),
                  //             //           ),
                  //             //           const PopupMenuItem(
                  //             //             value: 2,
                  //             //             child: Text("Remove trip friend"),
                  //             //           ),
                  //             //           PopupMenuItem(
                  //             //             // value: 3,
                  //             //             child: InkWell(
                  //             //                 onTap: () {
                  //             //                   Navigator.push(
                  //             //                       context,
                  //             //                       MaterialPageRoute(
                  //             //                           builder: (ctx) =>
                  //             //                               ReportIncorrectTripScreen()));
                  //             //                 },
                  //             //                 child: Text("Report incorrect")),
                  //             //           ),
                  //             //         ],
                  //             //         color: white,
                  //             //         elevation: 2,
                  //             //       ),
                  //             //     ),
                  //             //     // Row(
                  //             //     //   crossAxisAlignment: CrossAxisAlignment.start,
                  //             //     //   children: [
                  //             //     //     InkWell(
                  //             //     //       onTap: () {},
                  //             //     //       child: Container(
                  //             //     //         height: 25,
                  //             //     //         width: width(context) * 0.22,
                  //             //     //         decoration:
                  //             //     //             myOutlineBoxDecoration(1, primary, 6),
                  //             //     //         child: Center(
                  //             //     //           child: Text(
                  //             //     //             'Message',
                  //             //     //             style: bodyText12Small(color: black),
                  //             //     //           ),
                  //             //     //         ),
                  //             //     //       ),
                  //             //     //     ),
                  //             //     //     addHorizontalySpace(10),
                  //             //     //     tripMembers[i]['isShow']
                  //             //     //         ? InkWell(
                  //             //     //             onTap: () {},
                  //             //     //             child: Container(
                  //             //     //               height: 25,
                  //             //     //               width: width(context) * 0.22,
                  //             //     //               decoration:
                  //             //     //                   myFillBoxDecoration(1, primary, 6),
                  //             //     //               child: Center(
                  //             //     //                 child: Text(
                  //             //     //                   'Accept',
                  //             //     //                   style:
                  //             //     //                       bodyText12Small(color: black),
                  //             //     //                 ),
                  //             //     //               ),
                  //             //     //             ),
                  //             //     //           )
                  //             //     //         : SizedBox(),
                  //             //     //   ],
                  //             //     // ),
                  //             //   ],
                  //             // ),
                  //             addVerticalSpace(20)
                  //           ],
                  //         );
                  //       }),
                  // ),
                  addVerticalSpace(15),
                  Text(
                    'Members type allowed',
                    style: bodyText16w600(color: black),
                  ),
                  addVerticalSpace(7),
                  if (allowedMember1 == 'Public')
                    Text(
                      'All members are invited',
                      style: bodyText12Small(spacing: 1.3, color: black),
                    )
                  else
                    Text(
                      'Trip friends are invited',
                      style: bodyText12Small(spacing: 1.3, color: black),
                    ),
                  if (allowedMember2 == 'All type')
                    Text(
                      'Man and Woman can be a member',
                      style: bodyText12Small(spacing: 1.3, color: black),
                    )
                  else
                    Text(
                      '$allowedMember2 can be a member',
                      style: bodyText12Small(spacing: 1.3, color: black),
                    ),
                  addVerticalSpace(height(context) * 0.1)
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: primary,
                ),
              );
            }
          },
        ));
  }
}

// class CustomRequestToJoinButton extends StatelessWidget {
//   const CustomRequestToJoinButton({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: width(context) * 0.45,
//         child: CustomButton(
//             name: 'Request to join',
//             onPressed: () {
//               showDialog(
//                   context: context,
//                   builder: (_) => AlertDialog(
//                         contentPadding: const EdgeInsets.all(6),
//                         shape: const RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0))),
//                         content: Builder(
//                           builder: (context) {
//                             var height = MediaQuery.of(context).size.height;
//                             var width = MediaQuery.of(context).size.width;
//
//                             return Container(
//                                 height: height * 0.34,
//                                 padding: EdgeInsets.all(10),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           'Trek to Sinhagad fort',
//                                           style: bodyText16w600(color: black),
//                                         ),
//                                         addHorizontalySpace(15),
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               bottom: 8.0),
//                                           child: IconButton(
//                                               onPressed: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               icon: const Icon(
//                                                 Icons.close,
//                                                 size: 30,
//                                               )),
//                                         )
//                                       ],
//                                     ),
//                                     Center(child: Text('Feb 06-09, 2022')),
//                                     addVerticalSpace(25),
//                                     Text(
//                                       'Meeting point and time',
//                                       style: bodyText14w600(color: black),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         SizedBox(
//                                           width: width * 0.4,
//                                           child: TextField(
//                                             decoration: InputDecoration(
//                                                 hintText:
//                                                     'Address of meeting point*',
//                                                 hintStyle: bodyText12Small(
//                                                     color: black)),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: width * 0.25,
//                                           child: TextField(
//                                             decoration: InputDecoration(
//                                                 hintText: 'Time*',
//                                                 hintStyle: bodyText12Small(
//                                                     color: black)),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     addVerticalSpace(height * 0.05),
//                                     Center(
//                                       child: SizedBox(
//                                         width: width * 0.4,
//                                         child: CustomButton(
//                                             name: 'Save',
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             }),
//                                       ),
//                                     )
//                                   ],
//                                 ));
//                           },
//                         ),
//                       ));
//             }),
//       ),
//     );
//   }
// }

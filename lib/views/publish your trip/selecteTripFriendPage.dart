import 'dart:developer' as dev;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelnew_app/views/humburger_flow/my_account/my_following_trip_friends.dart';
import 'package:travelnew_app/views/humburger_flow/my_account/report_incorrect_user_screen.dart';
import 'package:travelnew_app/views/start/sign_in_screen.dart';
import 'package:travelnew_app/widget/custom_appbar.dart';
import 'package:travelnew_app/widget/custom_textfield.dart';

import 'package:numberpicker/numberpicker.dart';
import 'package:age_calculator/age_calculator.dart';

import '../../../utils/constant.dart';
import '../../../widget/custom_button.dart';

class selectTripFriendPage extends StatefulWidget {
  selectTripFriendPage({required this.title});
  String title;

  @override
  State<selectTripFriendPage> createState() => _selectTripFriendPageState();
}

class _selectTripFriendPageState extends State<selectTripFriendPage> {
  List<dynamic> permanentList = [];
  List<dynamic> listo = [];
// List<dynamic> friendsInVicinity = [];
  List<dynamic> tripFriend = [];
  bool isFIV = false;
  List<dynamic> allMemList = [];
  bool loading = false;
  late String title;
  TextEditingController searchFriendController = TextEditingController();

  // getFriendInVicinityList() async {
  //   friendsInVicinity.clear();
  //   allMemList.clear();
  //   permanentList.clear();
  //   setState(() {
  //     loading = true;
  //   });
  //   var x = await FirebaseFirestore.instance.collection('users').get();
  //   var y = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
  //
  //   double userLat = double.parse(y.data()!['lat']);
  //   double userLng = double.parse(y.data()!['lng']);
  //
  //   for (var element in x.docs) {
  //     permanentList.add(element.data());
  //     allMemList.add(element.data());
  //   }
  //   print(allMemList);
  //
  //   //last 30 days active
  //   for (var element in allMemList) {
  //     var lastActTime = DateTime.fromMillisecondsSinceEpoch(int.parse(element['lastActive'] ?? 0) * 1000);
  //     //prima, friend &
  //     var nowTime = DateTime.now();
  //
  //     print('${element['UID']}=====$nowTime ========$lastActTime');
  //     var diff = double.parse(nowTime.difference(lastActTime).inDays.toString());
  //     if (diff <= 30) {
  //       friendsInVicinity.add(element);
  //     }
  //   }
  //
  //   //30km radius
  //   for (var element in allMemList) {
  //     double lat = double.parse(element['lat'] ?? 0.0);
  //     double lng = double.parse(element['lng'] ?? 0.0);
  //     double dist = calculateDistance(userLat, userLng, lat, lng);
  //     print('$lat -- $lng -- $dist');
  //     if (dist <= 30 && element['UID'] != FirebaseAuth.instance.currentUser!.uid && !friendsInVicinity.contains(element)) {
  //       friendsInVicinity.add(element);
  //       allMemList.remove(element);
  //     }
  //   }
  //
  //   setState(() {
  //     listo = friendsInVicinity;
  //     loading = false;
  //   });
  // }

  send_friendRequset({required String friendUid}) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(friendUid).collection("inbox").doc("request").get();
    bool docExist = doc.exists;
    //String docExistString = await FirebaseFirestore.instance.collection('users').doc(friendUid).collection("inbox").doc("request").id;

    //print("${{"frdId": friendUid, "userid": FirebaseAuth.instance.currentUser!.uid, "image": friendImg, "name": name, "status": 0}}");
    print(docExist);
    if (docExist) {
      await FirebaseFirestore.instance.collection('users').doc(friendUid).collection("inbox").doc("request").update({
        "data": FieldValue.arrayUnion([
          {"id": FirebaseAuth.instance.currentUser!.uid, "image": USERIMAGE, "name": USERNAME, "status": 0}
        ])
      });
    } else {
      await FirebaseFirestore.instance.collection('users').doc(friendUid).collection("inbox").doc("request").set({
        "data": {"id": FirebaseAuth.instance.currentUser!.uid, "image": USERIMAGE, "name": USERNAME, "status": 0}
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Friend Request Sent",
        style: TextStyle(color: white),
      ),
      backgroundColor: primary,
      duration: Duration(seconds: 3),
    ));
  }

  //
  // Future<bool>? checkIfDocExists(String docId) async {
  //   bool isDocumentExist;
  //   try {
  //
  //     // Get reference to Firestore collection
  //     var collectionRef = FirebaseFirestore.instance.collection('vendors');
  //
  //     var doc = await collectionRef.doc(docId).get();
  //
  //
  //       isDocumentExist = doc.exists;
  //
  //
  //     return doc.exists;
  //   } catch (e) {
  //
  //       isDocumentExist = false;
  //
  //
  //     return false;
  //   }
  // }
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  void initState() {
    title = widget.title;

    isFIV = title == 'Friends in vicinity' ? true : false;
    getTripFriend();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("----------$listo-------------");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            )),
        title: Text(
          widget.title,
          style: bodyText20w700(color: black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 48,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            decoration:
                BoxDecoration(color: white.withOpacity(0.7), borderRadius: BorderRadius.all(Radius.circular(50)), border: Border.all(color: primary)),
            child: TextField(
              controller: searchFriendController,
              cursorColor: black,
              onChanged: (txt) {
                setState(() {});
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: primary),
                border: InputBorder.none,
                // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)), borderSide: BorderSide(color: primary)),
                // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)), borderSide: BorderSide(color: primary))
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              //height: height(context) * 0.95,
              decoration: shadowDecoration(10, 1),
              child: ListView.builder(
                  itemCount: listo.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, i) {
                    return listo[i]['fullName'].toString().toLowerCase().contains(searchFriendController.text.toLowerCase()) ||
                            searchFriendController.text.isEmpty
                        ? Column(
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                listo[i]['profileImg'] == null
                                    ? const CircleAvatar(
                                        backgroundImage: AssetImage('assets/images/nearbyfestivals.png'),
                                        radius: 30,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(listo[i]['profileImg']),
                                        radius: 30,
                                      ),
                                addHorizontalySpace(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: width(context) * 0.5,
                                      child: Text(
                                        listo[i]['fullName'] ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: bodyText18w600(color: black),
                                      ),
                                    ),
                                    addVerticalSpace(3),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.bar_chart_outlined,
                                          size: 20,
                                          color: primary,
                                        ),
                                        addHorizontalySpace(1),
                                        Text(
                                          'Tripometer',
                                          style: bodyText12Small(color: black),
                                        )
                                      ],
                                    ),
                                    addVerticalSpace(4),
                                    listo[i]['profession'] != null && listo[i]['profession'] != ""
                                        ? Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/Vector (1).png',
                                                color: primary,
                                              ),
                                              addHorizontalySpace(1),
                                              Text(
                                                listo[i]['profession'] ?? '',
                                                style: bodyText12Small(color: black),
                                              )
                                            ],
                                          )
                                        : SizedBox(),
                                    addVerticalSpace(4),
                                    listo[i]['locality'] != null && listo[i]['locality'] != ""
                                        ? Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: primary,
                                              ),
                                              addHorizontalySpace(1),
                                              Text(
                                                listo[i]['locality'],
                                                style: bodyText12Small(color: black),
                                              )
                                            ],
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                                const Spacer(),
                                PopupMenuButton<int>(
                                  onSelected: (val) {
                                    dev.log("${val}");

                                    if (val == 2) {
                                      print("object");
                                      send_friendRequset(friendUid: listo[i]['UID']);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 1,
                                      child: Text("Send a message"),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {},
                                      value: 2,
                                      child: Text('Add trip friend'),
                                    ),
                                    PopupMenuItem(
                                      value: 3,
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (ctx) => ReportIncorrectUserScreen()));
                                          },
                                          child: Text("Report incorrect")),
                                    ),
                                  ],
                                  color: white,
                                  elevation: 2,
                                ),
                              ]),
                              const Divider(
                                height: 30,
                                thickness: 1,
                              )
                            ],
                          )
                        : SizedBox();
                  }))
        ]),
      ),
    );
  }

  // filterDialog(BuildContext context) {
  //   TextEditingController locController = TextEditingController();
  //   TextEditingController profController = TextEditingController();
  //   bool ageFilter = false;
  //   final ages = List<String>.generate(100, (int index) => (index + 1).toString(), growable: false);
  //   print(ages);
  //
  //   var currentValue = '';
  //
  //   void getFilteredFriendInVicinityList() {
  //     List allMemberList = permanentList;
  //     friendsInVicinity.clear();
  //
  //     for (var element in allMemberList) {
  //       if (locController.text.isNotEmpty) {
  //         if ((element['address'] ?? '').toString().toLowerCase().contains(locController.text.toLowerCase())) {
  //           friendsInVicinity.add(element);
  //           print('loc ele added');
  //         }
  //       } else if (profController.text.isNotEmpty) {
  //         if ((element['profession'] ?? '').toString().toLowerCase().contains(profController.text.toLowerCase()) && !friendsInVicinity.contains(element)) {
  //           friendsInVicinity.add(element);
  //           print('pprof ele added');
  //         }
  //       } else if (ageFilter == true) {
  //         if (element['dob'] != null && element['dob'] != "" && element['dob'] != ' ') {
  //           var d = element['dob'];
  //           print(element['UID']);
  //           print(d);
  //
  //           List<String> parts = d.split('-');
  //           print(parts);
  //
  //           DateTime birthday =
  //               DateTime(int.parse(parts[0]) > 999 ? int.parse(parts[0]) : int.parse("20" + parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  //
  //           DateDuration duration;
  //           // print('Your age is $birthday');
  //           duration = AgeCalculator.age(birthday);
  //           print('Your age is $duration');
  //           print(currentValue);
  //           if (int.parse(currentValue) == duration.years && !friendsInVicinity.contains(element)) {
  //             friendsInVicinity.add(element);
  //             print('age ele added');
  //           }
  //         } else {
  //           continue;
  //         }
  //       }
  //       listo = friendsInVicinity;
  //     }
  //     setState(() {});
  //     print(friendsInVicinity.length);
  //
  //     Navigator.pop(context);
  //   }
  //
  //   showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //             contentPadding: const EdgeInsets.all(6),
  //             shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //             content: Builder(
  //               builder: (context) {
  //                 var height = MediaQuery.of(context).size.height;
  //                 var width = MediaQuery.of(context).size.width;
  //                 return Container(
  //                     height: height * 0.6,
  //                     padding: EdgeInsets.all(10),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Text(
  //                           'Filter Options',
  //                           style: bodyText30W600(color: black),
  //                         ),
  //                         addVerticalSpace(height * 0.02),
  //                         Row(
  //                           children: [
  //                             Text("by Location : "),
  //                             Spacer(),
  //                             Container(
  //                               width: width * 0.35,
  //                               child: CustomTextFieldWidget(
  //                                 labelText: 'location',
  //                                 controller: locController,
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                         addVerticalSpace(height * 0.01),
  //                         StatefulBuilder(
  //                           builder: (context, setStat) {
  //                             return Row(
  //                               children: [
  //                                 Text("by Age : "),
  //                                 Container(
  //                                   width: width * 0.35,
  //                                   child: DropdownButton<String>(
  //                                     isExpanded: true,
  //                                     items: ages.map((String value) {
  //                                       return DropdownMenuItem<String>(
  //                                         value: value,
  //                                         child: Text(value),
  //                                       );
  //                                     }).toList(),
  //                                     onChanged: (val) {
  //                                       currentValue = val!;
  //                                       ageFilter = true;
  //                                       print('$currentValue -- $val');
  //                                       setStat(() {});
  //                                     },
  //                                     alignment: Alignment.center,
  //                                     hint: Text("${ageFilter ? currentValue : ''}"),
  //                                   ),
  //                                 )
  //                               ],
  //                             );
  //                           },
  //                         ),
  //                         addVerticalSpace(height * 0.01),
  //                         Row(
  //                           children: [
  //                             Text("by profession : "),
  //                             Spacer(),
  //                             Container(
  //                               width: width * 0.35,
  //                               child: CustomTextFieldWidget(
  //                                 labelText: 'profession',
  //                                 controller: profController,
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                         addVerticalSpace(height * 0.07),
  //                         SizedBox(
  //                           width: width * 0.4,
  //                           child: CustomButton(
  //                               name: 'Filter',
  //                               onPressed: () {
  //                                 getFilteredFriendInVicinityList();
  //                               }),
  //                         ),
  //                         addVerticalSpace(height * 0.01),
  //                         SizedBox(
  //                           width: width * 0.4,
  //                           child: CustomButton(
  //                               name: 'Clear Filter',
  //                               onPressed: () {
  //                                 setState(() {
  //                                   locController.clear();
  //                                   profController.clear();
  //                                   ageFilter = false;
  //                                   currentValue = '25';
  //                                 });
  //                                 getFriendInVicinityList();
  //                               }),
  //                         )
  //                       ],
  //                     ));
  //               },
  //             ),
  //           ));
  // }

  getTripFriend() async {
    //   var x = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    //   List tfUIDs = x.data()!['tripFriends'] ?? [];
    //   var y = await FirebaseFirestore.instance.collection('users').get();
    //   for (var element in y.docs) {
    //     for (var tf in tfUIDs) {
    //       if (element.data()['UID'] == tf) {
    //         tripFriend.add(element.data());
    //       }
    //     }
    //   }

    //}
    var x = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    List tfUIDs = x.data()!['tripFriends'] ?? [];
    List _allUsers = [];
    var y = await FirebaseFirestore.instance.collection('users').get();

    for (var element in y.docs) {
      _allUsers.add(element.data());
      for (var tf in tfUIDs) {
        if (element.data()['UID'] == tf) {
          tripFriend.add(element.data());
        }
      }
    }
    setState(() {
      listo = _allUsers;
      // print(_allUsers);
    });
  }
}

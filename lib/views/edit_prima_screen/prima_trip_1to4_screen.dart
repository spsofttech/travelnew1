import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelnew_app/views/edit_prima_screen/edit_prima_trip_screen.dart';
import 'package:travelnew_app/views/edit_prima_screen/entertainment_screen.dart';
import 'package:travelnew_app/views/edit_prima_screen/place_visiting_screen.dart';
import 'package:travelnew_app/views/edit_prima_screen/trip_members_screen.dart';
import 'package:travelnew_app/widget/custom_button.dart';

import '../../utils/constant.dart';
import '../../widget/custom_textfield.dart';
import '../../widget/my_bottom_navbar.dart';
import '../humburger_flow/my_account/my_trip_friends.dart';
import '../humburger_flow/my_account/report_incorrect_user_screen.dart';

class PrimaTrip1To4Screens extends StatefulWidget {
  const PrimaTrip1To4Screens({super.key});

  @override
  State<PrimaTrip1To4Screens> createState() => _PrimaTrip1To4ScreensState();
}

class _PrimaTrip1To4ScreensState extends State<PrimaTrip1To4Screens> {
  List mainIconTabbar = [
    {
      'icon': Icon(
        Icons.people_rounded,
        color: black,
        size: 25,
      ),
      'name': 'Trip Members',
    },
    {
      'icon': Icon(
        Icons.route_outlined,
        color: black,
        size: 25,
      ),
      'name': 'Places visiting',
    },
    {
      'icon': Icon(
        Icons.image_outlined,
        color: black,
        size: 25,
      ),
      'name': 'Entertainment',
    },
    {
      'icon': Icon(
        Icons.tiktok_outlined,
        color: black,
        size: 25,
      ),
      'name': 'What to bring',
    },
  ];

  String tripName = "";
  String tripAddress = "";
  String aboutTrip = "";
  String tripImage = "";
  String startDate = "";
  String endDate = "";

  void getdata() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Prima_Trip_Plan")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      tripName = profile.data()?['Specify_trip_name'];
      tripAddress = profile.data()?['where_to'];
      aboutTrip = profile.data()?['Include in trip'];
      tripImage = profile.data()?['Cover_Pic'];
      startDate = profile.data()?['start_date'];
      endDate = profile.data()?['End_date'];

      setState(() {});
    }
    //setState(() {});
  }

  void deletetrip() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Prima_Trip_Plan")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();
      setState(() {});
    }
  }

  Widget Edit() {
    return Text.rich(TextSpan(children: [
      WidgetSpan(
          child: Icon(
        Icons.edit,
        color: Colors.yellow,
      )),
      WidgetSpan(
          child: SizedBox(
        width: 10,
      )),
      TextSpan(text: "Edit Trip")
    ]));
  }

  Widget Delete() {
    return Text.rich(TextSpan(children: [
      WidgetSpan(
          child: Icon(
        Icons.delete,
        color: Colors.yellow,
      )),
      WidgetSpan(
          child: SizedBox(
        width: 10,
      )),
      TextSpan(text: "Delete/Detach trip")
    ]));
  }

  Widget OtherHost() {
    return Text.rich(TextSpan(children: [
      WidgetSpan(
        child: Icon(
          Icons.start,
          color: Colors.yellow,
        ),
      ),
      WidgetSpan(
          child: SizedBox(
        width: 10,
      )),
      TextSpan(text: "Make another host")
    ]));
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height(context) * 0.32,
              width: double.infinity,
              decoration: tripImage == ""
                  ? BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/editprima2.png')))
                  : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(tripImage))),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: white,
                            )),
                        const Spacer(),
                        // Image.asset('assets/images/arrowforward.png',
                        //     color: white),
                        // addHorizontalySpace(15),
                        // Image.asset('assets/images/msg.png', color: white),
                        // IconButton(
                        //     onPressed: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (ctx) =>
                        //                   const EditPrimaTripScreen()));
                        //     },
                        //     icon: Icon(
                        //       Icons.edit,
                        //       color: white,
                        //     ))
                        PopupMenuButton(
                            // add icon, by default "3 dot" icon,
                            iconSize: 32,
                            icon: Icon(Icons.more_vert_outlined, color: primary),
                            color: Colors.white,
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem<int>(
                                  value: 0,
                                  child: Edit(),
                                ),
                                PopupMenuItem<int>(
                                  value: 1,
                                  child: Delete(),
                                ),
                                PopupMenuItem<int>(
                                  value: 2,
                                  child: OtherHost(),
                                ),
                              ];
                            },
                            onSelected: (value) {
                              if (value == 0) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditPrimaTripScreen()));
                              } else if (value == 1) {
                                deletetrip();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MyBottomBar()));
                              } else if (value == 2) {
                                hostDialog(context);
                              }
                            })
                      ],
                    ),
                    addVerticalSpace(height(context) * 0.15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 20, bottom: 20),
                          height: 25,
                          width: width(context) * 0.4,
                          decoration: myFillBoxDecoration(0, primary, 50),
                          child: Center(
                            child: Text('$endDate'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$tripName',
                    style: bodyText30W600(color: black),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primary,
                      ),
                      Text(
                        '$tripAddress',
                        style: bodyText16normal(color: black),
                      )
                    ],
                  ),
                  addVerticalSpace(10),
                  DescriptionTextWidget(text: aboutTrip),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(text: '$aboutTrip', style: TextStyle(fontSize: 16, height: 1.4, color: black)),
                    // TextSpan(
                    //     text: ' more',
                    //     style: TextStyle(
                    //         decoration: TextDecoration.underline,
                    //         fontSize: 16,
                    //         color: primary,
                    //         fontWeight: FontWeight.w600))
                  ])),
                ],
              ),
            ),
            SizedBox(
                height: height(context) * 0.08,
                child: ListView.builder(
                    itemCount: mainIconTabbar.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, i) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              selectIndex = i;
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              height: height(context) * 0.05,
                              width: selectIndex == i ? width(context) * 0.35 : width(context) * 0.13,
                              decoration: selectIndex == i ? myFillBoxDecoration(0, primary, 10) : shadowDecoration(10, 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  mainIconTabbar[i]['icon'],
                                  addHorizontalySpace(5),
                                  selectIndex == i ? Text(mainIconTabbar[i]['name']) : const SizedBox()
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    })),
            if (selectIndex == 0)
              TripMembersTabPrimaProfile(tripData: {
                'tripImage': tripImage,
                'host': USER_UID,
                'tripName': tripName,
                'addres': tripAddress,
              }, isHost: true, onlyFriends: true),
            if (selectIndex == 1) PlaceVisitingScreen(),
            if (selectIndex == 2) EntertainmentTab(hostId: USER_UID),
            if (selectIndex == 3) const WhatToBringTab(),
          ],
        ),
      ),
      // bottomNavigationBar:
      //     SizedBox(height: 60, child: CustomRequestToJoinButton()),
    );
  }
}

hostDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            contentPadding: const EdgeInsets.all(6),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Builder(
              builder: (context) {
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;

                return Container(
                  height: 300,
                  child: Center(
                      child: Text(
                    'You are making another member host of this trip also you might not be the host again for this trip',
                    style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),
                  )),
                );
              },
            ),
          ));
}

class WhatToBringTab extends StatefulWidget {
  const WhatToBringTab({super.key});

  @override
  State<WhatToBringTab> createState() => _WhatToBringTabState();
}

class _WhatToBringTabState extends State<WhatToBringTab> {
  // CollectionReference _collectionRef = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .collection('Prima_Trip_Plan')
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .collection('items');

  // Future<void> getallIteamsData() async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await _collectionRef.get();
  //   // Get data from docs and convert map to List
  //   allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   setState(() {});
  //
  //   for (int i = 0; i <= allData.length; i++) {
  //     sum = sum + int.parse(allData[i]['iteamAmout']);
  //   }
  //
  //   //print(allData);
  // }

  int sum = 0;
  //List allData = [];

  // String hostname = "";
  // String image = "";

  // void getPrimaDeatials() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     var profile =
  //         await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('primaAccount').doc('profile').get();
  //     hostname = profile.data()?['fullName'];
  //     image = profile.data()?['imageUrl'];
  //     setState(() {});
  //   }
  // }

  Future removeItem({required Map removeMap}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Prima_Trip_Plan")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "items": FieldValue.arrayRemove([removeMap])
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpace(10),
          Row(
            children: [
              Text(
                'What to Bring',
                style: bodyText16w600(color: black),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  addItems(context);
                  //saveItemforTravel(context);
                },
                child: Icon(
                  Icons.edit,
                ),
              )
            ],
          ),
          addVerticalSpace(15),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("Prima_Trip_Plan")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List items = snapshot.data!.data()!['items'] ?? [];
                sum = 0;
                items.forEach((element) {
                  sum = sum + int.parse(element['iteamAmout']);
                });
                // items.forEach((element) {sum=sum+})
                print(items);
                return Column(
                  children: [
                    for (int i = 0; i < items.length; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTapDown: (detail) {
                              overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
                              tapXY = detail.globalPosition;
                              showMenu(context: context, position: relRectSize, items: [
                                PopupMenuItem(
                                    onTap: () {
                                      removeItem(removeMap: items[i]);
                                    },
                                    child: Text("Delete"))
                              ]);
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: items[i]['user']['userImage'] == ""
                                      ? BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(NoUserNetworkImage)))
                                      : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(items[i]['user']['userImage']))),

                                  // myFillBoxDecoration(
                                  //     0, black.withOpacity(0.2), 50),
                                ),
                              ),
                              title: Text(
                                '${items[i]['user']['name']}',
                                style: bodyText16w600(color: black),
                              ),
                              subtitle: Text(items[i]['itemName']),
                              trailing: Text('Rs. ${items[i]['iteamAmout']}'),
                            ),
                          ),
                          addVerticalSpace(10),
                          Text(
                            '${items[i]['dis']}',
                            style: TextStyle(height: 1.3),
                          ),
                          addVerticalSpace(15),
                        ],
                      )
                  ],
                );
              } else {
                return SizedBox();
              }
            },
          ),
          Row(
            children: [
              Spacer(),
              Text(
                'Total    Rs. $sum',
                style: bodyText16w600(color: black),
              )
            ],
          ),
          Text(
            'How Spends are distributed',
            style: bodyText14w600(color: black),
          ),
          addVerticalSpace(3),
          Text(
            'Each for him/her self',
            style: bodyText12Small(color: black),
          ),
          addVerticalSpace(height(context) * 0.1)
        ],
      ),
    );
  }

  // var i = 0;
  // void deleteIteam() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     var profile = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection("Prima_Trip_Plan")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('items')
  //         .doc(allData[i]['uid'])
  //         .delete();
  //   }
  //   setState(() {});
  // }

  //final items = [];
  String _string = 'Take on rent';

  // Future<void> saveItemforTravel(BuildContext context) {
  //   return showDialog<void>(
  //     // isScrollControlled: true,
  //
  //     context: context,
  //     // shape: RoundedRectangleBorder(
  //     //   borderRadius: BorderRadius.circular(20.0),
  //     // ),
  //     builder: (BuildContext context) {
  //       return SizedBox(
  //         height: height(context) * 0.5,
  //         child: Material(
  //           type: MaterialType.card,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(20.0),
  //           ),
  //           child: StatefulBuilder(builder: (context, setState) {
  //             return Container(
  //                 padding: EdgeInsets.all(12),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     // Row(
  //                     //   children: [
  //                     //     Spacer(),
  //                     //   ],
  //                     // ),
  //                     addVerticalSpace(height(context) * 0.02),
  //                     Text(
  //                       'What to bring for trip',
  //                       style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  //                     ),
  //                     addVerticalSpace(20),
  //                     Center(
  //                       child: Container(
  //                         height: height(context) * 0.15,
  //                         width: width(context) * 0.90,
  //                         decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 10),
  //                       ),
  //                     ),
  //                     addVerticalSpace(20),
  //                     Text(
  //                       'Save items that you wish to have it for trip',
  //                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                     ),
  //                     addVerticalSpace(30),
  //                     // SizedBox(
  //                     //   height: height(context) * 0.20,
  //                     //   width: width(context) * 0.95,
  //                     //   child: ListView.builder(
  //                     //       itemCount: allData.length,
  //                     //       itemBuilder: (ctx, i) {
  //                     //         return Padding(
  //                     //           padding: const EdgeInsets.only(right: 8, left: 8),
  //                     //           child: Column(children: [
  //                     //             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                     //               SizedBox(
  //                     //                 height: 40,
  //                     //                 child: Column(
  //                     //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                     //                   children: [
  //                     //                     Text(
  //                     //                       allData[i]['itemName'],
  //                     //                       style: bodyText14w600(color: black),
  //                     //                     ),
  //                     //                   ],
  //                     //                 ),
  //                     //               ),
  //                     //               SizedBox(
  //                     //                 height: 50,
  //                     //                 child: Column(
  //                     //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                     //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     //                   children: [
  //                     //                     Row(children: [
  //                     //                       Text(allData[i]['itemType']),
  //                     //                       Icon(
  //                     //                         Icons.arrow_drop_down_outlined,
  //                     //                         color: primary,
  //                     //                       ),
  //                     //                     ]),
  //                     //                   ],
  //                     //                 ),
  //                     //               ),
  //                     //               Padding(
  //                     //                 padding: const EdgeInsets.only(right: 10),
  //                     //                 child: SizedBox(
  //                     //                   height: 40,
  //                     //                   child: Column(
  //                     //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     //                     children: [
  //                     //                       Text(
  //                     //                         allData[i]['iteamAmout'],
  //                     //                         style: bodyText14w600(color: black),
  //                     //                       ),
  //                     //                     ],
  //                     //                   ),
  //                     //                 ),
  //                     //               ),
  //                     //               IconButton(
  //                     //                   onPressed: () {
  //                     //                     setState(() {});
  //                     //                     deleteIteam();
  //                     //                   },
  //                     //                   icon: Icon(Icons.delete)),
  //                     //             ]),
  //                     //           ]),
  //                     //         );
  //                     //       }),
  //                     // ),
  //                     // addVerticalSpace(15),
  //                     // Row(
  //                     //   children: [
  //                     //     addHorizontalySpace(120),
  //                     //     Text(
  //                     //       'Total',
  //                     //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  //                     //     ),
  //                     //     addHorizontalySpace(80),
  //                     //     Text('$sum', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
  //                     //   ],
  //                     // ),
  //                     // addVerticalSpace(50),
  //                     Row(
  //                       children: [
  //                         addHorizontalySpace(25),
  //                         SizedBox(
  //                           width: 140,
  //                           child: CustomButton(
  //                               name: 'Save',
  //                               onPressed: () {
  //                                 setState(() {});
  //                                 Navigator.pop(context);
  //                                 // updateitemacarry();
  //                               }),
  //                         ),
  //                         addHorizontalySpace(60),
  //                         SizedBox(
  //                           width: 140,
  //                           child: CustomButton(
  //                               name: 'Add items',
  //                               onPressed: () {
  //                                 setState(() {});
  //                                 // Navigator.pop(context);
  //                                 addItems(context);
  //                               }),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ));
  //           }),
  //         ),
  //       );
  //     },
  //   );
  // }

  //final String friendUid = "";

  RelativeRect get relRectSize => RelativeRect.fromSize(tapXY & const Size(40, 40), overlay.size);
  late Offset tapXY;
  // ↓ hold screen size, using first line in build() method
  late RenderBox overlay;
  // ↓ get the tap position Offset
  void getPosition(TapDownDetails detail) {
    print("----");
    overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    tapXY = detail.globalPosition;
    //  showMenu(context: context, position: relRectSize, items: [PopupMenuItem(onTap: () {}, child: Text("Delete"))]);
  }

  Future<void> addItems(BuildContext context) async {
    // RxString selectedUserName = "Select Friend".obs;
    //Map selectedUserMap = {};
    final TextEditingController iteamcontroller = TextEditingController();
    final TextEditingController amountcontroller = TextEditingController();
    final TextEditingController disController = TextEditingController();

    addIteamDetails() async {
      if (FirebaseAuth.instance.currentUser != null) {
        DocumentReference profile = FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("Prima_Trip_Plan")
            .doc(FirebaseAuth.instance.currentUser!.uid);
        await profile.update({
          'items': FieldValue.arrayUnion([
            {
              "itemName": iteamcontroller.text,
              "itemType": _string,
              "user": {'name': USERNAME, 'uid': USER_UID, 'userImage': USERIMAGE},
              "iteamAmout": amountcontroller.text,
              'dis': disController.text
            }
          ])
        });
        // setState(() {});
      }
      Navigator.pop(context);
    }

    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return Container(
            padding: EdgeInsets.all(12),
            height: height(context) * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: black,
                        ))
                  ],
                ),
                CustomTextFieldWidget(
                  //itemList: tripLocation,
                  controller: iteamcontroller,
                  labelText: 'Enter your item',
                ),
                addVerticalSpace(20),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                          top: BorderSide(
                            color: Colors.black,
                          ),
                          bottom: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(10),
                      value: _string,
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _string = newValue!;
                        });
                      },
                      items: ['Take on rent', 'Carry while travel', 'Buy while travel']
                          .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: bodytext12Bold(color: black),
                                ),
                              ))
                          .toList(),

                      // add extra sugar..
                      icon: const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Icon(
                          Icons.arrow_drop_down,
                        ),
                      ),
                      iconSize: 25,
                      iconEnabledColor: primary,
                      iconDisabledColor: black.withOpacity(0.7),
                      underline: const SizedBox(),
                    ),
                  ),
                ),
                addVerticalSpace(20),
                CustomTextFieldWidget(
                  //itemList: tripLocation,
                  controller: disController,
                  labelText: 'Enter your item Discription',
                ),
                // addVerticalSpace(20),
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       border: Border(
                //           top: BorderSide(
                //             color: Colors.black,
                //           ),
                //           bottom: BorderSide(color: Colors.black),
                //           right: BorderSide(color: Colors.black),
                //           left: BorderSide(color: Colors.black))),
                //   child: StreamBuilder(
                //     stream: FirebaseFirestore.instance
                //         .collection('users')
                //         .doc(FirebaseAuth.instance.currentUser!.uid)
                //         .collection("Prima_Trip_Plan")
                //         .doc(FirebaseAuth.instance.currentUser!.uid)
                //         .snapshots(),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         List tripMember = snapshot.data!.data()!['friends'];
                //         tripMember = tripMember.where((element) => element['status'] == 1).toList();
                //         List requestMember = snapshot.data!.data()!['friends'];
                //         requestMember = requestMember.where((element) => element['status'] == 0).toList();
                //         return Padding(
                //           padding: EdgeInsets.only(left: 20),
                //           child: Obx(() => DropdownButton(
                //                 borderRadius: BorderRadius.circular(10),
                //                 // value: tripMember[0]['name'],
                //                 hint: Text("${selectedUserName.value}"),
                //                 isExpanded: true,
                //                 onChanged: (newValue) {
                //                   selectedUserName.value = newValue!;
                //                 },
                //                 items: tripMember
                //                     .map<DropdownMenuItem<String>>((value) => DropdownMenuItem(
                //                           onTap: () {
                //                             selectedUserMap = value;
                //                           },
                //                           value: value['name'],
                //                           child: Text(
                //                             value['name'],
                //                             style: bodytext12Bold(color: black),
                //                           ),
                //                         ))
                //                     .toList(),
                //
                //                 // add extra sugar..
                //                 icon: const Padding(
                //                   padding: EdgeInsets.only(bottom: 8.0),
                //                   child: Icon(
                //                     Icons.arrow_drop_down,
                //                   ),
                //                 ),
                //                 iconSize: 25,
                //                 iconEnabledColor: primary,
                //                 iconDisabledColor: black.withOpacity(0.7),
                //                 underline: const SizedBox(),
                //               )),
                //         );
                //       } else {
                //         return SizedBox();
                //       }
                //     },
                //   ),
                // ),
                addVerticalSpace(20),
                CustomTextFieldWidget(
                  kebordType: TextInputType.number,
                  //itemList: tripLocation,
                  controller: amountcontroller,
                  labelText: 'Enter your amount',
                ),
                addVerticalSpace(30),
                CustomButton(
                    name: 'Save',
                    onPressed: () {
                      // setState(() {});
                      // Navigator.pop(context);
                      if (iteamcontroller.text.isNotEmpty && amountcontroller.text.isNotEmpty) {
                        addIteamDetails();
                      } else {
                        showSimpleTost(context, txt: "Please Fil all details");
                      }
                    })
              ],
            ));
      },
    );
  }
}

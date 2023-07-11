import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelnew_app/views/aspired_trip/aspired_trip_details_screen.dart';
import 'package:travelnew_app/widget/custom_appbar.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/widget/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/db/firebaseDB.dart';
import '../../utils/constant.dart';
import 'package:travelnew_app/views/start/signup_with_social_media_screen.dart';
import 'package:travelnew_app/views/humburger_flow/trip_library_screen.dart';

var _count = 0;
void getCount(_count) async {
  SharedPreferences counter = await SharedPreferences.getInstance();
  counter.setInt('count', _count);
}

class aspiredScreen extends StatefulWidget {
  const aspiredScreen({super.key});

  @override
  State<aspiredScreen> createState() => _aspiredScreen();
}

class _aspiredScreen extends State<aspiredScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  bool isShow = false;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: isShow
            ? CustomTextFieldWidget(labelText: '  Search  ')
            : Text(
                'Touch Nature at Hills',
                style: bodyText20w700(color: black),
              ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isShow = !isShow;
                });
              },
              icon: Icon(
                Icons.search,
                color: black,
              ))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: height(context) * 0.88,
            child: Column(
              children: [
                addVerticalSpace(5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TabBar(
                    padding: EdgeInsets.zero,
                    // labelPadding: EdgeInsets.zero,
                    // indicatorPadding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: Colors.grey,
                    controller: _tabController,
                    onTap: (value) {},
                    isScrollable: true,
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
                        text: 'Aspired Trip',
                      ),
                      Tab(
                        text: 'Festival Trip',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(controller: _tabController, children: const [
                    AspiredTrip2Screen(),
                    AspiredTrip2Screen(),
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AspiredTrip2Screen extends StatefulWidget {
  const AspiredTrip2Screen({super.key});

  @override
  State<AspiredTrip2Screen> createState() => _AspiredTrip2ScreenState();
}

class _AspiredTrip2ScreenState extends State<AspiredTrip2Screen> {
  bool isShow = false;

  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('Aspired_trips');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {});
    print(allData);
  }

  List allData = [];

  // String _destination = "";
  // String _state ="";
  // String _tripdays ="";
  // String _excerpttrip ="";
  // String _budget ="";
  // String _image ="";
  // String _tripname ="";
  //
  // void getDetails() async{
  //     var trip = await FirebaseFirestore.instance
  //         .collection('Aspired_trips')
  //         .doc('Trip1')
  //         .get();
  //     _destination = trip.data()?['destinationname'];
  //      _state = trip.data()?['statename'];
  //      _tripdays = trip.data()?['tripdays'];
  //      _excerpttrip = trip.data()?['Excerpt_of_trip'];
  //      _budget = trip.data()?['Budget'];
  //      _image = trip.data()?['imageUrl'];
  //      _tripname = trip.data()?['tripname'];
  //   setState(() {});
  // }

  String _id = "";
  String _location = "";
  String _subtitle = "";
  String _title = "";
  String _imagee = "";
  bool isBookmarked = false;
  List Bookmarklist = [];
  void bookmark() {
    if (isBookmarked) {
      Bookmarklist.removeAt(Bookmarklist.indexOf(['postID']));
      // CollectionReference users = FirebaseFirestore.instance
      //     .collection('users');
      // users
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .collection("bookmarks")
      //     .add({
      //   'id': _id,
      //   'image': _imagee,
      //   'location':_location,
      //   'subtitle':_subtitle,
      //   'title':_title,
      // });
      // setState(() {
      //   isBookmarked = !isBookmarked;
      // });
    } else {
      Bookmarklist.add(context);
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      users.doc(FirebaseAuth.instance.currentUser!.uid).collection("bookmarks").add({
        'id': _id,
        'image': _imagee,
        'location': _location,
        'subtitle': _subtitle,
        'title': _title,
      });
      // setState(() {
      // });
    }
  }

  @override
  void initState() {
    // getDetails();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AspiredTripDetailsScreen(
                                        MP: allData[i],
                                      )));
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupWithSocialMediaScreen(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: height(context) * 0.450,
                        width: width(context) * 0.95,
                        decoration: shadowDecoration(15, 0.2),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                    child: Image.network(allData[i]['imageUrl'])),
                                Positioned(
                                  top: -5,
                                  right: -5,
                                  child: IconButton(
                                      onPressed: () async {
                                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>TripLibraryScreen()));
                                        // bookmark();
                                        if (!isBookmarked) {
                                          Bookmarklist.add(context);
                                          DocumentReference users = FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                              .collection("bookmarks")
                                              .doc();
                                          users.set({
                                            'id': _id,
                                            "postID": users.id,
                                            'image': _imagee,
                                            'location': _location,
                                            'subtitle': _subtitle,
                                            'title': _title,
                                          });
                                        } else {
                                          var trip = await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                              .collection('bookmarks')
                                              .doc()
                                              .get();
                                          var docID = trip.data()?['docID'];
                                          FirebaseDB().removeBookmark(docID);
                                        }
                                        setState(() {
                                          isBookmarked = !isBookmarked;
                                        });
                                      },
                                      icon: !isBookmarked
                                          ? Icon(
                                              Icons.bookmark_border,
                                              color: white,
                                            )
                                          : const Icon(Icons.bookmark)),
                                ),
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: Container(
                                      height: height(context) * 0.04,
                                      width: width(context) * 0.95,
                                      padding: EdgeInsets.only(left: 5),
                                      color: black.withOpacity(0.5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width(context) * 0.88,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_rounded,
                                                  color: primary,
                                                  size: 20,
                                                ),
                                                addHorizontalySpace(5),
                                                Row(
                                                  children: [
                                                    Text(
                                                      allData[i]['destinationname'],
                                                      style: TextStyle(fontWeight: FontWeight.w500, color: white),
                                                    ),
                                                    Text(
                                                      allData[i]['statename'],
                                                      style: TextStyle(fontWeight: FontWeight.w500, color: white),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    Text(
                                                      allData[i]['tripdays'],
                                                      style: bodyText14w600(color: Colors.yellow),
                                                    ),
                                                    Text(
                                                      '  Days',
                                                      style: bodyText14w600(color: Colors.yellow),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          allData[i]['tripname'],
                                          style: bodyText22w700(color: black),
                                        ),
                                        addVerticalSpace(10),
                                        Text(
                                          allData[i]['Excerpt_of_trip'],
                                          style: bodyText14normal(color: black),
                                        ),
                                        addVerticalSpace(4),
                                        Row(
                                          children: [
                                            Text(
                                              'Expected ₹: ',
                                              style: bodyText14w600(color: black),
                                            ),
                                            Text(
                                              allData[i]['Budget'],
                                              style: bodyText14w600(color: black),
                                            ),
                                            Text(
                                              ' /per person',
                                              style: bodyText14w600(color: black),
                                            ),
                                            Spacer(),
                                            TextButton(child: Text('get quotes'), onPressed: () {})
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}

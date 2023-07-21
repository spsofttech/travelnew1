import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelnew_app/model/save_trip_model.dart';
import 'package:travelnew_app/services/db/firebaseDB.dart';
import 'package:travelnew_app/views/aspired_trip/travel_agency_details.dart';
import 'package:travelnew_app/views/humburger_flow/tourist_spot_screen.dart';
import 'package:travelnew_app/views/humburger_flow/trip_map_screen.dart';
import 'package:travelnew_app/views/humburger_flow/upcoming_trips.dart';
import 'package:travelnew_app/views/save_your_trips/bookmarkedTrips.dart';
import 'package:travelnew_app/views/save_your_trips/save_your_trips.dart';
import 'package:travelnew_app/widget/custom_button.dart';

import '../../model/DayWiseTripModel.dart';
import '../../utils/constant.dart';
import '../edit_prima_screen/prima_trip_1to4_screen.dart';
import '../edit_prima_screen/trip_members_screen.dart';

class TripLibraryScreen extends StatefulWidget {
  const TripLibraryScreen({super.key});

  @override
  State<TripLibraryScreen> createState() => _TripLibraryScreenState();
}

class _TripLibraryScreenState extends State<TripLibraryScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // getDummyTrip01();
    // getDummyTrip02();
    // getDummyTrip03();
    // getdata1();
    //getdata2();
    //getdata3();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  //---------Get-Trip-Dummy-Data----------//
  String _title = "";
  String _subtitle = "";
  String _image = "";
  String _location = "";
  var dockID = '';

  void getDummyTrip01() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var dummy = await FirebaseFirestore.instance.collection('dummyTrips').doc('2Xhglp1fUkvx3AGV6aQA').get();
      _title = dummy.data()?['title'];
      _subtitle = dummy.data()?['subtitle'];
      _image = dummy.data()?['image'];
      _location = dummy.data()?['location'];
      print(dummy);
    }
  }

  void getDummyTrip02() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var dummy = await FirebaseFirestore.instance.collection('dummyTrips').doc('AkwzekaiFE2orxmnBfoF').get();
      _title = dummy.data()?['title'];
      _subtitle = dummy.data()?['subtitle'];
      _image = dummy.data()?['image'];
      _location = dummy.data()?['location'];
      print(dummy);
    }
  }

  void getDummyTrip03() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var dummy = await FirebaseFirestore.instance.collection('dummyTrips').doc('fLNR63XQmrUNW9ng5yQ2').get();
      _title = dummy.data()?['title'];
      _subtitle = dummy.data()?['subtitle'];
      _image = dummy.data()?['image'];
      _location = dummy.data()?['location'];
      print(dummy);
    }
  }

  CollectionReference dummyFuture = FirebaseFirestore.instance.collection('dummyTrips');

  bool isBookmarked = true;

  String _image1 = "";
  String _location1 = "";
  String _subtitle1 = "";
  String _title1 = "";
  String _cartime1 = "";
  String _traintime1 = "";
  List UserFriendPrimaTrips = [];
  List ReuestTripData = [];
  void getdata1() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var tirp1 = await FirebaseFirestore.instance.collection('dummyTrips').doc('2Xhglp1fUkvx3AGV6aQA').get();
      _image1 = tirp1.data()?['image'];
      _location1 = tirp1.data()?['location'];
      _subtitle1 = tirp1.data()?['subtitle'];
      _title1 = tirp1.data()?['title'];
      _cartime1 = tirp1.data()?['carTime'];
      _traintime1 = tirp1.data()?['trainTime'];
    }
    setState(() {});
  }

  String _image2 = "";
  String _location2 = "";
  String _subtitle2 = "";
  String _title2 = "";
  String _cartime2 = "";
  String _traintime2 = "";

  // void getdata2() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     var tirp1 = await FirebaseFirestore.instance.collection('dummyTrips').doc('AkwzekaiFE2orxmnBfoF').get();
  //     _image2 = tirp1.data()?['image'];
  //     _location2 = tirp1.data()?['location'];
  //     _subtitle2 = tirp1.data()?['subtitle'];
  //     _title2 = tirp1.data()?['title'];
  //     _cartime2 = tirp1.data()?['carTime'];
  //     _traintime2 = tirp1.data()?['trainTime'];
  //   }
  //   setState(() {});
  // }

  String _image3 = "";
  String _location3 = "";
  String _subtitle3 = "";
  String _title3 = "";
  String _cartime3 = "";
  String _traintime3 = "";

  // void getdata3() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     var tirp1 = await FirebaseFirestore.instance.collection('dummyTrips').doc('fLNR63XQmrUNW9ng5yQ2').get();
  //     _image3 = tirp1.data()?['image'];
  //     _location3 = tirp1.data()?['location'];
  //     _subtitle3 = tirp1.data()?['subtitle'];
  //     _title3 = tirp1.data()?['title'];
  //     _cartime3 = tirp1.data()?['carTime'];
  //     _traintime3 = tirp1.data()?['trainTime'];
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: black,
            )),
        backgroundColor: white,
        title: Text(
          'Trip Library',
          style: bodyText20w700(color: black),
        ),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => UpcomingTripsScreen()));
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 30,
                  width: width(context) * 0.16,
                  decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/upcomingicon2.png',
                        color: black,
                      ),
                      addHorizontalySpace(5),
                      Image.asset(
                        'assets/images/upcomingicon1.png',
                        color: black,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TabBar(
              padding: const EdgeInsets.all(10),
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
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),

              tabs: const [
                Tab(
                  text: 'Unsaved \n  Trips',
                ),
                Tab(
                  text: 'Invited/Requested \n            Trips',
                ),
                Tab(
                  text: 'Search\n  Trips',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              SizedBox(
                height: height(context) * 0.87,
                child: Column(
                  children: [
                    Expanded(
                        // height: height(context) * 0.79,
                        child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('trip library')
                          .doc('unsaved')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          ReuestTripData.clear();
                          ReuestTripData = snapshot.data!.data()!['data'];
                          return ListView.builder(
                              itemCount: ReuestTripData.length,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        showAPICallPendingDialog(context);
                                        log("${ReuestTripData[index]}");

                                        CollectionReference users = FirebaseFirestore.instance.collection('users');
                                        await users
                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                            .collection("Plan_trip")
                                            .doc(FirebaseAuth.instance.currentUser!.uid)
                                            .set({
                                          "StartTrip": ReuestTripData[index]['StartTrip'],
                                          "tripPlan": ReuestTripData[index]['tripPlan'],
                                          "endtrip": ReuestTripData[index]['endtrip'],
                                          "StartDate": ReuestTripData[index]['StartDate'],
                                          "EndDate": ReuestTripData[index]['EndDate'],
                                          "tripmode": ReuestTripData[index]['tripmode'],
                                          "totalDays": ReuestTripData[index]['totalDays'],
                                          "Flexible": ReuestTripData[index]['Flexible'],
                                          "BookingId": '',
                                          // "cityImage": _cityImage,
                                        });

                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) => SaveYourTripsScreen(
                                                        storedDataMap: {
                                                          'type_Of_Trip': ReuestTripData[index]['type_Of_Trip'],
                                                          'plamTrip_at': ReuestTripData[index]['plamTrip_at'],
                                                          'trip_days': ReuestTripData[index]['trip_days'],
                                                          'interestList': ReuestTripData[index]['interestList'],
                                                          'date': ReuestTripData[index]['date'],
                                                          "StartTrip": ReuestTripData[index]['StartTrip'],
                                                          "StartDate": ReuestTripData[index]['StartDate'],
                                                          "EndDate": ReuestTripData[index]['EndDate'],
                                                          "tripmode": ReuestTripData[index]['tripmode'],
                                                          "totalDays": ReuestTripData[index]['totalDays'],
                                                          "Flexible": ReuestTripData[index]['Flexible'],
                                                          // "cityImage": _cityImage,
                                                        },
                                                        type_Of_Trip: ReuestTripData[index]['type_Of_Trip'],
                                                        plamTrip_at: ReuestTripData[index]['plamTrip_at'],
                                                        trip_days: ReuestTripData[index]['trip_days'],
                                                        interestList: ReuestTripData[index]['interestList'])));

                                        // getData();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10, bottom: 5),
                                        height: height(context) * 0.35,
                                        width: width(context) * 0.93,
                                        decoration: shadowDecoration(15, 2),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                ClipRRect(
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                                    child: Image.asset('assets/images/beach.png')),
                                                // Positioned(
                                                //   top: 5,
                                                //   right: 40,
                                                //   child: IconButton(
                                                //       onPressed: () async {
                                                //         // Navigator.push(context, MaterialPageRoute(builder: (context)=>TripLibraryScreen()));
                                                //         //  bookmark();
                                                //         if (!isBookmarked) {
                                                //           List Bookmarklist = [];
                                                //           Bookmarklist.add(context);
                                                //           DocumentReference users = FirebaseFirestore.instance
                                                //               .collection('users')
                                                //               .doc(FirebaseAuth.instance.currentUser!.uid)
                                                //               .collection("bookmarks")
                                                //               .doc();
                                                //           String _id = "";
                                                //           String _imagee = "";
                                                //           users.set({
                                                //             'id': _id,
                                                //             "postID": users.id,
                                                //             'image': _imagee,
                                                //             'location': _location,
                                                //             'subtitle': _subtitle,
                                                //             'title': _title,
                                                //           });
                                                //         } else {
                                                //           var trip = await FirebaseFirestore.instance
                                                //               .collection('users')
                                                //               .doc(FirebaseAuth.instance.currentUser!.uid)
                                                //               .collection('bookmarks')
                                                //               .doc()
                                                //               .get();
                                                //           var docID = trip.data()?['docID'];
                                                //           FirebaseDB().removeBookmark(docID);
                                                //         }
                                                //         setState(() {
                                                //           isBookmarked = !isBookmarked;
                                                //         });
                                                //
                                                //         setState(() {
                                                //           isBookmarked = !isBookmarked;
                                                //         });
                                                //       },
                                                //       icon: !isBookmarked
                                                //           ? Icon(
                                                //               Icons.bookmark_border,
                                                //               color: Colors.black,
                                                //             )
                                                //           : const Icon(Icons.bookmark)),
                                                // ),
                                                // Positioned(
                                                //   top: 5,
                                                //   right: 5,
                                                //   child: IconButton(onPressed: () async {}, icon: Icon(Icons.more_vert)),
                                                // ),
                                                Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    child: Container(
                                                      height: height(context) * 0.06,
                                                      width: width(context) * 0.95,
                                                      padding: EdgeInsets.only(left: 5),
                                                      color: black.withOpacity(0.5),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.location_on_rounded,
                                                                color: primary,
                                                                size: 20,
                                                              ),
                                                              addHorizontalySpace(5),
                                                              Text(
                                                                '${ReuestTripData[index]['plamTrip_at']}',
                                                                style: TextStyle(fontWeight: FontWeight.w500, color: white),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ))
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${ReuestTripData[index]['type_Of_Trip']}',
                                                    style: bodyText22w700(color: black),
                                                  ),
                                                  addVerticalSpace(2),
                                                  // Text(
                                                  //   '$_subtitle2',
                                                  //   style: bodyText14normal(color: black),
                                                  // ),
                                                  // addVerticalSpace(5),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/cardrive.png',
                                                      ),
                                                      addHorizontalySpace(5),
                                                      SizedBox(
                                                        width: width(context) * 0.15,
                                                        child: Text(
                                                          '$_cartime2 hours',
                                                          style: bodytext12Bold(color: black),
                                                        ),
                                                      ),
                                                      Text(
                                                        '  |  ',
                                                        style: bodyText16normal(color: black),
                                                      ),
                                                      Image.asset(
                                                        'assets/images/train2.png',
                                                      ),
                                                      addHorizontalySpace(5),
                                                      SizedBox(
                                                        width: width(context) * 0.15,
                                                        child: Text(
                                                          '$_traintime2 hours',
                                                          style: bodytext12Bold(color: black),
                                                        ),
                                                      ),
                                                      Text(
                                                        '  |  ',
                                                        style: bodyText16normal(color: black),
                                                      ),
                                                      Image.asset(
                                                        'assets/images/flight.png',
                                                      ),
                                                      addHorizontalySpace(5),
                                                      SizedBox(
                                                        width: width(context) * 0.15,
                                                        child: Text(
                                                          'No direct flights',
                                                          style: bodytext12Bold(color: black),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ))
                  ],
                ),
              ),
              // Column(
              //   children: [
              //     Expanded(
              //         // height: height(context) * 0.79,
              //         child: ListView.builder(
              //             itemCount: 0,
              //             itemBuilder: (ctx, index) {
              //               return Column(
              //                 children: [
              //                   InkWell(
              //                     onTap: () {
              //                       // getData();
              //                       Navigator.push(context, MaterialPageRoute(builder: (context) => SaveYourTripsScreen()));
              //                     },
              //                     child: Container(
              //                       margin: EdgeInsets.only(top: 10, bottom: 5),
              //                       height: height(context) * 0.420,
              //                       width: width(context) * 0.93,
              //                       decoration: shadowDecoration(15, 2),
              //                       child: Column(
              //                         crossAxisAlignment: CrossAxisAlignment.start,
              //                         children: [
              //                           Stack(
              //                             children: [
              //                               ClipRRect(
              //                                   borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              //                                   child: Image.network(_image1)),
              //                               Positioned(
              //                                 top: 5,
              //                                 right: 40,
              //                                 child: IconButton(
              //                                     onPressed: () async {
              //                                       //  Navigator.push(context, MaterialPageRoute(builder: (context)=>TripLibraryScreen()));
              //                                       // bookmark();
              //                                       if (!isBookmarked) {
              //                                         List Bookmarklist = [];
              //                                         Bookmarklist.add(context);
              //                                         DocumentReference users = FirebaseFirestore.instance
              //                                             .collection('users')
              //                                             .doc(FirebaseAuth.instance.currentUser!.uid)
              //                                             .collection("bookmarks")
              //                                             .doc();
              //                                         String _id = "";
              //                                         String _imagee = "";
              //                                         users.set({
              //                                           'id': _id,
              //                                           "postID": users.id,
              //                                           'image': _imagee,
              //                                           'location': _location,
              //                                           'subtitle': _subtitle,
              //                                           'title': _title,
              //                                         });
              //                                       } else {
              //                                         var trip = await FirebaseFirestore.instance
              //                                             .collection('users')
              //                                             .doc(FirebaseAuth.instance.currentUser!.uid)
              //                                             .collection('bookmarks')
              //                                             .doc()
              //                                             .get();
              //                                         var docID = trip.data()?['docID'];
              //                                         FirebaseDB().removeBookmark(docID);
              //                                       }
              //                                       setState(() {
              //                                         isBookmarked = !isBookmarked;
              //                                       });
              //                                     },
              //                                     icon: !isBookmarked
              //                                         ? Icon(
              //                                             Icons.bookmark_border,
              //                                             color: white,
              //                                           )
              //                                         : const Icon(Icons.bookmark)),
              //                               ),
              //                               Positioned(
              //                                 top: 5,
              //                                 right: 5,
              //                                 child: IconButton(onPressed: () async {}, icon: Icon(Icons.more_vert)),
              //                               ),
              //                               Positioned(
              //                                   bottom: 0,
              //                                   left: 0,
              //                                   child: Container(
              //                                     height: height(context) * 0.06,
              //                                     width: width(context) * 0.95,
              //                                     padding: EdgeInsets.only(left: 5),
              //                                     color: black.withOpacity(0.5),
              //                                     child: Column(
              //                                       mainAxisAlignment: MainAxisAlignment.center,
              //                                       crossAxisAlignment: CrossAxisAlignment.start,
              //                                       children: [
              //                                         Row(
              //                                           children: [
              //                                             Icon(
              //                                               Icons.location_on_rounded,
              //                                               color: primary,
              //                                               size: 20,
              //                                             ),
              //                                             addHorizontalySpace(5),
              //                                             Text(
              //                                               '$_location1',
              //                                               style: TextStyle(fontWeight: FontWeight.w500, color: white),
              //                                             ),
              //                                           ],
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ))
              //                             ],
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.all(10.0),
              //                             child: Column(
              //                               crossAxisAlignment: CrossAxisAlignment.start,
              //                               children: [
              //                                 Text(
              //                                   '$_title1',
              //                                   style: bodyText22w700(color: black),
              //                                 ),
              //                                 addVerticalSpace(2),
              //                                 Text(
              //                                   '$_subtitle1',
              //                                   style: bodyText14normal(color: black),
              //                                 ),
              //                                 addVerticalSpace(5),
              //                                 Row(
              //                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                                   children: [
              //                                     Image.asset(
              //                                       'assets/images/cardrive.png',
              //                                     ),
              //                                     addHorizontalySpace(5),
              //                                     SizedBox(
              //                                       width: width(context) * 0.15,
              //                                       child: Text(
              //                                         '$_cartime1 hours',
              //                                         style: bodytext12Bold(color: black),
              //                                       ),
              //                                     ),
              //                                     Text(
              //                                       '  |  ',
              //                                       style: bodyText16normal(color: black),
              //                                     ),
              //                                     Image.asset(
              //                                       'assets/images/train2.png',
              //                                     ),
              //                                     addHorizontalySpace(5),
              //                                     SizedBox(
              //                                       width: width(context) * 0.15,
              //                                       child: Text(
              //                                         '$_traintime1 hours',
              //                                         style: bodytext12Bold(color: black),
              //                                       ),
              //                                     ),
              //                                     Text(
              //                                       '  |  ',
              //                                       style: bodyText16normal(color: black),
              //                                     ),
              //                                     Image.asset(
              //                                       'assets/images/flight.png',
              //                                     ),
              //                                     addHorizontalySpace(5),
              //                                     SizedBox(
              //                                       width: width(context) * 0.15,
              //                                       child: Text(
              //                                         'No direct flights',
              //                                         style: bodytext12Bold(color: black),
              //                                       ),
              //                                     )
              //                                   ],
              //                                 )
              //                               ],
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               );
              //             }))
              //   ],
              // ),
              SizedBox(
                height: height(context) * 0.87,
                child: Column(
                  children: [
                    Expanded(
                        // height: height(context) * 0.79,
                        child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('trip library')
                          .doc('invite')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          ReuestTripData.clear();
                          ReuestTripData = snapshot.data!.data()!['data'];
                          return ListView.builder(
                              itemCount: ReuestTripData.length,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        log("${ReuestTripData[index]}");
                                        // getData();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => PrimaTrip1To4Screens(
                                                      isHost: ReuestTripData[index]['host'] == FirebaseAuth.instance.currentUser!.uid,
                                                      hostUid: ReuestTripData[index]['host'],
                                                      tripData: ReuestTripData[index],
                                                      showRequestTo_Join: ReuestTripData[index]['type'] == 'request' ? "" : "Accept Request",
                                                    )));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10, bottom: 5),
                                        height: height(context) * 0.40,
                                        width: width(context) * 0.93,
                                        decoration: shadowDecoration(15, 2),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                ClipRRect(
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                                    child: Image.network(ReuestTripData[index]['tripImage'])),
                                                // Positioned(
                                                //   top: 5,
                                                //   right: 40,
                                                //   child: IconButton(
                                                //       onPressed: () async {
                                                //         // Navigator.push(context, MaterialPageRoute(builder: (context)=>TripLibraryScreen()));
                                                //         //  bookmark();
                                                //         if (!isBookmarked) {
                                                //           List Bookmarklist = [];
                                                //           Bookmarklist.add(context);
                                                //           DocumentReference users = FirebaseFirestore.instance
                                                //               .collection('users')
                                                //               .doc(FirebaseAuth.instance.currentUser!.uid)
                                                //               .collection("bookmarks")
                                                //               .doc();
                                                //           String _id = "";
                                                //           String _imagee = "";
                                                //           users.set({
                                                //             'id': _id,
                                                //             "postID": users.id,
                                                //             'image': _imagee,
                                                //             'location': _location,
                                                //             'subtitle': _subtitle,
                                                //             'title': _title,
                                                //           });
                                                //         } else {
                                                //           var trip = await FirebaseFirestore.instance
                                                //               .collection('users')
                                                //               .doc(FirebaseAuth.instance.currentUser!.uid)
                                                //               .collection('bookmarks')
                                                //               .doc()
                                                //               .get();
                                                //           var docID = trip.data()?['docID'];
                                                //           FirebaseDB().removeBookmark(docID);
                                                //         }
                                                //         setState(() {
                                                //           isBookmarked = !isBookmarked;
                                                //         });
                                                //
                                                //         setState(() {
                                                //           isBookmarked = !isBookmarked;
                                                //         });
                                                //       },
                                                //       icon: !isBookmarked
                                                //           ? Icon(
                                                //               Icons.bookmark_border,
                                                //               color: Colors.black,
                                                //             )
                                                //           : const Icon(Icons.bookmark)),
                                                // ),
                                                // Positioned(
                                                //   top: 5,
                                                //   right: 5,
                                                //   child: IconButton(onPressed: () async {}, icon: Icon(Icons.more_vert)),
                                                // ),
                                                Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    child: Container(
                                                      height: height(context) * 0.06,
                                                      width: width(context) * 0.95,
                                                      padding: EdgeInsets.only(left: 5),
                                                      color: black.withOpacity(0.5),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.location_on_rounded,
                                                                color: primary,
                                                                size: 20,
                                                              ),
                                                              addHorizontalySpace(5),
                                                              Text(
                                                                '${ReuestTripData[index]['addres']}',
                                                                style: TextStyle(fontWeight: FontWeight.w500, color: white),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ))
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${ReuestTripData[index]['tripName']}',
                                                    style: bodyText22w700(color: black),
                                                  ),
                                                  addVerticalSpace(2),
                                                  // Text(
                                                  //   '$_subtitle2',
                                                  //   style: bodyText14normal(color: black),
                                                  // ),
                                                  // addVerticalSpace(5),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/cardrive.png',
                                                      ),
                                                      addHorizontalySpace(5),
                                                      SizedBox(
                                                        width: width(context) * 0.15,
                                                        child: Text(
                                                          '$_cartime2 hours',
                                                          style: bodytext12Bold(color: black),
                                                        ),
                                                      ),
                                                      Text(
                                                        '  |  ',
                                                        style: bodyText16normal(color: black),
                                                      ),
                                                      Image.asset(
                                                        'assets/images/train2.png',
                                                      ),
                                                      addHorizontalySpace(5),
                                                      SizedBox(
                                                        width: width(context) * 0.15,
                                                        child: Text(
                                                          '$_traintime2 hours',
                                                          style: bodytext12Bold(color: black),
                                                        ),
                                                      ),
                                                      Text(
                                                        '  |  ',
                                                        style: bodyText16normal(color: black),
                                                      ),
                                                      Image.asset(
                                                        'assets/images/flight.png',
                                                      ),
                                                      addHorizontalySpace(5),
                                                      SizedBox(
                                                        width: width(context) * 0.15,
                                                        child: Text(
                                                          'No direct flights',
                                                          style: bodytext12Bold(color: black),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: height(context) * 0.87,
                child: Column(
                  children: [
                    Expanded(
                        // height: height(context) * 0.79,
                        child: FutureBuilder(
                      future: getSearchTrip(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List ReuestTripData = snapshot.data!;

                          print(ReuestTripData);
                          return ReuestTripData.length == 0
                              ? Center(
                                  child: Text("No Data"),
                                )
                              : ListView.builder(
                                  itemCount: ReuestTripData.length,
                                  itemBuilder: (ctx, index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // getData();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => PrimaTrip1To4Screens(
                                                          isHost: ReuestTripData[index]['Uid'] == FirebaseAuth.instance.currentUser!.uid,
                                                          tripData: {
                                                            'addres': ReuestTripData[index]['where_to'],
                                                            'host': ReuestTripData[index]['Uid'],
                                                            'tripImage': ReuestTripData[index]['Cover_Pic'],
                                                            'tripName': ReuestTripData[index]['Specify_trip_name'],
                                                            'type': 'request'
                                                          },
                                                          hostUid: ReuestTripData[index]['Uid'],
                                                          showRequestTo_Join: "Send Request",
                                                        )));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10, bottom: 5),
                                            height: height(context) * 0.40,
                                            width: width(context) * 0.93,
                                            decoration: shadowDecoration(15, 2),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    SizedBox(
                                                      height: height(context) * 0.25,
                                                      width: width(context) * 0.93,
                                                      child: ClipRRect(
                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                                          child: Image.network(
                                                            ReuestTripData[index]['Cover_Pic'],
                                                            fit: BoxFit.fill,
                                                          )),
                                                    ),
                                                    // Positioned(
                                                    //   top: 5,
                                                    //   right: 40,
                                                    //   child: IconButton(
                                                    //       onPressed: () async {
                                                    //         // Navigator.push(context, MaterialPageRoute(builder: (context)=>TripLibraryScreen()));
                                                    //         //  bookmark();
                                                    //         if (!isBookmarked) {
                                                    //           List Bookmarklist = [];
                                                    //           Bookmarklist.add(context);
                                                    //           DocumentReference users = FirebaseFirestore.instance
                                                    //               .collection('users')
                                                    //               .doc(FirebaseAuth.instance.currentUser!.uid)
                                                    //               .collection("bookmarks")
                                                    //               .doc();
                                                    //           String _id = "";
                                                    //           String _imagee = "";
                                                    //           users.set({
                                                    //             'id': _id,
                                                    //             "postID": users.id,
                                                    //             'image': _imagee,
                                                    //             'location': _location,
                                                    //             'subtitle': _subtitle,
                                                    //             'title': _title,
                                                    //           });
                                                    //         } else {
                                                    //           var trip = await FirebaseFirestore.instance
                                                    //               .collection('users')
                                                    //               .doc(FirebaseAuth.instance.currentUser!.uid)
                                                    //               .collection('bookmarks')
                                                    //               .doc()
                                                    //               .get();
                                                    //           var docID = trip.data()?['docID'];
                                                    //           FirebaseDB().removeBookmark(docID);
                                                    //         }
                                                    //         setState(() {
                                                    //           isBookmarked = !isBookmarked;
                                                    //         });
                                                    //
                                                    //         setState(() {
                                                    //           isBookmarked = !isBookmarked;
                                                    //         });
                                                    //       },
                                                    //       icon: !isBookmarked
                                                    //           ? Icon(
                                                    //               Icons.bookmark_border,
                                                    //               color: Colors.black,
                                                    //             )
                                                    //           : const Icon(Icons.bookmark)),
                                                    // ),
                                                    // Positioned(
                                                    //   top: 5,
                                                    //   right: 5,
                                                    //   child: IconButton(onPressed: () async {}, icon: Icon(Icons.more_vert)),
                                                    // ),
                                                    Positioned(
                                                        bottom: 0,
                                                        left: 0,
                                                        child: Container(
                                                          height: height(context) * 0.06,
                                                          width: width(context) * 0.95,
                                                          padding: EdgeInsets.only(left: 5),
                                                          color: black.withOpacity(0.5),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.location_on_rounded,
                                                                    color: primary,
                                                                    size: 20,
                                                                  ),
                                                                  addHorizontalySpace(5),
                                                                  Text(
                                                                    '${ReuestTripData[index]['where_to']}',
                                                                    style: TextStyle(fontWeight: FontWeight.w500, color: white),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '${ReuestTripData[index]['Specify_trip_name']}',
                                                        style: bodyText22w700(color: black),
                                                      ),
                                                      addVerticalSpace(2),
                                                      // Text(
                                                      //   '$_subtitle2',
                                                      //   style: bodyText14normal(color: black),
                                                      // ),
                                                      // addVerticalSpace(5),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Image.asset(
                                                            'assets/images/cardrive.png',
                                                          ),
                                                          addHorizontalySpace(5),
                                                          SizedBox(
                                                            width: width(context) * 0.15,
                                                            child: Text(
                                                              '$_cartime2 hours',
                                                              style: bodytext12Bold(color: black),
                                                            ),
                                                          ),
                                                          Text(
                                                            '  |  ',
                                                            style: bodyText16normal(color: black),
                                                          ),
                                                          Image.asset(
                                                            'assets/images/train2.png',
                                                          ),
                                                          addHorizontalySpace(5),
                                                          SizedBox(
                                                            width: width(context) * 0.15,
                                                            child: Text(
                                                              '$_traintime2 hours',
                                                              style: bodytext12Bold(color: black),
                                                            ),
                                                          ),
                                                          Text(
                                                            '  |  ',
                                                            style: bodyText16normal(color: black),
                                                          ),
                                                          Image.asset(
                                                            'assets/images/flight.png',
                                                          ),
                                                          addHorizontalySpace(5),
                                                          SizedBox(
                                                            width: width(context) * 0.15,
                                                            child: Text(
                                                              'No direct flights',
                                                              style: bodytext12Bold(color: black),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                        } else if (snapshot.hasData) {
                          return Center(
                            child: Text("snapshot.error!.toString()"),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ))
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Future<List> getSearchTrip() async {
    //log("-------- ");

    UserFriendPrimaTrips.clear();
    try {
      DocumentSnapshot<Map<String, dynamic>> friendDoc =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('friends').doc('data').get();

      List userFriends = [];

      userFriends = friendDoc.data()!['data'];

      //log(friendDoc.toString());
      for (int a = 0; a < userFriends.length; a++) {
        //log("${userFriends[a]['id']}");
        try {
          if (ReuestTripData.where((element) => element['host'] == userFriends[a]['id']).toList().isEmpty) {
            log("------test");
            DocumentSnapshot<Map<String, dynamic>> userFriendTrip = await FirebaseFirestore.instance
                .collection('users')
                .doc('${userFriends[a]['id']}')
                .collection('Prima_Trip_Plan')
                .doc('${userFriends[a]['id']}')
                .get();

            UserFriendPrimaTrips.add(userFriendTrip.data()!);
          }
        } catch (e) {
          printc("__1__Catch");
        }
      }
    } catch (e) {
      printc("__2__Catch");
    }

    return UserFriendPrimaTrips;
  }
}

class CustomTripDataList extends StatelessWidget {
  const CustomTripDataList({
    Key? key,
    this.title,
    this.subtitle,
    required this.location,
    required this.containerYellowBox,
    required this.img,
    this.icon,
    required this.onTap,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final String location;
  final Widget containerYellowBox;
  final String img;
  final Widget? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            // height: height(context) * 0.37,
            width: width(context) * 0.93,
            decoration: shadowDecoration(15, 2),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)), child: Image.network(img)),
                    Positioned(
                        top: -5,
                        right: 1,
                        child: Row(
                          children: [
                            icon!,
                            InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.more_vert,
                                  color: white,
                                )),
                          ],
                        )),
                    Positioned(
                        bottom: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: width(context),
                              color: Colors.black.withOpacity(0.4),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    color: white,
                                    size: 20,
                                  ),
                                  addHorizontalySpace(5),
                                  Text(
                                    location,
                                    style: TextStyle(fontWeight: FontWeight.w500, color: white),
                                  ),
                                  addHorizontalySpace(width(context) * 0.25),
                                  containerYellowBox
                                ],
                              ),
                            )
                          ],
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? 'Tourist Spots list',
                        style: bodyText22w700(color: black),
                      ),
                      Text(
                        subtitle ?? 'Hill Station, Trekking, Waterfalls',
                        style: bodyText14normal(color: black),
                      ),
                      addVerticalSpace(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/images/cardrive.png',
                          ),
                          addHorizontalySpace(5),
                          SizedBox(
                            width: width(context) * 0.15,
                            child: Text(
                              '12 Hours drive',
                              style: bodytext12Bold(color: black),
                            ),
                          ),
                          Text(
                            '  |  ',
                            style: bodyText16normal(color: black),
                          ),
                          Image.asset(
                            'assets/images/train2.png',
                          ),
                          addHorizontalySpace(5),
                          SizedBox(
                            width: width(context) * 0.15,
                            child: Text(
                              '16 Hours journey',
                              style: bodytext12Bold(color: black),
                            ),
                          ),
                          Text(
                            '  |  ',
                            style: bodyText16normal(color: black),
                          ),
                          Image.asset(
                            'assets/images/flight.png',
                          ),
                          addHorizontalySpace(5),
                          SizedBox(
                            width: width(context) * 0.15,
                            child: Text(
                              'No direct flights',
                              style: bodytext12Bold(color: black),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TripLibraryDetailsScreen extends StatefulWidget {
  String targetType1;
  String targetState1;
  String docId;
  int totalDay;

  TripLibraryDetailsScreen({super.key, required this.targetState1, required this.targetType1, required this.docId, required this.totalDay});

  @override
  State<TripLibraryDetailsScreen> createState() => _TripLibraryDetailsScreenState();
}

class _TripLibraryDetailsScreenState extends State<TripLibraryDetailsScreen> {
  // final List dayWiseList = [
  //   'Day 1',
  //   '',
  //   'Day 2',
  //   '',
  //   'Day 3',
  //   '',
  //   'Day 4',
  //   '',
  //   'Day 5',
  //   '',
  //   'Day 6',
  //   '',
  //   'Day 7',
  // ];

  // Future<void> getAllData() async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await _collectionRef.get();
  //   // Get data from docs and convert map to List
  //   allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   setState(() {});
  //   print(allData);
  // }

  // List allData = [];
  List<DayTripData> dataSub = [];
  List<DayTripModel> data11 = [];
  @override
  void initState() {
    //getAllData();
    // gettutallData();
    // getTripData();
    super.initState();
  }

  Future<List<DayTripModel>> getDataListModel() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection('Travel New').doc('${widget.targetType1}').collection(widget.docId).get();

    data11.clear();

    printc("main List Lesnth ${widget.targetType1} -- ${widget.docId} -- ${data.docs.length}");
    for (int ii = 0; ii < data.docs.length; ii++) {
      // tripdataForStore.add({'docId': docid, 'tripImage': image});
      List<DayTripData> data1 = [];

      List dayDataList = data.docs[ii].data()['data'];

      printc("--${dayDataList.length}---");

      // print("---------");
      //printc("${value.docs[ii].id}-------" + dayDataList.length.toString());
      // printc(dayDataList[0]);
      for (int ii2 = 0; ii2 < dayDataList.length; ii2++) {
        //log("-- ---${value.docs[ii2].data()['day']}");
        //printc(value.docs[0].data());

        data1.add(DayTripData.fromJson(dayDataList[ii2]));
      }
      List<DayTripData> data2 = [];
      List dayDataBonusList = data.docs[ii].data()['bonus'];
      for (int ii2 = 0; ii2 < dayDataBonusList.length; ii2++) {
        //log("-- ---${value.docs[ii2].data()['day']}");
        //printc(value.docs[0].data());

        data2.add(DayTripData.fromJson(dayDataList[ii2]));
      }

      data11.add(DayTripModel(data: data1, bonus: data2));
      //finalData.add();

    }
    // days = widget.totalDay - 1;
    //print(data11);
    // firstIndex++;
    // finalDataMain.add([]);
    printc(data11);
    return data11;
    // print("-----" + "${finalData}");
  }

  //
  // CollectionReference _collectionRef2 =
  //     FirebaseFirestore.instance.collection('tripstate').doc('karnataka').collection('tripcity').doc('Bengaluru').collection('touristSport');

  // Future<void> gettutallData() async {
  //   CollectionReference _collectionRef2 = FirebaseFirestore.instance
  //       .collection('Trips_New')
  //       .doc('${widget.targetType1}')
  //       .collection('State')
  //       .doc('${widget.targetState1}')
  //       .collection('Trip');
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await _collectionRef2.get();
  //   // Get data from docs and convert map to List
  //   turistSportallData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   setState(() {});
  //   print(turistSportallData);
  // }

  List turistSportallData = [];

  int days = 0;
  // void getTripData() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     var profile = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('Plan_trip')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //     days = profile.data()?['totalDays'];
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: getDataListModel(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // printc(data11.length, 'g');

                printc(int.parse(days.toString()), "g");

                return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: widget.totalDay,
                    itemBuilder: (context, i) {
                      return SizedBox(
                        height: height(context),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: height(context) * 0.43,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: data11[0].data[i].image! != ""
                                            ? NetworkImage(data11[0].data[i].image!)
                                            : NetworkImage(
                                                "https://firebasestorage.googleapis.com/v0/b/travelnew-79e2e.appspot.com/o/featuredImages%2Ffeatured.png?alt=media&token=8ebc07d9-e50c-44a6-9c3e-b3ac65aac4b5"))),
                                child: SafeArea(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: height(context) * 0.11,
                                        width: width(context) * 1,
                                        padding: const EdgeInsets.only(left: 5),
                                        color: black.withOpacity(0.5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: primary,
                                                  size: 20,
                                                ),
                                                Text(
                                                  data11[i].data[0].state!,
                                                  style: bodyText16normal(color: white),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0, top: 5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    data11[i].data[0].type1!,
                                                    style: bodyText14normal(color: white),
                                                  ),
                                                  Text(' Trip', style: bodyText14normal(color: white)),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8.0, top: 5),
                                              child: Text(
                                                "${i == 0 ? "Bonus" : "day $i"}",
                                                style: bodyText13normal(color: white),
                                              ),
                                            ),
                                            addVerticalSpace(10)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: SizedBox(
                                  height: 500,
                                  width: width(context) * 0.95,
                                  child: ListView.builder(
                                      itemCount: data11[i].data.length,
                                      itemBuilder: (ctx, i2) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              // onTap: () {
                                              //   Navigator.push(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //           builder: (context) => TouristSpotsScreen(MP: allData[i],)));
                                              // },
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "${i2 == 0 ? "Bonus" : "day $i2"}",
                                                        style: bodyText18w600(color: black),
                                                      ),
                                                      addVerticalSpace(10),
                                                      SizedBox(
                                                        width: width(context) * 0.56,
                                                        child: Text(
                                                          "${data11[i].data[i2].touristSpot!}",
                                                          //turistSportallData[i]['name'],
                                                          style: bodyText18w600(color: black),
                                                        ),
                                                      ),
                                                      addVerticalSpace(5),
                                                      // Text('Religious,Culture'),
                                                      // addVerticalSpace(3),
                                                      SizedBox(
                                                        width: width(context) * 0.56,
                                                        child: Text(
                                                          "${data11[i].data[i2].description!}",

                                                          //turistSportallData[i]['about'],
                                                          style: bodyText12Small(spacing: 1.4, color: black),
                                                        ),
                                                      ),
                                                      addVerticalSpace(5),
                                                      // Row(
                                                      //   children: [
                                                      //     Text(
                                                      //       'Learn more on ',
                                                      //       style: bodytext12Bold(color: black),
                                                      //     ),
                                                      //     Image.asset('assets/images/google.png')
                                                      //   ],
                                                      // )
                                                    ],
                                                  ),
                                                  addHorizontalySpace(10),
                                                  SizedBox(
                                                      height: height(context) * 0.12,
                                                      width: width(context) * 0.3,
                                                      child: Image.network(
                                                        "${data11[i].data[i2].image != "" ? data11[i].data[i2].image : "https://media.istockphoto.com/id/490736905/photo/meenakshi-hindu-temple-in-madurai-tamil-nadu-south-india.jpg?s=612x612&w=0&k=20&c=OlOLvdryIdkdyKcY9gRPsM1RZa5HiP6QBr2JVAIvPb0="}",

                                                        //turistSportallData[i]['image'],
                                                        fit: BoxFit.fill,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            addVerticalSpace(30)
                                          ],
                                        );
                                      }),
                                ),
                              ),
                              // SizedBox(
                              //     height: height(context) * 1.3,
                              //     child: ListView.builder(
                              //         physics: const NeverScrollableScrollPhysics(),
                              //         padding: EdgeInsets.zero,
                              //         itemCount: int.parse(days.toString()),
                              //         itemBuilder: (context, i) {
                              //           return Padding(
                              //             padding: const EdgeInsets.symmetric(
                              //                 horizontal: 12.0, vertical: 5),
                              //             child: Column(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: [
                              //                 Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     Text(
                              //                       dayWiseList[i],
                              //                       style:
                              //                           bodyText20w700(color: black),
                              //                     ),
                              //                     // InkWell(
                              //                     //     onTap: () {
                              //                     //       Navigator.push(
                              //                     //           context,
                              //                     //           MaterialPageRoute(
                              //                     //               builder: (context) =>
                              //                     //                   const TripMapScreen()));
                              //                     //     },
                              //                     //     child: Image.asset(
                              //                     //         'assets/images/akar-icons_map.png'))
                              //                   ],
                              //                 ),
                              //                 // const Text('Monday, Feb 14 2022'),
                              //                 addVerticalSpace(10),
                              //                 SizedBox(
                              //                   height: height(context) * 0.32,
                              //                   child: ListView.builder(
                              //                       physics:
                              //                           const NeverScrollableScrollPhysics(),
                              //                       itemCount: 2,
                              //                       padding: EdgeInsets.zero,
                              //                       itemBuilder: (context, i) {
                              //                         return Column(
                              //                           children: [
                              //                             InkWell(
                              //                               onTap: () {
                              //                                 // Navigator.push(
                              //                                 //     context,
                              //                                 //     MaterialPageRoute(
                              //                                 //         builder:
                              //                                 //             (context) =>
                              //                                 //                 const TouristSpotsScreen()));
                              //                               },
                              //                               child: Row(
                              //                                 children: [
                              //                                   Column(
                              //                                     crossAxisAlignment:
                              //                                         CrossAxisAlignment
                              //                                             .start,
                              //                                     children: [
                              //                                       Text(
                              //                                         turistSportallData[i]['name'],
                              //                                         style: bodyText18w600(
                              //                                             color:
                              //                                                 black),
                              //                                       ),
                              //                                       // const Text(
                              //                                       //   'Religious,Culture',
                              //                                       //   style: TextStyle(
                              //                                       //       height:
                              //                                       //           1.4),
                              //                                       // ),
                              //                                       SizedBox(
                              //                                         width: width(
                              //                                                 context) *
                              //                                             0.56,
                              //                                         child: Text(
                              //                                           turistSportallData[i]['about'],
                              //                                           style: bodyText12Small(
                              //                                               spacing:
                              //                                                   1.5,
                              //                                               color:
                              //                                                   black),
                              //                                         ),
                              //                                       ),
                              //                                       addVerticalSpace(
                              //                                           5),
                              //                                     ],
                              //                                   ),
                              //                                   addHorizontalySpace(
                              //                                       10),
                              //                                   SizedBox(
                              //                                       height: height(
                              //                                               context) *
                              //                                           0.12,
                              //                                       child:
                              //                                           Image.network(
                              //                                        turistSportallData[i]['image'],
                              //                                         fit:
                              //                                             BoxFit.fill,
                              //                                       ))
                              //                                 ],
                              //                               ),
                              //                             ),
                              //                             addVerticalSpace(15)
                              //                           ],
                              //                         );
                              //                       }),
                              //                 ),
                              //                 // const Divider(
                              //                 //   thickness: 1,
                              //                 // ),
                              //               ],
                              //             ),
                              //           );
                              //         })),
                              addVerticalSpace(30)
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
          // Positioned(
          //   bottom: height(context) * 0.06,
          //   left: width(context) * 0.17,
          //   child: Center(
          //       child: SizedBox(
          //           width: width(context) * 0.65,
          //           child: CustomButton(
          //               name: 'See your travel Utility',
          //               onPressed: () {
          //                 Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                         builder: (context) =>
          //                            const TravelAgencyDetailsScreen(MP: widget,)));
          //               }))),
          // )
        ],
      ),
    );
  }
}

class TripLibraryDetailsScreen2 extends StatefulWidget {
  TripLibraryDetailsScreen2({super.key});

  @override
  State<TripLibraryDetailsScreen2> createState() => _TripLibraryDetailsScreenState2();
}

class _TripLibraryDetailsScreenState2 extends State<TripLibraryDetailsScreen2> {
  final List dayWiseList = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'];
  //
  // CollectionReference _collectionRef =
  // FirebaseFirestore.instance.collection('users')
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .collection("upcomingtrip");
  // Future<void> getData() async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await _collectionRef.get();
  //   // Get data from docs and convert map to List
  //   allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   setState(() {
  //   });
  //   print(allData);
  // }
  // List allData = [];

  String endplace = "";
  String date = "";
  int days = 0;
  void getTripData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Plan_trip')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      endplace = profile.data()?['endtrip'];
      date = profile.data()?['StartDate'];
      days = profile.data()?['totalDays'];
    }
    setState(() {});
  }

  List des = [];
  List touristSport = [];
  List touristSportimage = [];
  String cityimage = "";
  void getsportdata() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance.collection('tripstate').doc('karnataka').collection('tripcity').doc('Bengaluru').get();
      des = profile.data()?['TouristSportDesc'];
      touristSport = profile.data()?['TouristSport'];
      touristSportimage = profile.data()?['TouristSportImage'];
      cityimage = profile.data()?['cityImage'];
    }
    setState(() {});
    print('&&&&&&&&&&&&&&&');
    print('$endplace');
    print('$des');
  }

  @override
  void initState() {
    //getData();
    getsportdata();
    getTripData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (cityimage != ConnectionState.waiting && des != ConnectionState.waiting && touristSportimage != ConnectionState.waiting) {
      return Scaffold(
        body: Stack(
          children: [
            ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: int.parse(days.toString()),
                itemBuilder: (context, i) {
                  return SizedBox(
                    height: height(context),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height(context) * 0.43,
                            width: double.infinity,
                            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(cityimage))),
                            child: SafeArea(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: height(context) * 0.11,
                                    width: width(context) * 1,
                                    padding: const EdgeInsets.only(left: 5),
                                    color: black.withOpacity(0.5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: primary,
                                              size: 20,
                                            ),
                                            Text(
                                              '$endplace',
                                              style: bodyText16normal(color: white),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0, top: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                '$endplace',
                                                style: bodyText14normal(color: white),
                                              ),
                                              Text(' Trip', style: bodyText14normal(color: white)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0, top: 5),
                                          child: Text(
                                            '$date',
                                            style: bodyText13normal(color: white),
                                          ),
                                        ),
                                        addVerticalSpace(10)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              height: height(context) * 2.8,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: int.parse(days.toString()),
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                dayWiseList[i],
                                                style: bodyText20w700(color: black),
                                              ),
                                              // InkWell(
                                              //     onTap: () {
                                              //       Navigator.push(
                                              //           context,
                                              //           MaterialPageRoute(
                                              //               builder: (context) =>
                                              //               const TripMapScreen()));
                                              //     },
                                              //     child: Image.asset(
                                              //         'assets/images/akar-icons_map.png'))
                                            ],
                                          ),
                                          Text('$date'),
                                          addVerticalSpace(10),
                                          SizedBox(
                                            height: height(context) * 0.32,
                                            child: ListView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: 2,
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context, i) {
                                                  return Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          // Navigator.push(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //         builder:
                                                          //             (context) =>
                                                          //                 const TouristSpotsScreen()));
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  touristSport[i],
                                                                  style: bodyText18w600(color: black),
                                                                ),
                                                                const Text(
                                                                  'Religious,Culture',
                                                                  style: TextStyle(height: 1.4),
                                                                ),
                                                                SizedBox(
                                                                  width: width(context) * 0.56,
                                                                  child: Text(
                                                                    des[i],
                                                                    style: bodyText12Small(spacing: 1.5, color: black),
                                                                  ),
                                                                ),
                                                                addVerticalSpace(5),
                                                                // Row(
                                                                //   children: [
                                                                //     Text(
                                                                //       'Learn more on ',
                                                                //       style:
                                                                //       bodytext12Bold(
                                                                //           color:
                                                                //           black),
                                                                //     ),
                                                                //     Image.asset(
                                                                //         'assets/images/google.png')
                                                                //   ],
                                                                // )
                                                              ],
                                                            ),
                                                            addHorizontalySpace(10),
                                                            SizedBox(
                                                                height: height(context) * 0.12,
                                                                child: Image.network(
                                                                  touristSportimage[i],
                                                                  fit: BoxFit.fill,
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                      addVerticalSpace(15)
                                                    ],
                                                  );
                                                }),
                                          ),
                                          // const Divider(
                                          //   thickness: 1,
                                          // ),
                                        ],
                                      ),
                                    );
                                  })),
                          addVerticalSpace(30)
                        ],
                      ),
                    ),
                  );
                }),
            // Positioned(
            //   bottom: height(context) * 0.06,
            //   left: width(context) * 0.17,
            //   child: Center(
            //       child: SizedBox(
            //           width: width(context) * 0.65,
            //           child: CustomButton(
            //               name: 'See your travel Utility',
            //               onPressed: () {
            //                 Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                         builder: (context) =>
            //                            const TravelAgencyDetailsScreen(MP: widget,)));
            //               }))),
            // )
          ],
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}

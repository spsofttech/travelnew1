

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/views/aspired_trip/save_trip_and_get_qoute.dart';
import '../../model/home_model.dart';
import '../../services/db/firebaseDB.dart';
import '../../utils/constant.dart';
import '../../widget/custom_button.dart';
import '../home/festival_and_celebrations_screen.dart';
import '../humburger_flow/trip_library_screen.dart';

class AspiredTripDetailsScreen extends StatefulWidget {
  final Map<String,dynamic> MP;
  const AspiredTripDetailsScreen({super.key, required this.MP});

  @override
  State<AspiredTripDetailsScreen> createState() => _AspiredTripDetailsScreenState();
}

class _AspiredTripDetailsScreenState extends State<AspiredTripDetailsScreen> {


  // String _festival = "Rakhi";
  // String _locationn = "Jodhpur";
  // String _image = "https://images.unsplash.com/photo-1486870591958-9b9d0d1dda99?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80";
  // String _date = "26 jan 2023";
  // addupcomingDetails() async {
  //   // Call the user's CollectionReference to add a new user
  //
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   users
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("upcomingtrip")
  //       .doc('VB5hR7xMSptSRiVGJ3YF')
  //       .set({
  //     'Festivalname': _festival,
  //     'location': _location,
  //     'image': _image,
  //     'date': _date,
  //   })
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }
  // String _picimage = "";
  // String _destination = "";
  // String _state = "";
  // String _tripdays = "";
  // String _tripname = "";
  // String _experiences = "";
  // String _about = "";
  // String _include = "";
  // String _Expected_Budget = "";
  // List _days = [];
  // List _sportimage = [];
  // List _daysnumber = [];
  // void getDetails() async{
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     var trip = await FirebaseFirestore.instance
  //         .collection('Aspired_trips')
  //         .doc('Trip1')
  //         .get();
  //
  //     _picimage = trip.data()?['imageUrl'];
  //     _destination = trip.data()?['destinationname'];
  //     _state = trip.data()?['statename'];
  //     _tripdays = trip.data()?['tripdays'];
  //     _tripname = trip.data()?['tripname'];
  //     _experiences = trip.data()?['experiences'];
  //     _about = trip.data()?['about'];
  //     _include = trip.data()?['includes'];
  //     _Expected_Budget = trip.data()?['Expected_Budget'];
  //     _days = trip.data()?['Days'];
  //     _sportimage = trip.data()?['shportImage'];
  //     _daysnumber = trip.data()?['daysnumber'];
  //   }
  //   setState(() {});
  // }
  String _mobileNum = "";
  String _email = "";
  void getpermission() async{
    if (FirebaseAuth.instance.currentUser != null) {
      var per = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('primaAccount')
          .doc('profile')
          .get();
      _mobileNum = per.data()?['mobileNumber'];
      _email = per.data()?['emailId'];
    }
    setState(() {});
    print('$_mobileNum');
    print('$_email');
  }
  String _id = "";
  String _location = "";
  String _subtitle = "";
  String _title = "";
  String _imagee = "";
  bool isBookmarked = false;
  List Bookmarklist =[];

  void bookmark() async {
    SharedPreferences _prefs =
    await SharedPreferences.getInstance();
    if (!isBookmarked)  {
      // var docID = SharedPreferences.getInstance().getString('postID');
      // FirebaseDB().removeBookmark(docID);
    } else
    {
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
        'location':_location,
        'subtitle':_subtitle,
        'title':_title,
      });
      setState(() {
      });
    }
  }

  updatesavetrip() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("upcomingtrip")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
      });
      setState(() {});
    }
  }
  @override
  void initState() {
    // getDetails();
    getpermission();
        super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        child: Image.network(widget.MP['imageUrl'])),
                    SafeArea(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                          Spacer(),
                           Positioned(
                                top: -5,
                                right: -5,
                                child: IconButton(
                                    onPressed: () async {
                                      SharedPreferences _prefs =
                                      await SharedPreferences.getInstance();
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
                                            'location':_location,
                                            'subtitle':_subtitle,
                                            'title':_title,
                                          });
                                      }
                                       else {
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
                                      // DocumentReference users = FirebaseFirestore.instance
                                      //     .collection('users')
                                      //
                                      //     .doc(FirebaseAuth.instance.currentUser!.uid)
                                      //     .collection("bookmarks")
                                      // .doc();
                                      //     users.set({
                                      //       "postID": users.id,
                                      // });
                                    },
                                    icon: !isBookmarked
                                        ? Icon(
                                      Icons.bookmark_border,
                                      color: white,
                                    )
                                        : const Icon(Icons.bookmark)),
                              ),

                          Padding(
                            padding: EdgeInsets.only(right: 12.0, top: 10),
                            child: ImageIcon(
                                color: white,
                                AssetImage(
                                  'assets/images/forward.png',
                                )),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          height: height(context) * 0.04,
                          width: width(context) * 1,
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
                                          widget.MP['destinationname'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: white),
                                        ),
                                        Text(
                                          widget.MP['statename'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: white),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          widget.MP['tripdays'],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.MP['tripname'],
                        style: bodyText30W600(color: black),
                      ),
                      Text(
                      widget.MP['experiences'],
                      ),
                      addVerticalSpace(10),
                      Text(
                        'About',
                        style: bodyText20w700(color: black),
                      ),
                      addVerticalSpace(5),
                      Text(
                        widget.MP['about'],
                        style: TextStyle(
                            height: 1.3,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: black),
                      ),
                      addVerticalSpace(15),
                      Text(
                        'Itinerary',
                        style: bodyText20w700(color: black),
                      ),
                      addVerticalSpace(15),
                      SizedBox(
                        height: height(context) * 0.48,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: widget.MP['daysnumber'].length,
                            itemBuilder: (ctx, i) {
                              return Column(
                                children: [
                                  Row(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        margin: EdgeInsets.only(right: 8),
                                        height: height(context) * 0.13,
                                        width: width(context) * 0.37,
                                        child: Image.network(
                                          widget.MP['shportImage'][i],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.MP['daysnumber'][i],
                                          style: bodyText16w600(color: black),
                                        ),
                                        addVerticalSpace(5),
                                        SizedBox(
                                          width: width(context) * 0.55,
                                          child: Text(
                                            widget.MP['Days'][i],
                                            style: TextStyle(height: 1.3),
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                                  addVerticalSpace(15)
                                ],
                              );
                            }),
                      ),
                      addVerticalSpace(8),
                      Text(
                        'Suitable for',
                        style: bodyText20w700(color: black),
                      ),
                      addVerticalSpace(2),
                      Text(
                        'Family/friends/Couple',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: black),
                      ),
                      addVerticalSpace(15),
                      Text(
                        'Include',
                        style: bodyText20w700(color: black),
                      ),
                      addVerticalSpace(4),
                      Text(
                        widget.MP['includes'],
                        style: TextStyle(
                            height: 1.3,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: black),
                      ),
                      addVerticalSpace(15),
                      Text(
                        'Expected Budget',
                        style: bodyText20w700(color: black),
                      ),
                       Row(
                         children: [
                           Text(
                            widget.MP['Expected_Budget'],
                      ),
                           Text(
                             '₹  /person',
                           ),
                         ],
                       ),
                      addVerticalSpace(height(context) * 0.1),
                      addVerticalSpace(8)
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 9,
            child: CustomButton(
                name: 'Save trip and get quotes',
                onPressed: () {
               if(_email == "" || _mobileNum == ""){
                    NumberpoppubDialog(context);
                      }
                      else {
                 if (FirebaseAuth.instance.currentUser!.uid !=
                     null) {
                   updatesavetrip();
                   // addsavetrip();
                 } else {
                   updatesavetrip();
                 }
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) =>
                         const SaveTripAndGetQuote(
                           message1:
                           'Our travel partners may request you change in date as per travel seat reservations',
                           message2:
                           'Expected budget: 5000 per person (Cost includes hotel booking and travel booking)',
                         )));
               }
                }),
          )
        ],
      ),
    );
  }
}


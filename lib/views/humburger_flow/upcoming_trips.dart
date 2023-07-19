import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelnew_app/views/aspired_trip/save_trip_and_get_qoute.dart';
import 'package:travelnew_app/views/home/festival_and_celebrations_screen.dart';
import 'package:travelnew_app/views/humburger_flow/trip_library_screen.dart';
import 'package:travelnew_app/views/start/sign_in_screen.dart';
import 'package:travelnew_app/views/start/signup_with_social_media_screen.dart';

import '../../utils/constant.dart';
import '../../widget/custom_appbar.dart';
import '../aspired_trip/travel_agency_details.dart';
import '../edit_prima_screen/prima_trip_1to4_screen.dart';
import '../publish your trip/publish_your_trip.dart';
import '../publish your trip/step1.dart';
import '../publish your trip/step2.dart';

class UpcomingTripsScreen extends StatefulWidget {
  UpcomingTripsScreen({
    super.key,
    this.check,
  });
  final String? check;

  @override
  State<UpcomingTripsScreen> createState() => _UpcomingTripsScreenState();
}

class _UpcomingTripsScreenState extends State<UpcomingTripsScreen> {
  showSnackBar(BuildContext context, String str, [Color clr = Colors.black]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: clr,
    ));
  }

  @override
  void initState() {
    //getDetails();
    getData();
    super.initState();
  }

  // empatycomingtrip(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //             contentPadding: const EdgeInsets.all(6),
  //             shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //             content: Builder(
  //               builder: (context) {
  //                 var height = MediaQuery.of(context).size.height;
  //                 var width = MediaQuery.of(context).size.width;
  //
  //                 return Container(
  //                   height: 200,
  //                   child: Center(
  //                       child: Text(
  //                     'You not have any upcoming trip.',
  //                     style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),
  //                   )),
  //                 );
  //               },
  //             ),
  //           ));
  // }

  String _festival = "";
  String _location = "";
  String _image = "";
  String _date = "";
  var lastactive;

  //
  getDetails() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("upcomingtrip")
          .doc('VB5hR7xMSptSRiVGJ3YF')
          .get();

      _festival = profile.data()?['Festivalname'] ?? "";
      _location = profile.data()?['location'] ?? "";
      _image = profile.data()?['image'] ?? "";
      _date = profile.data()?['date'] ?? "";
      lastactive = profile.data()?['lastactive'];
    }
    setState(() {});
  }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("upcomingtrip");

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    upcomingTripData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {});
    print(upcomingTripData);
  }

  List upcomingTripData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
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
              'Upcoming Trips',
              style: bodyText20w700(color: black),
            ),
            actions: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (FirebaseAuth.instance.currentUser != null) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => TripLibraryScreen()));
                      } else {
                        showSnackBar(context, "Please Login First!", Colors.red);
                        Navigator.push(context, MaterialPageRoute(builder: (ctx) => SignupWithSocialMediaScreen()));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
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
        ),
        body: Column(
          children: [
            Expanded(
                // height: height(context) * 0.79,
                child: ListView.builder(
                    itemCount: upcomingTripData.length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // getData();
                              if (upcomingTripData[index]['travelTrip'] == 1)
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TripLibraryDetailsScreen(
                                              targetState1: upcomingTripData[index]['state'],
                                              targetType1: upcomingTripData[index]['tripsport'],
                                              docId: upcomingTripData[index]['tripDocId'],
                                              totalDay: upcomingTripData[index]['daysnumber'],
                                            )));
                              if (upcomingTripData[index]['travelTrip'] == 2) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PrimaTrip1To4Screens(
                                              isHost: upcomingTripData[index]['host'] == FirebaseAuth.instance.currentUser!.uid,
                                              hostUid: upcomingTripData[index]['host'],
                                              tripData: {
                                                'addres': upcomingTripData[index]['address'],
                                                'host': upcomingTripData[index]['host'],
                                                'tripImage': upcomingTripData[index]['tripImg'],
                                                'tripName': upcomingTripData[index]['tripname'],
                                              },
                                              showRequestTo_Join: "",
                                            )));
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10, bottom: 5),
                              height: height(context) * 0.32,
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
                                              upcomingTripData[index]['tripImg'],
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                      // Positioned(
                                      //   top: 5,
                                      //   right: 40,
                                      //   child: ImageIcon(
                                      //       color: white,
                                      //       const AssetImage(
                                      //         'assets/images/forward.png',
                                      //       )),
                                      // ),
                                      upcomingTripData[index]['travelTrip'] == 2
                                          ? SizedBox()
                                          : Positioned(
                                              top: -5,
                                              right: -5,
                                              child: IconButton(
                                                  onPressed: () async {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => TravelAgencyDetailsScreen(
                                                                  MP: upcomingTripData[index],
                                                                )));
                                                  },
                                                  icon: Icon(Icons.more_vert)),
                                            ),
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
                                                      Icons.calendar_month,
                                                      color: primary,
                                                      size: 20,
                                                    ),
                                                    addHorizontalySpace(5),
                                                    Text(
                                                      upcomingTripData[index]['date'],
                                                      style: TextStyle(fontWeight: FontWeight.w500, color: white),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on_rounded,
                                                      color: primary,
                                                      size: 20,
                                                    ),
                                                    addHorizontalySpace(5),
                                                    Text(
                                                      upcomingTripData[index]['address'],
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
                                          upcomingTripData[index]['tirpname'],
                                          style: bodyText22w700(color: black),
                                        ),
                                        addVerticalSpace(2),
                                        // Text(
                                        //   allData[index]['tripsport'],
                                        //   style: bodyText14normal(color: black),
                                        // ),
                                        // addVerticalSpace(8),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }))
          ],
        ));
  }
}

class utilityPage extends StatefulWidget {
  const utilityPage({Key? key}) : super(key: key);

  @override
  _utilityPage createState() => _utilityPage();
}

class _utilityPage extends State<utilityPage> {
  @override
  void initState() {
    super.initState();
  }
  // final List<String> tripLocation = ['Pune', 'Mumbai', 'chennai'];

  int _activeCurrentStep = 0;
  // bool isChecked = false;
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  final TextEditingController SeeTripController = TextEditingController();
  final TextEditingController InvitedMemberController = TextEditingController();
  final TextEditingController MaxMemberController = TextEditingController();
  final TextEditingController SpendsController = TextEditingController();

  List<Step> stepList() => [
        Step(
            state: _activeCurrentStep == 0 ? StepState.editing : StepState.complete,
            isActive: _activeCurrentStep == 0,
            label: const Text('Travel Operator'),
            title: const SizedBox(),
            content: Step1()),
        Step(
            state: _activeCurrentStep == 1 ? StepState.editing : StepState.complete,
            isActive: _activeCurrentStep == 1,
            label: const Text('Hotel'),
            title: const SizedBox(),
            content: const Step2()),
        Step(
            state: _activeCurrentStep == 2 ? StepState.editing : StepState.complete,
            isActive: _activeCurrentStep == 2,
            label: const Text('Journey'),
            title: const SizedBox(),
            content: const Step2()),
        Step(
            state: _activeCurrentStep == 3 ? StepState.editing : StepState.complete,
            isActive: _activeCurrentStep == 3,
            label: const Text('Explore'),
            title: const SizedBox(),
            content: const Step2()),
        Step(
            state: _activeCurrentStep == 4 ? StepState.editing : StepState.complete,
            isActive: _activeCurrentStep == 4,
            label: const Text('Budget/Checklist'),
            title: const SizedBox(),
            content: const Step2()),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50), child: CustomAppBar(title: 'Travel Utility')),
      body: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primary,
              ),
        ),
        child: Stepper(
          elevation: 0,
          margin: EdgeInsets.zero,

          controlsBuilder: (BuildContext context, ControlsDetails, {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
            return Column(
              children: [
                addVerticalSpace(40),
              ],
            );
          },
          type: StepperType.horizontal,
          currentStep: _activeCurrentStep,
          steps: stepList(),

          onStepContinue: () {
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(""),));
            if (_activeCurrentStep < (stepList().length - 1)) {
              setState(() {
                _activeCurrentStep += 1;
              });
            }
          },

          onStepCancel: () {
            if (_activeCurrentStep == 0) {
              return;
            }

            setState(() {
              _activeCurrentStep -= 1;
            });
          },
          // onStepTap allows to directly click on the particular step we want
          onStepTapped: (int index) {
            setState(() {
              _activeCurrentStep = index;
            });
          },
        ),
      ),
    );
  }
}

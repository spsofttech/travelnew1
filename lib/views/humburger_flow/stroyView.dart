import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:travelnew_app/views/humburger_flow/tourist_spot_screen.dart';
import 'package:travelnew_app/views/humburger_flow/trip_library_screen.dart';

import '../../model/DayWiseTripModel.dart';
import '../../utils/constant.dart';

class StoryPageView extends StatefulWidget {
  DayTripModel data;

  bool isBonus;
  StoryPageView({required this.data, this.isBonus = false});

  @override
  State<StoryPageView> createState() => _StoryPageViewState();
}

class _StoryPageViewState extends State<StoryPageView> {
  int days = 0;
  List<StoryItem>? storyItem;
  final controller = StoryController();
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
  // }
  //
  // CollectionReference _collectionRef =
  //     FirebaseFirestore.instance.collection('tripstate').doc('karnataka').collection('tripcity').doc('Bengaluru').collection('touristSport');
  Future<void> getallData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    //allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //getTripData();
    storyItem = [
      if (widget.isBonus)
        for (int i = 0; i < widget.data.bonus.length; i++)
          StoryItem(
              TouristSpotsScreen2(
                MP: widget.data.bonus[i],
              ),
              duration: Duration(minutes: 30))
      else
        for (int i = 0; i < widget.data.data.length; i++)
          StoryItem(
              TouristSpotsScreen2(
                MP: widget.data.data[i],
              ),
              duration: Duration(minutes: 30)),
    ];
    //print(allData);
  }

  // List allData = [];

  @override
  void initState() {
    getallData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    days = 5;

    return Scaffold(
      body: FutureBuilder(
        future: getallData(),
        builder: (context, snapshot) {
          return SizedBox(
            height: height(context),
            child: StoryView(
              storyItems: storyItem!,
              controller: controller,
              // inline: false,
              repeat: true,
            ),
          );
        },
      ),
    );
  }
}

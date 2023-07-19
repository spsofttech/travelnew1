import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/save_your_trips/save_your_trips.dart';
import 'package:travelnew_app/widget/custom_dropdown_button.dart';
import 'dart:math' as math;

class SaveTripStep2 extends StatefulWidget {
  SaveTripStep2({super.key});

  @override
  State<SaveTripStep2> createState() => _SaveTripStep2State();
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = math.cos;
  var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * math.asin(math.sqrt(a));
}

double distant_in_km = 0;

class _SaveTripStep2State extends State<SaveTripStep2> {
  final List saveTripList1 = [
    {'img': 'assets/images/road.png', 'name': 'Road'},
    {'img': 'assets/images/plane.png', 'name': 'Flight'},
  ];

  final List saveTripList2 = [
    {'img': 'assets/images/train.png', 'name': 'Train'},
    {'img': 'assets/images/plane.png', 'name': 'Flight'},
  ];

  final List saveTripList3 = [
    {'img': 'assets/images/plane.png', 'name': 'Flight'},
  ];

  int currentIndex1 = 0;
  int currentIndex2 = 1;
  String changemode = "";
  // int currentIndex3 = 2;
  String startplace = "";
  String endplace = "";
  String mode = "";

  void getData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Plan_trip')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      startplace = profile.data()?['StartTrip'];
      endplace = profile.data()?['endtrip'];
      mode = profile.data()?['tripmode'];
      changemode = mode;
    }
    distant_in_km = calculateDistance(USER_lat, USER_long, trip_citi_lat, trip_citi_long);

    setState(() {});
  }

  void updateTripData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Plan_trip')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"tripmode": changemode});
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mode of Travel', style: TextStyle(fontSize: 20, color: black)),
        addVerticalSpace(15),
        Text('Departure city'),
        Text(
          '$startplace',
          style: bodyText16w600(color: black),
        ),
        addVerticalSpace(10),
        Icon(Icons.arrow_downward),
        addVerticalSpace(10),
        Text('Trip Destination'),
        Obx(() => Text(
              '${trip_city_name.value}',
              style: bodyText16w600(color: black),
            )),
        const Divider(
          height: 30,
          thickness: 1,
        ),
        // InkWell(
        //   onTap: (){
        //     TravelMode(context);
        //   },
        if (mode == 'Bus')
          SizedBox(
            height: height(context) * 0.15,
            child: ListView.builder(
                itemCount: saveTripList1.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex1 = i;
                        changemode = saveTripList1[i]['name'];
                      });
                      updateTripData();
                    },
                    child: Column(
                      children: [
                        if (mode == 'Bus')
                          Container(
                            height: height(context) * 0.1,
                            width: width(context) * 0.23,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(12),
                            decoration: currentIndex1 == i ? myFillBoxDecoration(0, primary, 10) : myFillBoxDecoration(0, white, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: Image.asset(
                                    saveTripList1[i]['img'],
                                    color: currentIndex1 == i ? white : primary,
                                  ),
                                ),
                                addVerticalSpace(10),
                                Text(
                                  saveTripList1[i]['name'],
                                  style: bodyText16w600(color: black),
                                )
                              ],
                            ),
                          )
                        else
                          Container(
                            height: height(context) * 0.1,
                            width: width(context) * 0.23,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(12),
                            decoration: currentIndex2 == i ? myFillBoxDecoration(0, primary, 10) : myFillBoxDecoration(0, white, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: Image.asset(
                                    saveTripList1[i]['img'],
                                    color: currentIndex2 == i ? white : primary,
                                  ),
                                ),
                                addVerticalSpace(10),
                                Text(
                                  saveTripList1[i]['name'],
                                  style: bodyText16w600(color: black),
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  );
                }),
          )
        else if (mode == 'Train')
          SizedBox(
            height: height(context) * 0.15,
            child: ListView.builder(
                itemCount: saveTripList2.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex1 = i;
                        changemode = saveTripList2[i]['name'];
                        updateTripData();
                      });
                    },
                    child: Column(
                      children: [
                        if (mode == 'Train')
                          Container(
                            height: height(context) * 0.1,
                            width: width(context) * 0.23,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(12),
                            decoration: currentIndex1 == i ? myFillBoxDecoration(0, primary, 10) : myFillBoxDecoration(0, white, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: Image.asset(
                                    saveTripList2[i]['img'],
                                    color: currentIndex1 == i ? white : primary,
                                  ),
                                ),
                                addVerticalSpace(10),
                                Text(
                                  saveTripList2[i]['name'],
                                  style: bodyText16w600(color: black),
                                )
                              ],
                            ),
                          )
                        else
                          Container(
                            height: height(context) * 0.1,
                            width: width(context) * 0.23,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(12),
                            decoration: currentIndex2 == i ? myFillBoxDecoration(0, primary, 10) : myFillBoxDecoration(0, white, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: Image.asset(
                                    saveTripList2[i]['img'],
                                    color: currentIndex2 == i ? white : primary,
                                  ),
                                ),
                                addVerticalSpace(10),
                                Text(
                                  saveTripList2[i]['name'],
                                  style: bodyText16w600(color: black),
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  );
                }),
          )
        else
          SizedBox(
            height: height(context) * 0.15,
            child: ListView.builder(
                itemCount: saveTripList3.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) {
                  return Column(
                    children: [
                      Container(
                        height: height(context) * 0.1,
                        width: width(context) * 0.23,
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(12),
                        decoration: currentIndex1 == i ? myFillBoxDecoration(0, primary, 10) : myFillBoxDecoration(0, white, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 30,
                              child: Image.asset(
                                saveTripList3[i]['img'],
                                color: currentIndex1 == i ? white : primary,
                              ),
                            ),
                            addVerticalSpace(10),
                            Text(
                              saveTripList3[i]['name'],
                              style: bodyText16w600(color: black),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }),
          ),

        const Divider(
          height: 30,
          thickness: 1,
        ),
        const Text('If required, Our travel partners may request you change in travel due to seat availability and Itinerary as per travel convenience '),
        const Divider(
          height: 30,
          thickness: 1,
        ),
        addVerticalSpace(15),
        if (mode == 'Bus' && changemode == 'Bus')
          SizedBox(
            width: width(context) * 0.56,
            child: CustomDropDownButton(
              itemList: ['Rent me a vehicle', 'I’ll use my own'],
              lableText: '  Bus booking  ',
            ),
          )
        else if (mode == 'Train' && changemode == 'Train') ...[
          SizedBox(
            width: width(context) * 0.56,
            child: CustomDropDownButton(
              itemList: ['Yes', 'No'],
              lableText: '  Train booking  ',
            ),
          )
        ] else if (mode == 'Flight' && changemode == 'Flight')
          SizedBox(
            width: width(context) * 0.56,
            child: CustomDropDownButton(
              itemList: ['Rent me a vehicle', 'I’ll use my own'],
              lableText: '  Bus booking  ',
            ),
          )
        else if (changemode == 'Train')
          SizedBox(
            width: width(context) * 0.56,
            child: CustomDropDownButton(
              itemList: ['Yes', 'No'],
              lableText: '  Train booking  ',
            ),
          )
        else if (changemode == 'Flight')
          SizedBox(
            width: width(context) * 0.56,
            child: CustomDropDownButton(
              itemList: ['Yes', 'No'],
              lableText: '  Flight booking  ',
            ),
          ),
        addVerticalSpace(15),
        Text('It will take ${(distant_in_km / 20).round()} hours to reach'),
        Text('It is on ${distant_in_km.round()} KM Far'),
      ],
    );
  }

  TravelMode(BuildContext context) {
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
                    height: 200,
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50, left: 20, right: 10),
                            child: Text(
                              'your travel mode is aleready selected. So now \n          you can not change Travel Mode. ',
                              style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelnew_app/views/edit_prima_screen/trip_members_screen.dart';
import 'package:travelnew_app/Api/pref_halper.dart';
import '../../model/DayWiseTripModel.dart';
import '../../utils/constant.dart';
import '../humburger_flow/tourist_spot_screen.dart';
import '../humburger_flow/trip_map_screen.dart';
import '../publish your trip/step2.dart';

class PlaceVisitingScreen extends StatefulWidget {
  String hostUid;
  PlaceVisitingScreen({super.key, required this.hostUid});

  @override
  State<PlaceVisitingScreen> createState() => _PlaceVisitingScreenState();
}

class _PlaceVisitingScreenState extends State<PlaceVisitingScreen> {
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
  //   '',
  //   'Day 8',
  //   '',
  //   'Day 9',
  //   '',
  //   'Day 10',
  //   '',
  //   'Day 11',
  //   '',
  //   'Day 12',
  //   '',
  //   'Day 13',
  //   '',
  //   'Day 14',
  //   '',
  //   'Day 15'
  // ];

  final List saveTripList = [
    {'img': 'assets/images/road.png', 'name': 'Road', 'name2': 'Bus'},
    {'img': 'assets/images/train.png', 'name': 'Train', 'name2': 'Train'},
    {'img': 'assets/images/plane.png', 'name': 'Flight', 'name2': 'Flight'},
  ];
  int currentIndex = 0;

  String travelMode = "";

  void getdata() async {
    if (IS_USER_LOGIN) {
      var profile = await FirebaseFirestore.instance.collection('users').doc(widget.hostUid).collection("Prima_Trip_Plan").doc(widget.hostUid).get();
      travelMode = profile.data()?['Mode_of_travel'];
    }
    setState(() {});
  }

  Future<void> getallData() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('users').doc(widget.hostUid).collection('Prima_Trip_Plan').doc(widget.hostUid).collection('tourisprot');
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    setState(() {});
  }

  List allData = [];

  @override
  void initState() {
    getdata();
    getallData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //     height: height(context) * 0.7,
          //     child: ListView.builder(
          //         physics: NeverScrollableScrollPhysics(),
          //         padding: EdgeInsets.zero,
          //         itemCount: dayWiseList.length,
          //         itemBuilder: (context, i) {
          //           return Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   // Text(
          //                   //   dayWiseList[i],
          //                   //   style: bodyText20w700(color: black),
          //                   // ),
          //                 ],
          //               ),
          //               // Text('Monday, Feb 14 2022'),
          //               addVerticalSpace(10),

          //               // const Divider(
          //               //   thickness: 1,
          //               // ),
          //             ],
          //           );
          //         })),
          ...List.generate(
              allData.length,
              (i) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => TouristSpotsScreen(
                          //               MP: allData[i],
                          //             )));

                          // Navigator.push(context, MaterialPageRoute(
                          //   builder: (context) {
                          //     return Detail_touristspot_page(
                          //       i: i,
                          //       MP: DayTripData(
                          //         image: allData[i]['TouristSportImage'] ?? "",
                          //         description: allData[i]['touristDes'] ?? "",
                          //         touristSpot: allData[i]['TouristSportName'] ?? "",
                          //       ),
                          //     );
                          //   },
                          // ));
                        },
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                addVerticalSpace(10),
                                SizedBox(
                                  width: width(context) * 0.50,
                                  child: Text(
                                    allData[i]['TouristSportName'] ?? "",
                                    style: bodyText18w600(color: black),
                                  ),
                                ),
                                addVerticalSpace(5),
                                // Text('Religious,Culture'),
                                // addVerticalSpace(3),
                                SizedBox(
                                  width: width(context) * 0.56,
                                  child: Text(
                                    allData[i]['touristDes'],
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
                            allData[i]['TouristSportImage'] != ""
                                ? SizedBox(
                                    width: width(context) * 0.28,
                                    height: height(context) * 0.12,
                                    child: Image.network(
                                      allData[i]['TouristSportImage'],
                                      fit: BoxFit.fill,
                                    ))
                                : Container(
                                    width: width(context) * 0.28,
                                    height: height(context) * 0.12,
                                    decoration: BoxDecoration(border: Border.all(color: primary)),
                                    child: Center(
                                      child: Text('No Image'),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      addVerticalSpace(30)
                    ],
                  ))
          // ListView.builder(
          //     itemCount: allData.length,
          //     itemBuilder: (ctx, i) {
          //       return ;
          //     }),
          ,
          addVerticalSpace(15),
          // Text(
          //   'How are we going Mumbai to Sinhgad Fort?',
          //   style: bodyText16w600(color: black),
          // ),
          addVerticalSpace(5),
          // Text(
          //   '$travelMode',
          //   style: bodyText14normal(color: black),
          // ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: height(context) * 0.12,
              child: ListView.builder(
                  itemCount: saveTripList.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      onTap: () {
                        // currentIndex = i;
                        // setState(() {});
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          travelMode == saveTripList[i]['name2']
                              ? Container(
                                  height: height(context) * 0.08,
                                  width: width(context) * 0.2,
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.all(15),
                                  decoration:
                                      travelMode == saveTripList[i]['name2'] ? myFillBoxDecoration(0, primary, 10) : myFillBoxDecoration(0, white, 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 25,
                                        child: Image.asset(
                                          saveTripList[i]['img'],
                                          color: travelMode == saveTripList[i]['name2'] ? white : primary,
                                        ),
                                      ),
                                      addVerticalSpace(5),
                                      Text(
                                        saveTripList[i]['name'],
                                        style: bodyText16normal(color: black),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    );
                  }),
            ),
          ),

          addVerticalSpace(height(context) * 0.09)
        ],
      ),
    );
  }
}

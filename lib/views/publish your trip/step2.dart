import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/publish%20your%20trip/publish_your_trip.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/widget/custom_dropdown_button.dart';

import '../../model/DayWiseTripModel.dart';
import '../../model/prima_profile_model.dart';
import 'add_tourist_spots.dart';

addStep2PublishTripDetails() async {
  // Call the user's CollectionReference to add a new user
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  await users
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Prima_Trip_Plan")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
        "Include in trip": DoInTripController.text,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));

  for (int a = 0; a < selectedTouristSpotData.length; a++) {
    await users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Prima_Trip_Plan")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("tourisprot")
        .add(selectedTouristSpotData[a])
        .then((value) {})
        .catchError((error) => print("Failed to add user: $error"));
  }
}

class Step2 extends StatefulWidget {
  const Step2({super.key});

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  // CollectionReference tripCityRef2 = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .collection('Prima_Trip_Plan')
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .collection('tourisprot');

  // Future<void> getalltouristData() async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await tripCityRef2.get();
  //   // Get data from docs and convert map to List
  //   cityTripDataTot = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   setState(() {});
  //   print(cityTripDataTot);
  // }

  //List cityTripDataTot = [];

  // String place = "";
  // void getTripCityData() async {
  //   if (IS_USER_LOGIN) {
  //     var profile = await FirebaseFirestore.instance.collection('TripState').doc('karnataka').collection('TripCity').doc('Bengaluru').get();
  //     // touritSportDes = profile.data()?['TouristSportDesc'];
  //     place = profile.data()?['name'];
  //   }
  //   setState(() {});
  // }

  @override
  void initState() {
    // getDetails();
    super.initState();

    //getalltouristData();
    //getTripCityData();
  }
  // final List<String> tripLocation = ['Pune', 'Mumbai', 'chennai'];
  // void getDetails() async {
  //   if (IS_USER_LOGIN) {
  //     var profile = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('Prima_Trip_Plan')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //     DoInTripController.text = profile.data()?['Include in trip'];
  //
  //     setState(() {});
  //   }
  // }

  showSnackBar(BuildContext context, String str, [Color clr = Colors.black]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: clr,
    ));
  }

  // selectAndAddTrip(int i) {
  //   selectedTouristSpot[i].value = !selectedTouristSpot[i].value;
  //
  //   // Call the user's CollectionReference to add a new user
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   users
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("Prima_Trip_Plan")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("tourisprot")
  //       .add({
  //     "TouristSportImage": cityTripData[i]['image'],
  //     "TouristSportName": cityTripData[i]['name'],
  //     "touristDes": cityTripData[i]['description'],
  //     "address": selectedCityOfPrimaTrip,
  //     "ischeck": selectedTouristSpot[i].value
  //   }).then((value) {
  //     // Navigator.pop(context);
  //     showSimpleTost(context, txt: "Data Updated");
  //   }).catchError((error) => print("Failed to add user: $error"));
  // }

  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    print("----step 2 ${dataSecondPageLodedCount}---");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addVerticalSpace(10),
        Container(
            decoration: myOutlineBoxDecoration(2, black.withOpacity(0.1), 15),
            width: width(context) * 0.94,
            // height: height(context) * 0.08,
            child: TextField(
                controller: DoInTripController,
                maxLines: 3,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    hintStyle: bodyText13normal(color: black),
                    hintText: 'What you’ll do in Trip'))),
        addVerticalSpace(25),
        Text(
          'Click to add it in the trip',
          style: bodyText16w600(color: black),
        ),
        addVerticalSpace(10),
        SizedBox(
            height: height(context) * 0.20,
            child: Obx(
              () => dataSecondPageLodedCount.value
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: PrimaTouristSpot.first.data!.touristSpot!.length,
                      itemBuilder: (ctx, i) {
                     //   print("----------${cityTripData[i]['image']}");
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return Detail_touristspot_page(
                                        i: i,
                                        MP: DayTripData(
                                            image: PrimaTouristSpot.first.data!.touristSpot![i].image,
                                            description: PrimaTouristSpot.first.data!.touristSpot![i].description,
                                            touristSpot:PrimaTouristSpot.first.data!.touristSpot![i].touristSpot,
                                            rank: PrimaTouristSpot.first.data!.touristSpot![i].rank,
                                            type1: PrimaTouristSpot.first.data!.touristSpot![i].type1!),
                                      );
                                    },

                                  ));
                                  //setState(() {});
                                },
                                child: Container(
                                    height: height(context) * 0.11,
                                    width: width(context) * 0.23,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(cityTripData[i]['image']))),
                                    child: Obx(() => selectedTouristSpot[i].value
                                        ? Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                                            alignment: Alignment.topRight,
                                            child: Container(height: 20, width: 20, child: Image.asset('assets/images/bGgyE.png')),
                                          )
                                        : SizedBox())),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                width: width(context) * 0.30,
                                child: Column(
                                  children: [
                                    Text(
                                      '${cityTripData[i]['tourist_spot']}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        //selectAndAddTrip(i);
                                      },
                                      child: Container(
                                        height: height(context) * 0.02,
                                        width: width(context) * 0.15,
                                        decoration: myFillBoxDecoration(0, primary, 10),
                                        child: Center(
                                          child: Text(
                                            'Select',
                                            style: bodyText12Small(color: black),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                  : SizedBox(),
            )),
        addVerticalSpace(15),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (ctx) => AddTouristPointScreen()));
          },
          child: RichText(
              text: TextSpan(
                  children: [
            TextSpan(text: 'Not found the Tourist spot, you can select either the nearest spot or add tourist spot ', style: bodyText12Small(color: black)),
            TextSpan(text: 'here', style: bodyText12Small(color: primary))
          ])
          ),
        ),
      ],
    );
  }
}

class Detail_touristspot_page extends StatefulWidget {
  const Detail_touristspot_page({super.key, required this.MP, required this.i, this.onlyShow = false});
  final DayTripData MP;
  final int i;
  final bool onlyShow;

  @override
  State<Detail_touristspot_page> createState() => _Detail_touristspot_pageState();
}

class _Detail_touristspot_pageState extends State<Detail_touristspot_page> {
  // String hostname = "";
  // void getPrimaDeatials() async {
  //   if (IS_USER_LOGIN) {
  //     var profile = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('primaAccount')
  //         .doc('profile')
  //         .get();
  //     hostname = profile.data()?['fullName'];
  //     setState(() {});
  //   }
  // }

  showSnackBar(BuildContext context, String str, [Color clr = Colors.black]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: clr,
    ));
  }

  selectAndAddTrip() {
    int i = widget.i;

    selectedTouristSpot[i].value = !selectedTouristSpot[i].value;

    // Call the user's CollectionReference to add a new user
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Prima_Trip_Plan")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("tourisprot")
        .add({
      "TouristSportImage": widget.MP.image!,
      "TouristSportName": widget.MP.touristSpot!,
      "touristDes": widget.MP.description!,
      "address": selectedCityOfPrimaTrip,
      "ischeck": selectedTouristSpot[i].value
    }).then((value) {
      Navigator.pop(context);
    }).catchError((error) => print("Failed to add user: $error"));
  }

  @override
  void initState() {
    // getPrimaDeatials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height(context) * 0.42,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(/*widget.MP['image']*/ widget.MP.image != ""
                          ? widget.MP.image!
                          : "https://img.naidunia.com/naidunia/ndnimg/26052020/26_05_2020-tour_and_travel.jpg"))),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                        const Spacer(),
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: const Icon(Icons.bookmark_border_rounded)),
                        // const Padding(
                        //   padding: EdgeInsets.only(right: 12.0, top: 10),
                        //   child:
                        //       ImageIcon(AssetImage('assets/images/forward.png')),
                        // )
                      ],
                    ),
                    const Spacer(),
                    // Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       // Container(
                    //       //   height: 25,
                    //       //   width: width(context) * 0.35,
                    //       //   decoration: myFillBoxDecoration(0, primary, 30),
                    //       //   child: Row(
                    //       //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       //     children:  [
                    //       //       Icon(
                    //       //         Icons.camera_alt_outlined,
                    //       //         size: 20,
                    //       //       ),
                    //       //       Text('$hostname')
                    //       //     ],
                    //       //   ),
                    //       // ),
                    //       // Container(
                    //       //   height: 25,
                    //       //   width: width(context) * 0.15,
                    //       //   decoration: myFillBoxDecoration(0, primary, 30),
                    //       //   child: Row(
                    //       //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       //     children: const [
                    //       //       Text('4'),
                    //       //       Icon(
                    //       //         Icons.star,
                    //       //         size: 15,
                    //       //       ),
                    //       //     ],
                    //       //   ),
                    //       // )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.MP.touristSpot!,
                    style: bodyText30W600(color: black),
                  ),
                  // Text('Religious, Culture.'),
                  addVerticalSpace(15),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primary,
                        size: 20,
                      ),
                      Expanded(
                        child: Text(
                          widget.MP.type1!,
                          style: bodyText16normal(spacing: 1.3, color: black),
                        ),
                      )
                    ],
                  ),
                  addVerticalSpace(3),
                  // Text('Within 10 km From The city center'),
                  addVerticalSpace(20),
                  Text(
                    'About',
                    style: bodyText20w700(color: black),
                  ),
                  addVerticalSpace(10),
                  Text(
                    widget.MP.description!,
                    style: bodyText16normal(spacing: 1.3, color: black),
                  ),
                  addVerticalSpace(15),
                  Text(
                    'Contribute',
                    style: bodyText20w700(color: black),
                  ),
                  addVerticalSpace(10),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          //addRatingDialog(context);
                        },
                        child: Container(
                          height: 30,
                          width: width(context) * 0.25,
                          decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 30),
                          child: Center(
                              child: Text(
                            'Add Ratings',
                            style: bodytext12Bold(color: black),
                          )),
                        ),
                      ),
                      addHorizontalySpace(15),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (ctx) => ImproveListingScreen(
                          //               MP: widget.MP,
                          //             )));
                        },
                        child: Container(
                          height: 30,
                          width: width(context) * 0.25,
                          decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 30),
                          child: Center(
                              child: Text(
                            'Improve listing',
                            style: bodytext12Bold(color: black),
                          )),
                        ),
                      )
                    ],
                  ),
                  // addVerticalSpace(40),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 40, left: 20.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'Not interested in visiting Sri krishna math?',
                  //         style: bodyText16w600(color: black),
                  //       ),
                  //       RichText(
                  //           text: TextSpan(children: [
                  //         TextSpan(
                  //             text: 'Replace a new place',
                  //             style: TextStyle(
                  //                 decoration: TextDecoration.underline,
                  //                 color: primary))
                  //       ]))
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.onlyShow
          ? null
          : InkWell(
              onTap: () {
                selectedTouristSpot[widget.i].value == true
                    ? selectedTouristSpotData.removeAt(widget.i)
                    : selectedTouristSpotData.add({
                        "TouristSportImage": widget.MP.image!,
                        "TouristSportName": widget.MP.touristSpot!,
                        "touristDes": widget.MP.description!,
                        "address": selectedCityOfPrimaTrip,
                        "ischeck": selectedTouristSpot[widget.i].value
                      });

                selectedTouristSpot[widget.i].value == true
                    ? showSnackBar(context, "Your tourist sport has been Added.", primary)
                    : showSnackBar(context, "Your tourist sport has been Deleted.", primary);

                selectedTouristSpot[widget.i].value = !selectedTouristSpot[widget.i].value;
                Navigator.pop(context);
                //selectAndAddTrip();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (ctx) => ImproveListingScreen(
                //               MP: widget.MP,
                //             )));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                height: 50,
                width: width(context) * 0.25,
                decoration: myFillBoxDecoration(0, primary, 30),
                child: Center(
                    child: Text(
                  'Select TouristSpot',
                  style: bodyText16normal(color: black),
                )),
              ),
            ),
    );
  }

  // Future<void> addRatingDialog(BuildContext context) {
  //   return showModalBottomSheet<void>(
  //     isScrollControlled: true,
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(20.0),
  //     ),
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(builder: (context, setState) {
  //         return Container(
  //             padding: EdgeInsets.all(18),
  //             height: height(context) * 0.4,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   widget.MP.touristSpot!,
  //                   style: bodyText18w600(color: black),
  //                 ),
  //                 Text(
  //                   widget.MP.state!,
  //                   style: bodyText16normal(color: black),
  //                 ),
  //                 addVerticalSpace(25),
  //                 Text(
  //                   'Thankyou!',
  //                   style: bodyText18w600(color: black),
  //                 ),
  //                 addVerticalSpace(4),
  //                 SizedBox(
  //                   width: width(context) * 0.7,
  //                   child: Text(
  //                     'Your ratings will contribute to the overall ratings of the tourist spot. This will help fellow travelers',
  //                     style: bodyText14normal(color: black),
  //                   ),
  //                 ),
  //                 addVerticalSpace(30),
  //                 Center(
  //                   child: SizedBox(
  //                     child: Column(
  //                       children: [
  //                         Text(
  //                           'Liked it',
  //                           style: bodyText18w600(color: black),
  //                         ),
  //                         RatingBar.builder(
  //                           initialRating: 4.5,
  //                           minRating: 1,
  //                           itemSize: 40,
  //                           direction: Axis.horizontal,
  //                           allowHalfRating: true,
  //                           itemCount: 5,
  //                           unratedColor: Color.fromRGBO(254, 173, 29, 0.4),
  //                           itemBuilder: (context, _) => const Icon(
  //                             Icons.star_rate_rounded,
  //                             color: Color.fromRGBO(254, 173, 29, 1),
  //                           ),
  //                           onRatingUpdate: (rating) {},
  //                         ),
  //                         addVerticalSpace(8),
  //                         SizedBox(
  //                           width: width(context) * 0.4,
  //                           height: 37,
  //                           child: CustomButton(
  //                               name: 'Submit',
  //                               onPressed: () {
  //                                 Navigator.pop(context);
  //                               }),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ));
  //       });
  //     },
  //   );
  // }
}

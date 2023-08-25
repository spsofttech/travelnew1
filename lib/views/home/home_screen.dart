import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:location/location.dart' as loco;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travelnew_app/Api/pref_halper.dart';
import 'package:travelnew_app/model/home_model.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/home/festival_and_celebrations_screen.dart';
import 'package:travelnew_app/views/home/plan_trip_screen.dart';
import 'package:travelnew_app/views/home/profile_feeds_screen.dart';
import 'package:travelnew_app/views/home/quick_escape_screen.dart';
import 'package:travelnew_app/views/prima/go_prima_screen.dart';
import 'package:travelnew_app/views/start/sign_up_screen.dart';
import 'package:travelnew_app/widget/my_bottom_navbar.dart';
//import 'package:provider/provider.dart';
import 'package:travelnew_app/widget/my_drawer.dart';

import '../../providers/location_provider.dart';
import '../../widget/custom_overlaping_widget.dart';
import '../../widget/slider_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../start/sign_in_screen.dart';
import '../start/signup_with_social_media_screen.dart';

String? finalEmail;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  showSnackBar(BuildContext context, String str, [Color clr = Colors.black]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: clr,
    ));
  }

  festivalsdetail() async {
    final _fireStore = FirebaseFirestore.instance;
    await _fireStore.collection("festivals").doc(FirebaseAuth.instance.currentUser!.uid).set({
      'UID': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  DateTime _date = DateTime.now();
  String _image = "";
  String _festivalname = "";
  var date;
  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('festivals');

  getData() async {
    DocumentSnapshot<Map<String, dynamic>> userDataMap =
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    UserDataMap = userDataMap.data()!;
    USERIMAGE = UserDataMap['image'] ?? "https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_640.png";
    USERNAME = UserDataMap['fullName'] ?? "User";
    USER_UID = FirebaseAuth.instance.currentUser!.uid;
    USER_IS_PRIMA = UserDataMap['isPrima'] ?? false;

    print("--- --- --- --${USER_IS_PRIMA}");
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // allHomeData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //await FirebaseFirestore.instance.collection("festivals").doc('ger54gsdrr34fg124').set(allHomeData[0]);
    // Get data from docs and convert map to List
    allHomeData = querySnapshot.docs.map((doc) => doc.data()).toList();
    //print(allHomeData[0][]);
    setState(() {});
  }

  List allHomeData = [];
  List allQuickData = [];

  List nameList = [];
  // String c1 = "";
  // String c2 = "";
  // String c3 = "";
  // String c4 = "";
  // String c5 = "";
  // String c6 = "";

  Future<void> getQuickEscData1() async {
    CollectionReference _collectionRef11 = FirebaseFirestore.instance.collection('QuickEscapeTrip');

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef11.get();
    // Get data from docs and convert map to List
    allQuickData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {});
    //print(allData);
  }

  // void getquicks() async {
  // if (FirebaseAuth.instance.currentUser != null) {
  //   var profile = await FirebaseFirestore.instance.collection('Quick_Escape').doc('citys').get();
  //   c1 = profile.data()?['Mumbai'];
  //   c2 = profile.data()?['Dehli'];
  //   c3 = profile.data()?['Kolkata'];
  //   c4 = profile.data()?['Lucknow'];
  //   c5 = profile.data()?['Mumbai'];
  //   c6 = profile.data()?['Dehli'];
  // }
  // setState(() {
  //   quickEscapeList = [
  //     {'img': 'assets/images/home2.png', 'name': c1},
  //     {'img': 'assets/images/home3.png', 'name': c2},
  //     {'img': 'assets/images/home4.png', 'name': c3},
  //     {'img': 'assets/images/home5.png', 'name': c4},
  //     {'img': 'assets/images/home2.png', 'name': c5},
  //     {'img': 'assets/images/home3.png', 'name': c6},
  //   ];
  // });
  // }

  String _1name = "";
  // void getQuickEscape() async{
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     var festival = await FirebaseFirestore.instance
  //         .collection('festivals')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //
  //   }
  //   setState(() {
  //
  //   });
  // }

  festivalslocation() async {
    festivalLocationProvider _locationProvider = festivalLocationProvider();
    final _fireStore = FirebaseFirestore.instance;
    print('test');

    print(_locationProvider.lat);
    print(_locationProvider.long);
    await _fireStore.collection("festivals").doc(FirebaseAuth.instance.currentUser!.uid).update({
      "address": _locationProvider.fetchCurrentPosition(),
      "lat": _locationProvider.lat,
      "lng": _locationProvider.long,
      "CarTime": _locationProvider.cartime,
      "TrainTime": _locationProvider.traintime
    });
  }

  registerUser() async {
    LocationProvider _locationProvider = LocationProvider();
    final _fireStore = FirebaseFirestore.instance;
    print('test');

    print(_locationProvider.lat);
    print(_locationProvider.long);
    await _fireStore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
      'address': _locationProvider.fetchCurrentPosition(),
      'lat': _locationProvider.lat,
      'lng': _locationProvider.long,
    });
  }

  void screenNavigate(context) {}

  final List sliderImg = [
    'assets/images/slider1.png',
    'assets/images/slider1.png',
    'assets/images/slider1.png',
  ];

  @override
  void initState() {
    getQuickEscData1();
    getData();
    LocationProvider _locationProvider = LocationProvider();
    _locationProvider.fetchCurrentPosition();
    _locationProvider.getLocation();
    // getValidationData().whenComplete(() async {
    //    final user = FirebaseAuth.instance.currentUser;
    //    if (user == null) {
    //      Timer(Duration(seconds: 60), () {
    //        if (user == null) {
    //          Navigator.push(
    //              context,
    //              MaterialPageRoute(
    //                  builder: ((context) => SignupWithSocialMediaScreen())));
    //        }
    //      });
    //    }
    //  });

    super.initState();
  }

  // Future getValidationData() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   var obtainEmail = sharedPreferences.getString('email');
  //   setState(() {
  //     finalEmail = obtainEmail;
  //   });
  // }
  LocationPermission? permission;
  Future<bool> _handleLocationPermission(BuildContext context) async {
    // bool serviceEnabled;
    loco.Location location = loco.Location();
    bool serviceEnabled;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
      }
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: height(context) * 0.6,
            width: width(context),
            decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/home1.png'))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Text(
                  'Discover \nTravelNew',
                  style: TextStyle(fontSize: 40, color: white, fontWeight: FontWeight.w600),
                ),
                addVerticalSpace(5),
                InkWell(
                  onTap: () async {
                    if (IS_USER_LOGIN ){
                      // LocationProvider _locationProvider = LocationProvider();
                      // await _locationProvider.fetchCurrentPosition();
                      // registerUser();
                      // await _locationProvider.locationDeatials();
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => PlanATrip()));
                    } else {
                      showSnackBar(context, "Please Login First!", Colors.red);
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => SignupWithSocialMediaScreen()));
                    }
                  },
                  child: Container(
                    height: 35,
                    width: 109,
                    decoration: myFillBoxDecoration(0, primary, 8),
                    child: Center(
                      child: Text(
                        'Plan a trip',
                        style: bodyText14w600(color: black),
                      ),
                    ),
                  ),
                ),
                addVerticalSpace(height(context) * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quick Escape',
                      style: bodyText16w600(color: white),
                    ),
                    InkWell(
                      onTap: () async {
                        if (FirebaseAuth.instance.currentUser != null) {
                          LocationProvider _locationProvider = LocationProvider();
                          await _locationProvider.fetchCurrentPosition();
                          registerUser();
                          await _locationProvider.locationDeatials();
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) => QuickEscapeScreen()));
                        } else {
                          showSnackBar(context, "Please Login First!", Colors.red);
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) => SignupWithSocialMediaScreen()));
                        }
                      },
                      child: Text(
                        'View all >',
                        style: bodyText14w600(color: white),
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(5),
                // if (permission == LocationPermission.denied)
                //   SizedBox(
                //     height: height(context) * 0.1,
                //     child: ListView.builder(
                //         itemCount: allQuickData.length,
                //         scrollDirection: Axis.horizontal,
                //         itemBuilder: (context, index) {
                //           return Column(
                //             children: [
                //               CircleAvatar(
                //                 radius: 30,
                //                 backgroundColor: Colors.transparent,
                //                 child: ClipRRect(
                //                   borderRadius: BorderRadius.circular(60),
                //                   child: Image.asset(
                //                     allQuickData[index]['img'],
                //                     fit: BoxFit.fill,
                //                   ),
                //                 ),
                //               ),
                //               Text(
                //                 allQuickData[index]['name'],
                //                 style: bodyText12Small(color: white),
                //               )
                //             ],
                //           );
                //         }),
                //   )
                // else
                SizedBox(
                  height: height(context) * 0.1,
                  child: ListView.builder(
                      itemCount: allQuickData.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    allQuickData[index]['imageUrl'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(
                                allQuickData[index]['city'],
                                style: bodyText12Small(color: white),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          addVerticalSpace(5),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Events & Festivals',
                  style: bodyText20w700(color: black),
                ),
                InkWell(
                  onTap: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => FestivalAndCelebrationsScreen()));
                  },
                  child: Text(
                    'View all >',
                    style: bodyText14w600(color: black),
                  ),
                )
              ],
            ),
          ),
          addVerticalSpace(5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: height(context) * 0.205,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: allHomeData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) {
                    return i == allHomeData.length - 1
                        ? Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 12),
                                height: height(context) * 0.2,
                                width: width(context) * 0.45,
                                child: Card(
                                  elevation: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: height(context) * 0.13,
                                        width: width(context) * 0.45,
                                        child: Image.network(
                                          allHomeData[1]['imageUrl'],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Container(
                                        width: width(context) * 0.37,
                                        padding: const EdgeInsets.only(left: 6.0, top: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  allHomeData[1]['festivalname'],
                                                  style: bodyText16w600(color: black),
                                                ),
                                                SizedBox(
                                                  width: width(context) * 0.35,
                                                  child: Text(
                                                    allHomeData[1]['Date'].toString(),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: bodyText12Small(color: black),
                                                  ),
                                                )
                                              ],
                                            ),
                                            //  OverlapingImageCustomWidget(overlap: overlap)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 4,
                                  left: 4,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => FestivalAndCelebrationsScreen()));
                                    },
                                    child: Container(
                                      height: height(context) * 0.13,
                                      color: black.withOpacity(0.5),
                                      width: width(context) * 0.45,
                                      child: Center(
                                          child: Text(
                                        'View all >',
                                        style: bodyText16w600(color: white),
                                      )),
                                    ),
                                  ))
                            ],
                          )
                        : Container(
                            margin: EdgeInsets.only(right: 12),
                            height: height(context) * 0.2,
                            width: width(context) * 0.45,
                            child: Card(
                              elevation: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height(context) * 0.13,
                                    width: width(context) * 0.45,
                                    child: Image.network(
                                      allHomeData[i]['imageUrl'],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6.0, right: 8, top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              allHomeData[i]['festivalname'],
                                              style: bodyText16w600(color: black),
                                            ),
                                            SizedBox(
                                              width: width(context) * 0.35,
                                              child: Text(
                                                allHomeData[i]['Date'].toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: bodyText12Small(color: black),
                                              ),
                                            )
                                          ],
                                        ),
                                        //OverlapingImageCustomWidget(overlap: overlap)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                  }),
            ),
          ),
          addVerticalSpace(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Profile Feeds',
                  style: bodyText20w700(color: black),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => ProfileFeedScreen()));
                  },
                  child: Text(
                    'View all >',
                    style: bodyText14w600(color: black),
                  ),
                )
              ],
            ),
          ),
          addVerticalSpace(5),
          ProfileFeedWidget(overlap: overlap),
          GoPrimaSubscriptionsWidget(),
          addVerticalSpace(12),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              'Aspired Trips ',
              style: bodyText20w700(color: black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              'Trips grouped together',
              style: bodyText12Small(color: black.withOpacity(0.5)),
            ),
          ),
          addVerticalSpace(5),
          SliderWidget(
            imageList: sliderImg,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 10, top: 10),
            child: Text(
              'Featured',
              style: bodyText20w700(color: black),
            ),
          ),
          Stack(
            children: [
              Container(
                  height: height(context) * 0.48,
                  width: width(context),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          'assets/images/featurepage.png',
                        )),
                  )),
              Positioned(
                  top: height(context) * 0.06,
                  left: 14,
                  child: SizedBox(
                    width: width(context) * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                          style: TextStyle(height: 1.3, fontSize: 28, fontWeight: FontWeight.w600, color: white),
                        ),
                        addVerticalSpace(5),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                          style: TextStyle(height: 1.5, fontSize: 18, fontWeight: FontWeight.w400, color: white),
                        ),
                        addVerticalSpace(height(context) * 0.07),
                        Container(
                          height: 40,
                          width: width(context) * 0.35,
                          decoration: myFillBoxDecoration(0, white, 30),
                          child: Center(
                            child: Text(
                              'Explore',
                              style: bodyText16w600(color: black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          )
        ],
      )),
    );
  }
}

class GoPrimaSubscriptionsWidget extends StatelessWidget {
  const GoPrimaSubscriptionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context) * 0.43,
      width: width(context) * 1,
      decoration: myFillBoxDecoration(0, primary, 15),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10),
          child: Stack(
            children: [
              SizedBox(
                  width: width(context),
                  height: height(context) * 0.22,
                  child: Image.asset(
                    'assets/images/primamain.png',
                    fit: BoxFit.fill,
                  )),
              Positioned(
                bottom: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3.0, top: 10, bottom: 3),
                  child: SizedBox(
                    width: width(context) * 0.45,
                    child: Text(
                      'Go Explore, Go Prima!',
                      style: bodyText30W600(color: white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: SizedBox(
            width: width(context) * 0.8,
            child: Text(
              'Enjoy exclusive features made for travel enthusiasts',
              style: bodyText16w600(color: black),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const GoPrimaSubscriptionScreen()));
          },
          child: Container(
            height: height(context) * 0.05,
            width: width(context) * 0.4,
            margin: const EdgeInsets.only(left: 10, top: 10),
            decoration: myFillBoxDecoration(0, white, 50),
            child: Center(
              child: Text(
                'Get Unique',
                style: bodyText16w600(color: black),
              ),
            ),
          ),
        ),
        addVerticalSpace(height(context) * 0.01,),
        Row(
          children: [
            Spacer(),
            Text(
              '*Subscribe to prima to access full features.',
              style: bodytext12Bold(color: black),
            ),
            addHorizontalySpace(10)
          ],
        )
      ]),
    );
  }
}

class ProfileFeedWidget extends StatefulWidget {
  const ProfileFeedWidget({
    Key? key,
    required this.overlap,
  }) : super(key: key);

  final List overlap;

  @override
  State<ProfileFeedWidget> createState() => _ProfileFeedWidgetState();
}

class _ProfileFeedWidgetState extends State<ProfileFeedWidget> {
  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('festivals');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {});
    log("${allData[0]}");
  }

  List allData = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context) * 0.45,
      child: ListView.builder(
          itemCount: allData.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (
            ctx,
            i,
          ) {
            return InkWell(
              onTap: () {
                if (FirebaseAuth.instance.currentUser != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowDetailsOfFestivals(
                                MP: allData[i],
                              )));
                } else
                //  if (_count == 10)
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupWithSocialMediaScreen(),
                    ),
                  );
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                // padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                // height: height(context) * 0.2,
                width: width(context),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          allData[i]['Date'].toString(),
                          style: bodyText14normal(color: black),
                        ),
                        Text(
                          allData[i]['time'].toString(),
                          style: bodyText12Small(color: black),
                        ),
                        addVerticalSpace(17),
                        Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: width(context) * 0.5,
                                  height: height(context) * 0.13,
                                  child: Image.network(
                                    allData[i]['imageUrl'],
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            addHorizontalySpace(20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width(context) * 0.33,
                                  child: Text(
                                    allData[i]['tripsport'],
                                    style: bodyText14w600(spacing: 1.3, color: black),
                                  ),
                                ),
                                addVerticalSpace(20),
                                OverlapingImageCustomWidget(overlap: widget.overlap)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

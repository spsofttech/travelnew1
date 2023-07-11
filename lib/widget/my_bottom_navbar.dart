import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelnew_app/providers/locProvider.dart';
import 'package:travelnew_app/providers/location_provider.dart';
import 'package:location/location.dart' as loco;

import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/home/inbox_screen.dart';
import 'package:travelnew_app/views/humburger_flow/prima_profile/prima_profile_screen.dart';
import 'package:travelnew_app/views/humburger_flow/upcoming_trips.dart';
import 'package:travelnew_app/widget/custom_tab_indicator.dart';
import 'package:travelnew_app/widget/prima_bottom_navbar.dart';

import '../dummy.dart';
import '../views/home/home_screen.dart';
import '../views/prima/go_prima_screen.dart';
import 'my_drawer.dart';

registerUserSignupPage(String address, String lati, String lngi, String locality) async {
  LocationProvider _locationProvider = LocationProvider();
  List abc = [];
  abc.add(locality + '/$lati/$lngi');
  final _fireStore = FirebaseFirestore.instance;
  if (FirebaseAuth.instance.currentUser != null) {
    print('=========================================');
    var x = await _fireStore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    List y = x.data()!['homeLocations'] ?? [];
    if (y.contains('$locality/$lati/$lngi')) {
      await _fireStore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'address': address, 'lat': lati, 'lng': lngi, 'locality': locality, 'homeLocationIndex': 0}, SetOptions(merge: true));
    } else {
      await _fireStore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set(
          {'address': address, 'lat': lati, 'lng': lngi, 'locality': locality, 'homeLocations': FieldValue.arrayUnion(abc), 'homeLocationIndex': 0},
          SetOptions(merge: true));
    }
  }

  print('-----lat' + lati);
  print('-----lat' + lngi);
}

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({Key? key}) : super(key: key);

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final PageStorageBucket bucket = PageStorageBucket();
  TabController? tabController;

  // final List<Widget> mainScreens = [
  //   HomeScreen(),
  //   UpcomingTripsScreen(),
  //   const Text(''),
  //   const InboxScreen(),
  //   const Text(''),
  // ];

  var _counT = 0;

  void getCounT(_counT) async {
    SharedPreferences counter = await SharedPreferences.getInstance();
    counter.setInt('counT', _counT);
  }

  showSnackBar(BuildContext context, String str, [Color clr = Colors.black]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: clr,
    ));
  }

  // registerUser() async {

  //   LocationProvider _locationProvider = LocationProvider();
  //   final _fireStore = FirebaseFirestore.instance;
  //   print('test');

  //   print(_locationProvider.lat);
  //   print(_locationProvider.long);
  //   await _fireStore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
  //     'address': _locationProvider.fetchCurrentPosition(),
  //     'lat': _locationProvider.lat,
  //     'lng': _locationProvider.long,
  //   });
  // }

  getLoc() async {
    LocationProvider _locationProvider = LocationProvider();
    await _locationProvider.fetchCurrentPosition();
    // registerUser();
    await _locationProvider.locationDeatials();
  }

  @override
  void initState() {
    _getCurrentPosition(context);
    // getData();
    checkupcoming();
    getprimDetails();
    super.initState();

    tabController = TabController(initialIndex: 0, length: 5, vsync: this);
  }

  String check = "";

  void checkupcoming() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("upcomcheck").doc('checktrip').get();
      check = profile.data()?['upcoming'] ?? "";
    }
    setState(() {});
  }

  String Name = "";

  void getprimDetails() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('primaAccount').doc('profile').get();
      Name = profile.data()?['firstName'] ?? "";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print('spppppppp${check}');

    return Scaffold(
      key: _globalKey,
      drawer: MyDrawer(),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(),
            UpcomingTripsScreen(),
            const Text(''),
            const InboxScreen(),
            const Text(''),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          height: 55,
          child: TabBar(
              tabs: [
                const Tab(
                  icon: ImageIcon(
                    AssetImage(
                      'assets/images/navbar1.png',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (check == "") {
                      if (FirebaseAuth.instance.currentUser != null) {
                        empatycomingtrip(context);
                      } else {
                        empatycomingtrip(context);
                        Navigator.pop(context);
                        showSnackBar(context, "Please Login First!", Colors.red);
                      }
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => UpcomingTripsScreen()));
                    }
                  },
                  child: const Tab(
                    icon: SizedBox(
                      height: 100,
                      width: 100,
                      child: ImageIcon(
                        AssetImage(
                          'assets/images/navbar2.png',
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (_counT == 0) {
                      _counT++;
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => const GoPrimaSubscriptionScreen()));
                    } else {
                      if (Name == "") {
                        if (FirebaseAuth.instance.currentUser != null) {
                          empatyprimaccout(context);
                        } else {
                          empatyprimaccout(context);
                          Navigator.pop(context);
                          showSnackBar(context, "Please Login First!", Colors.red);
                        }
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (ctx) => PrimaMyBottomBar()));
                      }
                    }
                    //  if (FirebaseAuth.instance.currentUser != null) {
                    //   if (Name == "") {
                    //     empatyprimaccout(context);
                    //   } else {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (ctx) => const PrimaMyBottomBar()));
                    //   }
                    // } else {
                    //   showSnackBar(
                    //       context, "Please Login First!", Colors.red);
                    // }
                  },
                  child: const Tab(
                    icon: SizedBox(
                      height: 100,
                      width: 100,
                      child: ImageIcon(
                        AssetImage(
                          'assets/images/navbar3.png',
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (FirebaseAuth.instance.currentUser != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => InboxScreen()));
                    } else {
                      showSnackBar(context, "Please Login First!", Colors.red);
                    }
                  },
                  child: const Tab(
                    icon: SizedBox(
                      height: 100,
                      width: 100,
                      child: ImageIcon(
                        AssetImage(
                          'assets/images/navbar4.png',
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _globalKey.currentState!.openDrawer();
                  },
                  child: const Tab(
                    icon: SizedBox(
                      height: 100,
                      width: 100,
                      child: ImageIcon(
                        AssetImage(
                          'assets/images/navbar5.png',
                        ),
                      ),
                    ),
                  ),
                )
              ],
              labelPadding: const EdgeInsets.all(0),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              labelColor: primary,
              unselectedLabelColor: Colors.grey.shade400,
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.all(0.0),
              indicatorColor: primary,
              controller: tabController,
              indicator: const CustomTabIndicator()),
        ),
      ),
    );
  }

  empatycomingtrip(BuildContext context) {
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
                        child: Text(
                      'You not have any upcoming tirp.',
                      style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),
                    )),
                  );
                },
              ),
            ));
  }

  empatyprimaccout(BuildContext context) {
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
                        child: Text(
                      'You not have Prima Account.',
                      style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),
                    )),
                  );
                },
              ),
            ));
  }
}

String _currentAddress = '';
Position? _currentPosition;
String lat = '';
String lng = '';

Future<bool> _handleLocationPermission(BuildContext context) async {
  // bool serviceEnabled;
  LocationPermission permission;
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

Future<void> _getCurrentPosition(BuildContext context) async {
  final hasPermission = await _handleLocationPermission(context);

  if (!hasPermission) return;
  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
    _currentPosition = position;
    _getAddressFromLatLng(_currentPosition!);
  }).catchError((e) {
    debugPrint(e);
  });
}

Future<void> _getAddressFromLatLng(Position position) async {
  await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude).then((List<Placemark> placemarks) {
    Placemark place = placemarks[0];

    _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
    USER_lat = _currentPosition!.latitude;
    USER_long = _currentPosition!.longitude;
    registerUserSignupPage(
        _currentAddress, _currentPosition!.latitude.toStringAsFixed(2), _currentPosition!.longitude.toStringAsFixed(2), place.locality ?? '');
  }).catchError((e) {
    debugPrint(e);
  });
}

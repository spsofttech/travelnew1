import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:social_share_plugin/social_share_plugin.dart';
import 'package:travelnew_app/providers/location_provider.dart';

import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/aspired_trip/aspired_trip2_screen.dart';
import 'package:travelnew_app/views/home/festival_and_celebrations_screen.dart';
import 'package:travelnew_app/views/home/quick_escape_screen.dart';
import 'package:travelnew_app/views/humburger_flow/my_account/my_account.dart';
import 'package:travelnew_app/views/humburger_flow/my_account/my_trip_friends.dart';
import 'package:travelnew_app/views/humburger_flow/my_saved_pins.dart';
import 'package:travelnew_app/views/humburger_flow/prima_profile/create_prima_profile.dart';
import 'package:travelnew_app/views/humburger_flow/trip_library_screen.dart';
import 'package:travelnew_app/views/humburger_flow/upcoming_trips.dart';
import 'package:travelnew_app/views/publish%20your%20trip/publish_your_trip.dart';
import 'package:travelnew_app/views/start/on_boarding_screen.dart';
import 'package:travelnew_app/views/start/signup_with_social_media_screen.dart';

import '../views/edit_prima_screen/prima_trip_1to4_screen.dart';
import '../views/publish your trip/selecteTripFriendPage.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  //  void registerUser() async {
  //    LocationProvider _locationProvider = LocationProvider();
  //    final _fireStore = FirebaseFirestore.instance;
  //    await _fireStore
  //        .collection("users")
  //        .doc(FirebaseAuth.instance.currentUser!.uid)
  //        .update({
  //      'address': _locationProvider.currentAddress,
  //      'lat': _locationProvider.newLatLongList,
  //      'lng': _locationProvider.newLatLongList,
  //   // });
  // // }

  String url = "";
  String name = "";

  void getData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      name = profile.data()?['fullName'] ?? "";
      url = profile.data()?['profileuserImage'] ?? "";
      // USERIMAGE = profile.data()?['image'] ?? "";
      // USERNAME = name;
      setState(() {});
    }
  }

  showSnackBar(BuildContext context, String str, [Color clr = Colors.black]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: clr,
    ));
  }

  bool isExpand = false;
  bool isExpand1 = false;
  bool isExpand2 = false;
  bool isExpand3 = false;

  @override
  void initState() {
    getData();
    getPrimaTrip();
    checkupcoming();
    getprimDetails();
    // registerUser();
    //LocationProvider _locationProvider = LocationProvider();
    // _locationProvider.fetchCurrentPosition();
    super.initState();
  }

  String check = "";
  void checkupcoming() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("upcomingtrip").get();
      //check = profile.docs.first['state'] ?? "";
    }
    setState(() {});
  }

  String Name = "";
  void getprimDetails() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('primaAccount').doc('profile').get();
      Name = profile.data()?['firstName'] ?? "";

      // print("${USERIMAGE} ${USERNAME}");
    }
    setState(() {});
  }

  String uid = "";
  void getPrimaTrip() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Prima_Trip_Plan")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      uid = profile.data()?['Uid'] ?? "";
      USER_UID = uid;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: height(context) * 0.2,
            width: width(context),
            decoration: BoxDecoration(gradient: yellowBlackGradient()),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  backgroundImage: url == "" ? NetworkImage("https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_640.png") : NetworkImage(url),
                ),
                addHorizontalySpace(5),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addVerticalSpace(height(context) * 0.045),
                        Row(
                          children: [
                            Text(
                              'Hii, $name',
                              style: bodyText22w700(color: white),
                            ),
                            addHorizontalySpace(3),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Icon(
                                Icons.edit_note,
                                color: white,
                              ),
                            )
                          ],
                        ),
                        // addVerticalSpace(6),
                        Container(
                          height: 23,
                          width: width(context) * 0.35,
                          decoration: myFillBoxDecoration(0, white, 7),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                            Icon(
                              Icons.star_rate_rounded,
                              color: primary,
                              size: 20,
                            ),
                            Text(
                              'Verified Member',
                              style: bodytext12Bold(color: black),
                            )
                          ]),
                        ),
                        addVerticalSpace(6),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: InkWell(
                              onTap: () {
                                if (FirebaseAuth.instance.currentUser != null) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountScreen()));
                                } else {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupWithSocialMediaScreen()));
                                  showSnackBar(context, "Please Login First!", Colors.red);
                                }
                              },
                              child: Text(
                                'View/ Edit account',
                                style: bodyText14w600(color: black),
                              )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Theme(
            data: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: primary,
                  ),
            ),
            child: ExpansionTile(
              onExpansionChanged: (value) {
                isExpand1 = !isExpand1;
                setState(() {});
              },
              leading: ImageIcon(
                  color: isExpand1 ? primary : black.withOpacity(0.4),
                  const AssetImage(
                    'assets/images/upcomingicon1.png',
                  )),
              title: Text(
                'View / Manage Trips',
                style: bodyText14w600(color: black),
              ),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width(context) * 0.19),
                      child: InkWell(
                          onTap: () {
                            // if (check == "") {
                            //   if (FirebaseAuth.instance.currentUser != null) {
                            //     empatycomingtrip(context);
                            //   } else {
                            //     empatycomingtrip(context);
                            //     Navigator.pop(context);
                            //     showSnackBar(context, "Please Login First!", Colors.red);
                            //   }
                            // } else {
                            //   Navigator.push(context, MaterialPageRoute(builder: (ctx) => UpcomingTripsScreen()));
                            // }
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) => UpcomingTripsScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const ImageIcon(
                                AssetImage('assets/images/navbar2.png'),
                              ),
                              addHorizontalySpace(10),
                              Text('Upcoming Trips'),
                            ],
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width(context) * 0.195, top: 8),
                      child: InkWell(
                        onTap: () {
                          if (FirebaseAuth.instance.currentUser != null) {
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) => TripLibraryScreen()));
                          } else {
                            Navigator.pop(context);
                            showSnackBar(context, "Please Login First!", Colors.red);
                          }
                        },
                        child: Row(
                          children: [
                            const ImageIcon(
                              AssetImage('assets/images/menuicon1.png'),
                            ),
                            addHorizontalySpace(10),
                            Text('Trip Library'),
                          ],
                        ),
                      ),
                    ),
                    addVerticalSpace(8)
                  ],
                ),
              ],
            ),
          ),
          Theme(
            data: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: primary,
                  ),
            ),
            child: ExpansionTile(
              onExpansionChanged: (value) {
                isExpand = !isExpand;
                setState(() {});
              },
              leading: ImageIcon(
                  color: isExpand ? primary : black.withOpacity(0.4),
                  const AssetImage(
                    'assets/images/menu3.png',
                  )),
              title: Text(
                'Prima',
                style: bodyText14w600(color: black),
              ),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width(context) * 0.195),
                      child: InkWell(
                          onTap: () {
                            if (FirebaseAuth.instance.currentUser != null) {
                              Navigator.push(context, MaterialPageRoute(builder: (ctx) => CreatePrimaProfile()));
                            } else {
                              Navigator.pop(context);
                              showSnackBar(context, "Please Login First!", Colors.red);
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.person),
                              addHorizontalySpace(10),
                              Text('Prima Profile'),
                            ],
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width(context) * 0.195, top: 8),
                      child: InkWell(
                        onTap: () {
                          if (USER_IS_PRIMA == false) {
                            if (FirebaseAuth.instance.currentUser != null) {
                              printc("txt");
                              empatyprimaccout(context);
                            } else {
                              empatyprimaccout(context);
                              Navigator.pop(context);
                              showSnackBar(context, "Please Login First!", Colors.red);
                            }
                          } else if (uid == "") {
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) => PublishYourTripScreen()));
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) => PrimaTrip1To4Screens()));
                          }
                        },
                        child: Row(
                          children: [
                            const ImageIcon(
                              AssetImage('assets/images/menuicon2.png'),
                            ),
                            addHorizontalySpace(10),
                            Text('Prima Trip'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width(context) * 0.195, top: 8),
                      child: InkWell(
                        onTap: () {
                          if (FirebaseAuth.instance.currentUser != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => selectTripFriendPage(
                                          title: 'Friends in vicinity',
                                        )));
                          } else {
                            Navigator.pop(context);
                            showSnackBar(context, "Please Login First!", Colors.red);
                          }
                        },
                        child: Row(
                          children: [
                            const ImageIcon(
                              AssetImage('assets/images/menuicon3.png'),
                            ),
                            addHorizontalySpace(10),
                            Text('Friends in Vicinity'),
                          ],
                        ),
                      ),
                    ),
                    addVerticalSpace(8)
                  ],
                ),
              ],
            ),
          ),
          Theme(
            data: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: primary,
                  ),
            ),
            child: ExpansionTile(
              onExpansionChanged: ((value) {
                isExpand2 = !isExpand2;
                setState(() {});
              }),
              leading: ImageIcon(
                  color: isExpand2 ? primary : black.withOpacity(0.4),
                  const AssetImage(
                    'assets/images/menu4.png',
                  )),
              title: Text(
                'Explore Interesting',
                style: bodyText14w600(color: black),
              ),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: width(context) * 0.195,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => aspiredScreen()));
                        },
                        child: Row(
                          children: [
                            const ImageIcon(
                              AssetImage('assets/images/menuicon1.png'),
                            ),
                            addHorizontalySpace(10),
                            Text('Aspired Trips'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width(context) * 0.195, top: 8),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FestivalAndCelebrationsScreen()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.travel_explore_outlined),
                              addHorizontalySpace(10),
                              Text('Events & Festivals'),
                            ],
                          )),
                    ),
                    addVerticalSpace(8)
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: ImageIcon(
                color: black.withOpacity(0.4),
                const AssetImage(
                  'assets/images/menu6.png',
                )),
            title: Text(
              'Quick Escape',
              style: bodyText14w600(color: black),
            ),
            onTap: () async {
              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => QuickEscapeScreen()));
              } else {
                showSnackBar(context, "Please Login First!", Colors.red);
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => SignupWithSocialMediaScreen()));
              }
            },
          ),
          Theme(
            data: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: primary,
                  ),
            ),
            child: ExpansionTile(
              onExpansionChanged: ((value) {
                setState(() {
                  isExpand3 = !isExpand3;
                });
              }),
              leading: ImageIcon(
                  color: isExpand3 ? primary : black.withOpacity(0.4),
                  const AssetImage(
                    'assets/images/menu5.png',
                  )),
              title: Text(
                'My Saved Pins',
                style: bodyText14w600(color: black),
              ),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.only(
                    //       left: width(context) * 0.03, bottom: 10),
                    //   child: InkWell(
                    //     onTap: () {
                    //       if (FirebaseAuth.instance.currentUser != null) {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (ctx) => MySavedPinsScreens()));
                    //       } else {
                    //         Navigator.pop(context);
                    //         showSnackBar(
                    //             context, "Please Login First!", Colors.red);
                    //       }
                    //     },
                    //     child: Text('Trip City'),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: width(context) * 0.03, bottom: 10),
                      child: InkWell(
                        onTap: () {
                          if (FirebaseAuth.instance.currentUser != null) {
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) => MySavedPinsScreens()));
                          } else {
                            Navigator.pop(context);
                            showSnackBar(context, "Please Login First!", Colors.red);
                          }
                        },
                        child: Text('Tourist Spots'),
                      ),
                    ),
                    addVerticalSpace(8)
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: ImageIcon(
                color: black.withOpacity(0.4),
                const AssetImage(
                  'assets/images/menu7.png',
                )),
            title: InkWell(
              onTap: () {
                rating(context);
              },
              child: Text(
                'Rate us on App Store',
                style: bodyText14w600(color: black),
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Share.share("https://play.google.com/store/apps/details?id=com.instructivetech.testapp");
                },
                child: Image.asset(
                  'assets/images/Subtract.png',
                  fit: BoxFit.fill,
                ),
              ),
              InkWell(
                onTap: () {
                  Share.share("https://play.google.com/store/apps/details?id=com.instructivetech.testapp");
                },
                child: Image.asset(
                  'assets/images/Subtract (1).png',
                  fit: BoxFit.fill,
                ),
              ),
              InkWell(
                onTap: () {
                  Share.share("https://play.google.com/store/apps/details?id=com.instructivetech.testapp");
                },
                child: Image.asset(
                  'assets/images/Subtract (2).png',
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.all(9),
              height: height(context) * 0.3,
              // width: width(context) * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/tp1.png',
                  fit: BoxFit.fill,
                ),
              )),
          addVerticalSpace(height(context) * 0.06),
          Center(
            child: Text(
              'App Version 1.2022',
              style: bodyText12Small(color: black),
            ),
          ),
          addVerticalSpace(10)
        ],
      ),
    );
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

  rating(BuildContext context) {
    double rating = 0;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.all(6),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  return Container(
                    height: 200,
                    child: Scaffold(
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('App Rating'),
                            addVerticalSpace(40),
                            RatingBar.builder(
                              maxRating: 1,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) => setState(() {
                                // this.rating = rating;
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ));
  }
}

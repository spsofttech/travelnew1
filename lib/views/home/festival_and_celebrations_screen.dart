import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelnew_app/views/aspired_trip/save_trip_and_get_qoute.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/views/start/signup_with_social_media_screen.dart';
import '../../Api/Api_Helper.dart';
import '../../Api/model/event_trip_get_model.dart';
import '../../model/home_model.dart';
import '../../services/db/firebaseDB.dart';
import '../../utils/constant.dart';
import '../../widget/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelnew_app/utils/constant.dart';
import '../../../utils/constant.dart';
import '../../widget/custom_overlaping_widget.dart';
import '../../widget/custom_textfield.dart';
import '../aspired_trip/save_festival_trip_and_get_qoute.dart';
import '../humburger_flow/my_account/trip_intrest_screen.dart';
import '../humburger_flow/trip_library_screen.dart';
import 'package:travelnew_app/Api/pref_halper.dart';
var _count = 0;
void getCount(_count) async {
  SharedPreferences counter = await SharedPreferences.getInstance();
  counter.setInt('count', _count);
}

class FestivalAndCelebrationsScreen extends StatefulWidget {
  const FestivalAndCelebrationsScreen({super.key});

  @override
  State<FestivalAndCelebrationsScreen> createState() => _FestivalAndCelebrationsScreenState();
}

class _FestivalAndCelebrationsScreenState extends State<FestivalAndCelebrationsScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 12, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            )),
        title: Text(
          'Festivals and Celebrations',
          style: bodyText20w700(color: black),
        ),
        actions: [
          // InkWell(
          //   onTap: () {
          //     if (IS_USER_LOGIN) {
          //       filterDialog(context);
          //     } else {
          //       Navigator.push(context, MaterialPageRoute(builder: (ctx) => SignupWithSocialMediaScreen()));
          //     }
          //   },
          //   child: Row(
          //     children: [
          //       Text(
          //         'Filter',
          //         style: bodyText14w600(color: black),
          //       ),
          //       Icon(
          //         Icons.filter_alt_outlined,
          //         color: black,
          //       ),
          //       addHorizontalySpace(10)
          //     ],
          //   ),
          // ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: height(context) * 0.88,
            child: Column(
              children: [
                addVerticalSpace(5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TabBar(
                    padding: EdgeInsets.zero,
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
                    labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    tabs: const [
                      Tab(
                        text: 'January',
                      ),
                      Tab(
                        text: 'February',
                      ),
                      Tab(
                        text: 'March',
                      ),
                      Tab(
                        text: 'April',

                      ),Tab(
                        text: 'May',
                      ),Tab(
                        text: 'June',
                      ),Tab(
                        text: 'July',
                      ),Tab(
                        text: 'August',
                      ),Tab(
                        text: 'September',
                      ),Tab(
                        text: 'October',
                      ),Tab(
                        text: 'November',
                      ),Tab(
                        text: 'Desember',
                      ),
                    ].reversed.toList(),
                  ),
                ),
                Expanded(
                  child: TabBarView(controller: _tabController, children: const [
                    FestivalsDataList(index: 12),
                    FestivalsDataList(index: 11),
                    FestivalsDataList(index: 10),
                    FestivalsDataList(index: 9),
                    FestivalsDataList(index: 8),
                    FestivalsDataList(index: 7),
                    FestivalsDataList(index: 6),
                    FestivalsDataList(index: 5),
                    FestivalsDataList(index: 4),
                    FestivalsDataList(index: 3),
                    FestivalsDataList(index: 2),
                    FestivalsDataList(index: 1),
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FestivalsDataList extends StatefulWidget {
 final int index;
  const FestivalsDataList({
   required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<FestivalsDataList> createState() => _FestivalsDataListState();
}

class _FestivalsDataListState extends State<FestivalsDataList> {
  @override
  void initState() {
   // getData();
    super.initState();
  }

  //CollectionReference _collectionRef = FirebaseFirestore.instance.collection('festivals');

  // Future<void> getData() async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await _collectionRef.get();
  //   // Get data from docs and convert map to List
  //   allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   setState(() {});
  //   print(allData);
  // }
  //
  // List allData = [];

  String _id = "";
  String _location = "";
  String _subtitle = "";
  String _title = "";
  String _imagee = "";
  bool isBookmarked = false;
  List Bookmarklist = [];

  // void bookmark() {
  //   if (isBookmarked = false) {
  //     Bookmarklist.removeAt(Bookmarklist.indexOf(['name']));
  //     CollectionReference users = FirebaseFirestore.instance.collection('users');
  //     users.doc(FirebaseAuth.instance.currentUser!.uid).collection("bookmarks").add({
  //       'id': _id,
  //       'image': _imagee,
  //       'location': _location,
  //       'subtitle': _subtitle,
  //       'title': _title,
  //     });
  //     setState(() {
  //       isBookmarked = !isBookmarked;
  //     });
  //   } else {
  //     Bookmarklist.add(context);
  //     CollectionReference users = FirebaseFirestore.instance.collection('users');
  //     users.doc(FirebaseAuth.instance.currentUser!.uid).collection("bookmarks").add({
  //       'id': _id,
  //       'image': _imagee,
  //       'location': _location,
  //       'subtitle': _subtitle,
  //       'title': _title,
  //     });
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height(context) * 0.87,
        child: FutureBuilder(
        future: ApiHelper.get_event_trip_apiCall(month: widget.index),
    builder: (context, snapshot) {
    if(snapshot.hasData){
    List<Data> allData=snapshot.data!.data!;
    print(snapshot.data!.data);

    return allData.length>0?ListView.builder(
        itemCount: allData.length,
        itemBuilder: (ctx, i) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  if (IS_USER_LOGIN) {
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
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  height: height(context) * 0.385,
                  width: width(context) * 0.93,
                  alignment: Alignment.center,
                  decoration: shadowDecoration(15, 2),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                              height: 200,
                              width: width(context) * 0.9,
                              child: Image.network(
                                allData[i].image==""|| blanImageStrings.contains(allData[i].image)?NoTripNetworkImage:allData[1].image!,
                                fit: BoxFit.fill,
                              )),

                          // Positioned(
                          //   top: -5,
                          //   right: -5,
                          //   child: IconButton(
                          //       onPressed: () async {
                          //         // Navigator.push(context, MaterialPageRoute(builder: (context)=>TripLibraryScreen()));
                          //         //  bookmark();
                          //         if (!isBookmarked) {
                          //           Bookmarklist.add(context);
                          //           DocumentReference users =
                          //               FirebaseFirestore.instance
                          //                   .collection('users')
                          //                   .doc(FirebaseAuth
                          //                       .instance.currentUser!.uid)
                          //                   .collection("bookmarks")
                          //                   .doc();
                          //           users.set({
                          //             'id': _id,
                          //             "postID": users.id,
                          //             'image': _imagee,
                          //             'location': _location,
                          //             'subtitle': _subtitle,
                          //             'title': _title,
                          //           });
                          //         } else {
                          //           var trip = await FirebaseFirestore
                          //               .instance
                          //               .collection('users')
                          //               .doc(FirebaseAuth
                          //                   .instance.currentUser!.uid)
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
                          Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                height: height(context) * 0.06,
                                width: width(context) * 0.95,
                                padding: EdgeInsets.only(left: 5),
                                color: black.withOpacity(0.4),
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
                                          allData[i].startDate.toString(),
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
                                          allData[i].homeLocation.toString(),
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
                              allData[i].tripName!,
                              style: bodyText22w700(color: black),
                            ),
                            Text(
                              '${allData[i].description}',
                              style: bodyText14normal(color: black),
                            ),
                            addVerticalSpace(5),
                            OverlapingImageCustomWidget(overlap: overlap),
                            // addVerticalSpace(5),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     Image.asset(
                            //       'assets/images/cardrive.png',
                            //     ),
                            //     addHorizontalySpace(5),
                            //     SizedBox(
                            //       width: width(context) * 0.15,
                            //       child: Row(
                            //         children: [
                            //           Text(
                            //             allData[i].endDate.toString(),
                            //             style: bodytext12Bold(color: black),
                            //           ),
                            //           Text(
                            //             ' hours',
                            //             style: bodytext12Bold(color: black),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     Text(
                            //       '  |  ',
                            //       style: bodyText16normal(color: black),
                            //     ),
                            //     Image.asset(
                            //       'assets/images/train2.png',
                            //     ),
                            //     addHorizontalySpace(5),
                            //     SizedBox(
                            //       width: width(context) * 0.15,
                            //       child: Row(
                            //         children: [
                            //           Text(
                            //             allData[.toString(),
                            //             style: bodytext12Bold(color: black),
                            //           ),
                            //           Text(
                            //             ' hours',
                            //             style: bodytext12Bold(color: black),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     Text(
                            //       '  |  ',
                            //       style: bodyText16normal(color: black),
                            //     ),
                            //     Image.asset(
                            //       'assets/images/flight.png',
                            //     ),
                            //     addHorizontalySpace(5),
                            //     SizedBox(
                            //       width: width(context) * 0.15,
                            //       child: Text(
                            //         'No direct flights',
                            //         style: bodytext12Bold(color: black),
                            //       ),
                            //     )
                            //   ],
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }):Center(child: Text("Not Any Trip In this Month",style: TextStyle(color: primary),textAlign: TextAlign.center,),);
    }
    else if(snapshot.hasError){
    return Center(child: Text("${snapshot.error}"),);
    }
    else{
    return Center(child: CircularProgressIndicator(color: primary,),);
    }
    },));
  }
}

class ShowDetailsOfFestivals extends StatefulWidget {
  final Data MP;
  ShowDetailsOfFestivals({
    super.key,
    required this.MP,
  });

  @override
  State<ShowDetailsOfFestivals> createState() => _ShowDetailsOfFestivalsState();
}

class _ShowDetailsOfFestivalsState extends State<ShowDetailsOfFestivals> {
  @override
  void initState() {
    //getfestivals();
    getpermission();
    super.initState();
  }

  // String _address = "";
  // var _date;
  // String _image ="";
  // String _festivalname = "";
  // String _about = "";
  // var cartime;
  // var traintime;
  // List _nearbytouristname = [];
  // List _nearbyturistimage = [];
  // String _includes="";
  // void getfestivals() async{
  //   if (IS_USER_LOGIN) {
  //     var festival = await FirebaseFirestore.instance
  //         .collection('festivals')
  //         .doc('K5WCDLS8g0fZPM9Bgg9FPfcyuiu2')
  //         .get();
  //
  //     _festivalname = festival.data()?['festivalname'];
  //     _image = festival.data()?['imageUrl'];
  //     _date = festival.data()?['Date'];
  //     _address = festival.data()?['locality'];
  //     _about = festival.data()?['about'];
  //     _nearbytouristname = festival.data()?['nearbytouristname'];
  //     _nearbyturistimage = festival.data()?['nearbyturistimage'];
  //     _includes = festival.data()?['includes'];
  //   }
  //
  //   setState(() {});
  // }
  String _mobileNum = "";
  String _email = "";
  void getpermission() async {
    if (IS_USER_LOGIN) {
      var per =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('primaAccount').doc('profile').get();
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
  List Bookmarklist = [];
  // void bookmark() {
  //   if (isBookmarked = false) {
  //     Bookmarklist.removeAt(Bookmarklist.indexOf(['name']));
  //     CollectionReference users =
  //         FirebaseFirestore.instance.collection('users');
  //     users
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection("bookmarks")
  //         .add({
  //       'id': _id,
  //       'image': _imagee,
  //       'location': _location,
  //       'subtitle': _subtitle,
  //       'title': _title,
  //     });
  //     setState(() {
  //       isBookmarked = !isBookmarked;
  //     });
  //   } else {
  //     Bookmarklist.add(context);
  //     CollectionReference users =
  //         FirebaseFirestore.instance.collection('users');
  //     users
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection("bookmarks")
  //         .add({
  //       'id': _id,
  //       'image': _imagee,
  //       'location': _location,
  //       'subtitle': _subtitle,
  //       'title': _title,
  //     });
  //     setState(() {});
  //   }
  // }

  addsavetrip() async {
    if (IS_USER_LOGIN) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("upcomingtrip")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({});
      setState(() {});
    }
  }

  updatesavetrip() async {
    if (IS_USER_LOGIN) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("upcomingtrip")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({});
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height(context) * 0.42,
                  width: double.infinity,
                  decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(
                    widget.MP.image==""|| blanImageStrings.contains(widget.MP.image)?NoTripNetworkImage:widget.MP.image!,
                  ))),
                  child: SafeArea(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              // if (_count == 10) {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           SignupWithSocialMediaScreen(),
                              //     ),
                              //   );
                              // } else {
                              //_count++;
                              Navigator.pop(context);
                              //}
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                        Spacer(),
                        Positioned(
                          top: -5,
                          right: -5,
                          child: IconButton(
                              onPressed: () async {
                                SharedPreferences _prefs = await SharedPreferences.getInstance();
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
                                    'location': _location,
                                    'subtitle': _subtitle,
                                    'title': _title,
                                  });
                                } else {
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
                        const Padding(
                          padding: EdgeInsets.only(right: 12.0, top: 10),
                          child: ImageIcon(AssetImage('assets/images/forward.png')),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.MP.tripName!,
                        style: bodyText30W600(color: black),
                      ),
                      // Text(
                      //   'Religious, Culture.',
                      // ),
                      addVerticalSpace(8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: primary,
                          ),
                          Text(
                            widget.MP.homeLocation!,
                            style: bodyText16normal(color: black),
                          )
                        ],
                      ),
                      addVerticalSpace(10),
                      Text(
                        'About',
                        style: bodyText20w700(color: black),
                      ),
                      addVerticalSpace(5),
                      Text(
                        widget.MP.description!,
                        style: TextStyle(height: 1.3, fontSize: 18, fontWeight: FontWeight.w300, color: black),
                      ),
                      addVerticalSpace(15),
                      Row(
                        children: [
                          addHorizontalySpace(7),
                          Stack(
                            children: [
                              Container(
                                width: width(context) * 0.32,
                                child: Row(
                                  children: [
                                    for (int i = 0; i < overlap2.length; i++)
                                      Align(
                                        widthFactor: 0.5,
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: white,
                                          backgroundImage: AssetImage(overlap2[i]),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  left: 80,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.blue.withOpacity(0.4),
                                    child: Text(
                                      '+ 50',
                                      style: bodyText11Small(color: white),
                                    ),
                                  ))
                            ],
                          ),
                          Text('Shown Interest')
                        ],
                      ),
                      addVerticalSpace(15),
                      Text(
                        'Nearby Tourist Spots',
                        style: bodyText20w700(color: black),
                      ),
                      addVerticalSpace(15),
                      SizedBox(
                        height: height(context) * 0.16,
                        child: ListView.builder(
                            itemCount: widget.MP.touristSpot!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, i) {
                              return Column(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    margin: EdgeInsets.only(right: 8),
                                    height: height(context) * 0.12,
                                    width: width(context) * 0.37,
                                    child: Image.network(
                              widget.MP.touristSpot![i].image! ==""|| blanImageStrings.contains(widget.MP.touristSpot![i].image!)?NoTripNetworkImage:widget.MP.touristSpot![i].image!,


                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                addVerticalSpace(5),
                                Text(
                                  widget.MP.touristSpot![i].state!,
                                )
                              ]);
                            }),
                      ),
                      addVerticalSpace(10),
                      Text(
                        'Includes',
                        style: bodyText20w700(color: black),
                      ),
                      addVerticalSpace(5),
                      Text(
                        widget.MP.highlight!,
                        style: TextStyle(height: 1.3, fontSize: 18, fontWeight: FontWeight.w300, color: black),
                      ),
                      addVerticalSpace(35),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: height(context) * 0.05,
            left: 9,
            child: CustomButton(
                name: 'Interested! Save Trip and Get Quote',
                onPressed: () {
                  if (_email == "" || _mobileNum == "") {
                    NumberpoppubDialog(context);
                  } else {
                    if (FirebaseAuth.instance.currentUser!.uid != null) {
                      updatesavetrip();
                      // addsavetrip();
                    } else {
                      // updatesavetrip();
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => SaveFestivalTripAndGetQuote(
                                message1: 'The best mode of travel and travel booking will be suggested by our travel partner for this trip',
                                message2: '')));
                  }
                }),
          )
        ],
      ),
    );
  }
}

filterDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            contentPadding: const EdgeInsets.all(6),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Builder(
              builder: (context) {
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;

                return Container(height: 500, child: YourFilter());
              },
            ),
          ));
}

NumberpoppubDialog(BuildContext context) {
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();

  updatePrimaAccountDetails() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("primaAccount")
        .doc("profile")
        .update({
          "mobileNumber": mobileNumber.text,
          "emailId": emailcontroller.text,
        })
        .then((value) => print("Details Updated"))
        .catchError((error) => print("Failed to Update users Details: $error"));
  }

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
                    height: 500,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Your contact details are required for Travel operators to contact and send the booking details',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        addVerticalSpace(15),
                        SizedBox(
                            height: 37,
                            width: width * 0.65,
                            child: CustomTextFieldWidget(
                              labelText: 'Mobile number',
                              controller: mobileNumber,
                            )),
                        addVerticalSpace(10),
                        SizedBox(
                            height: 37,
                            width: width * 0.65,
                            child: CustomTextFieldWidget(
                              labelText: 'Email',
                              controller: emailcontroller,
                            )),
                        addVerticalSpace(10),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: chekbox(),
                        ),
                        addVerticalSpace(30),
                        Container(
                            width: 255,
                            child: CustomButton(
                                name: 'Submit',
                                onPressed: () {
                                  updatePrimaAccountDetails();
                                  Navigator.pop(context);
                                }))
                      ],
                    ));
              },
            ),
          ));
}

class YourFilter extends StatefulWidget {
  @override
  _YourFilterState createState() => _YourFilterState();
}

class _YourFilterState extends State<YourFilter> {
  List chipList = [
    {'name': "Temple festivals", 'isSelect': false},
    {'name': "Local festivals", 'isSelect': false},
    {'name': "Local melas", 'isSelect': false},
    {'name': "Big festivals", 'isSelect': false},
    {'name': "Cattle festivals", 'isSelect': false},
  ];

  void getFilteredfestival() async {
    for (var element in chipList) {
      if (chipList.isEmpty) {
        if ((element['festivalname'] ?? '').toString().toLowerCase().contains(chipList.toString().toLowerCase())) {
          FirebaseFirestore.instance.collection('festivals').doc(FirebaseAuth.instance.currentUser!.uid).get();
          print('festival filtered');
        }
      }
    }
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Filter',
                        style: bodyText18w600(color: black),
                      ),
                    ],
                  ),
                ),
                FilterWidget(chipName: chipList),
                addVerticalSpace(15),
                Positioned(
                  bottom: 30,
                  left: width(context) * 0.25,
                  child: SizedBox(
                    width: width(context) * 0.5,
                    child: CustomButton(
                        name: 'use',
                        onPressed: () {
                          getFilteredfestival();
                          //  Navigator.pop(context);
                        }),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FilterWidget extends StatefulWidget {
  final List chipName;

  FilterWidget({required this.chipName});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context) * 0.30,
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.chipName.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.8),
          itemBuilder: (ctx, i) {
            return InkWell(
              onTap: () {
                setState(() {
                  widget.chipName[i]['isSelect'] = !widget.chipName[i]['isSelect'];
                });
              },
              child: Container(
                margin: EdgeInsets.all(5),
                height: height(context) * 0.045,
                width: width(context) * 0.3,
                decoration: widget.chipName[i]['isSelect'] ? myFillBoxDecoration(0, primary, 50) : myOutlineBoxDecoration(2, primary, 50),
                child: Center(
                  child: Text(widget.chipName[i]['name']),
                ),
              ),
            );
          }),
    );
  }
}

class chekbox extends StatefulWidget {
  const chekbox({Key? key}) : super(key: key);

  @override
  State<chekbox> createState() => _chekboxState();
}

class _chekboxState extends State<chekbox> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: this.value,
            activeColor: primary,
            checkColor: Colors.black,
            onChanged: (bool? value) {
              setState(() {
                this.value = value!;
              });
            },
          ),
          Text(
            'Save to my profile',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

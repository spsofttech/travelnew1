import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:travelnew_app/chatUtils/IndividualChatScreen.dart';
import 'package:travelnew_app/model/prima_profile_model.dart';
import 'package:travelnew_app/views/humburger_flow/prima_profile/about_me_screen.dart';
import 'package:travelnew_app/views/humburger_flow/prima_profile/create_prima_profile.dart';
import 'package:travelnew_app/views/humburger_flow/prima_profile/prima_my_account_screen.dart';
import 'package:travelnew_app/views/humburger_flow/prima_profile/travel_photos_screen.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/widget/custom_dropdown_button.dart';
import 'package:travelnew_app/Api/pref_halper.dart';
import '../../../chatUtils/chatModel.dart';
import '../../../utils/constant.dart';

class UserPrimaProfileScreen extends StatefulWidget {
  const UserPrimaProfileScreen({super.key, required this.userDetails, required this.chat});
  final Map<String, dynamic> userDetails;
  final ChatModel chat;
  @override
  State<UserPrimaProfileScreen> createState() => _UserPrimaProfileScreenState();
}

class _UserPrimaProfileScreenState extends State<UserPrimaProfileScreen> {
  String imgURL = '';
  getData() async {
    var x = await FirebaseFirestore.instance.collection('users').doc(widget.chat.sender).get();
    imgURL = x.data()!['profileImg'] ??
        'https://firebasestorage.googleapis.com/v0/b/travelnew-79e2e.appspot.com/o/profileImg?alt=media&token=39dc5e0e-8a3d-41cf-94c0-8ca03147aa7a';
    setState(() {});
  }

  @override
  void initState() {
    print(widget.userDetails);
    getDetails();
    getlocationDetails();
    super.initState();
  }

  List travelPhoto = [
    'assets/images/Rectangle 111.png',
    'assets/  images/Rectangle 111 (1).png',
    'assets/images/Rectangle 111 (2).png',
    'assets/images/Rectangle 111 (3).png',
  ];
  String Name = "";
  String image = "";
  String _profession = "";
  String _aboutme = "";
  String _otherintrest = "";
  void getDetails() async {
    if (IS_USER_LOGIN) {
      var profile =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('primaAccount').doc('profile').get();
      image = profile.data()?['imageUrl'];
      // Name = profile.data()?['fullName'];
      Name = profile.data()?['fullName'];
      _profession = profile.data()!['profession'];
      _aboutme = profile.data()?['aboutme'];
      _otherintrest = profile.data()?['userInterest'];
      setState(() {});
    }
  }

  String _address = "";
  void getlocationDetails() async {
    if (IS_USER_LOGIN) {
      var profile = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      _address = profile.data()?['locality'];
      setState(() {});
    }
  }

  Widget EditAction() {
    return Text.rich(TextSpan(children: [
      WidgetSpan(
          child: Icon(
        Icons.edit,
        color: Colors.yellow,
      )),
      WidgetSpan(
          child: SizedBox(
        width: 10,
      )),
      TextSpan(text: "Edit Profile")
    ]));
  }

  Widget SubscriptionAction() {
    return Text.rich(TextSpan(children: [
      WidgetSpan(
          child: ImageIcon(
        AssetImage("assets/images/editicon.png"),
        color: Colors.yellow,
      )),
      WidgetSpan(
          child: SizedBox(
        width: 10,
      )),
      TextSpan(text: "My Prima Subscriptions")
    ]));
  }

  Widget ShareProfileAction() {
    return Text.rich(TextSpan(children: [
      WidgetSpan(
        child: Icon(
          Icons.share,
          color: Colors.yellow,
        ),
      ),
      WidgetSpan(
          child: SizedBox(
        width: 10,
      )),
      TextSpan(text: "Share Profile")
    ]));
  }

  Widget ActivityProfileAction() {
    return Text.rich(TextSpan(children: [
      WidgetSpan(
        child: Icon(
          Icons.report,
          color: Colors.yellow,
        ),
      ),
      WidgetSpan(
          child: SizedBox(
        width: 10,
      )),
      TextSpan(text: "My activity feeds")
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height(context) * 1.85,
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: height(context) * 0.42,
                  width: width(context) * 1,
                  decoration: widget.userDetails['profileImg'] == ""
                      ? BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/prima3.png')))
                      : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(widget.userDetails['profileImg']))),
                  child: SafeArea(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: white,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                            'Prima Profile',
                            style: bodyText20w700(color: white),
                          ),
                        ),
                        PopupMenuButton(
                            // add icon, by default "3 dot" icon

                            iconSize: 32,
                            color: Colors.white,
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem<int>(
                                  value: 0,
                                  child: EditAction(),
                                ),
                                PopupMenuItem<int>(
                                  value: 1,
                                  child: SubscriptionAction(),
                                ),
                                PopupMenuItem<int>(
                                  value: 2,
                                  child: ShareProfileAction(),
                                ),
                                PopupMenuItem<int>(value: 3, child: ActivityProfileAction())
                              ];
                            },
                            onSelected: (value) {
                              if (value == 0) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PrimaMyAccount()));
                              } else if (value == 1) {
                                print("Settings menu is selected.");
                              } else if (value == 2) {
                                print("Logout menu is selected.");
                              }
                            })
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height(context) * 0.38,
                child: Container(
                  height: height(context) * 1.5,
                  padding: EdgeInsets.all(10),
                  width: width(context) * 1,
                  decoration: shadowDecoration(20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 2,
                          width: width(context) * 0.35,
                          color: black,
                        ),
                      ),
                      addVerticalSpace(10),
                      Center(
                        child: Text(
                          widget.userDetails['fullName'],
                          style: bodyText30W600(color: black),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on_outlined),
                          Text(
                            widget.userDetails['locality'],
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                      addVerticalSpace(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              tripFriendDialog(context);
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/images/Group.png'),
                                addVerticalSpace(5),
                                Text(
                                  'Trip Friend',
                                  style: bodyText12Small(color: black),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              inviteToTripDsialog(context);
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/images/Group1.png'),
                                addVerticalSpace(5),
                                Text(
                                  'Invite to Trips',
                                  style: bodyText12Small(color: black),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              joinToTripBottomSheet(context);
                            },
                            child: Column(
                              children: [
                                Image.asset('assets/images/Group3.png'),
                                addVerticalSpace(5),
                                Text(
                                  'Join their trip',
                                  style: bodyText12Small(color: black),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualPage(chatModel: widget.chat, img: imgURL)));
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.mail,
                                  color: primary,
                                ),
                                addVerticalSpace(5),
                                Text(
                                  'Message',
                                  style: bodyText12Small(color: black),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpace(15),
                      Text(
                        'About  ${widget.userDetails['fullName']}',
                        style: bodyText22w700(color: black),
                      ),
                      addVerticalSpace(10),
                      Row(
                        children: [
                          Image.asset('assets/images/Vector (1).png'),
                          addHorizontalySpace(8),
                          Text(
                            '$_profession',
                            style: TextStyle(fontSize: 18, color: black),
                          )
                        ],
                      ),
                      addVerticalSpace(4),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: primary,
                          ),
                          addHorizontalySpace(8),
                          Text(
                            ', 25',
                            style: TextStyle(fontSize: 18, color: black),
                          ),
                          addHorizontalySpace(width(context) * 0.1),
                          Icon(
                            Icons.connect_without_contact_outlined,
                            color: primary,
                          ),
                          addHorizontalySpace(8),
                          Text(
                            'Married',
                            style: TextStyle(fontSize: 18, color: black),
                          ),
                        ],
                      ),
                      addVerticalSpace(14),
                      Text(
                        '$_aboutme',
                        style: bodyText16normal(spacing: 1.5, color: black),
                      ),
                      addVerticalSpace(15),
                      Text(
                        'Tripometer of  ${widget.userDetails['fullName']}',
                        style: bodyText20w700(color: black),
                      ),
                      addVerticalSpace(15),
                      TripometerCircleWidget(),
                      addVerticalSpace(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$Name  Friends',
                            style: bodyText20w700(color: black),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'View all',
                                style: bodyText14w600(color: black),
                              ))
                        ],
                      ),
                      TripFriendsAndMutualFriendsWidget(),
                      addVerticalSpace(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Travel Photos of  $Name',
                            style: bodyText20w700(color: black),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (ctx) => TravelPhotosScreen()));
                              },
                              child: Text(
                                'View all>',
                                style: bodyText14w600(color: primary),
                              )),
                        ],
                      ),
                      addVerticalSpace(6),
                      Container(
                        padding: EdgeInsets.all(8),
                        height: height(context) * 0.13,
                        width: width(context) * 0.95,
                        decoration: myFillBoxDecoration(0, black.withOpacity(0.08), 15),
                        child: SizedBox(
                          height: height(context) * 0.13,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: travelPhoto.length,
                              itemBuilder: (ctx, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: height(context) * 0.11,
                                        width: width(context) * 0.23,
                                        child: Image.asset(
                                          travelPhoto[i],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                      addVerticalSpace(15),
                      Text(
                        'Other Interests',
                        style: bodyText20w700(color: black),
                      ),
                      Text(
                        '$_otherintrest',
                        style: bodyText13normal(spacing: 1.4, color: black),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  tripFriendDialog(BuildContext context) {
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
                      height: height * 0.22,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Trip Friend',
                            style: bodyText16w600(color: black),
                          ),
                          Text(
                            'The request has been sent. You will be a trip friend after the request has been accepted. ',
                            textAlign: TextAlign.center,
                            style: bodyText13normal(spacing: 1.4, color: black),
                          ),
                          // addVerticalSpace(height * 0.07),
                          SizedBox(
                            width: width * 0.4,
                            child: CustomButton(
                                name: 'Okay',
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          )
                        ],
                      ));
                },
              ),
            ));
  }

  inviteToTripDsialog(BuildContext context) {
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
                      height: height * 0.36,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'An invitation will be send to Alexander to join your trip',
                            textAlign: TextAlign.center,
                            style: bodyText16w600(color: black),
                          ),
                          addVerticalSpace(height * 0.02),
                          Text(
                            'Select a trip for Invitation',
                            style: bodyText14w600(color: black),
                          ),
                          CustomDropDownButton(itemList: locationList, lableText: '  Trip Invitation  '),
                          Text(
                            'Trips requesting for new trip friends are only listed here',
                            style: bodyText12Small(color: black),
                            textAlign: TextAlign.center,
                          ),
                          addVerticalSpace(10),
                          SizedBox(
                            width: width * 0.4,
                            child: CustomButton(
                                name: 'Send Invitation',
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          )
                        ],
                      ));
                },
              ),
            ));
  }

  sendMessageDialog(BuildContext context) {
    TextEditingController _con = new TextEditingController();
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
                      height: height * 0.32,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Send a quick messages',
                            textAlign: TextAlign.center,
                            style: bodyText16w600(color: black),
                          ),
                          addVerticalSpace(height * 0.01),
                          Container(
                              decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 15),
                              width: width * 0.94,
                              // height: height(context) * 0.08,
                              child: TextField(
                                  maxLines: 3,
                                  controller: _con,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10),
                                      hintStyle: bodyText13normal(color: black),
                                      hintText: 'Write something interesting'))),
                          Text(
                            'Please send message only to the person whomm you know well. TravelNew has a zero-tolerance policy for spam',
                            style: bodyText12Small(spacing: 1.4, color: black),
                            textAlign: TextAlign.center,
                          ),
                          addVerticalSpace(10),
                          SizedBox(
                            width: width * 0.4,
                            child: CustomButton(
                                name: 'Send Message',
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          )
                        ],
                      ));
                },
              ),
            ));
  }

  Future<void> joinToTripBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: EdgeInsets.all(10),
            height: height(context) * 0.6,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'You have following request to be your trip friend',
                textAlign: TextAlign.center,
                style: bodyText18w600(color: black),
              ),
              addVerticalSpace(15),
              Expanded(
                  child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (ctx, i) {
                        return Column(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage('assets/images/nearbyfestivals.png'),
                                radius: 30,
                              ),
                              addHorizontalySpace(5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sumit patil',
                                    style: bodyText16w600(color: black),
                                  ),
                                  addVerticalSpace(3),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/Vector (1).png',
                                        color: primary,
                                      ),
                                      addHorizontalySpace(1),
                                      Text(
                                        'Software Developer',
                                        style: bodyText12Small(color: black),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: primary,
                                      ),
                                      addHorizontalySpace(1),
                                      Text(
                                        'Pune',
                                        style: bodyText12Small(color: black),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 25,
                                      width: 100,
                                      decoration: myFillBoxDecoration(0, primary, 5),
                                      child: Center(
                                        child: Text(
                                          'Accept',
                                          style: bodyText14w600(color: black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  addVerticalSpace(10),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 25,
                                      width: 100,
                                      decoration: myOutlineBoxDecoration(1, primary, 5),
                                      child: Center(
                                        child: Text(
                                          'Deny',
                                          style: bodyText14w600(color: black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ]),
                            const Divider(
                              thickness: 1,
                            )
                          ],
                        );
                      }))
            ]),
          );
        });
      },
    );
  }
}

class TripFriendsAndMutualFriendsWidget extends StatefulWidget {
  const TripFriendsAndMutualFriendsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TripFriendsAndMutualFriendsWidget> createState() => _TripFriendsAndMutualFriendsWidgetState();
}

class _TripFriendsAndMutualFriendsWidgetState extends State<TripFriendsAndMutualFriendsWidget> with TickerProviderStateMixin {
  List<dynamic> friendsInVicinity = [];
  bool loading = false;

  getFriendInVicinityList() async {
    setState(() {
      loading = true;
    });
    var x = await FirebaseFirestore.instance.collection('users').get();
    var y = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

    double userLat = double.parse(y.data()!['lat']);
    double userLng = double.parse(y.data()!['lng']);

    for (var element in x.docs) {
      // print(element.data());
      double lat = double.parse(element.data()['lat']);
      double lng = double.parse(element.data()['lng']);

      double dist = calculateDistance(userLat, userLng, lat, lng);

      print('$lat -- $lng -- $dist');
      if (dist <= 30 && element.data()['UID'] == FirebaseAuth.instance.currentUser!.uid) {
        friendsInVicinity.add(element.data());
      }
    }
    setState(() {
      loading = false;
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  TabController? controller;
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller!.dispose();
    super.dispose();
  }

  getTripFriends() async {
    tripAndMutualfrnds.clear();
    var x = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    List abc = x.data()!['tripFriends'];
    print(abc);
    for (var element in abc) {
      var y = await FirebaseFirestore.instance.collection('users').doc(element).get();
      tripAndMutualfrnds.add(y.data());
    }
    print(tripAndMutualfrnds);
    print('|||||||||||||||||||||||||||||||');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: height(context) * 0.28,
      width: width(context) * 0.95,
      decoration: myFillBoxDecoration(0, black.withOpacity(0.08), 15),
      child: Column(
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.grey,
            controller: controller,
            onTap: (value) {},
            isScrollable: false,
            indicator: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10), color: primary),
            indicatorColor: primary,
            labelColor: black,
            labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            tabs: const [
              Tab(
                text: 'Trip Friends',
              ),
              Tab(
                text: 'Mutual Friends',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(controller: controller, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(10),
                  SizedBox(
                    height: height(context) * 0.14,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: tripAndMutualfrnds.length,
                        itemBuilder: (ctx, i) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: height(context) * 0.11,
                                  width: width(context) * 0.23,
                                  child: Image.asset(
                                    tripAndMutualfrnds[i]['img'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                addVerticalSpace(5),
                                Text(tripAndMutualfrnds[i]['name']),
                              ],
                            ),
                          );
                        }),
                  ),
                  addVerticalSpace(18),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'You have trip friend request >',
                      style: TextStyle(decoration: TextDecoration.underline, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(10),
                  SizedBox(
                    height: height(context) * 0.14,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: friendsInVicinity.length,
                        itemBuilder: (ctx, i) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: height(context) * 0.11,
                                  width: width(context) * 0.23,
                                  child: Image.asset(
                                    friendsInVicinity[i]['img'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text(friendsInVicinity[i]['name']),
                              ],
                            ),
                          );
                        }),
                  ),
                  addVerticalSpace(8),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'You have trip friend request >',
                      style: TextStyle(decoration: TextDecoration.underline, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class TripometerCircleWidget extends StatefulWidget {
  TripometerCircleWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TripometerCircleWidget> createState() => _TripometerCircleWidgetState();
}

class _TripometerCircleWidgetState extends State<TripometerCircleWidget> {
  final List tripoMeter = ['Adventure', 'City', 'Nature', 'Religious'];
  List tripoMeterValue = [12.0, 32.1, 78.4, 90.6];

  double city = 0.0;
  double nature = 0.0;
  double adventure = 0.0;
  double religlous = 0.0;

  @override
  void initState() {
    getTripometerDetails();
    super.initState();
  }

  void getTripometerDetails() async {
    if (IS_USER_LOGIN) {
      var profile =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("tripoMeter").doc("profile").get();
      adventure = profile.data()?['Adventure'];
      city = profile.data()?['City'];
      nature = profile.data()?['Nature'];
      religlous = profile.data()?['Religlous'];
      setState(() {
        tripoMeterValue = [adventure, city, nature, religlous];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(tripoMeter.length, (i) {
        return Stack(
          children: [
            Container(
              height: height(context) * 0.12,
              width: width(context) * 0.45,
              padding: EdgeInsets.all(10),
              decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height(context) * 0.09,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          centerX: 0.2,
                          centerY: 0.6,
                          canScaleToFit: false,
                          canRotateLabels: false,
                          showAxisLine: false,
                          showLabels: false,
                          showTicks: false,
                          minimum: 0,
                          maximum: 100,
                          interval: 10,
                          ranges: <GaugeRange>[
                            GaugeRange(
                              startValue: 0,
                              endValue: tripoMeterValue[i],
                              color: primary,
                              startWidth: 8,
                              endWidth: 8,
                            ),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${tripoMeterValue[i]}%",
                                  style: bodytext12Bold(color: Colors.black),
                                ),
                              ],
                            ))
                          ],
                        ) // RadialAxis
                      ], // < RadialAxis > [ ]
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tripoMeter[i],
                      style: bodyText16w600(color: black),
                    ),
                    addVerticalSpace(7),
                    Text(
                      'Road Trip',
                      style: bodyText12Small(color: black),
                    ),
                    Text(
                      'Paragliding',
                      style: bodyText12Small(color: black),
                    ),
                    addVerticalSpace(5),
                    Text(
                      'View all',
                      style: bodytext12Bold(color: black),
                    )
                  ],
                ))
          ],
        );
      }),
    );
  }
}

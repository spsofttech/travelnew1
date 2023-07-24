import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travelnew_app/views/humburger_flow/improve_listing_screen.dart';
import 'package:travelnew_app/widget/custom_button.dart';

import '../../model/DayWiseTripModel.dart';
import '../../utils/constant.dart';

class TouristSpotsScreen extends StatefulWidget {
  const TouristSpotsScreen({super.key, required this.MP});
  final DayTripData MP;

  @override
  State<TouristSpotsScreen> createState() => _TouristSpotsScreenState();
}

class _TouristSpotsScreenState extends State<TouristSpotsScreen> {
  String hostname = "";
  void getPrimaDeatials() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('primaAccount').doc('profile').get();
      hostname = profile.data()?['fullName'];
      setState(() {});
    }
  }

  @override
  void initState() {
    getPrimaDeatials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height(context) * 0.42,
            width: double.infinity,
            decoration: widget.MP.image! == '' ? null : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(widget.MP.image!))),
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 25,
                          width: width(context) * 0.35,
                          decoration: myFillBoxDecoration(0, primary, 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 20,
                              ),
                              Text('$hostname')
                            ],
                          ),
                        ),
                        // Container(
                        //   height: 25,
                        //   width: width(context) * 0.15,
                        //   decoration: myFillBoxDecoration(0, primary, 30),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: const [
                        //       Text('4'),
                        //       Icon(
                        //         Icons.star,
                        //         size: 15,
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  )
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
                    Text(
                      widget.MP.state!,
                      style: bodyText16normal(color: black),
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
                        addRatingDialog(context);
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => ImproveListingScreen(
                                      MP: widget.MP,
                                    )));
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
    );
  }

  Future<void> addRatingDialog(BuildContext context) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
              padding: EdgeInsets.all(18),
              height: height(context) * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.MP.touristSpot!,
                    style: bodyText18w600(color: black),
                  ),
                  Text(
                    widget.MP.state!,
                    style: bodyText16normal(color: black),
                  ),
                  addVerticalSpace(25),
                  Text(
                    'Thankyou!',
                    style: bodyText18w600(color: black),
                  ),
                  addVerticalSpace(4),
                  SizedBox(
                    width: width(context) * 0.7,
                    child: Text(
                      'Your ratings will contribute to the overall ratings of the tourist spot. This will help fellow travelers',
                      style: bodyText14normal(color: black),
                    ),
                  ),
                  addVerticalSpace(30),
                  Center(
                    child: SizedBox(
                      child: Column(
                        children: [
                          Text(
                            'Liked it',
                            style: bodyText18w600(color: black),
                          ),
                          RatingBar.builder(
                            initialRating: 4.5,
                            minRating: 1,
                            itemSize: 40,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            unratedColor: Color.fromRGBO(254, 173, 29, 0.4),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_rate_rounded,
                              color: Color.fromRGBO(254, 173, 29, 1),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          addVerticalSpace(8),
                          SizedBox(
                            width: width(context) * 0.4,
                            height: 37,
                            child: CustomButton(
                                name: 'Submit',
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ));
        });
      },
    );
  }
}

class TouristSpotsScreen2 extends StatefulWidget {
  const TouristSpotsScreen2({super.key, required this.MP});
  final DayTripData MP;

  @override
  State<TouristSpotsScreen2> createState() => _TouristSpotsScreen2State();
}

class _TouristSpotsScreen2State extends State<TouristSpotsScreen2> {
  // String hostname = "";
  // void getPrimaDeatials() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
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
                      image: NetworkImage(
                          widget.MP.image != "" ? widget.MP.image! : "https://img.naidunia.com/naidunia/ndnimg/26052020/26_05_2020-tour_and_travel.jpg"))),
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
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Container(
                          //   height: 25,
                          //   width: width(context) * 0.35,
                          //   decoration: myFillBoxDecoration(0, primary, 30),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //     children:  [
                          //       Icon(
                          //         Icons.camera_alt_outlined,
                          //         size: 20,
                          //       ),
                          //       Text('$hostname')
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   height: 25,
                          //   width: width(context) * 0.15,
                          //   decoration: myFillBoxDecoration(0, primary, 30),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //     children: const [
                          //       Text('4'),
                          //       Icon(
                          //         Icons.star,
                          //         size: 15,
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    )
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
                          "${widget.MP.tripCity!} , ${widget.MP.state!}",
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
                          addRatingDialog(context);
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => ImproveListingScreen(
                                        MP: widget.MP,
                                      )));
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
    );
  }

  Future<void> addRatingDialog(BuildContext context) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
              padding: EdgeInsets.all(18),
              height: height(context) * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.MP.touristSpot!,
                    style: bodyText18w600(color: black),
                  ),
                  Text(
                    widget.MP.state!,
                    style: bodyText16normal(color: black),
                  ),
                  addVerticalSpace(25),
                  Text(
                    'Thankyou!',
                    style: bodyText18w600(color: black),
                  ),
                  addVerticalSpace(4),
                  SizedBox(
                    width: width(context) * 0.7,
                    child: Text(
                      'Your ratings will contribute to the overall ratings of the tourist spot. This will help fellow travelers',
                      style: bodyText14normal(color: black),
                    ),
                  ),
                  addVerticalSpace(30),
                  Center(
                    child: SizedBox(
                      child: Column(
                        children: [
                          Text(
                            'Liked it',
                            style: bodyText18w600(color: black),
                          ),
                          RatingBar.builder(
                            initialRating: 4.5,
                            minRating: 1,
                            itemSize: 40,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            unratedColor: Color.fromRGBO(254, 173, 29, 0.4),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_rate_rounded,
                              color: Color.fromRGBO(254, 173, 29, 1),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          addVerticalSpace(8),
                          SizedBox(
                            width: width(context) * 0.4,
                            height: 37,
                            child: CustomButton(
                                name: 'Submit',
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ));
        });
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../utils/constant.dart';
import '../../widget/custom_button.dart';

class DetailsOfTripWidget extends StatefulWidget {
  DetailsOfTripWidget({required this.isShow, required this.MP});
  bool isShow;
  final Map<String,dynamic> MP;
  @override
  State<DetailsOfTripWidget> createState() => _DetailsOfTripWidgetState();
}

class _DetailsOfTripWidgetState extends State<DetailsOfTripWidget> {
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('Travalar');
  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
    });
    print(allData);
  }
  List allData = [];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text('Booking ID :  ',style: TextStyle(color: Colors.black),),
                      Text(
                        widget.MP['bookingId'],
                        style: bodyText16w600(color: black),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      contactDialog(context);
                    },
                    child: Text(
                      'Your contact detail',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: primary,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          ),
          Text(
            'Details of Trip',
            style: bodyText18w600(color: black),
          ),
          addVerticalSpace(20),
          DetailsOfTripData(MP: widget.MP),
          Text(
            'Includes',
            style: bodyText14normal(color: black.withOpacity(0.4)),
          ),
          addVerticalSpace(7),
          Text(
            widget.MP['Includes'],
            style: bodyText16w600(color: black),
          ),
          const Divider(
            height: 30,
            thickness: 1,
          ),
          addVerticalSpace(10),
          SizedBox(
              height: height(context),
              child: ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (ctx, i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Trip Advisor',
                                  style: bodyText14normal(
                                      color: black.withOpacity(0.4)),
                                ),
                                addVerticalSpace(5),
                                Row(
                                  children: [
                                    Text(
                                      allData[i]['name'],
                                      style: bodyText18w600(color: black),
                                    ),
                                    Text(
                                      ' Travalar',
                                      style: bodyText18w600(color: black),
                                    ),
                                  ],
                                ),
                                RatingBar.builder(
                                  initialRating: 4.5,
                                  minRating: 1,
                                  itemSize: 20,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  unratedColor:
                                      Color.fromRGBO(254, 173, 29, 0.4),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star_rate_rounded,
                                    color: Color.fromRGBO(254, 173, 29, 1),
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                              ],
                            ),
                            widget.isShow
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Package Costs',
                                        style: bodyText14normal(
                                            color: black.withOpacity(0.4)),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '₹ :',
                                            style: bodyText14normal(color: black),
                                          ),Text(
                                               allData[i]['cost']  ,
                                            style: bodyText14normal(color: black),
                                          ),Text(
                                            ' (total)',
                                            style: bodyText14normal(color: black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Booking ID : ',style: bodyText12Small(color: black)),
                                          Text(
                                            widget.MP['bookingId'],
                                            style: bodyText12Small(color: black),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : SizedBox()
                          ],
                        ),
                        addVerticalSpace(10),
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Est : ',
                                  style: bodyText13normal(color: black)),
                          TextSpan(
                              text: allData[i]['Est'],
                              style: bodyText13normal(color: black)),
                          TextSpan(
                              text: ' Know more',
                              style: bodyText13normal(color: primary))
                        ])),
                        addVerticalSpace(15),
                        !widget.isShow
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Package Costs : ₹ ', style: bodyText18w600(color: black),),
                                      Text(
                                        allData[i]['cost'],
                                        style: bodyText18w600(color: black),
                                      ),
                                      Text(' (total)',style: bodyText18w600(color: black))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Booking ID : ',style: bodyText12Small(color: black)),
                                      Text(
                                        widget.MP['bookingId'],
                                        style: bodyText12Small(color: black),
                                      ),
                                    ],
                                  ),
                                  addVerticalSpace(15),
                                ],
                              )
                            : SizedBox(),
                        !widget.isShow
                            ? Row(
                                children: [
                                  SizedBox(
                                    height: 35,
                                    width: width(context) * 0.3,
                                    child: CustomButton(
                                        name: 'Pay for trip',
                                        onPressed: () {
                                          showModalBottomSheet<void>(
                                            isScrollControlled: true,
                                            context: context,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            builder: (BuildContext context) {
                                              return Container(
                                                  height: height(context) * 0.8,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Spacer(),
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              icon: Icon(
                                                                Icons.close,
                                                                color: black,
                                                              ))
                                                        ],
                                                      ),
                                                      Text(
                                                        'You payment is now fast & Easy',
                                                        style: bodyText22w700(
                                                            color: black),
                                                      ),
                                                      addVerticalSpace(
                                                          height(context) *
                                                              0.05),
                                                      SizedBox(
                                                        width: width(context) *
                                                            0.73,
                                                        child: Text(
                                                          'With just one click, you will be able to do the booking and subscribe to Prima when you add payment methods to your travelNew account,',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              bodyText16normal(
                                                                  spacing: 1.5,
                                                                  color: black),
                                                        ),
                                                      ),
                                                      addVerticalSpace(
                                                          height(context) *
                                                              0.05),
                                                      InkWell(
                                                        onTap: () {
                                                          widget.isShow = true;
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          height: 45,
                                                          width:
                                                              width(context) *
                                                                  0.8,
                                                          decoration:
                                                              myOutlineBoxDecoration(
                                                                  1,
                                                                  primary,
                                                                  15),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Image.asset(
                                                                    'assets/images/credit.png'),
                                                                const Text(
                                                                  '+Add a payment method',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                )
                                                              ]),
                                                        ),
                                                      )
                                                    ],
                                                  ));
                                            },
                                          );
                                        }),
                                  ),
                                  addHorizontalySpace(20),
                                  InkWell(
                                    onTap: () {
                                      showAlertDialog(context);
                                    },
                                    child: Container(
                                      height: 35,
                                      width: width(context) * 0.3,
                                      decoration: shadowDecoration(10, 4),
                                      child: Center(
                                        child: Text(
                                          'Details',
                                          style: bodyText16w600(color: black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                    height: 35,
                                    width: width(context) * 0.4,
                                    child: CustomButton(
                                        name: 'Request a call back',
                                        onPressed: () {}),
                                  ),
                                  addHorizontalySpace(20),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 35,
                                      width: width(context) * 0.3,
                                      decoration: shadowDecoration(10, 4),
                                      child: Center(
                                        child: Text(
                                          'Cancel Trip',
                                          style: bodyText16w600(color: black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        addVerticalSpace(10),
                        !widget.isShow
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Package cost payment due date: ${allData[i]['paymentdueDate']}',
                                    style: bodyText14w600(color: black),
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Got cheaper deals?, ',
                                        style: bodyText14w600(color: black)),
                                    TextSpan(
                                      text: 'Tell us',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                          color: primary),
                                    )
                                  ])),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Hotel details, ',
                                        style: bodyText14w600(color: black)),
                                    TextSpan(
                                        text: 'Request here',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: primary,
                                            decoration:
                                                TextDecoration.underline)),
                                  ])),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Journey details, ',
                                        style: bodyText14w600(color: black)),
                                    TextSpan(
                                        text: 'Request here',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: primary,
                                            decoration:
                                                TextDecoration.underline)),
                                  ]))
                                ],
                              ),
                        Row(
                          children: [
                            Spacer(),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Cancellation policy',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                      color: primary),
                                ))
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        )
                      ],
                    );
                  }))
        ],
      ),
    );

  }

  showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: EdgeInsets.all(6),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return Container(
                    height: height * 0.5,
                    width: width * 0.95,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Udupi, Karnataka',
                          style: bodyText18w600(color: black),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              'Booking id: 540986',
                              style: bodyText14w600(color: primary),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Travelers',
                                  style: bodyText12Small(
                                      color: black.withOpacity(0.4)),
                                ),
                                Text(
                                  '6 Adults 2 Children',
                                  style: bodyText14w600(color: black),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Duration',
                                  style: bodyText12Small(
                                      color: black.withOpacity(0.4)),
                                ),
                                Text(
                                  '4 days & 3 Nights',
                                  style: bodyText14w600(color: black),
                                )
                              ],
                            )
                          ],
                        ),
                        addVerticalSpace(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hotel',
                                  style: bodyText12Small(
                                      color: black.withOpacity(0.4)),
                                ),
                                Text(
                                  '3 Star',
                                  style: bodyText14w600(color: black),
                                ),
                                addVerticalSpace(10),
                                Text(
                                  'Travel Mode',
                                  style: bodyText12Small(
                                      color: black.withOpacity(0.4)),
                                ),
                                Text(
                                  'Flight',
                                  style: bodyText14w600(color: black),
                                ),
                                addVerticalSpace(10),
                                Text(
                                  'Includes',
                                  style: bodyText12Small(
                                      color: black.withOpacity(0.4)),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Sightseeing Transport ',
                                      style: bodyText14w600(color: black),
                                    ),
                                    Icon(
                                      Icons.info_outline,
                                      size: 15,
                                    )
                                  ],
                                ),
                                addVerticalSpace(6),
                                Row(
                                  children: [
                                    Text(
                                      'Pickup and Drop',
                                      style: bodyText14w600(color: black),
                                    ),
                                    Icon(
                                      Icons.info_outline,
                                      size: 15,
                                    )
                                  ],
                                ),
                                addVerticalSpace(6),
                                Text(
                                  'Travel Guide',
                                  style: bodyText14w600(color: black),
                                ),
                                addVerticalSpace(6),
                                Text(
                                  'Infant instance',
                                  style: bodyText14w600(color: black),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '',
                                  style: bodyText12Small(
                                      color: black.withOpacity(0.4)),
                                ),
                                Text(
                                  '₹ 25,000',
                                  style: bodyText14w600(color: black),
                                ),
                                addVerticalSpace(10),
                                Text(
                                  '',
                                  style: bodyText12Small(
                                      color: black.withOpacity(0.4)),
                                ),
                                Text(
                                  '₹ 25,000',
                                  style: bodyText14w600(color: black),
                                ),
                                addVerticalSpace(10),
                                Text(
                                  '',
                                  style: bodyText12Small(
                                      color: black.withOpacity(0.4)),
                                ),
                                Text(
                                  '₹ 5,000',
                                  style: bodyText14w600(color: black),
                                ),
                                addVerticalSpace(6),
                                Text(
                                  '₹ 900',
                                  style: bodyText14w600(color: black),
                                ),
                                addVerticalSpace(6),
                                Text(
                                  '₹ 3,000',
                                  style: bodyText14w600(color: black),
                                ),
                                addVerticalSpace(6),
                                Text(
                                  '₹ 00',
                                  style: bodyText14w600(color: black),
                                ),
                              ],
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Total',
                              style: bodyText16w600(color: black),
                            ),
                            addHorizontalySpace(60),
                            Text(
                              '₹ 58,900',
                              style: bodyText16w600(color: black),
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        addVerticalSpace(25),
                        Center(
                          child: SizedBox(
                              width: 150,
                              child: CustomButton(
                                  name: 'Okay',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })),
                        )
                      ],
                    ),
                  );
                },
              ),
            ));
  }
  @override
  void initState() {
    getcontact();
    getData();
    super.initState();
  }
  String _email = "";
  String _mobnum = "";
  void getcontact() async{
    if (FirebaseAuth.instance.currentUser != null) {
      var details = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('primaAccount')
          .doc('profile')
          .get();
      _email = details.data()?['emailId'];
      _mobnum = details.data()?['mobileNumber'];
    }

    setState(() {});
  }
  contactDialog(BuildContext context) {

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding: const EdgeInsets.all(6),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(
            builder: (context) {
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;

              return Container(
                height: 200,
                child: Column(
                  children: [
                    addVerticalSpace(30),
                    Text('Email ID :',style: TextStyle(color: primary),),
                    addVerticalSpace(10),
                    Text('$_email'),
                    addVerticalSpace(10),
                    Text('Mobile Number :',style: TextStyle(color: primary),),
                    addVerticalSpace(10),
                    Text('$_mobnum')
                  ],
                ),
              );
            },
          ),
        ));
  }
}

class DetailsOfTripData extends StatefulWidget {
  final Map<String,dynamic> MP;
  const DetailsOfTripData({
    Key? key, required this.MP,
  }) : super(key: key);

  @override
  State<DetailsOfTripData> createState() => _DetailsOfTripDataState();
}

class _DetailsOfTripDataState extends State<DetailsOfTripData> {


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip Type',
              style: bodyText14normal(color: black.withOpacity(0.4)),
            ),
            addVerticalSpace(5),
            Text(
              widget.MP['tripType'],
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(15),
            Text(
              'Journey date',
              style: bodyText14normal(color: black.withOpacity(0.4)),
            ),
            addVerticalSpace(5),
            Text(
             widget.MP['date'],
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(15),
            Text(
              'Travel Mode',
              style: bodyText14normal(color: black.withOpacity(0.4)),
            ),
            addVerticalSpace(5),
            Text(
              'Flight',
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(15),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Travelers',
              style: bodyText14normal(color: black.withOpacity(0.4)),
            ),
            addVerticalSpace(5),
            Row(
              children: [
                Text(
                  widget.MP['Adults'],
                  style: bodyText16w600(color: black),
                ),
                Text('  Adults ',style: TextStyle(color: Colors.black),),
                Text(
                  widget.MP['childer'],
                  style: bodyText16w600(color: black),
                ),
                Text('  Childerns')
              ],
            ),
            addVerticalSpace(15),
            Text(
              'Duration',
              style: bodyText14normal(color: black.withOpacity(0.4)),
            ),
            addVerticalSpace(5),
            Row(
              children: [
                Text(
                  widget.MP['TripDays'],
                  style: bodyText16w600(color: Colors.black),
                ),
                Text('  Days',style: TextStyle(color: Colors.black),)
              ],
            ),
            addVerticalSpace(15),
            Text(
              'Hotel',
              style: bodyText14normal(color: black.withOpacity(0.4)),
            ),
            addVerticalSpace(5),
            Text(
              widget.MP['Hoteltype'],
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(15),
          ],
        ),
      ],
    );
  }
}


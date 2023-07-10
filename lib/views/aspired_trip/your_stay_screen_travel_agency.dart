import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/constant.dart';
import '../../widget/custom_button.dart';

class YourStayScreen extends StatefulWidget {
  const YourStayScreen({super.key, required this.MP});
  final Map<String,dynamic> MP;
  @override
  State<YourStayScreen> createState() => _YourStayScreenState();
}

class _YourStayScreenState extends State<YourStayScreen> {

@override
  void initState() {
    super.initState();
  }

  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isOpen == false)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 140),
                      child: Text('Booking ID : ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
                    ),
                    Text(
                      widget.MP['bookingId'],
                      style: bodyText16w600(color: black),
                    ),
                  ],
                ),
                addVerticalSpace(15),
                Container(
                  margin: EdgeInsets.all(10),
                  width: width(context) * 0.93,
                  child: Text(
                        widget.MP['bookingeresponse'],
                    textAlign: TextAlign.center,
                    style: bodyText14normal(
                        spacing: 1.4, color: black.withOpacity(0.5)),
                  ),
                ),
                addVerticalSpace(30),
                Center(
                  child: SizedBox(
                      width: width(context) * 0.5,
                      height: 40,
                      child: CustomButton(
                          name: 'Send a reminder',
                          onPressed: () {
                            isOpen = true;
                            setState(() {});
                          })),
                ),
              ],
            ),
          if (isOpen)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your stay',
                    style: bodyText18w600(color: black),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            'Booking id: ',
                            style: bodyText14w600(color: primary),
                          ),
                          Text(
                            widget.MP['bookingId']
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                    'Sai International',
                    style: bodyText16w600(color: black),
                  ),
                  Text(
                    'Sai Temple Rd, Nr Corporation Bank, Udupi - 111000',
                    style: bodyText13normal(color: black.withOpacity(0.5)),
                  ),
                  addVerticalSpace(20),
                  Text(
                    'Free morning breakfast, Swimming Pool, Doctor on calls and Free Wifi',
                    style: bodyText13normal(color: black.withOpacity(0.5)),
                  ),
                  addVerticalSpace(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hotel',
                            style:
                                bodyText14normal(color: black.withOpacity(0.4)),
                          ),
                          addVerticalSpace(5),
                          Text(
                          widget.MP['Hoteltype'],
                            style: bodyText16w600(color: black),
                          ),
                          addVerticalSpace(15),
                          Text(
                            'Check in date',
                            style:
                                bodyText14normal(color: black.withOpacity(0.4)),
                          ),
                          addVerticalSpace(5),
                          Text(
                            widget.MP['date'],
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
                            style:
                                bodyText14normal(color: black.withOpacity(0.4)),
                          ),
                          addVerticalSpace(5),
                          Row(
                            children: [
                              Text(
                                widget.MP['Adults'],
                                style: bodyText16w600(color: black),
                              ),
                              Text(
                                ' Adults  ',
                                style: bodyText16w600(color: black),
                              ),
                              Text(
                                widget.MP['childer'],
                                style: bodyText16w600(color: black),
                              ),
                              Text(
                                ' Childerens',
                                style: bodyText16w600(color: black),
                              ),
                            ],
                          ),
                          addVerticalSpace(15),
                          Text(
                            'Duration',
                            style:
                                bodyText14normal(color: black.withOpacity(0.4)),
                          ),
                          addVerticalSpace(5),
                          Row(
                            children: [
                              Text(
                              widget.MP['TripDays'],
                                style: bodyText16w600(color: black),
                              ),
                              Text(
                                ' Days',
                                style: bodyText16w600(color: black),
                              ),
                            ],
                          ),
                          addVerticalSpace(15),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'This is not your e-invoice. Ask your travel advisor for detail',
                    style: bodyText13normal(color: black.withOpacity(0.5)),
                  ),
                  addVerticalSpace(height(context) * 0.25),
                  CustomButton(
                      name: 'Show uploaded Government id', onPressed: () {})
                ],
              ),
            )
        ],
      ),
    );
  }
}

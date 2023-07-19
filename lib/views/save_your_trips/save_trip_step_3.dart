import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelnew_app/views/save_your_trips/save_your_trips.dart';
import 'package:travelnew_app/widget/custom_dropdown_button.dart';
import 'package:travelnew_app/widget/custom_textfield.dart';

import '../../model/save_trip_model.dart';
import '../../utils/constant.dart';
import '../home/plan_trip_screen.dart';

enum includes { one, two, three, four }

includes _value = includes.one;
final TextEditingController DepatureDateController = TextEditingController();

String adults_cnt = "Select";
String children_cnt = "Select";
String hotaltype = "";
String incl1 = "";

updatePlanTrip() async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users.doc(FirebaseAuth.instance.currentUser!.uid).collection("Plan_trip").doc(FirebaseAuth.instance.currentUser!.uid).update({
    "DepatureDate": DepatureDateController.text,
    "Adults": adults_cnt,
    "Children": children_cnt,
    "HotelType": hotaltype,
    "Includes": incl1,
    "tripDocId": "${tripdataForStore[0]['id']}"
  });
}

String place = "";
int days1 = 0;
String days2 = "";
String _image = "";
String _date = "";
String _tripName = "";
String _tripType = "";
String _startDate = "";
bool? flexibledate;
int _bookingId = 0;

void getData() async {
  if (FirebaseAuth.instance.currentUser != null) {
    var profile = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Plan_trip')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    place = profile.data()?['endtrip'] ?? "";
    days1 = profile.data()?['totalDays'];
    //days2 = profile.data()?['mainualyEnterDays'];
    flexibledate = profile.data()?['Flexible'];
    _date = profile.data()?['StartDate'];
    _tripName = profile.data()?['endtrip'];
    _tripType = profile.data()?['tripPlan'];
    _totalday = profile.data()?['totalDays'];
    _startDate = profile.data()?['StartDate'];
  }

  _bookingId = DateTime.now().microsecondsSinceEpoch;
  DepatureDateController.text = _startDate;
  // setState(() {
  //
  // });
}

int _totalday = 0;

// addUpcomingTrip() async {
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   users.doc(FirebaseAuth.instance.currentUser!.uid).collection("upcomingtrip").add({
//     // "image": _image ?? "",
//     "tirpname": "${place} Trip",
//     "address": place,
//     "date": _date,
//     "tripsport": '1',
//     "travelTrip": true,
//     "tripDocId": "${tripdataForStore[0]['docId']}",
//     "tripImg": "${tripdataForStore[0]['tripImage']}",
//     "tripType": _tripType,
//     "totalDays": _totalday,
//     "state": "${targetState}",
//     'tripType': "${targetType}",
//   });
//   // setState(() {
//   //
//   // });
// }

addupcomingtrip() async {
  if (FirebaseAuth.instance.currentUser != null) {
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('trip library').doc('unsaved').update({
      'data': FieldValue.arrayRemove([
        {
          'type': 1,
          'type_Of_Trip': type_of_trip1,
          'plamTrip_at': planTrip_at_,
          'trip_days': totalDays,
          'interestList': usereTripIntrest,
          'date': startDate.text,
          "StartTrip": UserCity,
          "StartDate": startDate.text,
          "EndDate": endDate.text,
          "tripmode": trip_mode,
          "totalDays": totalDays,
          "Flexible": flexible,
          "BookingId": '',
        }
      ])
    });
    // DocumentReference profile =
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("upcomingtrip").add({
      'image': _image,
      'date': _date,
      "tripDocId": "${tripdataForStore[0]['docId']}",
      "tripImg": "${tripdataForStore[0]['tripImage']}",
      'address': place,
      'tirpname': "${place} Trip",
      'tripsport': trip_city_name.value,
      "travelTrip": 1,
      "state": "${targetState}",
      'daysnumber': _totalday,
      "I'm Flexible with date": flexibledate,
      "tripType": _tripType,
      'departuredate': DepatureDateController.text,
      "Hoteltype": hotaltype,
      "TripDays": _totalday,
      "childer": adults_cnt,
      "Adults": children_cnt,
      "bookingId": _bookingId,
      "Includes": _value.name,
      "bookingeresponse": 'bookingres',
      "AirIndia": 'airind',
      "Seat": '_seats',
      "Endtrip": _tripName,
    });
  }
}

class SaveTripStep3 extends StatefulWidget {
  const SaveTripStep3({super.key});

  @override
  State<SaveTripStep3> createState() => _SaveTripStep3State();
}

class _SaveTripStep3State extends State<SaveTripStep3> {
  String _email = "";
  String _mobnum = "";
  void getcontact() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var details =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('primaAccount').doc('profile').get();
      _email = details.data()?['emailId'] ?? "";
      _mobnum = details.data()?['mobileNumber'] ?? "";
    }

    setState(() {});
  }

  @override
  void initState() {
    getData();
    getcontact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Travel Details', style: TextStyle(fontSize: 20, color: black)),
        addVerticalSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width(context) * 0.4,
              child: Obx(() => Text(
                    '${trip_city_name.value} Trip',
                    style: bodyText16w600(color: black),
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: width(context) * 0.40,
                  child: Text(
                    'Booking id: ${_bookingId}',
                    overflow: TextOverflow.ellipsis,
                    style: bodyText16w600(color: black),
                  ),
                ),
                // TextButton(
                //     onPressed: () {
                //       contactDialog(context);
                //     },
                //     child: Text(
                //       'Your contact detail',
                //       style: bodyText14w600(color: primary),
                //     )),
              ],
            )
          ],
        ),
        addVerticalSpace(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (flexibledate == false)
                  SizedBox(
                      width: width(context) * 0.6,
                      child: CustomTextFieldWidget(Enable: false, controller: DepatureDateController, labelText: 'Departure date'))
                else
                  SizedBox(
                      width: width(context) * 0.6,
                      child: CustomTextFieldWidget(Enable: false, controller: DepatureDateController, labelText: 'Departure date')),
                addVerticalSpace(5),
                SizedBox(width: width(context) * 0.6, child: const Text('You’ve preferred our travel partner suggesting a date'))
              ],
            ),
            Container(
              height: height(context) * 0.1,
              width: width(context) * 0.2,
              decoration: myOutlineBoxDecoration(1, primary, 10),
              child: Column(
                children: [
                  if (days1 == 0)
                    Text(
                      '$days2',
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                    )
                  else
                    Text(
                      '$days1',
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                    ),
                  Text(
                    '  Days',
                    //  style: bodyText16normal(color: black),
                  )
                ],
              ),
            )
          ],
        ),
        addVerticalSpace(20),
        Text(
          'Travellers',
          style: bodyText16w600(color: black),
        ),
        addVerticalSpace(20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [Text('Adults'), Spacer(), Text('Children')],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 43,
                width: 150,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                          top: BorderSide(
                            color: Colors.black26,
                          ),
                          bottom: BorderSide(color: Colors.black26),
                          right: BorderSide(color: Colors.black26),
                          left: BorderSide(color: Colors.black26))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(10),
                      value: adults_cnt,
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          adults_cnt = newValue!;
                        });
                      },
                      items: ['Select', '1', '2', '3', '4', '5', '6', '7', '8', '9']
                          .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              ))
                          .toList(),

                      // add extra sugar..
                      icon: const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Icon(
                          Icons.arrow_drop_down,
                        ),
                      ),
                      iconSize: 25,
                      iconEnabledColor: primary,
                      iconDisabledColor: black.withOpacity(0.7),
                      underline: const SizedBox(),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   width: width(context) * 0.42,
            //   child: CustomDropDownButton(
            //     itemList: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
            //     lableText: '  Adults  ',
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 43,
                width: 150,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                          top: BorderSide(
                            color: Colors.black26,
                          ),
                          bottom: BorderSide(color: Colors.black26),
                          right: BorderSide(color: Colors.black26),
                          left: BorderSide(color: Colors.black26))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(10),
                      value: children_cnt,
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          children_cnt = newValue!;
                        });
                      },
                      items: ['Select', '1', '2', '3', '4', '5', '6', '7', '8', '9']
                          .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              ))
                          .toList(),

                      // add extra sugar..
                      icon: const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Icon(
                          Icons.arrow_drop_down,
                        ),
                      ),
                      iconSize: 25,
                      iconEnabledColor: primary,
                      iconDisabledColor: black.withOpacity(0.7),
                      underline: const SizedBox(),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   width: width(context) * 0.42,
            //   child: CustomDropDownButton(
            //     itemList: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
            //     lableText: '  Children  ',
            //   ),
            // )
          ],
        ),
        addVerticalSpace(20),
        Text(
          'Preferred Hotel type',
          style: bodyText16w600(color: black),
        ),
        SizedBox(
            height: height(context) * 0.05,
            width: width(context) * 0.95,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: checkListItems2.length,
                itemBuilder: (ctx, index) {
                  return Row(
                    children: [
                      Checkbox(
                        activeColor: primary,
                        checkColor: black,
                        value: checkListItems2[index]["value"],
                        onChanged: (value) {
                          setState(() {
                            hotaltype = checkListItems2[index]['title'];
                            for (var element in checkListItems2) {
                              element["value"] = false;
                            }
                            checkListItems2[index]["value"] = value;
                            //updatehotaltype();
                          });
                        },
                      ),
                      Text(checkListItems2[index]['title'])
                    ],
                  );
                })),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Conditions to Hotel type available in the trip city',
            style: bodyText12Small(color: black),
          ),
        ),
        addVerticalSpace(20),
        Text(
          'Includes',
          style: bodyText16w600(color: black),
        ),
        SizedBox(
          height: 30,
          child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: primary,
              title: Text('Pickup and drop'),
              value: includes.one,
              groupValue: _value,
              onChanged: (val) {
                setState(() {
                  incl1 = "Pickup and drop";
                  _value = val!;
                });
              }),
        ),
        SizedBox(
          height: 30,
          child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: primary,
              title: Text('Sightseeing transport'),
              value: includes.two,
              groupValue: _value,
              onChanged: (val) {
                setState(() {
                  incl1 = "Sightseeing transport";
                  _value = val!;
                });
              }),
        ),
        SizedBox(
          height: 30,
          child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: primary,
              title: Text('Travel guide'),
              value: includes.three,
              groupValue: _value,
              onChanged: (val) {
                setState(() {
                  incl1 = "Travel guide";
                  _value = val!;
                });
              }),
        ),
        SizedBox(
          height: 30,
          child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: primary,
              title: Text('Infant assistance'),
              value: includes.four,
              groupValue: _value,
              onChanged: (val) {
                setState(() {
                  incl1 = "Infant assistance";
                  _value = val!;
                });
              }),
        ),
        addVerticalSpace(height(context) * 0.06),
        Text(
          'All travelers are requested to adhere health protocols as prescribed by the state and various authorities ',
          style: bodyText11Small(color: black),
        )
      ],
    );
  }

  contactDialog(BuildContext context) {
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '       Your contact details are required for Travel operators to contact and send the booking details.',
                            style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),
                          ),
                        ),
                        addVerticalSpace(30),
                        Text(
                          'Email ID :',
                          style: TextStyle(color: primary),
                        ),
                        addVerticalSpace(10),
                        Text('$_email'),
                        addVerticalSpace(10),
                        Text(
                          'Mobile Number :',
                          style: TextStyle(color: primary),
                        ),
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

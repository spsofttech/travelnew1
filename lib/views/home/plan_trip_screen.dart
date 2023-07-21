import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/humburger_flow/my_account/trip_intrest_screen.dart';
import 'package:travelnew_app/views/humburger_flow/trip_library_screen.dart';
import 'package:travelnew_app/widget/custom_appbar.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/widget/custom_textfield.dart';

import '../../widget/custom_dropdown_button.dart';
import '../save_your_trips/save_your_trips.dart';
import 'dart:math' as math;

class PlanATrip extends StatefulWidget {
  const PlanATrip({super.key});

  @override
  State<PlanATrip> createState() => _PlanATripState();
}

List usereTripIntrest = [];

String type_of_trip1 = "Select";
String planTrip_at_ = "Select";
String trip_mode = "Select";
var firstDate;
var secondDate;
int totalDays = 0;
bool dateEnable = true;
bool? flexible;
final TextEditingController startDate = TextEditingController();
final TextEditingController endDate = TextEditingController();

class _PlanATripState extends State<PlanATrip> {
  var Trip_type_vise;
  List<Map<String, dynamic>> trip_interest_catName = [
    {'val': "Select", 'prima': false}
  ];

  // final items = ['Mumbai', 'Pune', 'indore', 'Jaipur', 'Baroda'];
  // final items3 = ['Mumbai', 'Pune', 'indore', 'Jaipur', 'Baroda'];
  // final items2 = ['Trip to the Beach', 'Camping Trip', 'Road Trip', 'Group Tour', 'Trip to the city'];

  String? selectedValue;

  final TextEditingController enterdate = TextEditingController();

  getIntrest() async {
    usereTripIntrest.clear();
    DocumentSnapshot<Map<String, dynamic>> profile =
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

    QuerySnapshot<Map<String, dynamic>> trip_intrest_snapshot = await FirebaseFirestore.instance.collection('Category Interest').get();
    print("${trip_intrest_snapshot.docs[0].data()['data']}");
    print("${trip_intrest_snapshot.docs[0].id}");

    int b = 0;
    trip_intrest_snapshot.docs.forEach((element) {
      //trip_interest_data_list.add([]);
      // List c = element.data()['data'];
      // print(element.id);
      usereTripIntrest.addAll(profile.data()!['${element.id}'] ?? []);
      //trip_interest_catName.add("${element.id}");
      b++;
    });

    //print(trip_interest_data);
  }

  Future<bool> getMainIntrest() async {
    trip_interest_catName.clear();
    QuerySnapshot<Map<String, dynamic>> trip_intrest_snapshot = await FirebaseFirestore.instance.collection('Category Interest').get();
    // print("${trip_intrest_snapshot.docs[0].data()['data']}");
    // print("${trip_intrest_snapshot.docs[0].id}");

    int b = 0;
    trip_intrest_snapshot.docs.forEach((element) {
      trip_interest_catName.add({'val': "${element.id}", 'prima': element.data()['prima'] == 0 ? false : true});
      b++;
    });

    return true;
    printc(trip_interest_catName);
  }

  //String startplace = "";
  void getData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      //
      // usereTripIntrest.addAll(profile.data()!['Adventure'] ?? []);
      // usereTripIntrest.addAll(profile.data()!['City'] ?? []);
      // usereTripIntrest.addAll(profile.data()!['Nature'] ?? []);
      // usereTripIntrest.addAll(profile.data()!['Religlous'] ?? []);
      await getIntrest();
      print("---  User  ---${usereTripIntrest}");
      // Trip_type_vise  = await FirebaseFirestore.instance.collection('tripstate').doc('karnataka').collection('tripcity').doc('Bengaluru').get();
      Trip_type_vise = await FirebaseFirestore.instance.collection('Trips_New').get();
      // startplace = profile.data()?['locality'];
      // print("===Start===${startplace}");
    }
    setState(() {});
  }

  String _cityImage = "";

  // void getCityImageData() async {
  //   // if (FirebaseAuth.instance.currentUser != null) {
  //   //   var profile = await FirebaseFirestore.instance.collection('tripstate').doc('karnataka').collection('tripcity').doc('Bengaluru').get();
  //   //   _cityImage = profile.data()?['cityImage'];
  //   // }
  //   // if (FirebaseAuth.instance.currentUser != null) {
  //   //   var profile = await FirebaseFirestore.instance.collection('Trips_New').get();
  //   //   //  _cityImage = profile.data()?['cityImage'];
  //   // }
  //   setState(() {});
  // }

  //////--------Catlculate distence--------------///////

  // Data1.sort((a, b) {
  // // print('\x1B[32m ======shorting\x1B[0m');
  // double aDistance =
  // calculateDistance(latitude, longitude, double.parse(a.data()["latitude"].toString()), double.parse(a.data()["longitude"].toString()));
  // double bDistance =
  // calculateDistance(latitude, longitude, double.parse(b.data()["latitude"].toString()), double.parse(b.data()["longitude"].toString()));
  //
  // return aDistance.compareTo(bDistance);
  // });

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = math.cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * math.asin(math.sqrt(a));
  }

  Future setTripPlan() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(FirebaseAuth.instance.currentUser!.uid).collection("Plan_trip").doc(FirebaseAuth.instance.currentUser!.uid).set({
      "StartTrip": UserCity,
      "tripPlan": type_of_trip1,
      "endtrip": planTrip_at_,
      "StartDate": startDate.text,
      "EndDate": endDate.text,
      "tripmode": trip_mode,
      "totalDays": totalDays,
      "Flexible": flexible,
      "BookingId": '',
      // "cityImage": _cityImage,
    });
    setState(() {});
  }

  @override
  void initState() {
    getData();

    // getCityImageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50), child: CustomAppBar(title: 'Let’s Plan your trip')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(12),
              height: height(context) * 0.88,
              width: width(context) * 0.95,
              decoration: shadowDecoration(15, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(height(context) * 0.04),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: const Text('Trip Start Location*'),
                  ),
                  addVerticalSpace(10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                        height: 43,
                        width: width(context) * 0.85,
                        decoration: myOutlineBoxDecoration(1, Colors.black26, 10),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Text(
                            '$UserCity ,$UserState',
                            style: const TextStyle(fontSize: 15),
                          ),
                        )),
                  ),
                  addVerticalSpace(25),
                  Container(padding: EdgeInsets.only(left: 10), child: const Text('Type of Trip you are planning*  ')),
                  addVerticalSpace(10),

                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: 43,
                      width: width(context) * 0.85,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: const Border(
                                top: BorderSide(
                                  color: Colors.black26,
                                ),
                                bottom: BorderSide(color: Colors.black26),
                                right: BorderSide(color: Colors.black26),
                                left: BorderSide(color: Colors.black26))),
                        child: FutureBuilder(
                          future: getMainIntrest(),
                          builder: (context, snapshot) {
                            print("--- ${snapshot.hasError}----" + '${trip_interest_catName}');
                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<Map<String, dynamic>>(
                                  borderRadius: BorderRadius.circular(10),
                                  // value: null,
                                  hint: Text("${type_of_trip1}"),
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      type_of_trip1 = newValue!['val'];
                                    });
                                  },
                                  items: trip_interest_catName.map<DropdownMenuItem<Map<String, dynamic>>>((Map<String, dynamic> value) {
                                    printc(value['prima']);
                                    return DropdownMenuItem<Map<String, dynamic>>(
                                      value: value,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          value['val'].toString(),
                                          style: TextStyle(
                                              fontSize: 15, color: (value['prima'] == USER_IS_PRIMA) || USER_IS_PRIMA ? Colors.black : Colors.grey),
                                        ),
                                      ),
                                    );
                                  }).toList(),
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
                              );
                            } else {
                              print("--- ${snapshot.hasError}----");
                              return SizedBox();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  // CustomDropDownButton(
                  //   lableText: ' Type of Trip you are planning* ',
                  //   itemList: items2,
                  // ),
                  addVerticalSpace(25),
                  Container(padding: EdgeInsets.only(left: 10), child: const Text('Plan trip at')),
                  addVerticalSpace(10),

                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: 43,
                      width: width(context) * 0.85,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: const Border(
                                top: BorderSide(
                                  color: Colors.black26,
                                ),
                                bottom: BorderSide(color: Colors.black26),
                                right: BorderSide(color: Colors.black26),
                                left: BorderSide(color: Colors.black26))),
                        child: FutureBuilder(
                          future: FirebaseFirestore.instance.collection('State').doc("State_Name").get(),
                          builder: (context, snapshot) {
                            print("--------");
                            if (snapshot.hasData) {
                              // print("--------${snapshot.data!.data()!['states']}");
                              List<String> travelNewTripState = ["Select"];
                              List state_data = snapshot.data!.data()!['states'];

                              state_data.forEach((element) {
                                travelNewTripState.add(element.toString());
                              });

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(10),
                                  // value: _string2,
                                  isExpanded: true,
                                  hint: Text("${planTrip_at_}"),
                                  onChanged: (newValue) {
                                    setState(() {
                                      planTrip_at_ = newValue!;
                                    });
                                  },
                                  items: travelNewTripState
                                      .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5),
                                              child: Text(
                                                value,
                                                style: const TextStyle(fontSize: 15, color: Colors.black),
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
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  // addVerticalSpace(25),
                  // CustomDropDownButton(
                  //   lableText: '  Plan Trip at  ',
                  //   itemList: items3,
                  // ),
                  addVerticalSpace(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                              height: 40,
                              width: width(context) * 0.5,
                              child: CustomTextFieldWidget(
                                Enable: dateEnable,
                                controller: startDate,
                                labelText: 'Start Date',
                                onClick: () async {
                                  var pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(Duration(days: 182)),
                                    builder: (context, child) {
                                      return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: primary,
                                            ),
                                          ),
                                          child: child!);
                                    },
                                  );
                                  if (pickedDate != null) {
                                    print(pickedDate);
                                    firstDate = pickedDate.day;
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

                                    setState(() {
                                      startDate.text = formattedDate;
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                                icon: const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.black,
                                ),
                              )),
                          addVerticalSpace(15),
                          SizedBox(
                              width: width(context) * 0.5,
                              height: 40,
                              child: CustomTextFieldWidget(
                                Enable: dateEnable,
                                controller: endDate,
                                labelText: 'End Date',
                                onClick: () async {
                                  var pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                    builder: (context, child) {
                                      return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: primary,
                                            ),
                                          ),
                                          child: child!);
                                    },
                                  );
                                  if (pickedDate != null) {
                                    print(pickedDate);
                                    secondDate = pickedDate.day;
                                    totalDays = secondDate - firstDate;
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

                                    setState(() {
                                      endDate.text = formattedDate;
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                                icon: const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.black,
                                ),
                              )),
                        ],
                      ),
                      Container(
                        height: height(context) * 0.12,
                        width: width(context) * 0.32,
                        decoration: myFillBoxDecoration(0, black.withOpacity(0.05), 10),
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                          if (dateEnable)
                            Container(
                              height: 30,
                              width: width(context) * 0.25,
                              decoration: myOutlineBoxDecoration(1, primary, 7),
                              child: Center(
                                child: Text('$totalDays Days'),
                              ),
                            )
                          else
                            Container(
                              height: 30,
                              width: width(context) * 0.25,
                              decoration: myOutlineBoxDecoration(1, primary, 7),
                              child: Center(
                                child: Text('${enterdate.text} Days'),
                              ),
                            ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                dateEnable = !dateEnable;
                                flexible = dateEnable;
                              });
                            },
                            child: Container(
                                height: 30,
                                width: width(context) * 0.25,
                                decoration: dateEnable ? myFillBoxDecoration(1, primary, 7) : myFillBoxDecoration(1, Colors.black12, 7),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: black,
                                      size: 18,
                                    ),
                                    Text(
                                      'I’m Flexible',
                                      style: bodytext12Bold(color: black),
                                    ),
                                  ],
                                )),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 230, top: 5),
                    child: InkWell(
                        onTap: () {
                          KnowMore(context);
                        },
                        child: const Text(
                          'Know More',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        )),
                  ),
                  addVerticalSpace(15),
                  if (!dateEnable)
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                      child: CustomTextFieldWidget(
                          onChanged: () {
                            totalDays = int.parse(enterdate.text);
                          },
                          kebordType: TextInputType.number,
                          controller: enterdate,
                          labelText: 'Please Enter Your Trip Days'),
                    ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text('Travel Mode'),
                  ),
                  addVerticalSpace(10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: 43,
                      width: width(context) * 0.85,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: const Border(
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
                            value: trip_mode,
                            isExpanded: true,
                            onChanged: (newValue) {
                              setState(() {
                                trip_mode = newValue!;
                              });
                            },
                            items: ['Select', 'Bus', 'Train', 'Flight']
                                .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 15, color: Colors.black),
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
                  // CustomDropDownButton(
                  //
                  //   lableText: '  Travel Mode  ',
                  //   itemList: items3,
                  // ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (ctx) => YourTripInterest()));
                      },
                      child: Text(
                        'Your Trip Intrest',
                        style: TextStyle(color: primary, decoration: TextDecoration.underline, fontWeight: FontWeight.w600),
                      )),
                  addVerticalSpace(50),
                  Center(
                    child: SizedBox(
                        height: 40,
                        width: width(context) * 0.5,
                        child: CustomButton(
                            name: 'Explore Trips',
                            onPressed: () async {
                              // printc("------${_string1}");
                              bool allCodition = true;
                              String msg = "";

                              if (type_of_trip1 == "Select") {
                                msg = "${msg} Please Select Travel Type";
                                showSimpleTost(context, txt: "${msg}");
                                allCodition = false;
                              }

                              if (planTrip_at_ == "Select") {
                                msg = "";
                                msg = "${msg} Please Select Travel State";
                                showSimpleTost(context, txt: "${msg}");
                                allCodition = false;
                              }

                              if (trip_mode == "Select") {
                                msg = "";
                                msg = "${msg} Please Select Travel Mode";
                                showSimpleTost(context, txt: "${msg}");
                                allCodition = false;
                              }

                              if (totalDays == 0) {
                                msg = "";
                                msg = "${msg} Please Select Days";
                                showSimpleTost(context, txt: "${msg}");
                                allCodition = false;
                              }

                              if (allCodition) {
                                showAPICallPendingDialog(context);
                                DocumentSnapshot<Map<String, dynamic>> unsavedPathDoc = await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('trip library')
                                    .doc('unsaved')
                                    .get();

                                if (unsavedPathDoc.exists) {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                      .collection('trip library')
                                      .doc('unsaved')
                                      .update({
                                    'data': FieldValue.arrayUnion([
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
                                } else {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                      .collection('trip library')
                                      .doc('unsaved')
                                      .set({
                                    'data': FieldValue.arrayUnion([
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
                                }

                                await setTripPlan();
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => SaveYourTripsScreen(
                                            type_Of_Trip: type_of_trip1,
                                            plamTrip_at: planTrip_at_,
                                            trip_days: totalDays,
                                            interestList: usereTripIntrest)));
                              }
                            })),
                  ),

                  // Center(
                  //   child: SizedBox(
                  //       height: 40,
                  //       width: width(context) * 0.5,
                  //       child: CustomButton(
                  //           name: 'Explore Trips',
                  //           onPressed: () async {
                  //             DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
                  //                 .collection('Friends Trip')
                  //                 .doc('Karnataka')
                  //                 .collection('lj9msda30dw9sypqyd4d')
                  //                 .doc('Bonus')
                  //                 .get();
                  //             await FirebaseFirestore.instance
                  //                 .collection('Travel New')
                  //                 .doc('Surat')
                  //                 .collection('ljr46pqh2kxfa5nm4nu')
                  //                 .doc('Bonus')
                  //                 .set(data.data()!);
                  //
                  //             // printc("------${_string1}");
                  //           })),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  KnowMore(BuildContext context) {
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
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
                              child: Center(
                                  child: Text(
                                "The dates taken here might require change as per travel seat availability and other convenience of the trip to the selected trip destination. If you wish our travel operator to suggest you a date for the trip, opt for I'm flexible. The number of days here suggested is for sightseeing and travel times will be added after the mode of travel is saved.",
                                style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ));
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:travel_app/utils/constant.dart';
import 'package:travel_app/views/aspired_trip/travel_agency_details.dart';
import 'package:travel_app/views/humburger_flow/upcoming_trips.dart';
import 'package:travel_app/widget/custom_appbar.dart';
import 'package:travel_app/widget/custom_button.dart';
import 'package:travel_app/widget/custom_dropdown_button.dart';

import '../../model/save_trip_model.dart';

class SaveTripAndGetQuote extends StatefulWidget {
  const SaveTripAndGetQuote({required this.message1, required this.message2});

  final String message1;
  final String message2;
  @override
  State<SaveTripAndGetQuote> createState() => _SaveTripAndGetQuoteState();
}

class _SaveTripAndGetQuoteState extends State<SaveTripAndGetQuote> {

  List clipList = [
    {'name': "Pickup and drop", 'isSelect': false},
    {'name': "Sightseeing Transport", 'isSelect': false},
    {'name': "Travel Guide", 'isSelect': false},
    {'name': "Infant assistance", 'isSelect': false},
  ];

  TextEditingController dateinput = TextEditingController();

  bool felexdate = false;
  String inclutes="";
  // updatesavetrip() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     var profile = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection("upcomingtrip")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .update({
  //       'departuredate':dateinput.text,
  //       "I'm Flexible with date": felexdate,
  //       "Include":inclutes,
  //       "Hoteltype":hotaltype
  //     });
  //     setState(() {});
  //   }
  // }
  String _image = "";
 var _date;
  String _address = "";
  String _tripname = "";
  String _tripsport = "";
  String triptype = "";
  String hotaltype = "";
  String _tripdays = "";
  String _bookingId = "";
  String _include = "";
  List _daysnumber = [];

  getaspridtrip() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance
          .collection('Aspired_trips')
          .doc('Trip1')
          .get();
      _image = profile.data()?['imageUrl'];
      _date = profile.data()?['date'].toDate().toString().split(" ").first;
      _address = profile.data()?['statename'];
      _tripname = profile.data()?['tripname'];
      _tripsport = profile.data()?['turistsport'];
      _daysnumber = profile.data()?['daysnumber'];
      _tripdays = profile.data()?['tripdays'];
      _bookingId = profile.data()?['bookingId'];
      _include = profile.data()?['includes'];

      setState(() {});
    }
  }
  checkupcomingtip() async {
    if (FirebaseAuth.instance.currentUser != null) {
      DocumentReference profile =  FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("upcomcheck")
      .doc('checktrip');
      profile.set({
        "upcoming": check
      });
      setState(() {});
    }
  }
  String check = "yes";

  addupcomingtrip() async {
    if (FirebaseAuth.instance.currentUser != null) {
      DocumentReference profile =  FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("upcomingtrip")
          .doc();
          profile.set({
          'image': _image,
          'date': _date,
          'address': _address,
          'tirpname': _tripname,
          'tripsport': _tripsport,
          'postId' :  profile.id,
            'daysnumber' :_daysnumber,
            "I'm Flexible with date": felexdate,
            "tripType": triptype,
            'departuredate':dateinput.text,
            "I'm Flexible with date": felexdate,
            "Hoteltype":hotaltype,
            "TripDays":_tripdays,
            "childer":child,
            "Adults":adults,
            "bookingId":_bookingId,
            "Includes":_include,
            "bookingeresponse":bookingres,
            "AirIndia":airind,
            "Seat": _seats,
            "Endtrip":_endtrip,


      });
      setState(() {});
    }
  }
  String _endtrip="Manglor";
  String airind ="AxP21-43";
  String _seats ="Sh1,Sh2,Sh4,SH32,Sh43";
  String bookingres ="Please check emails";
  String child = '4';
  String adults = '2';


  @override
  void initState() {
    getfestivals();
    getaspridtrip();
    getcontact();
    super.initState();
  }

  bool isChecked = false;
  String _festivalname = "";
  String _departurecity = "";
  String _tripdestination = "";

  void getfestivals() async{
    if (FirebaseAuth.instance.currentUser != null) {
      var festival = await FirebaseFirestore.instance
          .collection('festivals')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      _festivalname = festival.data()?['festivalname'];
      _departurecity = festival.data()?['locality'];
      _tripdestination = festival.data()?['tripdestination'];
    }

    setState(() {});
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(
            title: 'Save trip and get free quote\n         for your $_festivalname trip',
          )),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: height(context) * 0.9,
        width: width(context) * 0.95,
        decoration: shadowDecoration(10, 7),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Booking id: 540986',
                      style: bodyText16w600(color: black),
                    ),
                    TextButton(onPressed: (){
                      contactDialog(context);
                      },
                        child: Text('Your contact detail',
                          style: bodyText14w600(color: primary),)),

                  ],
                )
              ],
            ),
            addVerticalSpace(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width(context) * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Departure City',
                                style: bodyText14normal(
                                    color: Color.fromRGBO(185, 185, 185, 1)),
                              ),
                              Text(
                                '$_departurecity',
                                style: bodyText14w600(color: black),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Trip Destination',
                                style: bodyText14normal(
                                    color: Color.fromRGBO(185, 185, 185, 1)),
                              ),
                              Text(
                                '$_tripdestination',
                                style: bodyText14w600(color: black),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    addVerticalSpace(10),
                    SizedBox(
                      width: width(context) * 0.65,
                      height: 40,
                      child: TextField(
                        controller: dateinput,
                        onTap: () async {
                          var pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101)
                          );
                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            log(formattedDate);

                            setState(() {
                              dateinput.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.calendar_today_rounded,
                            color: primary,
                          ),
                          labelText: 'Departure date',
                          labelStyle: bodyText14w600(color: primary),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primary,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primary,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: isChecked,
                            activeColor: primary,
                            checkColor: black,
                            onChanged: (value) {
                              isChecked = !isChecked;
                              setState(() {
                                if(isChecked){
                                  felexdate = true;
                                }else{
                                  felexdate=false;
                                }
                              });
                            }),
                        Text(
                          'I’m Flexible with date',
                          style: bodyText13normal(color: black),
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  height: height(context) * 0.11,
                  width: width(context) * 0.2,
                  decoration: myOutlineBoxDecoration(2, primary, 10),
                  child: Column(
                    children: [
                      Text(
                        '7',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Days',
                        style: bodyText14w600(color: black),
                      )
                    ],
                  ),
                )
              ],
            ),
            addVerticalSpace(15),
            Text(
              'Trip type',
              style: bodyText16w600(color: black),
            ),
          SizedBox(
              height: height(context) * 0.05,
              width: width(context) * 0.95,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: checkListItems.length,
                  itemBuilder: (ctx, index) {
                    return Row(
                      children: [
                        Checkbox(
                          activeColor: primary,
                          checkColor: black,
                          value: checkListItems[index]["value"],
                          onChanged: (value) {
                            setState(() {
                              triptype = checkListItems[index]['title'];
                              for (var element in checkListItems) {
                                element["value"] = false;
                              }
                              checkListItems[index]["value"] = value;
                            // addupcomingtrip();
                            });
                          },
                        ),
                        Text(checkListItems[index]['title'])
                      ],
                    );
                  })),
            addVerticalSpace(15),
            Text(
              'Travellers',
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(15),
            TravellersAdultAndChildenSelectWidget(),
            addVerticalSpace(15),
            Text(
              'Preferred Hotel type',
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(3),
            Text(
              'Conditions to Hotel type available in the trip city',
              style: bodyText12Small(color: black),
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
            addVerticalSpace(15),
            Text(
              'Includes',
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(10),
                Includes(chipName: clipList),
            //   Text(
            //   widget.message1,
            //   style: bodyText12Small(spacing: 1.3, color: black),
            // ),
                Row(
                  children: [
                    Text('No payment now.'),
                    TextButton(onPressed: (){
                      LearnmoreDialog(context);
                    }, child: Text('Learn more',style: TextStyle(color: primary),))
                  ],
                ),
           // addVerticalSpace(5),
                Text('All travelers are requested to adhere health protocols as prescribed by the state and various authorities'),

                Text(
              widget.message2,
              style: bodyText12Small(spacing: 1.3, color: black),
            ),
            addVerticalSpace(30),
            Center(
              child: SizedBox(
                  width: width(context) * 0.35,
                  child: CustomButton(
                      name: 'Get Quotes',
                      onPressed: () {
                        addupcomingtrip();
                        checkupcomingtip();
                      //  updatesavetrip();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpcomingTripsScreen()));
                      })),
            ),
            addVerticalSpace(20)
          ]),
        ),
      ),
    );
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

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('       Your contact details are required for Travel operators to contact and send the booking details.',style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),),
                  ),
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


// class TripTypeWidget extends StatefulWidget {
//   const TripTypeWidget({super.key});
//
//   @override
//   State<TripTypeWidget> createState() => _TripTypeWidgetState();
// }
//
// class _TripTypeWidgetState extends State<TripTypeWidget> {
//
// String triptype ="";
//   updatetriptype() async {
//     if (FirebaseAuth.instance.currentUser != null) {
//       var profile = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .collection("upcomingtrip")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//         .update({
//         'Triptype':triptype,
//
//       });
//       setState(() {});
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: height(context) * 0.05,
//         width: width(context) * 0.95,
//         child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: checkListItems.length,
//             itemBuilder: (ctx, index) {
//               return Row(
//                 children: [
//                   Checkbox(
//                     activeColor: primary,
//                     checkColor: black,
//                     value: checkListItems[index]["value"],
//                     onChanged: (value) {
//                       setState(() {
//                         triptype = checkListItems[index]['title'];
//                         for (var element in checkListItems) {
//                           element["value"] = false;
//                         }
//                         checkListItems[index]["value"] = value;
//                         updatetriptype();
//                       });
//                     },
//                   ),
//                   Text(checkListItems[index]['title'])
//                 ],
//               );
//             }));
//     ;
//   }
// }

class TravellersAdultAndChildenSelectWidget extends StatefulWidget {
  const TravellersAdultAndChildenSelectWidget({super.key});

  @override
  State<TravellersAdultAndChildenSelectWidget> createState() =>
      _TravellersAdultAndChildenSelectWidgetState();
}

class _TravellersAdultAndChildenSelectWidgetState
    extends State<TravellersAdultAndChildenSelectWidget> {
  final items = ['1', '2', '3', '4', '6', '7', '8', '9', '10'];
  final items2 = ['1', '2', '3', '4', '6', '7', '8', '9', '10'];
  List itemss=[
    {'name':'1'},
    {'name':'2'},
    {'name':'3'},
    {'name':'4'},
  ];
  String? selectedValue = '1';
  String? selectedValue2 = '1';
  String selected1 = "";
  String selected2 = "";
  update() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("upcomingtrip")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'Adults': selected1,
        'Children': selected2
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: width(context) * 0.4,
          child: CustomDropDownButton(
            itemList: items,
              value: selected1,
            lableText: '  Adults  ',
          ),
        ),
        SizedBox(
          width: width(context) * 0.4,
          child: CustomDropDownButton(
            itemList: items2,
            value: selected2,
            lableText: '  Children  ',
          ),
        ),
        // TextButton(onPressed: (){update();}, child: Text('Bhavesh'))
      ],
    );
  }
}
//
// class PreferredHotelTypeWidget extends StatefulWidget {
//   const PreferredHotelTypeWidget({super.key});
//
//   @override
//   State<PreferredHotelTypeWidget> createState() =>
//       _PreferredHotelTypeWidgetState();
// }
//
// class _PreferredHotelTypeWidgetState extends State<PreferredHotelTypeWidget> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: height(context) * 0.05,
//         width: width(context) * 0.95,
//         child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: checkListItems2.length,
//             itemBuilder: (ctx, index) {
//               return Row(
//                 children: [
//                   Checkbox(
//                     activeColor: primary,
//                     checkColor: black,
//                     value: checkListItems2[index]["value"],
//                     onChanged: (value) {
//                       setState(() {
//                         hotaltype = checkListItems2[index]['title'];
//                         for (var element in checkListItems2) {
//                           element["value"] = false;
//                         }
//                         checkListItems2[index]["value"] = value;
//                         //updatehotaltype();
//                       });
//                     },
//                   ),
//                   Text(checkListItems2[index]['title'])
//                 ],
//               );
//             }));
//   }
// }
class Includes extends StatefulWidget {
  final List chipName;
  const Includes({Key? key, required this.chipName,}) : super(key: key);

  @override
  State<Includes> createState() => _IncludesState();
}

class _IncludesState extends State<Includes> {

  // String inclutes="";
  // updatesavetrip() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     var profile = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection("upcomingtrip")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .update({
  //       "Include":inclutes,
  //     });
  //     setState(() {});
  //   }
  // }

  List IncludeList = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: height(context) * 0.135,
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: includesList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemBuilder: (ctx, i) {
              return InkWell(
                onTap: () {
                  if (IncludeList.contains(widget.chipName[i]['name'])) {
                    IncludeList
                        .removeAt(IncludeList.indexOf(widget.chipName[i]['name']));
                    CollectionReference users = FirebaseFirestore.instance
                        .collection('users');
                    users
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("upcomingtrip")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      'Unsaved Includes':
                      FieldValue.arrayRemove([widget.chipName[i]['name']])
                    });
                    setState(() {});
                  } else {
                    IncludeList.add(widget.chipName[i]['name']);
                    CollectionReference users = FirebaseFirestore.instance
                        .collection('users');
                    users
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("upcomingtrip")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      'Unsaved Includes':
                      FieldValue.arrayUnion([widget.chipName[i]['name']])
                    });
                    setState(() {});
                  }

                  includesList[i].isSelected =
                  !includesList[i].isSelected;
                  setState(() {
                  });
                },
                child: Container(
                  height: height(context) * 0.05,
                  width: width(context) * 0.4,
                  decoration: includesList[i].isSelected
                      ? myOutlineBoxDecoration(1, primary, 10)
                      : myFillBoxDecoration(
                      0, black.withOpacity(0.1), 10),
                  child: Center(
                    child: Text(includesList[i].name),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
LearnmoreDialog(BuildContext context) {


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
              height: 300,
              child: Center(child: Text('Once you save this trip, TravelNew will provide your trip details to our network of certified travel operators and they shall provide you with their best quotation. Our travel operator may suggest you change in travel due to seat availability and Itinerary as per travel convenience',
              style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),
              )),
            );
          },
        ),
      ));
}



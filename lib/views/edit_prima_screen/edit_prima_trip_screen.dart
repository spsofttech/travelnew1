import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/edit_prima_screen/prima_trip_1to4_screen.dart';
import 'package:travelnew_app/views/publish%20your%20trip/step1.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/widget/custom_dropdown_button.dart';
import 'package:travelnew_app/widget/custom_textfield.dart';

class EditPrimaTripScreen extends StatefulWidget {
  const EditPrimaTripScreen({super.key});

  @override
  State<EditPrimaTripScreen> createState() => _EditPrimaTripScreenState();
}

class _EditPrimaTripScreenState extends State<EditPrimaTripScreen> {
  // final TextEditingController startDate = TextEditingController();
  // final TextEditingController endDate = TextEditingController();

  List imgList1 = [
    'assets/images/tp1.png',
    'assets/images/tp2.png',
    'assets/images/tp3.png',
    'assets/images/tp1.png',
    'assets/images/tp2.png',
    'assets/images/tp3.png'
  ];
  final TextEditingController TripNameController = TextEditingController();
  final TextEditingController aboutTripController = TextEditingController();
  final TextEditingController StarDateController = TextEditingController();
  final TextEditingController EndDateController = TextEditingController();

  updatePrimaTripDetails() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Prima_Trip_Plan")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
          "Specify_trip_name": TripNameController.text,
          "Include in trip": aboutTripController.text,
          "start_date": StarDateController.text,
          "End_date": EndDateController.text,
          "totalDays": tripTotalDays,
          "Inveted Member": InvitedMembervalue,
          "who see trip": seetripvalue,
          "Max_Member": MaxMembervalue,
          "Spends": spendvalue,
          "Mode_of_travel": _string3,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  String InvitedMembervalue = "Select";
  String seetripvalue = "Select";
  String MaxMembervalue = "Select";
  String spendvalue = "Select";
  String _string3 = "Bus";
  int tripTotalDays = 0;
  var firstDate;
  var secondDate;
  void getdata() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Prima_Trip_Plan")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      TripNameController.text = profile.data()?['Specify_trip_name'];
      aboutTripController.text = profile.data()?['Include in trip'];
      StarDateController.text = profile.data()?['start_date'];
      EndDateController.text = profile.data()?['End_date'];
      tripTotalDays = profile.data()?['totalDays'];
      tripImage = profile.data()?['Cover_Pic'];
    }
    setState(() {});
  }

  String tripImage = "";
  List image = [];
  List touristSportName = [];
  void getImageData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance.collection('tripstate').doc('karnataka').collection('tripcity').doc('Bengaluru').get();
      image = profile.data()?['TouristSportImage'];
      touristSportName = profile.data()?['TouristSport'];
    }
    setState(() {});
  }

  @override
  void initState() {
    getdata();
    getImageData();
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
              height: height(context) * 0.35,
              width: double.infinity,
              decoration: tripImage == ""
                  ? BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/editprima2.png')))
                  : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(tripImage))),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
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
                          padding: const EdgeInsets.only(right: 150),
                          child: Text(
                            'Edit Prima Trip',
                            style: bodyText20w700(color: white),
                          ),
                        ),
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: Icon(
                        //       Icons.edit,
                        //       color: white,
                        //     ))
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About trip',
                    style: bodyText16w600(color: black),
                  ),
                  addVerticalSpace(15),
                  CustomTextFieldWidget(controller: TripNameController, labelText: 'Edit trip name'),
                  addVerticalSpace(15),
                  SizedBox(
                    // height: height(context) * 0.05,
                    width: width(context) * 0.95,
                    child: Theme(
                      data: ThemeData(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: primary,
                            ),
                      ),
                      child: TextField(
                        controller: aboutTripController,
                        // maxLines: 4,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'What you’ll do in Trip',
                          // labelStyle: bodyText14w600(color: primarhy),

                          focusColor: primary,

                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide(color: Colors.black26, width: 1.0), borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primary, width: 1.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  addVerticalSpace(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                              height: 40,
                              width: width(context) * 0.52,
                              child: CustomTextFieldWidget(
                                controller: StarDateController,
                                labelText: 'Start Date',
                                onClick: () async {
                                  var pickedDate = await showDatePicker(
                                      context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                                  if (pickedDate != null) {
                                    print(pickedDate);
                                    firstDate = pickedDate.day;
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

                                    setState(() {
                                      StarDateController.text = formattedDate;
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
                              width: width(context) * 0.52,
                              height: 40,
                              child: CustomTextFieldWidget(
                                controller: EndDateController,
                                labelText: 'End Date',
                                onClick: () async {
                                  var pickedDate = await showDatePicker(
                                      context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                                  if (pickedDate != null) {
                                    print(pickedDate);
                                    secondDate = pickedDate.day;
                                    tripTotalDays = secondDate - firstDate;
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

                                    setState(() {
                                      EndDateController.text = formattedDate;
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
                        width: width(context) * 0.36,
                        decoration: myOutlineBoxDecoration(2, primary, 10),
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                          Text(
                            '$tripTotalDays',
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: black),
                          ),
                          Text(
                            'Days',
                            style: TextStyle(fontSize: 22, color: black),
                          )
                        ]),
                      )
                    ],
                  ),
                  addVerticalSpace(15),
                  CustomTextFieldWidget(labelText: 'Places Visiting'),
                  addVerticalSpace(15),
                  Text(
                    'Click to add it in the trip',
                    style: bodyText14w600(color: black.withOpacity(0.4)),
                  ),
                  addVerticalSpace(10),
                  SizedBox(
                    height: height(context) * 0.20,
                    child: ListView.builder(
                        itemCount: image.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) {
                          return InkWell(
                            onTap: () {
                              // Call the user's CollectionReference to add a new user
                              CollectionReference users = FirebaseFirestore.instance.collection('users');
                              users
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("Prima_Trip_Plan")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                    "TouristSportImage": FieldValue.arrayUnion([image[i]]),
                                    "TouristSportName": FieldValue.arrayUnion([touristSportName[i]]),
                                  })
                                  .then((value) => print("User Added"))
                                  .catchError((error) => print("Failed to add user: $error"));

                              setState(() {});
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  height: height(context) * 0.15,
                                  width: width(context) * 0.3,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        image[i],
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                addVerticalSpace(5),
                                Text(touristSportName[i]),
                              ],
                            ),
                          );
                        }),
                  ),
                  addVerticalSpace(15),
                  Text(
                    'Not found the tourist spot, you can select either the nearest spot or add tourist spot here',
                    style: bodyText12Small(spacing: 1.4, color: black),
                  ),
                  addVerticalSpace(20),
                  Container(
                    child: const Text('       Travel Mode'),
                  ),
                  addVerticalSpace(5),

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
                            value: _string3,
                            isExpanded: true,
                            onChanged: (newValue) {
                              setState(() {
                                _string3 = newValue!;
                              });
                            },
                            items: ['Bus', 'Train', 'Flight']
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
                  // addVerticalSpace(20),
                  // SizedBox(
                  //   width: width(context) * 0.55,
                  //   child: CustomDropDownButton(
                  //     itemList: ['By road', 'Flight', 'Train'],
                  //     lableText: '  Mode of  Travel  ',
                  //   ),
                  // ),
                  addVerticalSpace(20),
                  Row(
                    children: [
                      Container(child: const Text('     Who can see your trip  ')),
                      Container(child: const Text('                      Members Type invited  ')),
                    ],
                  ),
                  addVerticalSpace(5),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: SizedBox(
                          height: 43,
                          width: width(context) * 0.42,
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
                                value: InvitedMembervalue,
                                isExpanded: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    InvitedMembervalue = newValue!;
                                  });
                                },
                                items: ['Select', 'Public', 'My Trip friends']
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
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                          height: 43,
                          width: width(context) * 0.42,
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
                                value: seetripvalue,
                                isExpanded: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    seetripvalue = newValue!;
                                  });
                                },
                                items: ['Select', 'All type', 'Only Men', 'Only Women']
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(child: const Text('     Max Members for Trip  ')),
                          Container(child: const Text('                      How spends distributed?  ')),
                        ],
                      ),
                      addVerticalSpace(5),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: SizedBox(
                              height: 43,
                              width: width(context) * 0.42,
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
                                    value: MaxMembervalue,
                                    isExpanded: true,
                                    onChanged: (newValue) {
                                      setState(() {
                                        MaxMembervalue = newValue!;
                                      });
                                    },
                                    items: [
                                      'Select',
                                      '1',
                                      '2',
                                      '3',
                                      '4',
                                    ]
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
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              height: 43,
                              width: width(context) * 0.42,
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
                                    value: spendvalue,
                                    isExpanded: true,
                                    onChanged: (newValue) {
                                      setState(() {
                                        spendvalue = newValue!;
                                      });
                                    },
                                    items: ['Select', 'For him/her self', ' Trip host', 'Except trip host']
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
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  addVerticalSpace(15),
                  Text(
                    'For convience of all travellers, we have placed a limit to activities and edits on prima trips',
                    style: bodyText12Small(spacing: 1.4, color: black),
                  ),
                  addVerticalSpace(height(context) * 0.1),
                  Center(
                    child: SizedBox(
                      width: width(context) * 0.5,
                      child: CustomButton(
                          name: 'Save trip',
                          onPressed: () {
                            updatePrimaTripDetails();
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) => PrimaTrip1To4Screens()));
                          }),
                    ),
                  ),
                  addVerticalSpace(20)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

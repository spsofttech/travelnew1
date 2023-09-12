import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:travelnew_app/views/publish%20your%20trip/publish_your_trip.dart';
import 'package:travelnew_app/widget/custom_dropdown_button.dart';
import 'package:travelnew_app/widget/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/constant.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widget/custom_appbar.dart';

Future<void> addPublishTripDetails() async {
  print(FirebaseAuth.instance.currentUser!.uid);
  // Call the user's CollectionReference to add a new user
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Prima_Trip_Plan")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({
        "Uid": FirebaseAuth.instance.currentUser!.uid,
        // "Star_Trip_location": startLocationController.text,
        "Specify_type": selectedTypeOfPrimaTrip,
        "where_to": selectedCityOfPrimaTrip,
        "Mode_of_travel": selectedModeOfPrimaTrip,
        "start_date": startDateController.text,
        "End_date": endDateController.text,
        "Specify_trip_name": specitTripName,
        "totalDays": totalDays,
        "Cover_Pic": coverpicImage,
        "friends": [],
        "items": [],
        'tripHost': {
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'image': USERIMAGE,
          'name': USERNAME,
        }
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

//
// addStep1PublishTripDetails() async {
//   // Call the user's CollectionReference to add a new user
//
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   users
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .collection("Trip_Plan")
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .update({
//         "Star_Trip_location": startLocationController.text,
//         "Specify_type": selectedTypeOfPrimaTrip,
//         "where_to": slectedCityOfPrimaTrip,
//         "Mode_of_travel": selectedModeOfPrimaTrip,
//         "start_date": endDateController.text,
//         "End_date": endDateController.text,
//         "Specify_trip_name": specitTripNameController.text,
//       })
//       .then((value) => print("User Added"))
//       .catchError((error) => print("Failed to add user: $error"));
// }
//
// String selectedTypeOfPrimaTrip = "Select";
// String slectedCityOfPrimaTrip = "Select";
// String selectedModeOfPrimaTrip = "Bus";
String _image = "";

//final TextEditingController startLocationController = TextEditingController();
// final TextEditingController specifyTripTypeController = TextEditingController();
// final TextEditingController andTripController = TextEditingController();
// final TextEditingController modeTravelController = TextEditingController();
final TextEditingController startDateController = TextEditingController();
final TextEditingController endDateController = TextEditingController();

// final TextEditingController triptypeController = TextEditingController();

class Step1 extends StatefulWidget {
  const Step1({super.key});

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  @override
  void initState() {
    getDetails();
    getstartlocation();
    super.initState();
  }
  // [
  // 'Select',
  // 'Agartala',
  // 'Ahmedabad',
  // 'Aizawl',
  // 'Amritsar',
  // 'Ayodhya',
  // 'Badrinath',
  // 'Bengaluru',
  // 'Bhopal',
  // 'Bhubaneshwar',
  // 'Bilaspur',
  // 'Chandigarh',
  // 'Dehradun',
  // 'Delhi',
  // 'Gangtok',
  // 'Guwahati',
  // 'Hyderabad',
  // 'Jaipur',
  // 'Agra',
  // 'Aurangabad',
  // 'Bhuj',
  // 'Bhavnagar',
  // 'Ajmer',
  // 'Anandpur Sahib',
  // 'Chamarajanagar',
  // 'Rewari',
  // 'Namakkal',
  // 'Azamgarh',
  // 'Chalakudy',
  // 'Bishnupur'
  // ]
  // final List<String> tripLocation = ['Pune', 'Mumbai', 'chennai'];

  String coverPic = "";
  List<Map<String, dynamic>> cityDropDown = [];
  void getDetails() async {
    if (IS_USER_LOGIN) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Prima_Trip_Plan')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      coverPic = profile.data()?['Cover_Pic'] ?? "";

      setState(() {});
    }
  }

  String startplace = "";

  void getstartlocation() async {
    if (IS_USER_LOGIN) {
      var profile = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      startplace = profile.data()?['locality'];

      setState(() {});
    }
  }

  void getTripCities({required String cat}) async {
    // String col = cat == 1
    //     ? "Adventure"
    //     : cat == 2
    //         ? "Fairs"
    //         : "Road";

    if (IS_USER_LOGIN) {
      var cityData = await FirebaseFirestore.instance.collection('Prima Tourist Spot').doc(cat).get();

      setState(() {
        List cityListData = cityData.data()?['data'] ?? [];

        cityListData.sort(
          (a, b) {
            return a['rank'].compareTo(b['rank']);
          },
        );
        print(cityListData);
        cityDropDown = cityListData.map((e) => e as Map<String, dynamic>).toList();
        printc(cityDropDown);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text('Trip Start Location*'),
        ),
        addVerticalSpace(5),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
              height: 43,
              width: width(context) * 0.85,
              decoration: myOutlineBoxDecoration(1, Colors.black26, 10),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Text(
                  '$startplace',
                  style: const TextStyle(fontSize: 15),
                ),
              )),
        ),
        addVerticalSpace(20),
        Container(padding: EdgeInsets.only(left: 8), child: const Text('Specify trip type  ')),
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
              child: FutureBuilder(
                future: FirebaseFirestore.instance.collection('Tripometer').get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        hint: Text("${selectedTypeOfPrimaTrip}"),
                        borderRadius: BorderRadius.circular(10),
                        // value: selectedTypeOfPrimaTrip,
                        isExpanded: true,
                        onChanged: (newValue) {
                          selectedTypeOfPrimaTrip = newValue!;
                          selectedCityOfPrimaTrip = "Select";
                          String cat = selectedTypeOfPrimaTrip;
                          getTripCities(cat: cat);
                        },
                        items: snapshot.data!.docs
                            .map((e) => e.id)
                            .toList()
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
        addVerticalSpace(20),
        Container(padding: EdgeInsets.only(left: 8), child: const Text('Plan trip at  ')),
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
                child: DropdownButton<Map>(
                  borderRadius: BorderRadius.circular(10),
                  hint: Text("${selectedCityOfPrimaTrip}"),
                  //value: slectedCityOfPrimaTrip,
                  isExpanded: true,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCityOfPrimaTrip = newValue!['name'];
                      specitTripName = newValue['trip_name'];
                    });
                  },

                  items: cityDropDown
                      .map<DropdownMenuItem<Map<String, dynamic>>>((value) => DropdownMenuItem<Map<String, dynamic>>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                value['name'],
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
        // CustomDropDownButton(
        //     value: slectedCityOfPrimaTrip,
        //     controller: specitTripNameController,
        //     lableText: 'Where to ?',
        //     itemList: [
        //       'jaipur',
        //       'Bengaluru ',
        //       'Vadodara',
        //       'Mysuru',
        //       'Jaisalmer',
        //       'Patan',
        //       'Thanjavur',
        //       'Kasargod',
        //       'Belgavi',
        //       'Ujjain'
        //     ]),
        addVerticalSpace(20),
        Container(
          padding: EdgeInsets.only(left: 8),
          child: const Text('Travel Mode'),
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
                  value: selectedModeOfPrimaTrip,
                  isExpanded: true,
                  onChanged: (newValue) {
                    setState(() {
                      selectedModeOfPrimaTrip = newValue!;
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
        // CustomDropDownButton(
        //     value: selectedModeOfPrimaTrip,
        //     // controller: specitTripNameController,
        //     lableText: 'Mode of trip',
        //     itemList: ['Flight', 'Train', 'Road']),
        addVerticalSpace(20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                      height: 40,
                      width: width(context) * 0.5,
                      child: CustomTextFieldWidget(
                        controller: startDateController,
                        labelText: 'Start Date',
                        onClick: () async {
                          var pickedDate =
                              await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2101));
                          secondDate = DateTime.now();
                          if (pickedDate != null) {
                            print(pickedDate);
                            firstDate = pickedDate;
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

                            setState(() {
                              startDateController.text = formattedDate;
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
                        controller: endDateController,
                        labelText: 'End Date',
                        onClick: () async {
                          if (firstDate != null) {
                            var pickedDate =
                                await showDatePicker(context: context, initialDate: firstDate!, lastDate: DateTime(3000), firstDate: firstDate!);
                            if (pickedDate != null) {
                              print(pickedDate);
                              secondDate = pickedDate;
                              totalDays = secondDate!.difference(firstDate!).inDays;
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                endDateController.text = formattedDate;
                              });
                            }
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
                height: 70,
                width: width(context) * 0.25,
                decoration: myOutlineBoxDecoration(2, primary, 10),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Text(
                    '$totalDays',
                    style: bodyText30W600(color: black),
                  ),
                  Text(
                    'Days',
                    style: bodyText16normal(color: black),
                  )
                ]),
              )
            ],
          ),
        ),
        addVerticalSpace(15),
        Row(
          children: [
            InkWell(
              onTap: () {
                if (coverpicImage == "") Navigator.push(context, MaterialPageRoute(builder: (context) => CoverPicScreen()));
              },
              child: Container(
                height: height(context) * 0.05,
                width: width(context) * 0.55,
                decoration: myFillBoxDecoration(0, black.withOpacity(0.05), 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      coverpicImage != "" ? Icons.done : Icons.image,
                      color: black.withOpacity(0.2),
                    ),
                    coverpicImage != "" ? Text('cover pic Selected') : Text('Choose a cover pic'),
                  ],
                ),
              ),
            ),
            addHorizontalySpace(34),
            // Container(
            //   height: 90,
            //   width: width(context) * 0.25,
            //   decoration: coverPic == ""
            //       ? BoxDecoration(
            //       image: DecorationImage(
            //           fit: BoxFit.fill,
            //           image: AssetImage('assets/images/prima3.png')))
            //       : BoxDecoration(
            //       image: DecorationImage(
            //           fit: BoxFit.fill, image: NetworkImage(coverPic))),
            // )
          ],
        ),
        addVerticalSpace(20),
        // SizedBox(
        //   height: height(context) * 0.06,
        //   width: width(context) * 0.95,
        //   child: Theme(
        //     data: ThemeData(
        //       colorScheme: Theme.of(context).colorScheme.copyWith(
        //             primary: primary,
        //           ),
        //     ),
        //     child: TextField(
        //       // minLines: 2,
        //       // maxLines: 2,
        //       controller: specitTripNameController,
        //       // onChanged:(String){ onChanged},
        //       keyboardType: TextInputType.text,
        //       decoration: InputDecoration(
        //         labelText: 'Specify a trip name',
        //         // labelStyle: bodyText14w600(color: primarhy),
        //         focusColor: primary,
        //         enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26, width: 1.0), borderRadius: BorderRadius.circular(10)),
        //         focusedBorder: OutlineInputBorder(
        //           borderSide: BorderSide(color: primary, width: 1.5),
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         // contentPadding:
        //         //     const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        //       ),
        //     ),
        //   ),
        // ),
        // addVerticalSpace(20),
      ],
    );
  }

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height, imageQuality: 75);
    Reference ref = FirebaseStorage.instance.ref().child('profileImg');

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        _image = value;
      });
    });
  }
}

class Step4 extends StatefulWidget {
  const Step4({Key? key}) : super(key: key);

  @override
  State<Step4> createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CoverPicScreen extends StatefulWidget {
  CoverPicScreen({super.key});

  @override
  State<CoverPicScreen> createState() => _CoverPicScreenState();
}

class _CoverPicScreenState extends State<CoverPicScreen> {
  DocumentReference<Map<String, dynamic>> _collectionRef = FirebaseFirestore.instance.collection('Cover Pic').doc('data');

  Future<void> getcoverImageList() async {
    // Get docs from collection reference
    DocumentSnapshot<Map<String, dynamic>> querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    // List imageList=querySnapshot.data()!['image']
    print(querySnapshot.data()!['image']);
    coverImageList = (querySnapshot.data()!['image']) as List;
    setState(() {});
    print(coverImageList);
  }

  List coverImageList = [];

  @override
  void initState() {
    getcoverImageList();
    super.initState();
  }

  showSnackBar(BuildContext context, String str, [Color clr = Colors.black]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: clr,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50), child: CustomAppBar(title: 'Cover Pic Images')),
      body: ListView.builder(
          itemCount: coverImageList.length,
          itemBuilder: (ctx, i) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      coverpicImage = coverImageList[i];
                      Navigator.pop(context);
                      showSnackBar(context, "Your cover pic has been selected.", primary);
                      //setState(() {});
                    },
                    child: SizedBox(
                      height: height(context) * 0.290,
                      width: width(context) * 1,
                      child: Image.network(
                        coverImageList[i],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  addVerticalSpace(10)
                ],
              ),
            );
          }),
    );
  }
}

import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:travel_app/views/humburger_flow/my_account/trip_intrest_screen.dart';
import 'package:travel_app/views/humburger_flow/prima_profile/prima_my_account_screen.dart';
import 'package:travel_app/views/humburger_flow/prima_profile/prima_profile_screen.dart';
import 'package:travel_app/widget/custom_appbar.dart';
import 'package:travel_app/widget/custom_button.dart';
import 'package:travel_app/widget/custom_dropdown_button.dart';
import 'package:travel_app/widget/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../widget/upload_image.dart';
import '../../prima/go_prima_screen.dart';

class CreatePrimaProfile extends StatefulWidget {
  const CreatePrimaProfile({super.key});

  @override
  State<CreatePrimaProfile> createState() => _CreatePrimaProfileState();
}

class _CreatePrimaProfileState extends State<CreatePrimaProfile> {
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController annivarsaryDate = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController emailId = TextEditingController();
  // final TextEditingController statusController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController emergencyNumber = TextEditingController();
  final TextEditingController userInterestController = TextEditingController();
  final TextEditingController destination = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();

  addPrimaAccountDetails() async {
    // Call the user's CollectionReference to add a new user

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("primaAccount")
        .doc("profile")
        .set({
          "imageUrl": _image,
          "fullName": firstnameController.text + " " + lastnameController.text,
          "firstName": firstnameController.text,
          "lastName": lastnameController.text,
          "DOB": dateOfBirth.text,
          "Annivarsary": annivarsaryDate.text,
          'profession': professionController.text,
          "maritalStatus": _string,
          "gender": _string1,
          // John Doe
          "governmentId": IdUrl, // 42

          "emailId": emailId.text,
          "mobileNumber": mobileNumber.text,
          "emergencyNumber": emergencyNumber.text,
          "aboutme": aboutMeController.text,
          "userInterest": userInterestController.text,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  updatePrimaAccountDetails() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("primaAccount")
        .doc("profile")
        .update({
          "imageUrl": _image ?? "",
          "fullName": firstnameController.text + "" + lastnameController.text,
          "firstName": firstnameController.text,
          "lastName": lastnameController.text,
          "DOB": dateOfBirth.text,
          "Annivarsary": annivarsaryDate.text,
          'profession': professionController.text,
          "maritalStatus": _string,
          "gender": _string1,
          // John Doe
          "governmentId": IdUrl, // 42
          "aboutme": aboutMeController.text,
          "emailId": emailId.text,
          "mobileNumber": mobileNumber.text,
          "emergencyNumber": emergencyNumber.text,
          "userInterest": userInterestController.text,
        })
        .then((value) => print("Details Updated"))
        .catchError((error) => print("Failed to Update users Details: $error"));
  }

  bool _prima = true;
  updateprima() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"isPrima": _prima})
        .then((value) => print("Details Updated"))
        .catchError((error) => print("Failed to Update users Details: $error"));
  }

  String _string = "Single";
  String _string1 = "Male";
  String _image = "";
  String firstname = "";
  void getDetails() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("primaAccount").doc("profile").get();
      _image = profile.data()?['image'];
      // url = profile.data()?['document'];
      firstnameController.text = profile.data()?['firstName'];
      firstname = profile.data()?['firstName'];
      dateOfBirth.text = profile.data()?['DOB'];
      annivarsaryDate.text = profile.data()?['Annivarsary'];
      professionController.text = profile.data()?['profession'];
      emergencyNumber.text = profile.data()?['emergencyNumber'];
      lastnameController.text = profile.data()?['lastName'];
      mobileNumber.text = profile.data()?['mobileNumber'];
      aboutMeController.text = profile.data()?['aboutme'];
      emailId.text = profile.data()?['emailId'];
      userInterestController.text = profile.data()?['userInterest'];
      // statusController.text = profile.data()?['maritalStatus'];
      // genderController.text = profile.data()?['gender'];
      setState(() {});
    }
  }

  int _currentStep = 0;

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // CollectionReference primaAccount =
  //     FirebaseFirestore.instance.collection('primaAccounts');

  final user = FirebaseAuth.instance.currentUser;

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height, imageQuality: 75);

    showAPICallPendingDialog(context);
    _image = await FireBaseImageUpload.fireBaseImageUpload.userUploadImage(fileImagePath: image!.path, folderPath: FirebaseFolderPath.userImageUpload);
    final docRef = await FirebaseFirestore.instance.collection("users").doc(USER_UID).update({'image': _image});
    Navigator.pop(context);
    setState(() {});
    // Reference ref = FirebaseStorage.instance.ref().child('profileImg');
    //
    // await ref.putFile(File(image!.path));
    // ref.getDownloadURL().then((value) {
    //   print(value);
    //   setState(() {
    //     _image = value;
    //   });
    // });
  }

  File? pdfFile;
  String? _filename;

  Future pickIdProof() async {
    try {
      final Id = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (Id == null) {
        return;
      }
      final filepath = Id.files.single.path;
      final filename = Id.files.single.name;
      setState(() {
        pdfFile = File(filepath!);
        _filename = filename;
        print(filename);
      });
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  String? IdUrl;
  Future uploadId(File pdfFile) async {
    String imgid = DateTime.now().microsecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child('pdfs').child('users$imgid');
    await ref.putFile(pdfFile);
    IdUrl = await ref.getDownloadURL();
    print(IdUrl);
  }

  void initState() {
    getDetails();
    gerprimacheck();
    //addPrimaAccountDetails();
    //  updatePrimaAccountDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50), child: CustomAppBar(title: 'Create Prima Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StepperWidget(),
              const Text(
                'General details',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              addVerticalSpace(4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      height: height(context) * 0.15,
                      width: width(context) * 0.3,
                      decoration: _image == ""
                          ? BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/prima3.png')))
                          : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(_image))),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      pickUploadImage();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 13, left: 5),
                      height: 25,
                      width: width(context) * 0.43,
                      decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.edit_note_outlined,
                            size: 22,
                          ),
                          Text('Add Profile Picture')
                        ],
                      ),
                    ),
                  )
                ],
              ),
              addVerticalSpace(10),
              Row(
                children: [
                  SizedBox(
                      height: 37,
                      width: width(context) * 0.45,
                      child: CustomTextFieldWidget(
                        labelText: 'First Name',
                        controller: firstnameController,
                      )),
                  addHorizontalySpace(10),
                  SizedBox(
                      height: 37,
                      width: width(context) * 0.45,
                      child: CustomTextFieldWidget(
                        labelText: 'Last Name',
                        controller: lastnameController,
                      ))
                ],
              ),
              addVerticalSpace(12),
              Row(
                children: [
                  SizedBox(
                      height: 37,
                      width: width(context) * 0.45,
                      child: CustomTextFieldWidget(
                        controller: dateOfBirth,
                        labelText: 'Date Of Birth',
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: primary,
                        ),
                        onClick: () async {
                          var pickedDate =
                              await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

                            setState(() {
                              dateOfBirth.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      )),
                  addHorizontalySpace(10),
                  SizedBox(
                      height: 37,
                      width: width(context) * 0.45,
                      child: CustomTextFieldWidget(
                        controller: annivarsaryDate,
                        labelText: 'Anniversary dates',
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: primary,
                        ),
                        onClick: () async {
                          var pickedDate =
                              await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

                            setState(() {
                              annivarsaryDate.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      )),
                ],
              ),
              addVerticalSpace(10),
              SizedBox(
                  height: 37,
                  child: CustomTextFieldWidget(
                    labelText: 'Profession',
                    controller: professionController,
                  )),
              addVerticalSpace(22),
              Row(
                children: [Text('   Married status'), Text('                                         Gender')],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 37,
                    width: width(context) * 0.45,
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
                          value: _string,
                          isExpanded: true,
                          onChanged: (newValue) {
                            setState(() {
                              _string = newValue!;
                            });
                          },
                          items: ['Single', 'Married', 'Commited']
                              .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: bodytext12Bold(color: black),
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
                  addHorizontalySpace(10),
                  SizedBox(
                    height: 37,
                    width: width(context) * 0.45,
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
                          value: _string1,
                          isExpanded: true,
                          onChanged: (newValue) {
                            setState(() {
                              _string1 = newValue!;
                            });
                          },
                          items: ['Male', 'Female', 'Other']
                              .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: bodytext12Bold(color: black),
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
                ],
              ),
              SizedBox(
                height: 30,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Why is this required?',
                      style: TextStyle(fontWeight: FontWeight.w600, color: primary, decoration: TextDecoration.underline),
                    )),
              ),
              const Divider(
                // height: ,
                thickness: 1,
              ),
              addVerticalSpace(7),
              const Text(
                'Contact details',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              addVerticalSpace(10),
              SizedBox(
                height: 37,
                child: CustomTextFieldWidget(
                  labelText: 'Email Id',
                  controller: emailId,
                ),
              ),
              addVerticalSpace(10),
              Row(
                children: [
                  SizedBox(
                      height: 37,
                      width: width(context) * 0.45,
                      child: CustomTextFieldWidget(
                        labelText: 'Mobile number',
                        controller: mobileNumber,
                      )),
                  addHorizontalySpace(10),
                  SizedBox(
                      height: 37,
                      width: width(context) * 0.45,
                      child: CustomTextFieldWidget(
                        labelText: 'Emergency number',
                        controller: emergencyNumber,
                      ))
                ],
              ),
              addVerticalSpace(10),
              const Divider(
                thickness: 1,
              ),
              addVerticalSpace(7),
              // ignore: prefer_const_constructors
              Text(
                'Government IDs',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              InkWell(
                onTap: () {
                  pickIdProof().whenComplete(() {
                    uploadId(pdfFile!);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 8, left: 2),
                  height: 40,
                  width: pdfFile != null ? width(context) * 0.9 : width(context) * 0.55,
                  decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      pdfFile != null
                          ? Text.rich(TextSpan(children: [WidgetSpan(child: Icon(Icons.picture_as_pdf)), TextSpan(text: _filename)]))
                          : Text(
                              'Address Proof',
                              style: bodyText16w600(color: black),
                            ),
                      addHorizontalySpace(12),
                      const Icon(
                        Icons.edit_note_outlined,
                        size: 22,
                      ),
                      addHorizontalySpace(10),
                      const Icon(
                        Icons.remove_red_eye_outlined,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSpace(10),
              SizedBox(
                height: 30,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Why is this required?',
                      style: TextStyle(fontWeight: FontWeight.w600, color: primary, decoration: TextDecoration.underline),
                    )),
              ),
              addVerticalSpace(7),
              const Divider(
                thickness: 1,
              ),
              addVerticalSpace(7),

              const Text(
                'About me',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              addVerticalSpace(10),
              Container(
                decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 15),
                width: width(context) * 0.94,
                // height: height(context) * 0.15,
                child: TextField(
                    controller: aboutMeController,
                    onTap: () {},
                    maxLines: 3,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: bodyText16normal(color: black.withOpacity(0.5)),
                        hintText: 'Whats amazing about me? \nWhy I’m on travel new?')),
              ),
              addVerticalSpace(15),
              addVerticalSpace(10),
              const Text(
                'Other interest',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              addVerticalSpace(10),
              Container(
                decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 15),
                width: width(context) * 0.94,
                // height: height(context) * 0.15,
                child: TextField(
                    controller: userInterestController,
                    onTap: () {},
                    maxLines: 3,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: bodyText16normal(color: black.withOpacity(0.5)),
                        hintText: 'Example: Loves to cook, workout, books etc')),
              ),
              addVerticalSpace(10),
              Text(
                'Show my other interest to',
                style: bodyText14w600(color: black),
              ),
              SizedBox(
                  height: height(context) * 0.06,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectOtherInterestList.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (ctx, i) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                                child: Checkbox(
                                  activeColor: primary,
                                  checkColor: black,
                                  value: selectOtherInterestList[i].isSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      for (var element in selectOtherInterestList) {
                                        element.isSelected = false;
                                      }
                                      selectOtherInterestList[i].isSelected = value!;
                                    });
                                  },
                                ),
                              ),
                              Text(selectOtherInterestList[i].name)
                            ],
                          ),
                        );
                      })),
              const Divider(
                thickness: 1,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tripometer',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.help))
                ],
              ),
              TripometerWidget(),
              InkWell(
                  onTap: () {
                    tripomererequaried(context);
                  },
                  child: Text(
                    'Why is this required',
                    style: TextStyle(fontWeight: FontWeight.w600, color: primary, decoration: TextDecoration.underline),
                  )),
              addVerticalSpace(10),
              Divider(
                thickness: 1,
              ),
              addVerticalSpace(10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'What excites you?',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (ctx) => YourTripInterest()));
                      },
                      icon: Icon(Icons.edit_note))
                ],
              ),
              WhatExcitesYouWidget(),
              const Divider(
                thickness: 1,
              ),
              UploadTravelsPhotos(),
              addVerticalSpace(10),

              addVerticalSpace(20),
              CustomButton(
                  name: 'Create my profile',
                  onPressed: () {
                    updatetravelphoto();
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(' Are You Ready to be a Prima Member!'),
                        content: const Text(' You will be directed to payment Gateway fill free to click on Confirm '),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              updateprima();
                              if (firstname != "") {
                                yesprimprofile(context);

                                updatePrimaAccountDetails();
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (ctx) =>
                                //               PrimaProfileScreen()));
                              } else {
                                notprimamember(context);
                                addPrimaAccountDetails();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (ctx) =>
                                //             PrimaProfileScreen()));
                              }
                            },
                            child: const Text('Confirm'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'CANCEL'),
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    );
                  }),
              addVerticalSpace(15)
            ],
          ),
        ),
      ),
    );
  }

  yesprimprofile(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: const Text(
            ' You are missing joining trip of your trip friends, getting connected to the  travel community, visiting unexplored places and more features '),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GoPrimaSubscriptionScreen()));
            },
            child: const Text('Upgrade '),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PrimaProfileScreen()));
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  notprimamember(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: const Text(
            ' Hey, You have created your Prima profile. But you cannot avail the complete features like joining trip of your trip friends and more, until you subscribe to Prima. You will direct to payment gateway, fill free to click on Subscribe '),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GoPrimaSubscriptionScreen()));
            },
            child: const Text('Subscribe '),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PrimaProfileScreen()));
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  bool _primacheck = false;
  void gerprimacheck() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      _primacheck = profile.data()?['isPrima'];
    }
    setState(() {});
  }

  tripomererequaried(BuildContext context) {
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
                    width: 100,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'As you like type of trips, adjust the trip-type bar to highlight it in your profile. This helps to know what kind of trips you like and how much’. Remove the ? ',
                        style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),
                      ),
                    )),
                  );
                },
              ),
            ));
  }
}

class TripometerWidget extends StatefulWidget {
  const TripometerWidget({super.key});

  @override
  State<TripometerWidget> createState() => _TripometerWidgetState();
}

class _TripometerWidgetState extends State<TripometerWidget> {
  List tripoMeterList = [
    {'name': 'Adventure', 'value': 30.0},
    {'name': 'City', 'value': 60.0},
    {'name': 'Nature', 'value': 80.0},
    {'name': 'Religlous', 'value': 30.0},
  ];

  double city = 0.0;
  double nature = 0.0;
  double adventure = 0.0;
  double religlous = 0.0;
  double _value = 50;

  // addTripometerDetails() async {
  //   // Call the user's CollectionReference to add a new user
  //
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //
  //   users
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("tripoMeter")
  //       .doc("profile")
  //       .set({"Adventure": adventure, "City": city, "Nature": nature, "Religlous": religlous});
  // }

  updateTripometerDetails() async {
    // Call the user's CollectionReference to add a new user

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("tripoMeter")
        .doc("profile")
        .update({"Adventure": adventure, "City": city, "Nature": nature, "Religlous": religlous});
  }

  void getTripometerDetails() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("tripoMeter").doc("profile").get();
      adventure = profile.data()?['Adventure'];
      city = profile.data()?['City'];
      nature = profile.data()?['Nature'];
      religlous = profile.data()?['Religlous'];
      setState(() {
        tripoMeterList = [
          {'name': 'Adventure', 'value': adventure},
          {'name': 'City', 'value': city},
          {'name': 'Nature', 'value': nature},
          {'name': 'Religlous', 'value': religlous},
        ];
      });
    }
  }

  @override
  void initState() {
    getTripometerDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              height: height(context) * 0.28,
              width: width(context) * 0.95,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tripoMeterList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 23, left: 23),
                      child: Column(
                        children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: Slider(
                              value: tripoMeterList[i]['value'],
                              onChanged: (value) {
                                tripoMeterList[i]['value'] = value;
                                print(tripoMeterList[i]['value']);
                                setState(() {
                                  adventure = tripoMeterList[0]['value'];
                                  city = tripoMeterList[1]['value'];
                                  nature = tripoMeterList[2]['value'];
                                  religlous = tripoMeterList[3]['value'];
                                });
                                if (city != 0.0) {
                                  //addTripometerDetails();
                                } else {
                                  updateTripometerDetails();
                                }

                                getTripometerDetails();
                              },
                              max: 100,
                              min: 0,
                              activeColor: primary,
                            ),
                          ),
                          Text(
                            tripoMeterList[i]['name'],
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: black),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ],
    );
  }
}

String _image1 = "";
String _image2 = "";
String _image3 = "";
String _image4 = "";
updatetravelphoto() async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("primaAccount")
      .doc("profile")
      .update({
        "TravelPhoto1": _image1,
        "TravelPhoto2": _image2,
        "TravelPhoto3": _image3,
        "TravelPhoto4": _image4,
      })
      .then((value) => print("Details Updated"))
      .catchError((error) => print("Failed to Update users Details: $error"));
}

class UploadTravelsPhotos extends StatefulWidget {
  const UploadTravelsPhotos({super.key});

  @override
  State<UploadTravelsPhotos> createState() => _UploadTravelsPhotosState();
}

class _UploadTravelsPhotosState extends State<UploadTravelsPhotos> {
  // File? _image1;
  // File? _image2;
  // File? _image3;
  // File? _image4;

  // Future pickImage() async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (image == null) {
  //     return;
  //   }
  //   final imagepath = File(image.path);
  //   setState(() {
  //     _image1 = imagepath;
  //     _image2 = imagepath;
  //     _image3 = imagepath;
  //     _image4 = imagepath;
  //   });
  // }
  // String _image1 = "";
  // String _image2 = "";
  // String _image3 = "";
  // String _image4 = "";
  void pickUploadImage1() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height, imageQuality: 75);
    Reference ref = FirebaseStorage.instance.ref().child('profileImg');

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        _image1 = value;
      });
    });
  }

  void pickUploadImage2() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height, imageQuality: 75);
    Reference ref = FirebaseStorage.instance.ref().child('profileImg');

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        _image2 = value;
      });
    });
  }

  void pickUploadImage3() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height, imageQuality: 75);
    Reference ref = FirebaseStorage.instance.ref().child('profileImg');

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        _image3 = value;
      });
    });
  }

  void pickUploadImage4() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height, imageQuality: 75);
    Reference ref = FirebaseStorage.instance.ref().child('profileImg');

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        _image4 = value;
      });
    });
  }

  void getDetails() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("primaAccount").doc("profile").get();
      _image1 = profile.data()?['TravelPhoto1'];
      _image2 = profile.data()?['TravelPhoto2'];
      _image3 = profile.data()?['TravelPhoto3'];
      _image4 = profile.data()?['TravelPhoto4'];

      setState(() {});
    }
  }

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addVerticalSpace(7),
        Text(
          'Upload Travel Photos',
          style: bodyText20w700(color: black),
        ),
        Text(
          'Show your travel pics to your trip friends on TravelNew',
          style: bodyText12Small(color: black),
        ),
        addVerticalSpace(15),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        pickUploadImage1();
                      },
                      child: Container(
                        height: height(context) * 0.15,
                        width: width(context) * 0.3,
                        decoration: _image1 == ""
                            ? BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        'https://creazilla-store.fra1.digitaloceanspaces.com/icons/3175753/ic-fluent-add-square-24-regular-icon-sm.png')))
                            : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(_image1))),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        pickUploadImage2();
                      },
                      child: Container(
                        height: height(context) * 0.15,
                        width: width(context) * 0.3,
                        decoration: _image2 == ""
                            ? BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        'https://creazilla-store.fra1.digitaloceanspaces.com/icons/3175753/ic-fluent-add-square-24-regular-icon-sm.png')))
                            : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(_image2))),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        pickUploadImage3();
                      },
                      child: Container(
                        height: height(context) * 0.15,
                        width: width(context) * 0.3,
                        decoration: _image3 == ""
                            ? BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        'https://creazilla-store.fra1.digitaloceanspaces.com/icons/3175753/ic-fluent-add-square-24-regular-icon-sm.png')))
                            : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(_image3))),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        pickUploadImage4();
                      },
                      child: Container(
                        height: height(context) * 0.15,
                        width: width(context) * 0.3,
                        decoration: _image4 == ""
                            ? BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        'https://creazilla-store.fra1.digitaloceanspaces.com/icons/3175753/ic-fluent-add-square-24-regular-icon-sm.png')))
                            : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(_image4))),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Center(
        //   child: Wrap(
        //     spacing: 10,
        //     runSpacing: 10,
        //     children: List.generate(4, (i) {
        //       return InkWell(
        //         onTap: () {
        //           pickUploadImage();
        //         },
        //         child: _image1 != null
        //             ? Image.file(
        //           _image1!,
        //           height: height(context) * 0.15,
        //           width: width(context) * 0.35,
        //           fit: BoxFit.cover,
        //         )
        //             : _image2 != null
        //             ? Image.file(
        //           _image2!,
        //           height: height(context) * 0.15,
        //           width: width(context) * 0.35,
        //           fit: BoxFit.cover,
        //         )
        //             : _image3 != null
        //             ? Image.file(
        //           _image3!,
        //           height: height(context) * 0.15,
        //           width: width(context) * 0.35,
        //           fit: BoxFit.cover,
        //         )
        //             : _image4 != null
        //             ? Image.file(
        //           _image4!,
        //           height: height(context) * 0.15,
        //           width: width(context) * 0.35,
        //           fit: BoxFit.cover,
        //         )
        //             : Container(
        //           height: height(context) * 0.15,
        //           width: width(context) * 0.35,
        //           decoration: myOutlineBoxDecoration(
        //               1, black.withOpacity(0.3), 10),
        //           child: Center(
        //               child: Icon(
        //                 Icons.add,
        //                 color: black.withOpacity(0.3),
        //               )),
        //         ),
        //       );
        //     }),
        //   ),
        // ),
        addVerticalSpace(15),
        Container(
          decoration: myOutlineBoxDecoration(1, black.withOpacity(0.4), 9),
          width: width(context) * 0.94,
          child: TextField(
            maxLines: 2,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
                hintStyle: bodyText13normal(color: black),
                hintText: 'Mention destination of above travel photos'),
          ),
        ),
      ],
    );
  }
}

class WhatExcitesYouWidget extends StatelessWidget {
  WhatExcitesYouWidget({super.key});

  final List whatExcitesYou = [
    {'title': 'Adventure', 'subTitle': 'Camping Waterfalls Hills and Trek'},
    {'title': 'Nature', 'subTitle': 'Hill area Safari Wildlife Sa'},
    {'title': 'City', 'subTitle': 'Shopping Nightlife Water sports'},
    {'title': 'Religlous', 'subTitle': 'A religion is a set of beliefs regarding the purpose of existence'}
  ];
  // final List ViewFunction = [
  //   {'function': YourAdventureInterest()},
  //   {'function': YourNatureInterest()},
  //   {'function': YourCityInterest()},
  //   {'function': YourReliglousInterst()}
  // ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height(context) * 0.15,
        child: CarouselSlider(
          options: CarouselOptions(height: 400.0),
          items: [0, 1, 2, 3].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 10),
                      height: height(context) * 0.13,
                      width: width(context) * 1.32,
                      decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            whatExcitesYou[i]['title'],
                            style: bodyText16w600(color: black),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SizedBox(
                                    width: width(context) * 0.3,
                                    child: Text(
                                      whatExcitesYou[i]['subTitle'],
                                    )),
                              ),
                              TextButton(
                                  onPressed: () {
                                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFunction[i]['function']));
                                  },
                                  child: Text(
                                    'View all',
                                    style: bodyText14w600(color: black),
                                  ))
                            ],
                          ),
                          // TextButton(
                          //     onPressed: () {},
                          //     child: Text(
                          //       'View all',
                          //       style: bodyText14w600(color: black),
                          //     ))
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ));
  }
}

class SelectOtherInterest {
  String name;
  bool isSelected;
  SelectOtherInterest({required this.name, required this.isSelected});
}

List<SelectOtherInterest> selectOtherInterestList = [
  SelectOtherInterest(name: 'My trip friends', isSelected: true),
  SelectOtherInterest(name: 'Everyone', isSelected: true),
  SelectOtherInterest(name: 'Myself', isSelected: true),
];

class StepperWidget extends StatefulWidget {
  const StepperWidget({super.key});

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _activeCurrentStep = 0;

  List<Step> steps = [
    Step(
      state: StepState.complete,
      title: const Text(''),
      content: const Text(''),
      label: Text(
        'Account',
        style: bodytext12Bold(color: black),
      ),
      isActive: true,
    ),
    Step(
      state: StepState.editing,
      title: const Text(''),
      content: const Text(''),
      label: Text(
        'Travel Photos',
        style: bodytext12Bold(color: black),
      ),
      isActive: true,
    ),
    Step(
      state: StepState.editing,
      title: const Text(''),
      content: const Text(''),
      label: Text(
        'About',
        style: bodytext12Bold(color: black),
      ),
      isActive: true,
    ),
    Step(
      state: StepState.editing,
      title: const Text(''),
      content: const Text(''),
      label: Text(
        'Tripometer',
        style: bodytext12Bold(color: black),
      ),
      isActive: true,
    ),
  ];
  List<Step> stepList() => [
        Step(
            state: _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeCurrentStep >= 0,
            label: const Text('Account'),
            title: const SizedBox(),
            content: SizedBox()),
        Step(
            state: StepState.complete,
            isActive: _activeCurrentStep >= 1,
            label: const Text('Travel Photos'),
            title: const SizedBox(),
            content: SizedBox()),
        Step(state: StepState.complete, isActive: _activeCurrentStep >= 2, label: const Text('About'), title: const SizedBox(), content: SizedBox()),
        Step(state: StepState.complete, isActive: _activeCurrentStep >= 3, label: const Text('Tripometer'), title: const SizedBox(), content: SizedBox())
      ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context) * 0.13,
      child: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primary,
              ),
        ),
        child: Stepper(
          elevation: 0,
          margin: EdgeInsets.zero,

          controlsBuilder: (BuildContext context, ControlsDetails, {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
            return SizedBox();
          },
          type: StepperType.horizontal,
          currentStep: _activeCurrentStep,
          steps: stepList(),

          onStepContinue: () {
            if (_activeCurrentStep < (stepList().length - 1)) {
              setState(() {
                _activeCurrentStep += 1;
              });
            }
          },

          onStepCancel: () {
            if (_activeCurrentStep == 0) {
              return;
            }

            setState(() {
              _activeCurrentStep -= 1;
            });
          },

          // onStepTap allows to directly click on the particular step we want
          onStepTapped: (int index) {
            setState(() {
              _activeCurrentStep = index;
            });
          },
        ),
      ),
    );
  }
}

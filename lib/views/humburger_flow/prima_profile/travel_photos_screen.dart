import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:travelnew_app/widget/custom_appbar.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/widget/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/constant.dart';

class TravelPhotosScreen extends StatefulWidget {
  TravelPhotosScreen({super.key});

  @override
  State<TravelPhotosScreen> createState() => _TravelPhotosScreenState();
}

class _TravelPhotosScreenState extends State<TravelPhotosScreen> {
  String Name = "";
  void getDetails() async {
    if (IS_USER_LOGIN) {
      var profile =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('primaAccount').doc('profile').get();
      Name = profile.data()?['fullName'];
    }
    setState(() {});
  }

  @override
  void initState() {
    getDetails();
    //getDatatravephoto();
    super.initState();
  }

  // final List travelPhoto = [
  //   'assets/images/Rectangle 111.png',
  //   'assets/images/Rectangle 111 (1).png',
  //   'assets/images/Rectangle 111 (2).png',
  //   'assets/images/Rectangle 111 (3).png',
  // ];

  // Future<void> getDatatravephoto() async {
  //   // Get docs from collection reference
  //  // QuerySnapshot querySnapshot = await _collectionRef.get();
  //   // Get data from docs and convert map to List
  //
  //   setState(() {});
  //   print(allEditTravelPhotoData);
  // }

  List allEditTravelPhotoData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50), child: CustomAppBar(title: '$Name Travel photos')),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("primaAccount")
                  .doc('profile')
                  .collection('travel_photo')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  allEditTravelPhotoData = snapshot.data!.docs.map((doc) => doc.data()).toList();
                  return SizedBox(
                      height: height(context),
                      child: ListView.builder(
                          itemCount: allEditTravelPhotoData.length,
                          itemBuilder: (ctx, i) {
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(10),
                                  height: height(context) * 0.40,
                                  width: width(context) * 0.95,
                                  decoration: myFillBoxDecoration(0, black.withOpacity(0.08), 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Trip to destination',
                                            style: bodyText16w600(color: black),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (ctx) => EditTravelPhotos()));
                                            },
                                            child: const Icon(
                                              Icons.edit,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        allEditTravelPhotoData[i]['Date'],
                                        style: bodyText12Small(color: black),
                                      ),
                                      addVerticalSpace(8),
                                      SizedBox(
                                        height: height(context) * 0.300,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: allEditTravelPhotoData.length,
                                            itemBuilder: (ctx, i) {
                                              return Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: height(context) * 0.290,
                                                      width: width(context) * 1,
                                                      child: Image.network(
                                                        allEditTravelPhotoData[i]['travelphotoUrl'],
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                      SizedBox(
                                        width: width(context) * 0.5,
                                        child: Text(allEditTravelPhotoData[i]['Describe']),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }));
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("No Photo"),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: primary,
                    ),
                  );
                }
              },
            ),
          ),
          Positioned(
            left: 30,
            bottom: 30,
            child: SizedBox(
                width: width(context) * 0.8,
                child: CustomButton(
                    name: 'Add more photos',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => UploadTravelsPhotosScreen()));
                    })),
          ),
          addVerticalSpace(10)
        ],
      ),
    );
  }
}

class UploadTravelsPhotosScreen extends StatefulWidget {
  const UploadTravelsPhotosScreen({super.key});

  @override
  State<UploadTravelsPhotosScreen> createState() => _UploadTravelsPhotosScreenState();
}

class _UploadTravelsPhotosScreenState extends State<UploadTravelsPhotosScreen> {
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController DateController = TextEditingController();
  final TextEditingController DescribeController = TextEditingController();

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

  String _image = "";
  void getDetails() async {
    if (IS_USER_LOGIN) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('primaAccount')
          .doc('profile')
          .collection('travel_photo')
          .doc()
          .get();
      _image = profile.data()?['travelphotoUrl'];
    }
    setState(() {});
  }

  addupcomingtrip() async {
    if (IS_USER_LOGIN) {
      DocumentReference profile = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("primaAccount")
          .doc('profile')
          .collection('travel_photo')
          .doc();
      profile.set({"Destination": destinationController.text, "Date": DateController.text, "Describe": DescribeController.text, "travelphotoUrl": _image});
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50), child: CustomAppBar(title: 'Upload Travel Photos')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Show fellow travelers your travel photos',
                style: bodyText20w700(color: black),
              ),
              addVerticalSpace(15),
              CustomTextFieldWidget(
                labelText: 'Trip Destination',
                controller: destinationController,
              ),
              addVerticalSpace(10),
              CustomTextFieldWidget(
                labelText: 'Date of visit',
                controller: DateController,
              ),
              addVerticalSpace(20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      height: height(context) * 0.15,
                      width: width(context) * 0.3,
                      decoration: _image == ""
                          ? BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/icons8-add-new-50.png')))
                          : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(_image))),
                    ),
                  ),
                  addHorizontalySpace(10),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 35,
                            width: width(context) * 0.4,
                            child: CustomButton(
                                name: 'Upload Photo',
                                onPressed: () {
                                  pickUploadImage();
                                })),
                        // Text('Upload upto 10 Photos')
                      ],
                    ),
                  )
                ],
              ),
              addVerticalSpace(20),
              Container(
                  decoration: myOutlineBoxDecoration(1, black.withOpacity(0.3), 15),
                  width: width(context) * 0.94,
                  // height: height(context) * 0.15,
                  child: TextField(
                    controller: DescribeController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      hintStyle: bodyText13normal(color: black),
                      hintText: 'Describe your trip and experience  ',
                    ),
                  )),
              addVerticalSpace(10),
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: 'TravelNew follows zero tolerance policy for fake travel photos. Know ', style: bodytext12Bold(color: black)),
                TextSpan(text: 'Privacy Policy', style: bodytext12Bold(color: primary))
              ])),
              addVerticalSpace(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 35,
                    width: width(context) * 0.42,
                    child: CustomButton(
                        name: 'Submit',
                        onPressed: () {
                          addupcomingtrip();
                          Navigator.pop(context);
                        }),
                  ),
                  addHorizontalySpace(20),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 35,
                      width: width(context) * 0.42,
                      decoration: shadowDecoration(10, 4),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: bodyText16w600(color: black),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EditTravelPhotos extends StatelessWidget {
  const EditTravelPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50), child: CustomAppBar(title: 'Edit travel Photos')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                'Show fellow travelers your travel photos',
                style: bodyText20w700(color: black),
              ),
              addVerticalSpace(25),
              CustomTextFieldWidget(labelText: 'Trip Destination'),
              addVerticalSpace(10),
              CustomTextFieldWidget(labelText: 'Date of visit'),
              addVerticalSpace(20),
              Row(
                children: [
                  Spacer(),
                  Container(
                    height: 30,
                    width: width(context) * 0.3,
                    decoration: myFillBoxDecoration(0, primary, 5),
                    child: Center(
                      child: Text('Delete all'),
                    ),
                  )
                ],
              ),
              addVerticalSpace(15),
              SizedBox(
                height: height(context) * 0.28,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 8, crossAxisSpacing: 8, crossAxisCount: 3),
                    itemCount: 6,
                    itemBuilder: (ctx, i) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: width(context) * 0.3,
                              height: height(context) * 0.15,
                              child: Image.asset(
                                'assets/images/temple.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                              right: 4,
                              top: 4,
                              child: Container(
                                height: 25,
                                width: width(context) * 0.07,
                                decoration: myFillBoxDecoration(0, white, 3),
                                child: Center(
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: primary,
                                  ),
                                ),
                              ))
                        ],
                      );
                    }),
              ),
              addVerticalSpace(20),
              Row(
                children: [
                  const Text(
                    'Upload upto 10 Photos',
                  ),
                  Spacer(),
                  Container(
                    height: 30,
                    width: width(context) * 0.3,
                    decoration: myFillBoxDecoration(0, primary, 5),
                    child: Center(
                      child: Text('Add photos'),
                    ),
                  ),
                ],
              ),
              addVerticalSpace(20),
              Container(
                  decoration: myOutlineBoxDecoration(1, black.withOpacity(0.3), 15),
                  width: width(context) * 0.94,
                  // height: height(context) * 0.15,
                  child: TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: bodyText13normal(color: black),
                        hintText: 'Describe your trip and experience  '),
                  )),
              addVerticalSpace(10),
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: 'TravelNew follows zero tolerance policy for fake travel photos. Know ', style: bodytext12Bold(color: black)),
                TextSpan(text: 'Privacy Policy', style: bodytext12Bold(color: primary))
              ])),
              addVerticalSpace(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 35,
                    width: width(context) * 0.42,
                    child: CustomButton(
                        name: 'Submit',
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  addHorizontalySpace(20),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 35,
                      width: width(context) * 0.42,
                      decoration: shadowDecoration(10, 4),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: bodyText16w600(color: black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              addVerticalSpace(15)
            ],
          ),
        ),
      ),
    );
  }
}

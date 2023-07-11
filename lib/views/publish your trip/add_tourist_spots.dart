import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/widget/custom_textfield.dart';
import 'dart:io';

class AddTouristPointScreen extends StatefulWidget {
  const AddTouristPointScreen({super.key});

  @override
  State<AddTouristPointScreen> createState() => _AddTouristPointScreenState();
}

class _AddTouristPointScreenState extends State<AddTouristPointScreen> {
  String _image = "";
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

  addTourstSport() async {
    // Call the user's CollectionReference to add a new user
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Prima_Trip_Plan")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("tourisprot")
        .add({
          "TouristSportImage": _image,
          "TouristSportName": TouristSportNameController.text,
          "touristDes": DescribeController.text,
          "address": AddressController.text,
          "ischeck": true
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

    setState(() {});
  }

  final TextEditingController TouristSportNameController = TextEditingController();
  final TextEditingController AddressController = TextEditingController();
  final TextEditingController DescribeController = TextEditingController();

  showSnackBar(BuildContext context, String str, [Color clr = Colors.black]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: clr,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            )),
        title: Text(
          'Add Tourist Spot',
          style: bodyText20w700(color: black),
        ),
        actions: [
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.edit,
          //       color: black,
          //     ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Tourist Spot',
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(15),
            CustomTextFieldWidget(controller: TouristSportNameController, labelText: 'Tourist Spot Name'),
            addVerticalSpace(15),
            Container(
                decoration: myOutlineBoxDecoration(2, black.withOpacity(0.1), 15),
                width: width(context) * 0.94,
                // height: height(context) * 0.08,
                child: TextField(
                    controller: AddressController,
                    maxLines: 3,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: bodyText13normal(color: black),
                        hintText: 'Address / Location'))),
            addVerticalSpace(15),
            Container(
                decoration: myOutlineBoxDecoration(2, black.withOpacity(0.1), 15),
                width: width(context) * 0.94,
                // height: height(context) * 0.08,
                child: TextField(
                    controller: DescribeController,
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: bodyText13normal(color: black),
                        hintText: 'Describe the Tourist spot and experience'))),
            addVerticalSpace(15),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    pickUploadImage();
                  },
                  child: Container(
                    height: height(context) * 0.05,
                    width: width(context) * 0.55,
                    decoration: myFillBoxDecoration(0, black.withOpacity(0.05), 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.image,
                          color: black.withOpacity(0.2),
                        ),
                        InkWell(
                            onTap: () {
                              pickUploadImage();
                            },
                            child: Text('Upload an Image')),
                      ],
                    ),
                  ),
                ),
                addHorizontalySpace(34),
                Container(
                  height: 90,
                  width: width(context) * 0.25,
                  decoration: _image == ""
                      ? BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.black26)
                      : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(_image))),
                )
              ],
            ),
            addVerticalSpace(height(context) * 0.1),
            Center(
              child: SizedBox(
                width: width(context) * 0.55,
                child: CustomButton(
                    name: 'Add',
                    onPressed: () {
                      setState(() {});
                      showSnackBar(context, "Your ToursitSport is Added.", primary);
                      addTourstSport();
                      Navigator.pop(context);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

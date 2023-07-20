import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travelnew_app/model/save_trip_model.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/widget/custom_textfield.dart';
import 'package:travelnew_app/providers/image_provider.dart';
import 'package:provider/provider.dart';
import '../../../utils/constant.dart';
import '../../../widget/custom_dropdown_button.dart';

import 'package:path/path.dart' as j;

import '../humburger_flow/my_account/my_account.dart';

class noPrimaUserProfile extends StatefulWidget {
  final String userUid;
  const noPrimaUserProfile({super.key, required this.userUid});
  @override
  State<noPrimaUserProfile> createState() => _noPrimaUserProfileState();
}

class _noPrimaUserProfileState extends State<noPrimaUserProfile> {
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController anniversaryDate = TextEditingController();
  final TextEditingController firstName = new TextEditingController();
  final TextEditingController lastName = new TextEditingController();
  final TextEditingController profession = new TextEditingController();
  final TextEditingController mobNum = new TextEditingController();
  final TextEditingController emergencyNum = new TextEditingController();
  final TextEditingController genderController = new TextEditingController();
  final TextEditingController statusController = new TextEditingController();
  //final TextEditingController emailId = new TextEditingController();
  bool _prima = false;
  detailUser() async {
    final _fireStore = FirebaseFirestore.instance;
    await _fireStore.collection("users").doc(widget.userUid).update({
      'fullName': firstName.text + " " + lastName.text,
      'firstName': firstName.text,
      'LastName': lastName.text,
      'anniversary': anniversaryDate.text,
      'profession': profession.text,
      'dob': dateOfBirth.text,
      'isPrima': _prima,
      //'emailId': emailId.text,
      'emergencyNum': emergencyNum.text,
      'mobNum': mobNum.text,
      'gender': Gendervalue,
      'maritalStatus': statusvalue,
      'UID': widget.userUid,
      "image": img ?? "",
      "document": url ?? "",
    });
  }

  File? file;
  File? imageFile;
  UploadTask? task;
  String url = "";
  String img = "";
  String fullname = "";

  void getData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance.collection('users').doc(widget.userUid).get();
      img = profile.data()?['image'];
      url = profile.data()?['document'] ?? "";
      firstName.text = profile.data()?['firstName'];
      // firstName.text = profile.data()?['fullName'];
      dateOfBirth.text = profile.data()?['dob'] ?? "";
      anniversaryDate.text = profile.data()?['anniversary'] ?? "";
      profession.text = profile.data()?['profession'] ?? "";
      emergencyNum.text = profile.data()?['emergencyNum'] ?? "";
      lastName.text = profile.data()?['LastName'] ?? "";
      mobNum.text = profile.data()?['mobNum'] ?? "";
      Gendervalue = profile.data()?['gender'] ?? "";
      statusvalue = profile.data()?['maritalStatus'] ?? "";

      setState(() {});
    }
  }

  showSnackBar(BuildContext context, String str, [Color clr = Colors.black]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: clr,
    ));
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  final ImagePicker picker = ImagePicker();
  late ImageSource? imageSource;

  String Gendervalue = "Single";
  String statusvalue = "male";

  bool loading = true;
  late PhotoProvider imageProvider;
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? j.basename(file!.path) : 'No file Selected';
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height(context) * 1.2,
          child: Stack(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    height: height(context) * 0.42,
                    width: width(context) * 1,
                    decoration: img == ""
                        ? BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(NoUserNetworkImage)))
                        : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(img))),
                    child: SafeArea(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              'User Info',
                              style: bodyText20w700(color: white),
                            ),
                          ),
                          widget.userUid == FirebaseAuth.instance.currentUser!.uid
                              ? Padding(
                                  padding: EdgeInsets.only(right: 12.0, top: 10),
                                  child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(context: context, builder: ((builder) => bottomSheet()));
                                    },
                                    icon: ImageIcon(
                                      color: white,
                                      const AssetImage(
                                        'assets/images/editicon.png',
                                      ),
                                    ),
                                  ))
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: height(context) * 0.38,
                    child: Container(
                        height: height(context),
                        padding: EdgeInsets.all(10),
                        width: width(context) * 1,
                        decoration: shadowDecoration(20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addVerticalSpace(8),
                            const Text(
                              'General details',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            addVerticalSpace(13),
                            Row(
                              children: [
                                SizedBox(
                                  width: width(context) * 0.45,
                                  child: CustomTextFieldWidget(
                                    Enable: false,
                                    labelText: 'First Name',
                                    controller: firstName,
                                  ),
                                ),
                                addHorizontalySpace(10),
                                SizedBox(
                                    width: width(context) * 0.45,
                                    child: CustomTextFieldWidget(
                                      Enable: false,
                                      labelText: 'Last Name',
                                      controller: lastName,
                                    ))
                              ],
                            ),
                            addVerticalSpace(15),
                            Row(
                              children: [
                                SizedBox(
                                    width: width(context) * 0.45,
                                    child: CustomTextFieldWidget(
                                      Enable: false,
                                      controller: dateOfBirth,
                                      labelText: 'Date of Birth',
                                      icon: Icon(
                                        Icons.calendar_month_outlined,
                                        color: primary,
                                      ),
                                      onClick: () async {
                                        selectDOBdate(context);
                                      },
                                    )),
                                addHorizontalySpace(10),
                                SizedBox(
                                    width: width(context) * 0.45,
                                    child: CustomTextFieldWidget(
                                      Enable: false,
                                      controller: anniversaryDate,
                                      labelText: 'Anniversary dates',
                                      icon: Icon(
                                        Icons.calendar_month_outlined,
                                        color: primary,
                                      ),
                                      onClick: () async {
                                        selectAniversyDate(context);
                                      },
                                    )),
                              ],
                            ),
                            addVerticalSpace(15),
                            SizedBox(
                              child: CustomTextFieldWidget(
                                labelText: 'Profession',
                                controller: profession,
                                Enable: false,
                              ),
                            ),
                            addVerticalSpace(22),
                            // Row(
                            //   children: [
                            //     SizedBox(
                            //       height: 37,
                            //       width: width(context) * 0.45,
                            //       child: CustomDropDownButton(
                            //         itemList: const [
                            //           'Single',
                            //           'Married',
                            //           'Divorced',
                            //           'Separated',
                            //           'Widowed',
                            //         ],
                            //         value: statusvalue,
                            //         lableText: 'Marital Status',
                            //         controller: statusController,
                            //       ),
                            //     ),
                            //     addHorizontalySpace(10),
                            //     SizedBox(
                            //       height: 37,
                            //       width: width(context) * 0.45,
                            //       child: CustomDropDownButton(
                            //         itemList: const [
                            //           'Male',
                            //           'Female',
                            //           'Prefer not to say',
                            //         ],
                            //         value: Gendervalue,
                            //         lableText: 'Gender',
                            //         controller: genderController,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            addVerticalSpace(10),
                            InkWell(
                                onTap: () {
                                  showSnackBar(context, "This helps in listing your profile while searching by other travelers", Colors.green);
                                },
                                child: Text(
                                  'Why is this required?',
                                  style: TextStyle(fontWeight: FontWeight.w600, color: primary, decoration: TextDecoration.underline),
                                )),
                            Divider(
                              height: 30,
                              color: black.withOpacity(0.05),
                              thickness: 5,
                            ),
                            addVerticalSpace(7),
                            const Text(
                              'Contact details',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            addVerticalSpace(10),
                            Row(
                              children: [
                                SizedBox(
                                    // height: 37,
                                    child: Text('Email ID:')),
                                SizedBox(
                                    // height: 37,
                                    child: Text(FirebaseAuth.instance.currentUser!.email.toString())),
                              ],
                            ),
                            addVerticalSpace(15),
                            Row(
                              children: [
                                SizedBox(
                                    width: width(context) * 0.45,
                                    child: CustomTextFieldWidget(
                                      Enable: false,
                                      labelText: 'Mobile number',
                                      controller: mobNum,
                                    )),
                                addHorizontalySpace(10),
                                SizedBox(
                                  // height: 37,
                                  width: width(context) * 0.45,
                                  child: CustomTextFieldWidget(
                                    Enable: false,
                                    labelText: 'Emergency number',
                                    controller: emergencyNum,
                                  ),
                                )
                              ],
                            ),
                            TextButton(
                                onPressed: () async {
                                  await showSnackBar(context, "For quotes and booking and for Emergency use ", Colors.green);
                                },
                                child: Text(
                                  'Why is this required?',
                                  style: TextStyle(fontWeight: FontWeight.w600, color: primary, decoration: TextDecoration.underline),
                                )),
                            Divider(
                              thickness: 5,
                              color: black.withOpacity(0.05),
                            ),
                            addVerticalSpace(7),
                            // const Text(
                            //   'Government IDs',
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //   ),
                            // ),
                            // addVerticalSpace(5),
                            // InkWell(
                            //   onTap: () async {
                            //     showAPICallPendingDialog(context);
                            //     await selectUploadDocument(context);
                            //     Navigator.pop(context);
                            //   },
                            //   child: Container(
                            //     margin: const EdgeInsets.only(top: 8, left: 8),
                            //     height: 40,
                            //     width: width(context) * 0.9,
                            //     decoration: shadowDecoration(10, 3),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Text(
                            //           '+ Upload your ID',
                            //           style: bodyText16w600(color: black.withOpacity(0.5)),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Divider(
                              thickness: 5,
                              color: black.withOpacity(0.05),
                            ),
                            addVerticalSpace(20),
                            // addHorizontalySpace(20),
                            // CustomButton(
                            //     name: 'Save',
                            //     onPressed: () {
                            //       detailUser();
                            //       Navigator.push(context, MaterialPageRoute(builder: (ctx) => MyAccountScreen()));
                            //       showSnackBar(context, "Added", Colors.green);
                            //     }),
                            // addHorizontalySpace(20),
                          ],
                        )))
              ]),
        ),
      ),
    );
  }

  Future<void> selectDOBdate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.grey,
              splashColor: Colors.black,
              textTheme: TextTheme(
                subtitle1: TextStyle(color: Colors.black),
                button: TextStyle(color: Colors.black),
              ),
              accentColor: Colors.black,
              colorScheme: const ColorScheme.light(
                  primary: Color(0xffffbc00),
                  primaryVariant: Colors.black,
                  secondaryVariant: Colors.black,
                  onSecondary: Colors.black,
                  onPrimary: Colors.white,
                  surface: Colors.black,
                  onSurface: Colors.black,
                  secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? Text(""),
          );
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(1960, 8),
        lastDate: DateTime.now());
    if (picked != null) {
      print(picked);
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);

      setState(() {
        dateOfBirth.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> selectAniversyDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.grey,
              splashColor: Colors.black,
              textTheme: TextTheme(
                subtitle1: TextStyle(color: Colors.black),
                button: TextStyle(color: Colors.black),
              ),
              accentColor: Colors.black,
              colorScheme: ColorScheme.light(
                  primary: Color(0xffffbc00),
                  primaryVariant: Colors.black,
                  secondaryVariant: Colors.black,
                  onSecondary: Colors.black,
                  onPrimary: Colors.white,
                  surface: Colors.black,
                  onSurface: Colors.black,
                  secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? Text(""),
          );
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(1960, 8),
        lastDate: DateTime.now());
    if (picked != null) {
      print(picked);
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);

      setState(() {
        anniversaryDate.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<void> selectUploadDocument(BuildContext context) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
              padding: EdgeInsets.all(12),
              height: height(context) * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upload your Documents',
                        style: bodyText18w600(color: black),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                  Text(
                    'Document type',
                    style: bodyText14w600(color: black),
                  ),
                  SizedBox(
                      height: height(context) * 0.06,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectDocumentList.length,
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
                                      value: selectDocumentList[i].isSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          for (var element in selectDocumentList) {
                                            element.isSelected = false;
                                          }
                                          selectDocumentList[i].isSelected = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(selectDocumentList[i].name)
                                ],
                              ),
                            );
                          })),
                  InkWell(
                    onTap: () {
                      PickUploadDocument();
                      //feature to be added to upload pdf
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, left: 0),
                      height: 30,
                      width: width(context) * 0.95,
                      decoration: shadowDecoration(6, 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '+ Upload ',
                            style: bodyText14w600(color: black.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  addVerticalSpace(15),
                  Text(
                    'The document you upload here is not visible to anyone and it is saved on your device. It is available offline. It helps you with quick check-ins and meeting new trip friends.​ It also shows others you are really you making you a verified traveler.',
                    textAlign: TextAlign.center,
                    style: bodyText12Small(color: black),
                  ),
                  addVerticalSpace(20),
                  Center(
                    child: SizedBox(
                      width: width(context) * 0.4,
                      child: CustomButton(
                          name: 'Submit',
                          onPressed: () {
                            uploadFile();
                            Navigator.pop(context);
                          }),
                    ),
                  )
                ],
              ));
        });
      },
    );
  }

  Future uploadFile() async {
    if (file == null) return;
    final fileName = j.basename(file!.path);
    final destination = 'files/$fileName';
    task = FireBaseApi.uploadFile(destination, file!);

    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;
    setState() {
      file = File(path);
    }
  }

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height, imageQuality: 75);
    Reference ref = FirebaseStorage.instance.ref().child('profileImg');
    if (image == null) return;
    File? _img = File(image.path);
    _img = await _cropImage(imageFile: _img);
    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        img = value;
      });
    });
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }
  // void _cropImage(filePath) async {
  //    File croppedImage = (await ImageCropper.cropImage(
  //      sourcePath: filePath,
  //      maxWidth: 1080,
  //      maxHeight: 1080,
  //    )) as File;
  //    if (croppedImage != null) {
  //      imageFile = croppedImage;
  //      setState(() {});
  //    }
  //  }

  void cameraPickUploadImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.camera, maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height, imageQuality: 75);
    Reference ref = FirebaseStorage.instance.ref().child('profileImg');

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        img = value;
      });
    });
  }

  bool isSelected = false;
  void PickUploadDocument() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height, imageQuality: 75);
    Reference ref = FirebaseStorage.instance.ref().child('document');

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        url = value;
        isSelected = true;
      });
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            'Choose Profile photo',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Icon(Icons.camera),
              SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () {
                    cameraPickUploadImage();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Camera',
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(
                width: 100,
              ),
              Icon(Icons.image),
              SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () {
                    pickUploadImage();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Gallery',
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class FireBaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}

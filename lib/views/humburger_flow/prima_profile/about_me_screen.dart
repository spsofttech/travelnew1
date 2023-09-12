import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utils/constant.dart';

class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({super.key});

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {


  final TextEditingController aboutcontroller = TextEditingController();
  final TextEditingController otherintrestcontroller = TextEditingController();
  String _name = "";
  void getDetails() async {
    if (IS_USER_LOGIN) {
      var profile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('primaAccount')
          .doc('profile')
          .get();
      aboutcontroller.text = profile.data()?['aboutme'];
      _name = profile.data()?['fullName'];
      otherintrestcontroller.text = profile.data()?['userInterest'];

    }
    setState(() {

    });
  }
  @override
  void initState() {
    getDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: height(context) * 0.42,
                width: width(context) * 1,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/prima3.png'))),
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
                          'About me',
                          style: bodyText20w700(color: white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 12.0, top: 10),
                        child: ImageIcon(
                            color: white,
                            const AssetImage(
                              'assets/images/editicon.png',
                            )),
                      )
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
                      Text(
                        '$_name',
                        style: bodyText30W600(color: black),
                      ),
                      Container(
                        height: 23,
                        width: width(context) * 0.35,
                        decoration: shadowDecoration(5, 3),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Verified Member',
                                style: bodytext12Bold(color: black),
                              ),
                              Icon(
                                Icons.help,
                                color: black.withOpacity(0.4),
                                size: 20,
                              ),
                            ]),
                      ),
                      const Divider(
                        height: 35,
                        thickness: 1,
                      ),
                      const Text(
                        'About me',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      addVerticalSpace(10),
                      Container(
                        decoration:
                            myFillBoxDecoration(0, black.withOpacity(0.1), 15),
                        width: width(context) * 0.94,
                        // height: height(context) * 0.15,
                        child: TextField(
                          controller: aboutcontroller,
                            onTap: () {},
                            maxLines: 3,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                                hintStyle: bodyText16normal(
                                    color: black.withOpacity(0.5)),
                                hintText:
                                    'Whats amazing about me? \nWhy I’m on travel new?')),
                      ),
                      addVerticalSpace(15),
                      const Text(
                        'Other interest',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      addVerticalSpace(10),
                      Container(
                        decoration:
                            myFillBoxDecoration(0, black.withOpacity(0.1), 15),
                        width: width(context) * 0.94,
                        // height: height(context) * 0.15,
                        child: TextField(
                          controller: otherintrestcontroller,
                            onTap: () {},
                            maxLines: 3,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                                hintStyle: bodyText16normal(
                                    color: black.withOpacity(0.5)),
                                hintText:
                                    'Example: Loves to cook, workout, books etc')),
                      ),
                      addVerticalSpace(10),
                      Row(
                        children: const [
                          Spacer(),
                          Text('Other Interest Privacy : Everyone',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ))
                        ],
                      )
                    ],
                  ),
                ))
          ]),
    );
  }
}

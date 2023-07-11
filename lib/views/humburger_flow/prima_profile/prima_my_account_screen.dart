import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelnew_app/views/humburger_flow/prima_profile/about_me_screen.dart';
import 'package:travelnew_app/views/humburger_flow/prima_profile/personal_info_screen.dart';
import 'package:travelnew_app/views/humburger_flow/prima_profile/tripometer_manage_screen.dart';

import '../../../utils/constant.dart';

class PrimaMyAccount extends StatefulWidget {
  const PrimaMyAccount({super.key});

  @override
  State<PrimaMyAccount> createState() => _PrimaMyAccountState();
}

class _PrimaMyAccountState extends State<PrimaMyAccount> {
  String _name = "";
  void getDetails() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile =
          await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('primaAccount').doc('profile').get();
      _name = profile.data()?['fullName'];
    }
    setState(() {});
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
              decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/prima3.png'))),
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
                        'My Account',
                        style: bodyText20w700(color: white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, top: 10),
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
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        Icon(
                          Icons.star_rate_rounded,
                          color: primary,
                          size: 20,
                        ),
                      ]),
                    ),
                    const Divider(
                      height: 35,
                      thickness: 1,
                    ),
                    ListTile(
                      title: Text(
                        'Personal Information',
                        style: bodyText20w700(color: black),
                      ),
                      subtitle: Text('Contact, Account informations'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (ctx) => PersonalInformationScreen()));
                      },
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    ListTile(
                      title: Text(
                        'About me',
                        style: bodyText20w700(color: black),
                      ),
                      subtitle: Text('Bio, Other interest'),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (ctx) => AboutMeScreen()));
                      },
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    // const Divider(
                    //   height: 0,
                    //   thickness: 1,
                    // ),
                    // ListTile(
                    //   title: Text(
                    //     'Tripometer',
                    //     style: bodyText20w700(color: black),
                    //   ),
                    //   subtitle: Text('Manage Tripometer'),
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (ctx) => TripoMeterManage()));
                    //   },
                    //   trailing: Icon(Icons.arrow_forward_ios),
                    // ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                    )
                  ],
                ),
              ))
        ]));
  }
}

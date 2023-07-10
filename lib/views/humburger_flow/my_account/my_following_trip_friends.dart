import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app/views/humburger_flow/my_account/my_following_trip_friends.dart';
import 'package:travel_app/views/humburger_flow/my_account/report_incorrect_user_screen.dart';
import 'package:travel_app/widget/custom_appbar.dart';

import '../../../utils/constant.dart';
import '../../../widget/custom_button.dart';

class MyfollowingFriendScreen extends StatefulWidget {
  const MyfollowingFriendScreen({super.key});

  @override
  State<MyfollowingFriendScreen> createState() =>
      _MyfollowingFriendScreenState();
}

class _MyfollowingFriendScreenState extends State<MyfollowingFriendScreen> {
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
          'You have following request to be your friend',
          style: bodyText20w700(color: black),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: Text(''),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {

              return  ListTile(

                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      (snapshot.data! as dynamic).docs[index]['profileImg'],
                    ),
                    radius: 16,
                  ),
                  title: Text(
                    (snapshot.data! as dynamic).docs[index]['fullName'],

                  ),

              );
            },

          );
        },
      )
    );
  }
  }

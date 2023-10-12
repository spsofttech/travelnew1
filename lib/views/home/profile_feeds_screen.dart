import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelnew_app/views/home/home_screen.dart';
import 'package:travelnew_app/Api/pref_halper.dart';
import '../../model/home_model.dart';
import '../../utils/constant.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_overlaping_widget.dart';
import '../start/signup_with_social_media_screen.dart';
import 'festival_and_celebrations_screen.dart';

class ProfileFeedScreen extends StatefulWidget {
  ProfileFeedScreen({super.key});

  @override
  State<ProfileFeedScreen> createState() => _ProfileFeedScreenState();
}

class _ProfileFeedScreenState extends State<ProfileFeedScreen> {
  final _future = FirebaseFirestore.instance.collection('profileFeeds');

  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('festivals');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {});
    print(allData);
  }

  List allData = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(
            title: 'Feed',
          )),
      body: Column(
        children: [
          SizedBox(
            height: height(context) * 0.85,
            child: FutureBuilder<DocumentSnapshot>(
                future: _future.doc('iRTvLxbmxyefimnRdaMc').get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    //--------Default-Offline-Data----------//
                    return ListView.builder(
                        itemCount: 6,
                        // physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (ctx, i) {
                          return InkWell(
                            onTap: () {
                              if (IS_USER_LOGIN) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowDetailsOfFestivals(
                                              MP: allData[i],
                                            )));
                              } else
                              //  if (_count == 10)
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupWithSocialMediaScreen(),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              height: height(context) * 0.23,
                              width: width(context),
                              child: Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allData[i]['Date'].toDate(),
                                        style: bodyText14normal(color: black),
                                      ),
                                      Text(
                                        allData[i]['time'].toDate(),
                                        style: bodyText12Small(color: black),
                                      ),
                                      addVerticalSpace(16),
                                      Row(
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: SizedBox(
                                                width: width(context) * 0.5,
                                                height: height(context) * 0.13,
                                                child: Image.network(
                                                  allData[i]['imageUrl'],
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                          addHorizontalySpace(20),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: width(context) * 0.28,
                                                child: Text(
                                                  allData[i]['tripsport'],
                                                  style: bodyText14w600(color: black),
                                                ),
                                              ),
                                              addVerticalSpace(20),
                                              OverlapingImageCustomWidget(overlap: overlap)
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    //----------Show-Data-From-Snapshot--------//
                    return ListView.builder(
                        itemCount: allData.length,
                        // physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (ctx, i) {
                          return InkWell(
                            onTap: () {
                              if (IS_USER_LOGIN) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowDetailsOfFestivals(
                                              MP: allData[i],
                                            )));
                              } else
                              //  if (_count == 10)
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupWithSocialMediaScreen(),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              height: height(context) * 0.23,
                              width: width(context),
                              child: Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allData[i]['Date'],
                                        style: bodyText14normal(color: black),
                                      ),
                                      Text(
                                        allData[i]['time'],
                                        style: bodyText12Small(color: black),
                                      ),
                                      addVerticalSpace(16),
                                      Row(
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: SizedBox(
                                                width: width(context) * 0.5,
                                                height: height(context) * 0.13,
                                                child: Image.network(
                                                  allData[i]['imageUrl'],
                                                  fit: BoxFit.fill,
                                                ),
                                              )),
                                          addHorizontalySpace(20),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: width(context) * 0.28,
                                                child: Text(
                                                  allData[i]['tripsport'],
                                                  style: bodyText14w600(color: black),
                                                ),
                                              ),
                                              addVerticalSpace(20),
                                              OverlapingImageCustomWidget(overlap: overlap)
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}

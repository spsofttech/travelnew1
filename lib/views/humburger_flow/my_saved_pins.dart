import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../model/home_model.dart';
import '../../utils/constant.dart';
import '../../widget/custom_appbar.dart';

class MySavedPinsScreens extends StatefulWidget {
  const MySavedPinsScreens({super.key});

  @override
  State<MySavedPinsScreens> createState() => _MySavedPinsScreensState();
}

class _MySavedPinsScreensState extends State<MySavedPinsScreens> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50), child: CustomAppBar(title: 'My Saved Pins')),
      body: Column(
        children: [
          SizedBox(
            height: height(context) * 0.06,
            child: TabBar(
              padding: EdgeInsets.zero,
              // labelPadding: EdgeInsets.zero,
              // indicatorPadding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Colors.grey,
              controller: _tabController,
              onTap: (value) {},
              isScrollable: true,
              indicator: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: primary),
              indicatorColor: primary,
              labelColor: black,
              labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              tabs: const [
                Tab(
                  text: 'Aspired \n  trips',
                ),
                Tab(
                  text: 'Events and festival \n             trips',
                ),
                Tab(
                  text: 'Tourist spots',
                ),
              ],
            ),
          ),
          Expanded(
              child: TabBarView(controller: _tabController, children: [
            MysavedPinsTabbarWidget(),
            MysavedPinsTabbarWidget(),
            MysavedPinsTabbarWidget(),
          ]))
        ],
      ),
    );
  }
}

class MysavedPinsTabbarWidget extends StatelessWidget {
  const MysavedPinsTabbarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height(context) * 0.87,
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('bookmarks').get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List tripData = snapshot.data!.docs.map((e) => e).toList();
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //   builder: (context) => ShowDetailsOfFestivals()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10, bottom: 5),
                            height: height(context) * 0.38,
                            width: width(context) * 0.93,
                            decoration: shadowDecoration(15, 2),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: height(context) * 0.25,
                                      width: width(context),
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                          child: tripData[index]['image'] != ""
                                              ? Image.network(tripData[index]['image'])
                                              : Image.asset('assets/images/beach.png')),
                                    ),
                                    Positioned(
                                        top: -5,
                                        right: -5,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: white,
                                            ))),
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: Container(
                                          padding: EdgeInsets.only(left: 6),
                                          height: height(context) * 0.062,
                                          width: width(context),
                                          color: black.withOpacity(0.4),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Row(
                                              //   children: [
                                              //     Icon(
                                              //       Icons.calendar_month,
                                              //       color: white,
                                              //       size: 20,
                                              //     ),
                                              //     addHorizontalySpace(5),
                                              //     Text(
                                              //       '6th Feb 2022',
                                              //       style: TextStyle(fontWeight: FontWeight.w500, color: white),
                                              //     )
                                              //   ],
                                              // ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_rounded,
                                                    color: white,
                                                    size: 20,
                                                  ),
                                                  addHorizontalySpace(5),
                                                  Text(
                                                    '${tripData[index]['location']}',
                                                    style: TextStyle(fontWeight: FontWeight.w500, color: white),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${tripData[index]['tripname']}',
                                        style: bodyText22w700(color: black),
                                      ),
                                      addVerticalSpace(3),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(text: 'Category: ', style: bodyText14w600(color: black)),
                                        TextSpan(text: 'Aspied Trip', style: bodyText14normal(color: black)),
                                      ])),
                                      Text(
                                        '${tripData[index]['dis']}',
                                        style: bodyText14normal(spacing: 1.5, color: black),
                                      ),
                                      addVerticalSpace(8),
                                      Row()

                                      // Row(
                                      //   children: [
                                      //     addHorizontalySpace(7),
                                      //     Stack(
                                      //       children: [
                                      //         Container(
                                      //           width: width(context) * 0.32,
                                      //           child: Row(
                                      //             children: [
                                      //               for (int i = 0; i < overlap2.length; i++)
                                      //                 Align(
                                      //                   widthFactor: 0.5,
                                      //                   child: CircleAvatar(
                                      //                     radius: 15,
                                      //                     backgroundColor: white,
                                      //                     backgroundImage: AssetImage(overlap2[i]),
                                      //                   ),
                                      //                 ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //         Positioned(
                                      //             left: 80,
                                      //             child: CircleAvatar(
                                      //                 radius: 15,
                                      //                 backgroundColor: primary,
                                      //                 child: Icon(
                                      //                   Icons.person_add,
                                      //                   color: black,
                                      //                   size: 20,
                                      //                 )))
                                      //       ],
                                      //     ),
                                      //     RichText(
                                      //         text: TextSpan(children: [
                                      //       TextSpan(text: 'Trip member\n', style: bodyText14normal(color: black)),
                                      //       TextSpan(text: '6/8 added', style: bodyText14w600(color: black)),
                                      //     ])),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: primary,
              ));
            }
          },
        ));
  }
}

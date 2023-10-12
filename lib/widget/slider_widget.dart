import 'dart:ui';
import 'package:travelnew_app/Api/pref_halper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/aspired_trip/aspired_trip2_screen.dart';

import '../Api/model/aspired_trip_model.dart';

class SliderWidget extends StatefulWidget {
  List<Data> imageList;
  SliderWidget({required this.imageList});
  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final _carouselController = CarouselController();

  // int inActive = 0;
  int _current = 0;
  String _picks = "";
  String _visitSeason = "";
  String _image = "";
  // void getDetails() async {
  //   if (IS_USER_LOGIN) {
  //     var trip = await FirebaseFirestore.instance.collection('Aspired_trips').doc('Trip1').get();
  //     _picks = trip.data()?['tripnumber'] ?? "";
  //     _visitSeason = trip.data()?['visitcategory'] ?? "";
  //     _image = trip.data()?['imageUrl'] ?? '';
  //   }
  //   setState(() {});
  // }

  @override
  void initState() {
    //getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
      ),
      child: Column(
        children: [
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
                viewportFraction: 1,
                enlargeCenterPage: true,
                autoPlay: true,
                // enlargeCenterPage: true,
                height: MediaQuery.of(context).size.height * 0.25,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: widget.imageList.map((i) {
              // print("image url=============${i.image}");
              return Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) => AspiredTrip2Screen()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          // height: MediaQuery.of(context).size.height * 0.9,
                          margin: const EdgeInsets.symmetric(horizontal: 0.0),

                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.network(
                              i.image==""||blanImageStrings.contains(i.image)?"${NoTripNetworkImage}":"${i.image}"!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        left: 20,
                        width: width(context) * 0.8,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              color: Colors.white.withOpacity(0.1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: width(context) * 0.4,
                                    child: Text(overflow: TextOverflow.ellipsis,
                                      '${i.description}',
                                      style: bodyText16normal(color: white),
                                    ),
                                  ),
                                  Text(overflow: TextOverflow.ellipsis,
                                    '${i.includes} Picks',
                                    style: bodyText16normal(color: white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 10,),
          buildPage(),
        ],
      ),
    );
  }

  Widget buildPage() => AnimatedSmoothIndicator(
        activeIndex: _current,
        count: widget.imageList.length,
        effect: ExpandingDotsEffect(
            spacing: MediaQuery.of(context).size.width * 0.021,
            dotWidth: MediaQuery.of(context).size.width * 0.05,
            dotHeight: MediaQuery.of(context).size.height * 0.008,
            dotColor: Colors.grey,
            activeDotColor: primary),
      );
}

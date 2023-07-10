import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app/utils/constant.dart';
import 'package:travel_app/widget/custom_button.dart';

List planDetails = [];
int selectedIndex = 0;
bool loading = false;

class GoPrimaSubscriptionScreen extends StatefulWidget {
  const GoPrimaSubscriptionScreen({super.key});

  @override
  State<GoPrimaSubscriptionScreen> createState() =>
      _GoPrimaSubscriptionScreenState();
}

class _GoPrimaSubscriptionScreenState extends State<GoPrimaSubscriptionScreen> {
  final _carouselController = CarouselController();

  List listWidget = [
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(text: 'Travel\n', style: bodyText20w700(color: primary)),
              TextSpan(text: 'Comunity', style: bodyText20w700(color: black)),
            ])),
            Image.asset('assets/images/prima1.png'),
          ],
        ),
        Row(
          children: [
            Container(
              height: 50,
              width: 8,
              color: primary,
            ),
            addHorizontalySpace(10),
            SizedBox(
              width: 220,
              child: Text(
                'Get India’s most travel-specific profile page. Travel and build your trip friend community with ease.',
                style: bodyText14w600(color: black),
              ),
            )
          ],
        )
      ],
    ),
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(text: 'Unlock\n', style: bodyText20w700(color: primary)),
              TextSpan(text: 'Profile', style: bodyText20w700(color: black)),
            ])),
            Image.asset('assets/images/2nd.png'),
          ],
        ),
        Row(
          children: [
            Container(
              height: 50,
              width: 8,
              color: primary,
            ),
            addHorizontalySpace(10),
            SizedBox(
              width: 220,
              child: Text(
                'Unlock profile views and make like-minded trip friends.Start an unlimited chat with new friends',
                style: bodyText14w600(color: black),
              ),
            )
          ],
        )
      ],
    ),
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(text: 'Prima\n', style: bodyText20w700(color: primary)),
              TextSpan(text: 'Trips', style: bodyText20w700(color: black)),
            ])),
            Image.asset('assets/images/3rd.png'),
          ],
        ),
        Row(
          children: [
            Container(
              height: 50,
              width: 8,
              color: primary,
            ),
            addHorizontalySpace(10),
            SizedBox(
              width: 220,
              child: Text(
                'Search and join other trips and let others join your trip. Search friends and Invite them to your trip.',
                style: bodyText14w600(color: black),
              ),
            )
          ],
        )
      ],
    ),
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Unexplored\n', style: bodyText20w700(color: primary)),
              TextSpan(text: 'Places', style: bodyText20w700(color: black)),
            ])),
            Image.asset('assets/images/4rth.png'),
          ],
        ),
        Row(
          children: [
            Container(
              height: 55,
              width: 8,
              color: primary,
            ),
            addHorizontalySpace(10),
            SizedBox(
              width: 230,
              child: Text(
                'Visit tourist places which are unexplored and yet astonishing to make you and your trip friend surprised.',
                style: bodyText14w600(color: black),
              ),
            )
          ],
        )
      ],
    ),
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Travel alone\n',
                  style: bodyText20w700(color: primary)),
              TextSpan(text: 'Trips', style: bodyText20w700(color: black)),
            ])),
            Image.asset('assets/images/5th.png'),
          ],
        ),
        Row(
          children: [
            Container(
              height: 50,
              width: 8,
              color: primary,
            ),
            addHorizontalySpace(10),
            SizedBox(
              width: 220,
              child: Text(
                'Travel alone if you need to find your inner peace.Unlock crafted trips that are safe to travel alone',
                style: bodyText14w600(color: black),
              ),
            )
          ],
        )
      ],
    ),
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Plan trips\n', style: bodyText20w700(color: primary)),
              TextSpan(
                  text: 'from multiple cities',
                  style: bodyText20w700(color: black)),
            ])),
            // Image.asset('assets/images/5th.png'),
            Icon(
              Icons.location_on,
              color: primary,
              size: 50,
            )
          ],
        ),
        Row(
          children: [
            Container(
              height: 50,
              width: 8,
              color: primary,
            ),
            addHorizontalySpace(10),
            SizedBox(
              width: 220,
              child: Text(
                'Add a new hometown city to your profile and do planning and booking trips starting from multiple cities',
                style: bodyText14w600(color: black),
              ),
            )
          ],
        )
      ],
    ),
  ];

  // int inActive = 0;
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        foregroundColor: black,
        elevation: 0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Go ', style: bodyText30W600(color: primary)),
                    TextSpan(
                        text: 'Explore!\n',
                        style: bodyText30W600(color: black)),
                    TextSpan(
                        text: 'Go ', style: bodyText30W600(color: primary)),
                    TextSpan(
                        text: 'Prima.', style: bodyText30W600(color: black)),
                  ])),
                  addVerticalSpace(height(context) * 0.05),
                  CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        // enlargeCenterPage: true,
                        height: MediaQuery.of(context).size.height * 0.18,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    items: listWidget.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Column(
                            children: [
                              i,
                            ],
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: _current,
                      count: 5,
                      effect: ExpandingDotsEffect(
                          spacing: MediaQuery.of(context).size.width * 0.021,
                          dotWidth: MediaQuery.of(context).size.width * 0.02,
                          dotHeight: MediaQuery.of(context).size.height * 0.01,
                          dotColor: Colors.grey,
                          activeDotColor: primary),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                'Plan Details',
                style: bodyText20w700(color: black),
              ),
            ),
            addVerticalSpace(8),
            const PlanDetailsWidget(),
            addVerticalSpace(10),
            Center(
              child: SizedBox(
                  width: width(context) * 0.6,
                  child: InkWell(
                    onTap: () {
                      showAlertDialog(context);
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: '    Select your plan or try Prima\n',
                          style: bodyText14normal(color: black)),
                      TextSpan(
                          text: 'Free ',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: primary)),
                      TextSpan(
                          text: 'for 7 days (limited ',
                          style: TextStyle(color: black)),
                      TextSpan(
                          text: 'features',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: primary)),
                      TextSpan(text: ')', style: TextStyle(color: black)),
                    ])),
                  )),
            ),
            addVerticalSpace(height(context) * 0.05),
            Center(
              child: SizedBox(
                width: width(context) * 0.52,
                child: const Text(
                  'Already member know status Have an Issue contact us',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.3,
                      decoration: TextDecoration.underline,
                      fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      )),
      bottomNavigationBar: Container(
        height: height(context) * 0.1,
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        width: width(context),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
              ),
            ]),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          loading
              ? const CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        planDetails.isNotEmpty
                            ? planDetails[selectedIndex]['price']
                            : 'X00',
                        style: bodyText16w600(color: black),
                      ),
                      addVerticalSpace(5),
                      Text(
                        '${planDetails.isNotEmpty ? planDetails[selectedIndex]['months'] : 0} Months Planned',
                        style: bodyText14w600(color: black.withOpacity(0.3)),
                      )
                    ],
                  ),
                ),
          Column(
            children: [
              Text(
                'Access to all features',
                style: bodyText12Small(color: black),
              ),
              InkWell(
                onTap: () {
                  primaSubscriptionSummary(context);
                },
                child: Container(
                  height: 40,
                  width: width(context) * 0.4,
                  decoration: myFillBoxDecoration(0, primary, 10),
                  child: Center(
                    child: Text(
                      'Subscribe',
                      style: bodyText16w600(color: white),
                    ),
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }

  getFreeTrail() async {
    setState(() {
      loading = true;
    });

    // var x= FirebaseFirestore.instance.collection(collectionPath)
  }

  showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.all(6),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return StatefulBuilder(builder: (context, setState) {
                    return Container(
                        height: height * 0.25,
                        width: width * 0.95,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              'Enjoy 7 days Prima trial membership as a welcome gift. To avail complete features subscribe now',
                              textAlign: TextAlign.center,
                              style:
                                  bodyText16normal(spacing: 1.3, color: black),
                            ),
                            addVerticalSpace(height * 0.07),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    getFreeTrail();
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    decoration:
                                        myOutlineBoxDecoration(1, primary, 10),
                                    child: Center(
                                      child: Text(
                                        'Continue Trial',
                                        style: bodyText14w600(color: black),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    decoration:
                                        myFillBoxDecoration(0, primary, 10),
                                    child: Center(
                                      child: Text(
                                        'Subscribe',
                                        style: bodyText14w600(color: black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ));
                  });
                },
              ),
            ));
  }

  primaSubscriptionSummary(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.all(6),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return Container(
                    height: height * 0.4,
                    width: width * 0.95,
                    padding: EdgeInsets.all(13),
                    child: Column(
                      children: [
                        Text(
                          'Prima Subscription Summary',
                          style: bodyText16w600(color: black),
                        ),
                        addVerticalSpace(20),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text:
                                  'Your subscription is live now. Go explore your \n               trip by access to all',
                              style: bodyText12Small(color: black)),
                          TextSpan(
                              text: ' features.',
                              style:
                                  bodyText14w600(spacing: 1.2, color: primary))
                        ])),
                        addVerticalSpace(20),
                        Container(
                          padding: EdgeInsets.all(8),
                          height: height * 0.13,
                          width: width * 0.7,
                          decoration: myFillBoxDecoration(
                              0, black.withOpacity(0.1), 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/images/menu3.png'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Plan - Hobby',
                                    style: bodytext12Bold(color: black),
                                  ),
                                  addVerticalSpace(4),
                                  Text(
                                    '₹500 for 3 months',
                                    style: bodytext12Bold(color: black),
                                  ),
                                  addVerticalSpace(10),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            'Your subscription ends on \nFeb 03, 2022\n',
                                        style: TextStyle(
                                            height: 1.3,
                                            fontSize: 12,
                                            color: black)),
                                    TextSpan(
                                        text: 'Extend Subscription',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: primary))
                                  ]))
                                ],
                              ),
                            ],
                          ),
                        ),
                        addVerticalSpace(15),
                        Text(
                          'Prima member since November 08, 2022',
                          style: bodyText13normal(color: black),
                        ),
                        addVerticalSpace(20),
                        CustomButton(
                            name: 'Okay',
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                  );
                },
              ),
            ));
  }
}

class PlanDetailsWidget extends StatefulWidget {
  const PlanDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PlanDetailsWidget> createState() => _PlanDetailsWidgetState();
}

class _PlanDetailsWidgetState extends State<PlanDetailsWidget> {
  getPrimaPlans() async {
    var x = await FirebaseFirestore.instance
        .collection('primaPlans')
        .doc('planDeatils')
        .get();
    planDetails.clear();
    print(x.data());
    x.data()!.forEach((key, value) {
      planDetails.add(value);
    });
    planDetails.forEach((element) {
      print(element['no']);
    });
    List plans = [];
    planDetails.forEach((element) {
      plans.add(element);
    });
    print('[[[[[[[[[[[[[[[object]]]]]]]]]]]]]]]');
    print(plans);

    planDetails.clear();
    for (int i = 0; i < 4; i++) {
      print(plans);
      for (int j = 0; j <= 4; j++) {
        print('$i $j ${plans[j]}');
        if (plans[j]['no'] == (i + 1)) {
          planDetails.add(plans[j]);
          break;
        }
      }
    }

    print(planDetails);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getPrimaPlans();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context) * 0.2,
      child: ListView.builder(
          itemCount: planDetails.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    // setState(() {
                    //   loading = true;
                    // });
                    selectedIndex = i;
                    setState(() {
                      // loading = false;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(7),
                    height: 143,
                    width: 100,
                    decoration: selectedIndex == i
                        ? BoxDecoration(
                            border: Border.all(width: 2, color: primary),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10) //
                                    ),
                            color: Colors.white,
                            boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                ),
                              ])
                        : shadowDecoration(10, 5),
                    child: Column(
                      children: [
                        addVerticalSpace(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              planDetails[i]['planName'],
                              style:
                                  bodytext12Bold(color: black.withOpacity(0.4)),
                            ),
                            selectedIndex == i
                                ? Icon(
                                    Icons.check_circle,
                                    color: primary,
                                  )
                                : Icon(
                                    Icons.circle_outlined,
                                    color: black.withOpacity(0.3),
                                  )
                          ],
                        ),
                        addVerticalSpace(height(context) * 0.03),
                        Text(
                          planDetails[i]['months'],
                          style: bodyText14w600(color: black),
                        ),
                        Text(
                          'Months',
                          style: bodyText14w600(color: black),
                        ),
                        addVerticalSpace(height(context) * 0.02),
                        Text(
                          planDetails[i]['price'],
                          style: bodyText20w700(color: primary),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

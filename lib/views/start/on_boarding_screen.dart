import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app/views/start/signup_with_social_media_screen.dart';
import 'package:travel_app/widget/my_bottom_navbar.dart';

import '../../utils/constant.dart';
import 'sign_in_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();

  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height(context),
            child: PageView(
              controller: pageController,
              onPageChanged: (i) {
                setState(() {
                  if (i == 5) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyBottomBar(),
                        //SignupWithSocialMediaScreen(),
                      ),
                    );
                  }
                });
              },
              children: const [
                PageViewItemWidget(
                  text: "Your next new trip starts here",
                  text2:
                      "Plan a niche trip from our 7500+ tourist places throughout India. Visit unexplored tourist places and experience different aspects of Indian culture, history, people, etc.",
                  assetUrl: 'assets/images/onb1.png',
                ),
                PageViewItemWidget(
                  text: "Discover local events and festival",
                  text2:
                      "Go for festival trips and witness celebrations, traditions, fairs and events in India which will be forever etched in your heart. Meet new friends while your festival trip.",
                  assetUrl: 'assets/images/onb2.png',
                ),
                PageViewItemWidget(
                  text: "Host and join new trips customized trips",
                  text2:
                      " Organize exclusive trips and publish to meet up with old, new and like-minded trip friends. Find fun by joining others’ trips. Hold a new buddy and make memories.",
                  assetUrl: 'assets/images/onb3.png',
                ),
                PageViewItemWidget(
                  text: "Join the passionate Traveler Community",
                  text2:
                      "Find and interact with travelers through India’s most travel-specific social platform. It’s here where your journey begins to be a part of the large travel community.",
                  assetUrl: 'assets/images/onb4.png',
                ),
                PageViewItemWidget(
                  text: "Experience your trip at the best",
                  text2:
                      "Experience more fun while your trip. Get Information viz. know places, what & where to buy, special to eat and more mentioned in our travel utility section.",
                  assetUrl: 'assets/images/onb5.png',
                ),
                SignInScreen(),
              ],
            ),
          ),
          Positioned(
            right: width(context) * 0.42,
            top: height(context) * 0.54,
            child: SmoothPageIndicator(
              controller: pageController,
              count: 6,
              axisDirection: Axis.horizontal,
              effect: ExpandingDotsEffect(
                  spacing: 4.0,
                  radius: 16.0,
                  dotWidth: 5.0,
                  dotHeight: 5.0,
                  // paintStyle: PaintingStyle.stroke,
                  // strokeWidth: 5,
                  dotColor: Colors.grey,
                  activeDotColor: primary),
            ),
          ),
          Positioned(
              right: width(context) * 0.43,
              bottom: height(context) * 0.1,
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    SignupWithSocialMediaScreen())));
                      },
                      child: Text(
                        'Skip',
                        style: bodyText14w600(color: black),
                      )),
                  addHorizontalySpace(30),
                  InkWell(
                    onTap: () {
                      setState(() {});

                      pageController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut);
                    },
                    child: CircleAvatar(
                      backgroundColor: primary,
                      child: Icon(
                        Icons.arrow_forward,
                        color: white,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class PageViewItemWidget extends StatelessWidget {
  final String text;
  final String text2;
  final String assetUrl;

  const PageViewItemWidget({
    Key? key,
    required this.text,
    required this.assetUrl,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: height(context) * 0.3,
            width: width(context),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                assetUrl,
              ),
              // fit: BoxFit.fill,
            ))),
        SizedBox(
          height: height(context) * 0.08,
        ),
        Container(
          width: width(context) * 0.95,
          child: Text(
            text,
            style: bodyText20w700(color: black),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: height(context) * 0.04,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: width(context) * 0.1),
          width: width(context),
          child: Text(
            text2,
            style: bodyText16normal(spacing: 1.4, color: black),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

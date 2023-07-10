import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app/utils/constant.dart';
import 'package:travel_app/views/aspired_trip/explore_trip_suggestion.dart';
import 'package:travel_app/widget/custom_button.dart';

class ExploreTripDestination extends StatefulWidget {
  const ExploreTripDestination({super.key});

  @override
  State<ExploreTripDestination> createState() => _ExploreTripDestinationState();
}

class _ExploreTripDestinationState extends State<ExploreTripDestination> {
  String _name = "";
  String _undrestand = "";
  String _language = "";
  String _howgohotal = "";
  String _help = "";
  String _image = "";
  String _experience = "";
  String _food_and_drink = "";
  String _far = "";

  void getDetails() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var ads = await FirebaseFirestore.instance.collection('Travalar').doc('Mahaveer_travalar').collection('Explore_ads').doc('Fatured').get();
      _name = ads.data()?['name'];
      _undrestand = ads.data()?['undrerstandname'];
      _language = ads.data()?['locaLanguage'];
      _howgohotal = ads.data()?['howtogohotel'];
      _help = ads.data()?['helpnumber'];
      _image = ads.data()?['image'];
      _experience = ads.data()?['Experience'];
      _far = ads.data()?['hotelarea'];
      _food_and_drink = ads.data()?['food_and_drink'];
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Explore Trip destination',
                  style: bodyText18w600(color: black),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => ExploreTripSuggestionScreen()));
                  },
                  child: Container(
                    height: height(context) * 0.035,
                    width: width(context) * 0.25,
                    decoration: myFillBoxDecoration(0, primary, 6),
                    child: Center(
                      child: Text(
                        'Suggest Edit',
                        style: bodytext12Bold(color: black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            addVerticalSpace(25),
            Text(
              'Understand $_name',
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(4),
            Text(
              '$_undrestand',
              style: bodyText13normal(spacing: 1.5, color: black),
            ),
            addVerticalSpace(15),
            Text(
              'Local Language',
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(4),
            Text('$_language'),
            addVerticalSpace(15),
            Text(
              'How to go to Hotel',
              style: bodyText14normal(color: black.withOpacity(0.5)),
            ),
            addVerticalSpace(4),
            Text(
              '$_howgohotal',
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(15),
            Text(
              'I need help, please call the police',
              style: bodyText14normal(color: black.withOpacity(0.5)),
            ),
            addVerticalSpace(4),
            Text(
              '$_help',
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(15),
            Text(
              'How far is Hotel',
              style: bodyText14normal(color: black.withOpacity(0.5)),
            ),
            addVerticalSpace(4),
            Text(
              '$_far',
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(15),
            Text(
              'Rickshaw take me to the temple',
              style: bodyText14normal(color: black.withOpacity(0.5)),
            ),
            addVerticalSpace(4),
            Text(
              '',
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(18),
            Container(
              height: height(context) * 0.25,
              width: width(context) * 0.95,
              decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(_image))),
            ),
            addVerticalSpace(20),
            Text(
              'Experience at $_name',
              style: bodyText16w600(color: black),
            ),
            Text(
              '$_experience',
              style: bodyText14normal(color: black, spacing: 1.5),
            ),
            addVerticalSpace(25),
            Text(
              'Food & Drinks at $_name',
              style: bodyText16w600(color: black),
            ),
            Text(
              '$_food_and_drink',
              style: bodyText14normal(color: black, spacing: 1.5),
            )
          ],
        ),
      ),
    );
  }
}

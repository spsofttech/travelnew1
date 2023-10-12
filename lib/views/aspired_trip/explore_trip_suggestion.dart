import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/Api/pref_halper.dart';
import '../../utils/constant.dart';

class ExploreTripSuggestionScreen extends StatefulWidget {
  const ExploreTripSuggestionScreen({super.key});

  @override
  State<ExploreTripSuggestionScreen> createState() => _ExploreTripSuggestionScreenState();
}

class _ExploreTripSuggestionScreenState extends State<ExploreTripSuggestionScreen> {
  String _string = 'Shopping';
  final TextEditingController suggestion1 = TextEditingController();
  final TextEditingController suggestion2 = TextEditingController();
  updateads() async {
    final _fireStore = FirebaseFirestore.instance;
    await _fireStore
        .collection('Travalar')
        .doc('Mahaveer_travalar')
        .collection('Explore_ads')
        .doc('Fatured')
        .update({"suggestion1": suggestion1.text, "suggestion2": suggestion2.text});
  }

  String _name = "";
  String _address = "";
  String _date = "";
  void getDetails() async {
    if (IS_USER_LOGIN) {
      var ads = await FirebaseFirestore.instance.collection('Travalar').doc('Mahaveer_travalar').collection('Explore_ads').doc('Fatured').get();
      _name = ads.data()?['name'];
      _address = ads.data()?['address'];
      _date = ads.data()?['date'];
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
        title: Column(
          children: [
            Text(
              '$_name $_address',
              style: bodyText20w700(color: black),
            ),
            Text(
              '$_date',
              style: bodyText14normal(color: black),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your suggestions will keep the information updated in this section.',
              style: bodyText16w600(color: black),
              textAlign: TextAlign.center,
            ),
            addVerticalSpace(20),
            Text(
              '$_name',
              style: bodyText18w600(color: black),
            ),
            addVerticalSpace(15),
            Text('Suggesting Edit for?'),
            addVerticalSpace(6),
            Container(
              decoration: myOutlineBoxDecoration(1, primary, 10),
              height: height(context) * 0.04,
              width: width(context) * 0.45,
              // color: const Color(0xffF0F0F0),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 2, right: 8),
                child: Center(
                  child: DropdownButton<String>(
                    value: _string,
                    isExpanded: true,
                    onChanged: (newValue) {
                      setState(() {
                        _string = newValue!;
                      });
                    },
                    items: ['Shopping', 'Riding']
                        .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: bodytext12Bold(color: black),
                              ),
                            ))
                        .toList(),

                    // add extra sugar..
                    icon: const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Icon(
                        Icons.arrow_drop_down,
                      ),
                    ),
                    iconSize: 25,
                    iconEnabledColor: primary,
                    iconDisabledColor: black.withOpacity(0.7),
                    underline: const SizedBox(),
                  ),
                ),
              ),
            ),
            addVerticalSpace(20),
            Container(
                decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 15),
                width: width(context) * 0.95,
                child: TextField(
                    controller: suggestion1,
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      hintStyle: bodyText13normal(color: black),
                      hintText: 'Suggest any changes or additional information for the section ',
                    ))),
            addVerticalSpace(20),
            Container(
                decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 15),
                width: width(context) * 0.95,
                child: TextField(
                    controller: suggestion2,
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      hintStyle: bodyText13normal(color: black),
                      hintText: 'Reference if any for the suggestion ',
                    ))),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'TravelNewfollows zero tolerance policy for fake suggestions.For suggestions on multiple sections, please submit them separately.',
              ),
            ),
            addVerticalSpace(35),
            Center(
              child: SizedBox(
                width: width(context) * 0.5,
                child: CustomButton(
                    name: 'Send Suggestion',
                    onPressed: () {
                      updateads();
                      suggestionOverlay(context);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  suggestionOverlay(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.all(6),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return Container(
                      height: height * 0.22,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'We won’t be able to respond to your suggestions personally, but we assure you that your input reaches the appropriate team for editing the existing information in our platform.',
                            textAlign: TextAlign.center,
                            style: bodyText13normal(color: black),
                          ),
                          // addVerticalSpace(height * 0.07),
                          SizedBox(
                            width: width * 0.4,
                            child: CustomButton(
                                name: 'Okay',
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          )
                        ],
                      ));
                },
              ),
            ));
  }
}

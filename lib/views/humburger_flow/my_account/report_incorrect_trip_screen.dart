import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app/model/save_trip_model.dart';
import 'package:travel_app/utils/constant.dart';
import 'package:travel_app/widget/custom_button.dart';

import '../../../widget/custom_appbar.dart';

class ReportIncorrectTripScreen extends StatefulWidget {
  const ReportIncorrectTripScreen({super.key});

  @override
  State<ReportIncorrectTripScreen> createState() =>
      _ReportIncorrectTripScreenState();
}

class _ReportIncorrectTripScreenState extends State<ReportIncorrectTripScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(title: 'Report Incorrect User')),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0, left: 10, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: width(context) * 0.8,
                child: Text(
                  'Your Contribution will help safe travel for fellow travelers ',
                  style: bodyText16w600(color: black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            addVerticalSpace(20),
            Text(
              'Mumbai, Maharahshtra',
              style: bodyText18w600(color: black),
            ),
            addVerticalSpace(5),
            Text(
              'Alexander Doe',
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(30),
            Text(
              'What’s incorrect?',
              style: bodyText18w600(color: black),
            ),
            addVerticalSpace(15),
            SizedBox(
              height: height(context) * 0.1,
              child: GridView.builder(
                  itemCount: incorrectTripCheckboxList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3.5, crossAxisCount: 3),
                  itemBuilder: (ctx, i) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 25,
                          child: Checkbox(
                            activeColor: primary,
                            checkColor: black,
                            value: incorrectTripCheckboxList[i].isSelected,
                            onChanged: (value) {
                              setState(() {
                                for (var element in incorrectTripCheckboxList) {
                                  element.isSelected = false;
                                }
                                incorrectTripCheckboxList[i].isSelected =
                                    value!;
                              });
                            },
                          ),
                        ),
                        Text(
                          incorrectTripCheckboxList[i].name,
                          style: bodyText12Small(color: black),
                        )
                      ],
                    );
                  }),
            ),
            Container(
                decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 15),
                width: width(context) * 0.95,
                height: height(context) * 0.15,
                margin: EdgeInsets.only(right: 10),
                child: TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      hintStyle: bodyText13normal(color: black),
                      hintText:
                          'Mention what’s incorrect with any reference if any For suggestion on multiple sections, please mention them in separate paragraphs.'),
                )),
            addVerticalSpace(15),
            Center(
              child: Text(
                'Be sure you know exactly what you are reporting. TravelNew \nhas zero tolerance on fake reporting',
                style: bodyText12Small(color: black),
              ),
            ),
            addVerticalSpace(height(context) * 0.07),
            Center(
              child: SizedBox(
                width: width(context) * 0.6,
                child: CustomButton(
                    name: 'Send Suggestion',
                    onPressed: () {
                      reportIncorrectUserPopup(context);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  reportIncorrectUserPopup(BuildContext context) {
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
                      height: height * 0.22,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            ' We won’t be able to respond to your suggestions personally, but we assure you that your input reaches the appropriate team for editing the existing information in our platform.',
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

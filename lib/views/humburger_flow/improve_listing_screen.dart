import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/widget/custom_appbar.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/widget/custom_textfield.dart';

import '../../model/DayWiseTripModel.dart';
import '../../model/save_trip_model.dart';

class ImproveListingScreen extends StatefulWidget {
  const ImproveListingScreen({super.key, required this.MP});
  final DayTripData MP;

  @override
  State<ImproveListingScreen> createState() => _ImproveListingScreenState();
}

class _ImproveListingScreenState extends State<ImproveListingScreen> {
  final TextEditingController dateSelect = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: 'Improve Listing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Your suggestions will keep the information updated in this section.',
                  textAlign: TextAlign.center,
                  style: bodyText16w600(color: black),
                ),
              ),
              addVerticalSpace(25),
              Text(
                widget.MP.touristSpot!,
                style: bodyText18w600(color: black),
              ),
              Text(
                'Udupi, Karnataka',
                style: bodyText16normal(color: black),
              ),
              addVerticalSpace(15),
              Text(
                'Suggesting improvements of',
                style: bodyText18w600(color: black),
              ),
              addVerticalSpace(10),
              SizedBox(
                height: height(context) * 0.12,
                child: GridView.builder(
                    itemCount: improveListingCheckbox.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 3.5, crossAxisCount: 3),
                    itemBuilder: (ctx, i) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: Checkbox(
                              activeColor: primary,
                              checkColor: black,
                              value: improveListingCheckbox[i]["value"],
                              onChanged: (value) {
                                setState(() {
                                  for (var element in improveListingCheckbox) {
                                    element["value"] = false;
                                  }
                                  improveListingCheckbox[i]["value"] = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: width(context) * 0.225, child: Text(improveListingCheckbox[i]['title']))
                        ],
                      );
                    }),
              ),
              addVerticalSpace(15),
              Text(
                'When did you visited?',
                style: bodyText18w600(color: black),
              ),
              addVerticalSpace(12),
              SizedBox(
                width: width(context) * 0.45,
                height: 35,
                child: CustomTextFieldWidget(
                  icon: Icon(
                    Icons.arrow_drop_down_sharp,
                    color: primary,
                  ),
                  controller: dateSelect,
                  labelText: '',
                  onClick: () async {
                    var pickedDate =
                        await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

                      setState(() {
                        dateSelect.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              addVerticalSpace(15),
              Container(
                  decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 15),
                  width: width(context) * 0.94,
                  // height: height(context) * 0.15,
                  child: TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: bodyText13normal(color: black),
                        hintText:
                            'Mention what’s incorrect with any reference if any For suggestion on multiple sections, please enter after each suggestion '),
                  )),
              addVerticalSpace(15),
              Container(
                  decoration: myFillBoxDecoration(0, black.withOpacity(0.1), 15),
                  width: width(context) * 0.94,
                  // height: height(context) * 0.08,
                  child: TextField(
                      maxLines: 2,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          hintStyle: bodyText13normal(color: black),
                          hintText: 'Upload Screen shot or any reference image'))),
              addVerticalSpace(20),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "For suggestions on multiple sections, please mention them in separate paragraphs.",
                  style: bodyText12Small(color: black),
                ),
              ),
              addVerticalSpace(10),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Be sure you know exactly what you are reporting. TravelNew follows zero tolerance policy for fake feedback",
                  style: bodyText12Small(color: black),
                ),
              ),
              addVerticalSpace(25),
              Center(
                child: SizedBox(
                  height: 40,
                  width: width(context) * 0.4,
                  child: CustomButton(
                      name: 'Submit',
                      onPressed: () {
                        showImproveListingOverlay(context);
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showImproveListingOverlay(BuildContext context) {
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
                      height: height * 0.25,
                      width: width * 0.95,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                              'We won’t be able to respond to your suggestions personally, but we assure you that your input reaches the appropriate team for editing the existing information in our platform.',
                              textAlign: TextAlign.center,
                              style: bodyText14w600(color: black)),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 35,
                              width: width * 0.3,
                              decoration: myFillBoxDecoration(0, primary, 10),
                              child: Center(
                                child: Text(
                                  'Okay',
                                  style: bodyText14w600(color: black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ));
                },
              ),
            ));
  }
}

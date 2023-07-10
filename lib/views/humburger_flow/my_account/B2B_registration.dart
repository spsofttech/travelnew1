import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app/utils/constant.dart';
import 'package:travel_app/widget/custom_button.dart';
import 'package:travel_app/widget/custom_textfield.dart';

import '../../../widget/custom_appbar.dart';

class B2BRegistrationScreen extends StatefulWidget {
  const B2BRegistrationScreen({super.key});

  @override
  State<B2BRegistrationScreen> createState() => _B2BRegistrationScreenState();
}

class _B2BRegistrationScreenState extends State<B2BRegistrationScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(title: 'TravelNew Biz Registration')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            addVerticalSpace(10),
            Text(
              'We have exciting travelers for your business',
              style: bodyText16w600(color: black),
            ),
            addVerticalSpace(25),
            CustomTextFieldWidget(labelText: 'Business Name*'),
            addVerticalSpace(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width(context) * 0.45,
                  child: CustomTextFieldWidget(labelText: 'First Name*'),
                ),
                SizedBox(
                  width: width(context) * 0.45,
                  child: CustomTextFieldWidget(labelText: 'Last Name*'),
                ),
              ],
            ),
            addVerticalSpace(15),
            CustomTextFieldWidget(labelText: 'Mobile Number*'),
            addVerticalSpace(4),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Why is this required?',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primary,
                        decoration: TextDecoration.underline),
                  )),
            ),
            addVerticalSpace(8),
            CustomTextFieldWidget(labelText: 'Location of Service*'),
            addVerticalSpace(4),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Explain about this?',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primary,
                        decoration: TextDecoration.underline),
                  )),
            ),
            addVerticalSpace(8),
            CustomTextFieldWidget(labelText: 'Website'),
            addVerticalSpace(0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    activeColor: primary,
                    checkColor: black,
                    value: isChecked,
                    onChanged: (val) {
                      isChecked = val!;
                      setState(() {});
                    }),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (ctx) => SignUpScreen()));
                  },
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'I accept the ',
                        style: bodyText14normal(color: black)),
                    TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: primary,
                            decoration: TextDecoration.underline))
                  ])),
                ),
              ],
            ),
            addVerticalSpace(height(context) * 0.07),
            CustomButton(name: 'Submit', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

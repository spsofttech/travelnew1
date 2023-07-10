import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_app/services/firebase_services.dart';
import 'package:travel_app/utils/constant.dart';
import 'package:travel_app/views/start/create_new_password.dart';
import 'package:travel_app/views/start/sign_up_screen.dart';
import 'package:travel_app/widget/custom_button.dart';
import 'package:travel_app/widget/custom_textfield.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: primary,
                    )),
              ],
            ),
          ),
          addVerticalSpace(height(context) * 0.1),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Reset Password',
                    style: bodyText22w700(color: black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: width(context) * 0.8,
                    child: Text(
                      'We’ll send you an OTP on your registered email id.',
                      style: bodyText16normal(color: black.withOpacity(0.6)),
                    ),
                  ),
                ),
                addVerticalSpace(height(context) * 0.09),
                CustomTextFieldWidget(
                  labelText: 'Email Address',
                  controller: _controller,
                ),
                addVerticalSpace(12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: ((context) => ForgotPassword())));
                      },
                      child: Text(
                        'Forgot Email id? Send on registered mobile number',
                        style: bodyText13normal(color: black.withOpacity(0.5)),
                      )),
                ),
                // addVerticalSpace(6),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => SignUpScreen())));
                      },
                      child: Text(
                        'Sign up with new email id?',
                        style: bodyText13normal(color: black.withOpacity(0.5)),
                      )),
                ),
                addVerticalSpace(height(context) * 0.09),
                CustomButton(
                    name: 'Send',
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: ((context) => CreateNewPassword())));

                      //Send-Password-Reset-Link//
                      if (_controller.text == null) {
                        Fluttertoast.showToast(
                            msg: "Please enter email address");
                      }
                      FirebaseServices()
                          .passwordReset(_controller.text, context);
                    })
              ],
            ),
          ),
        ],
      )),
    );
  }
}

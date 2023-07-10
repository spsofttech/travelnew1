import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app/utils/constant.dart';
import 'package:travel_app/widget/custom_button.dart';
import 'package:travel_app/widget/custom_textfield.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
              color: primary,
            )),
        title: Text(
          'Create New Password',
          style: TextStyle(color: black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          addVerticalSpace(height(context) * 0.12),
          Text('We have sent a OTP to your registered email ID'),
          addVerticalSpace(height(context) * 0.07),
          CustomTextFieldWidget(labelText: 'Enter OTP'),
          addVerticalSpace(15),
          CustomTextFieldWidget(labelText: 'New Password'),
          addVerticalSpace(15),
          CustomTextFieldWidget(labelText: 'Confirm New Password'),
          Row(
            children: [
              Spacer(),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        color: black),
                  ))
            ],
          ),
          addVerticalSpace(height(context) * 0.099),
          CustomButton(name: 'Update', onPressed: () {})
        ]),
      ),
    );
  }
}

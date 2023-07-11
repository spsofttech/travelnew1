import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/start/sign_in_screen.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/widget/my_bottom_navbar.dart';
import 'package:intl/intl.dart';

import '../../widget/custom_textfield.dart';
import '../home/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = "";

  String password = "";

  bool isButtonActive = true;
  TextEditingController field0 = new TextEditingController();
  TextEditingController field1 = new TextEditingController();
  TextEditingController field2 = new TextEditingController();
  TextEditingController field3 = new TextEditingController();
  TextEditingController field4 = new TextEditingController();
  bool _prima = false;
  registerUser() async {
    final _fireStore = FirebaseFirestore.instance;
    await _fireStore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set({
      'firstName': field0.text,
      'fullName': field0.text,
      'email': field1.text,
      'dob': field2.text,
      'mobNum': field3.text,
      'isPrima': _prima,
      'UID': FirebaseAuth.instance.currentUser!.uid,
      'image': ""
    });
  }

  @override
  void initstate() {
    super.initState();
    field0 = TextEditingController();
    field0.addListener(() {
      final isButtonActive = field0.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
    field1 = TextEditingController();
    field1.addListener(() {
      final isButtonActive = field1.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
    field2 = TextEditingController();
    field2.addListener(() {
      final isButtonActive = field2.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
    field3 = TextEditingController();
    field3.addListener(() {
      final isButtonActive = field3.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
    field4 = TextEditingController();
    field4.addListener(() {
      final isButtonActive = field4.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    field0.dispose();
    field1.dispose();
    field2.dispose();
    field3.dispose();
    field4.dispose();
    super.dispose();
  }

  showSnackBar(BuildContext context, String str, [Color clr = Colors.black]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: clr,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: primary,
                          ))
                    ],
                  ),
                ),
                addVerticalSpace(height(context) * 0.01),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign up',
                        style: bodyText22w700(color: black),
                      ),
                      Text(
                        'To kick - start your next trip',
                        style: bodyText16normal(color: black),
                      ),
                      addVerticalSpace(height(context) * 0.09),
                      CustomTextFieldWidget(
                        labelText: 'Full Name',
                        controller: field0,
                      ),
                      addVerticalSpace(15),
                      SizedBox(
                        child: Theme(
                          data: ThemeData(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
                                  primary: primary,
                                ),
                          ),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            showSnackBar(context, "We won’t post anything without your consent", Colors.green);
                                          },
                                          icon: Icon(
                                            Icons.mail_outline,
                                            color: primary,
                                          )),
                                      hintText: 'name@example.com',
                                      labelText: '  Email',
                                      focusColor: primary,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black26, width: 1.0), borderRadius: BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: primary, width: 1.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    controller: field1,
                                  ),
                                ),
                                //    addHorizontalySpace(15),
                              ],
                            ),
                          ),
                        ),
                      ),
                      addVerticalSpace(15),
                      CustomTextFieldWidget(
                        labelText: 'Date Of Birth',
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: primary,
                        ),
                        onClick: () async {
                          var pickedDate =
                              await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

                            setState(() {
                              field2.text = formattedDate;
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                        // icon: Icon(Icons.calendar_month_rounded),
                        // labelText: 'Date of birth',
                        controller: field2,
                      ),
                      addVerticalSpace(15),
                      SizedBox(
                        child: Theme(
                          data: ThemeData(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
                                  primary: primary,
                                ),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.perm_contact_cal_rounded,
                                color: primary,
                              ),
                              labelText: 'Mobile Number',
                              // labelStyle: bodyText14w600(color: primarhy),

                              focusColor: primary,

                              enabledBorder:
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.black26, width: 1.0), borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primary, width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 20,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            controller: field3,
                          ),
                        ),
                      ),
                      addVerticalSpace(15),
                      SizedBox(
                        child: Theme(
                          data: ThemeData(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
                                  primary: primary,
                                ),
                          ),
                          child: TextField(
                            obscureText: true,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: InputDecoration(
                              // prefixIcon: Icon(Icons.remove_red_eye_sharp),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    showSnackBar(context, "Password should be at least 6 characters with one small and one big alphabet", Colors.green);
                                  },
                                  icon: Icon(
                                    Icons.help,
                                    color: primary,
                                  )),
                              hintText: 'Password',
                              labelText: 'Password',
                              enabledBorder:
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.black26, width: 1.0), borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primary, width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: field4,
                            // icon: Icon(
                            //   Icons.remove_red_eye_rounded,
                            //   color: primary,
                            // ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width(context) * 0.2, top: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) => SignInScreen()));
                          },
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(text: 'Already a member?', style: bodyText14normal(color: black.withOpacity(0.5))),
                            TextSpan(text: ' Sign in', style: TextStyle(fontWeight: FontWeight.w600, decoration: TextDecoration.underline, color: primary))
                          ])),
                        ),
                      ),
                      addVerticalSpace(20),
                      addVerticalSpace(height(context) * 0.04),
                      Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: height(context) * 0.06,
                            // width: width(context) * 0.15,
                            child: Center(
                              child: Ink(
                                decoration: const ShapeDecoration(
                                  shape: CircleBorder(),
                                ),
                                child: Visibility(
                                  visible: (field0.text.isNotEmpty ||
                                          field1.text.isNotEmpty ||
                                          field2.text.isNotEmpty ||
                                          field3.text.isNotEmpty ||
                                          field4.text.isNotEmpty)
                                      ? true
                                      : false,
                                  child: IconButton(
                                      style: IconButton.styleFrom(disabledBackgroundColor: primary),
                                      icon: const Icon(Icons.refresh_sharp),
                                      color: primary,
                                      onPressed: () {
                                        field0.clear();
                                        field1.clear();
                                        field2.clear();
                                        field3.clear();
                                        field4.clear();
                                        setState(() {});
                                      }),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 355,
                              child: CustomButton(
                                name: 'Sign up',
                                onPressed: () async {
                                  try {
                                    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                      email: email,
                                      password: password,
                                    );
                                    registerUser();
                                    showSnackBar(context, "Signed Up", Colors.green);
                                    Navigator.push(context, MaterialPageRoute(builder: ((context) => SignInScreen())));
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      print('The password provided is too weak.');
                                    } else if (e.code == 'email-already-in-use') {
                                      print('The account already exists for that email.');
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      addVerticalSpace(height(context) * 0.05),
                      SizedBox(
                        // width: width(context) * 0.9,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(text: 'By Proceeding further you agree to Travel New’s ', style: bodyText14normal(spacing: 1.4, color: black)),
                              TextSpan(
                                text: 'Terms of Services & Privacy Policy. ',
                                recognizer: TapGestureRecognizer()..onTap = () {},
                                style: TextStyle(fontWeight: FontWeight.w600, height: 1.4, color: black, decoration: TextDecoration.underline),
                              ),
                              TextSpan(
                                  text: 'To sign up, you need to be at least 18. You can hide your DOB',
                                  style: bodyText14normal(spacing: 1.4, color: black))
                            ])),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

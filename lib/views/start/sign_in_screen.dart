import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/home/home_screen.dart';
import 'package:travelnew_app/views/start/forgot_password.dart';
import 'package:travelnew_app/views/start/sign_up_screen.dart';
import 'package:travelnew_app/views/start/signup_with_social_media_screen.dart';
import 'package:travelnew_app/widget/my_bottom_navbar.dart';

import '../../widget/custom_button.dart';
import '../../widget/custom_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = "";

  String password = "";
  showSnackBar(BuildContext context, String str, [Color clr = Colors.black]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: clr,
    ));
  }

  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
              addVerticalSpace(height(context) * 0.10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, Alexandra',
                      style: bodyText22w700(color: black),
                    ),
                    addVerticalSpace(15),
                    Text(
                      'Sign In',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    addVerticalSpace(height(context) * 0.08),
                    TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primary, width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // icon: Icon(
                      //   Icons.help,
                      //   color: primary,
                      // ),
                    ),
                    addVerticalSpace(20),
                    TextField(
                      obscureText: !_passwordVisible,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                          hintText: 'Password',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primary, width: 1.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                              color: primary,
                            ),
                          )),
                      // icon: Icon(
                      //   Icons.help,
                      //   color: primary,
                      // ),
                    ),
                    addVerticalSpace(20),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => ForgotPassword())));
                        },
                        child: Text(
                          'Forgot password ?',
                          style: bodyText14normal(color: black.withOpacity(0.5)),
                        )),
                    addVerticalSpace(6),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => SignUpScreen())));
                        },
                        child: Text(
                          'Sign up with new email id ?',
                          style: bodyText14normal(color: black.withOpacity(0.5)),
                        )),
                    addVerticalSpace(height(context) * 0.07),
                    CustomButton(
                      name: 'Sign in',
                      onPressed: () async {
                        try {
                          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          sharedPreferences.setString('email', email.toString());
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => MyBottomBar())));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(context, "Your email is not exist", Colors.red);
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context, "Your password is Wrong", Colors.red);
                            print('Wrong password provided for that user.');
                          }
                        }
                        // FirebaseAuth.instance.createUserWithEmailAndPassword(email: null, password: )
                      },
                    ),
                    addVerticalSpace(height(context) * 0.08),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(text: '     By Proceeding further you agree to Travel New’s.\n               ', style: bodyText14normal(color: black)),
                        TextSpan(
                          text: 'Terms of Services and Privacy Policy',
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: TextStyle(fontWeight: FontWeight.w600, height: 1.4, color: black, decoration: TextDecoration.underline),
                        ),
                      ])),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

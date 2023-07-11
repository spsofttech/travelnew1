import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelnew_app/services/firebase_services.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/utils/firebaseAuth.dart';
import 'package:travelnew_app/views/start/sign_in_screen.dart';
import 'package:travelnew_app/widget/my_bottom_navbar.dart';

class SignupWithSocialMediaScreen extends StatefulWidget {
  const SignupWithSocialMediaScreen({super.key});

  @override
  State<SignupWithSocialMediaScreen> createState() => _SignupWithSocialMediaScreenState();
}

class _SignupWithSocialMediaScreenState extends State<SignupWithSocialMediaScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(height(context) * 0.04),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => MyBottomBar())));
                  },
                  child: Text(
                    'I’ll do it later',
                    style: bodyText14normal(color: black),
                  )),
            ),
            addVerticalSpace(height(context) * 0.04),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/loc.png'),
                  Row(
                    children: [
                      Text(
                        'Sign up / Sign in',
                        style: bodyText22w700(color: black),
                      ),
                      IconButton(
                          onPressed: () {
                            dialog1(context);
                          },
                          icon: Icon(
                            Icons.help,
                            color: black.withOpacity(0.5),
                          ))
                    ],
                  ),
                  Text(
                    'To kick - start your next trip',
                    style: bodyText16normal(color: black),
                  ),
                ],
              ),
            ),
            addVerticalSpace(height(context) * 0.06),
            InkWell(
              onTap: () async {
                FirebaseAuthen _auth = new FirebaseAuthen();
                await _auth.signInWithGoogle(context);
              },
              child: Container(
                height: 50,
                width: width(context) * 0.92,
                decoration: myOutlineBoxDecoration(1.3, primary, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/google2.png'),
                    addHorizontalySpace(15),
                    Text(
                      'Continue with Google',
                      style: bodyText16w600(color: black),
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(15),
            InkWell(
              onTap: () async {
                await FirebaseServices().signInWithFacebook();
                Navigator.push(context, MaterialPageRoute(builder: ((context) => MyBottomBar())));
                // signing with facebook
              },
              child: Container(
                height: 50,
                width: width(context) * 0.92,
                decoration: myOutlineBoxDecoration(1.3, primary, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/fb2.png'),
                    addHorizontalySpace(15),
                    Text(
                      'Continue with Facebook',
                      style: bodyText16w600(color: black),
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(15),
            InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                width: width(context) * 0.92,
                decoration: myOutlineBoxDecoration(1.3, primary, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/apple.png'),
                    addHorizontalySpace(15),
                    Text(
                      'Continue with Apple',
                      style: bodyText16w600(color: black),
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(15),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) => SignInScreen())));
              },
              child: Container(
                height: 50,
                width: width(context) * 0.92,
                decoration: myOutlineBoxDecoration(1.3, primary, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/Vector.png'),
                    addHorizontalySpace(15),
                    Text(
                      'Continue with Mail',
                      style: bodyText16w600(color: black),
                    )
                  ],
                ),
              ),
            ),
            addVerticalSpace(10),
            Center(
              child: TextButton(
                  onPressed: () {
                    dialog2(context);
                  },
                  child: Text(
                    'Why Login?',
                    style: TextStyle(fontWeight: FontWeight.w600, color: primary, decoration: TextDecoration.underline),
                  )),
            ),
            addVerticalSpace(30),
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
                    TextSpan(text: 'To sign up, you need to be at least 18. You can hide your DOB', style: bodyText14normal(spacing: 1.4, color: black))
                  ])),
            )
          ],
        ),
      )),
    );
  }

  dialog1(BuildContext context) {
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
                    height: 200,
                    child: Center(
                        child: Text(
                      'We won’t post anything without\n                your consent',
                      style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),
                    )),
                  );
                },
              ),
            ));
  }

  dialog2(BuildContext context) {
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
                    height: 200,
                    child: Center(
                        child: Text(
                      '             Login is required to save your trips, \n               connect with travelers and more. \n  It also enables syncing your trips and data on the \n                    occasion of handset change.',
                      style: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily),
                    )),
                  );
                },
              ),
            ));
  }
}

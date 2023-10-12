// ignore_for_file: use_build_context_synchronously

import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/start/create_new_password.dart';
import 'package:travelnew_app/views/start/sign_in_screen.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential =
            GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      throw e;
    }
  }

  //getting UID
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser!).uid;
  }

  signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await _auth.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      print(e);
      throw e;
    }
  }
  // signOUt()async{
  //  await _auth.signOut();
  //  await _googleSignIn.signOut();
  // }

  //-----Password-Reset-----//

  Future<void> passwordReset(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Reset Password"),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              actionsAlignment: MainAxisAlignment.center,
              actionsPadding: const EdgeInsets.all(2),
              content: const Text(
                  "Hey! A password reset link has been sent to your email. Please check your inbox and use the link to reset your password. Once you have reset your password, you can log in to your account with your new credentials."),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.amber),
                    child: Container(
                      height: 50,
                      width: width(context),
                      child: const Center(
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignInScreen()));
                    },
                  ),
                ),
              ],
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }
}

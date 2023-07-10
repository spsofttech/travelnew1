import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/widget/my_bottom_navbar.dart';
final _authent = FirebaseAuth.instance;
class FirebaseAuthen {
late final GoogleSignInAccount? googleSignInAccount;
  final _googleSignIn = GoogleSignIn();

  registerUser(
      String userid, String userMail, String photoUrl, String name) async {
    final _fireStore = FirebaseFirestore.instance;
    print('$userMail $userid $photoUrl $name');
    await _fireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'fullName': name,
      'email': userMail,
      'dob': '',
      'mobNum': '',
      'UID': userid,
    });
    print('uploaded-=-=-=-=-=-=-=-');
  }

  registerFBUser(String userid, String userMail, String photoUrl, String name,
      String dob, String gender) async {
    final _fireStore = FirebaseFirestore.instance;
  }

  signInWithGoogle(BuildContext context) async {
    try {
      googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount!.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _authent.signInWithCredential(authCredential);
        String userid = _authent.currentUser!.uid;
        String userMail = googleSignInAccount!.email;
        String userPhoto = googleSignInAccount!.photoUrl ?? '';
        String userName = googleSignInAccount!.displayName ?? '';

        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then(((value) {
          if (!(value.exists)) {
            registerUser(userid, userMail, userPhoto, userName);
          }
        }));

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => MyBottomBar())));
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      throw e;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseDB {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  Future<void> addBookmark(String id, String title, String subtitle, String image, String location) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      var uid = await _auth.currentUser!.uid;
      var data =
          user.doc(uid).collection('bookmarks').add({"id": id, "title": title, "subtitle": subtitle, "image": image, "location": location}).then((value) {
        print(value.id);
        _prefs.setString('docID', value.id);
      });
      Fluttertoast.showToast(msg: "Saved to Bookmarks");
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> removeBookmark(String? docID) async {
    try {
      var uid = _auth.currentUser!.uid;
      await user.doc(uid).collection('bookmarks').doc(docID).delete();
      Fluttertoast.showToast(msg: "Removed from bookmarks");
    } catch (e) {
      print(e);
    }
  }

  //------Update-Account-Privacy--------//

}

class UpdateAccountVisibility {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  //-----Age---------//
  Future<void> updatePrivacyVisibility(String value, String privacyList) async {
    try {
      var uid = _auth.currentUser!.uid;
      await user.doc(uid).update({
        privacyList: value,
      });
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  //---Save-Pins------//
  Future<void> savePins(String id, String title, String subtitle, String image, String location) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      var uid = await _auth.currentUser!.uid;
      var data =
          user.doc(uid).collection('savedPins').add({"id": id, "title": title, "subtitle": subtitle, "image": image, "location": location}).then((value) {
        print(value.id);
        _prefs.setString('docID', value.id);
      });
      Fluttertoast.showToast(msg: "Saved");
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}

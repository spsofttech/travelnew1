import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/save_your_trips/save_your_trips.dart';
import 'package:travelnew_app/Api/pref_halper.dart';
import '../../services/db/firebaseDB.dart';
import '../humburger_flow/trip_library_screen.dart';

class BookmarkedTrips extends StatefulWidget {
  String docID;
  bool isBookmarked;
  BookmarkedTrips({
    super.key,
    required this.isBookmarked,
    required this.docID,
  });

  @override
  State<BookmarkedTrips> createState() => _BookmarkedTripsState();
}

class _BookmarkedTripsState extends State<BookmarkedTrips> {
  @override
  void initState() {
    getDummyTrip01();

    super.initState();
  }

  String _title = "";
  String _subtitle = "";
  String _image = "";
  String _location = "";

  void getDummyTrip01() async {
    if (IS_USER_LOGIN) {
      var dummy = await FirebaseFirestore.instance.collection('dummyTrips').doc('2Xhglp1fUkvx3AGV6aQA').get();
      _title = dummy.data()?['title'];
      _subtitle = dummy.data()?['subtitle'];
      _image = dummy.data()?['image'];
      _location = dummy.data()?['location'];
      print(dummy);
    }
  }

  CollectionReference dummyFuture = FirebaseFirestore.instance.collection('dummyTrips');

  bool isBookmarked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: Text(
          "Bookmarks",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SizedBox(
        height: height(context) * 0.87,
        child: StreamBuilder<DocumentSnapshot>(
          stream: dummyFuture.doc("2Xhglp1fUkvx3AGV6aQA").snapshots(),
          builder: ((context, snapshot) {
            print(snapshot.data);
            if (widget.isBookmarked || snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data?.data() as Map<String, dynamic>;
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (ctx, i) {
                    return CustomTripDataList(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SaveYourTripsScreen()));
                      },
                      title: data['title'],
                      subtitle: data['subtitle'],
                      img: data['image'] ?? "https://www.unfe.org/wp-content/uploads/2019/04/SM-placeholder.png",
                      location: data['location'] ?? 'Udupi, Karnataka',
                      containerYellowBox: const SizedBox(),
                      icon: IconButton(
                          onPressed: () async {
                            SharedPreferences _prefs = await SharedPreferences.getInstance();
                            if (!isBookmarked) {
                              await FirebaseDB().addBookmark(widget.docID, data['title'], data['subtitle'], data['image'], data['location']);
                            } else {
                              var docID = _prefs.getString('docID');
                              FirebaseDB().removeBookmark(docID);
                            }

                            setState(() {
                              isBookmarked = !isBookmarked;
                            });
                          },
                          icon: !isBookmarked
                              ? Icon(
                                  Icons.bookmark_border,
                                  color: white,
                                )
                              : const Icon(Icons.bookmark)),
                    );
                  });
            }
            return const SizedBox();
          }),
        ),
      ),
    );
  }
}

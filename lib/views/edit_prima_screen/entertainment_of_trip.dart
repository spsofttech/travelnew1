import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/Api/pref_halper.dart';
import '../../../widget/custom_appbar.dart';

class EntertainmentOfTripScreen extends StatefulWidget {
  String tripHost;
  EntertainmentOfTripScreen({required this.tripHost});
  @override
  _EntertainmentOfTripScreenState createState() => _EntertainmentOfTripScreenState();
}

class _EntertainmentOfTripScreenState extends State<EntertainmentOfTripScreen> {
  // List chipList = [
  //   {'name': "Camping", 'isSelect': false},
  //   {'name': "Waterfalls", 'isSelect': false},
  //   {'name': "Hills and Trek", 'isSelect': false},
  //   {'name': "Biking", 'isSelect': false},
  //   {'name': "Safari", 'isSelect': false},
  //   {'name': "Water Sports", 'isSelect': false},
  //   {'name': "Mangroves", 'isSelect': false},
  //   {'name': "Tribal", 'isSelect': false},
  //   {'name': "Ropeways", 'isSelect': false},
  // ];
  // final List sportsList = [
  //   {'name': "Cricket", 'isSelect': false},
  //   {'name': "Batminton", 'isSelect': false},
  //   {'name': "Vally Ball", 'isSelect': false},
  //   {'name': "Football", 'isSelect': false},
  //   {'name': "Archery", 'isSelect': false},
  //   {'name': "Swimming", 'isSelect': false},
  // ];
  // final List natureList = [
  //   {'name': "Binding", 'isSelect': false},
  //   {'name': "Jungle Safari", 'isSelect': false},
  //   {'name': "Hiking", 'isSelect': false},
  //   {'name': "Sunrise/Sunset", 'isSelect': false},
  //   {'name': "Vaily & River", 'isSelect': false},
  //   {'name': "Botony", 'isSelect': false},
  // ];
  // final List FreeTime = [
  //   {'name': "Camping", 'isSelect': false},
  //   {'name': "Bonfire", 'isSelect': false},
  //   {'name': "Singing", 'isSelect': false},
  //   {'name': "Cooking", 'isSelect': false},
  //   {'name': "Archey", 'isSelect': false},
  //   {'name': "Reading", 'isSelect': false},
  //   {'name': "Star Gazing", 'isSelect': false},
  //   {'name': "Dancing", 'isSelect': false},
  //   {'name': "Fishing", 'isSelect': false},
  //   {'name': "Boating", 'isSelect': false},
  //   {'name': "Shopping", 'isSelect': false},
  //   {'name': "Arts and crafts", 'isSelect': false},
  //   {'name': "Casino", 'isSelect': false},
  //   {'name': "Luxury Stay", 'isSelect': false},
  //   {'name': "Cruise", 'isSelect': false},
  // ];
  // final List wellnessList = [
  //   {'name': "Yoga", 'isSelect': false},
  //   {'name': "Medition", 'isSelect': false},
  //   {'name': "Naturopathy", 'isSelect': false},
  // ];

  List<List<Map<String, Object>>> trip_interest_data_list = [];
  List<String> trip_interest_catName = [];
  getIntrest() async {
    trip_interest_data_list.clear();
    trip_interest_catName.clear();
    QuerySnapshot<Map<String, dynamic>> trip_intrest_snapshot = await FirebaseFirestore.instance.collection('trip_entertainment').get();
    print("${trip_intrest_snapshot.docs[0].data()['data']}");
    print("${trip_intrest_snapshot.docs[0].id}");

    int b = 0;
    trip_intrest_snapshot.docs.forEach((element) {
      trip_interest_data_list.add([]);
      List c = element.data()['data'];
      c.forEach((element2) {
        trip_interest_data_list[b].add({'image': element2['image'], 'name': element2['name'].toString(), 'isSelect': false});
      });

      trip_interest_catName.add("${element.id}");
      b++;
    });

    //print(trip_interest_data);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50), child: CustomAppBar(title: 'Entertainment of Trip')),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: FutureBuilder(
              future: getIntrest(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "What excites you?",
                            style: bodyText20w700(color: black),
                          ),
                        ),
                      ),
                      for (int a = 0; a < trip_interest_catName.length; a++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '${trip_interest_catName[a]}',
                                style: bodyText18w600(color: black),
                              ),
                            ),
                            filterChipWidget(height: 0.23, chipName: trip_interest_data_list[a], host: widget.tripHost),
                          ],
                        ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Text(
                      //     'Sports',
                      //     style: bodyText18w600(color: black),
                      //   ),
                      // ),
                      // filterChipWidget(height: 0.15, chipName: sportsList),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Text(
                      //     'Free Time',
                      //     style: bodyText18w600(color: black),
                      //   ),
                      // ),
                      // filterChipWidget(height: 0.37, chipName: FreeTime),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Text(
                      //     'Religious ',
                      //     style: bodyText18w600(color: black),
                      //   ),
                      // ),
                      // filterChipWidget(height: 0.23, chipName: chipList),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Text(
                      //     'Nature ',
                      //     style: bodyText18w600(color: black),
                      //   ),
                      // ),
                      // filterChipWidget(height: 0.16, chipName: natureList),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Text(
                      //     'Wellness ',
                      //     style: bodyText18w600(color: black),
                      //   ),
                      // ),
                      // filterChipWidget(height: 0.16, chipName: wellnessList),
                      addVerticalSpace(height(context) * 0.09),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: primary,
                    ),
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 30,
            left: width(context) * 0.25,
            child: Center(
              child: SizedBox(
                width: width(context) * 0.5,
                child: CustomButton(
                    name: 'Save',
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class filterChipWidget extends StatefulWidget {
  final List chipName;
  final double height;
  final String host;

  filterChipWidget({required this.chipName, required this.height, required this.host});

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  //String name = "";
  // void getdata() async {
  //   if (IS_USER_LOGIN) {
  //     var profile = await FirebaseFirestore.instance.collection('users').doc(widget.host).collection("primaAccount").doc('profile').get();
  //     name = profile.data()?['firstName'];
  //   }
  //   setState(() {});
  // }

  @override
  void initState() {
    // getdata();
    getDetails();
    super.initState();
  }

  List EntertainmentList = [];

  void getDetails() async {
    if (IS_USER_LOGIN) {
      var profile = await FirebaseFirestore.instance.collection('users').doc(widget.host).collection("Prima_Trip_Plan").doc(widget.host).get();
      EntertainmentList = profile.data()!['Entertainment'];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.chipName.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 3.2),
        itemBuilder: (ctx, i) {
          bool isSelected = EntertainmentList.where((element) => element['name'] == widget.chipName[i]['name']).toList().isNotEmpty;
          return GestureDetector(
            onTap: () {
              print(isSelected);
              if (isSelected) {
                EntertainmentList.remove(
                    {'image': widget.chipName[i]['image'], 'userName': '${USERNAME}', 'name': widget.chipName[i]['name'].toString(), 'isSelect': true});
                CollectionReference users = FirebaseFirestore.instance.collection('users');
                users.doc(widget.host).collection("Prima_Trip_Plan").doc(widget.host).update({
                  'Entertainment': FieldValue.arrayRemove([
                    {'image': widget.chipName[i]['image'], 'userName': '${USERNAME}', 'name': widget.chipName[i]['name'].toString(), 'isSelect': true}
                  ])
                });
                setState(() {
                  widget.chipName[i]['isSelect'] = !widget.chipName[i]['isSelect'];
                });
                getDetails();
              } else {
                EntertainmentList.add(
                    {'image': widget.chipName[i]['image'], 'userName': '${USERNAME}', 'name': widget.chipName[i]['name'].toString(), 'isSelect': false});
                CollectionReference users = FirebaseFirestore.instance.collection('users');
                users.doc(widget.host).collection("Prima_Trip_Plan").doc(widget.host).update({
                  'Entertainment': FieldValue.arrayUnion([
                    {'image': widget.chipName[i]['image'], 'userName': '${USERNAME}', 'name': widget.chipName[i]['name'].toString(), 'isSelect': true}
                  ])
                });
                setState(() {
                  widget.chipName[i]['isSelect'] = !widget.chipName[i]['isSelect'];
                });
                getDetails();
              }
            },
            child: Container(
              child: Column(
                children: [
                  // widget.chipName[i]['isSelect']
                  //     ? Text(
                  //         '$name',
                  //         style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: black),
                  //       )
                  //     : SizedBox(),
                  // if (EntertainmentList.contains(widget.chipName[i]['name']))
                  //   Text(
                  //     '$name',
                  //     style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: black),
                  //   )
                  // else
                  //   SizedBox(),
                  Container(
                    //margin: EdgeInsets.all(5),
                    height: height(context) * 0.035,
                    width: width(context) * 0.28,
                    decoration: isSelected ? myFillBoxDecoration(0, primary, 8) : myOutlineBoxDecoration(2, primary, 8),
                    child: Center(
                      child: Text(widget.chipName[i]['name']),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

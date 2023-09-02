import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelnew_app/Api/Api_Helper.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/humburger_flow/trip_library_screen.dart';
import 'package:travelnew_app/views/save_your_trips/save_your_trips.dart';
import 'package:travelnew_app/widget/custom_button.dart';

import '../../Api/model/day_vise_data_model.dart';
import '../../model/DayWiseTripModel.dart';
import '../../model/StateCatGetModel.dart';
import '../home/plan_trip_screen.dart';
import '../humburger_flow/stroyView.dart';
import '../humburger_flow/tourist_spot_screen.dart';

class SaveTripStep1 extends StatefulWidget {
  final String type_Of_Trip;
  final String plamTrip_at;
  final int trip_days;
  final List interestList;
  const SaveTripStep1({Key? key, this.type_Of_Trip = 'Friends Trip', this.plamTrip_at = "Karnataka", this.trip_days = -1, this.interestList = const [""]})
      : super(key: key);

  @override
  State<SaveTripStep1> createState() => _SaveTripStep1State();
}

class _SaveTripStep1State extends State<SaveTripStep1> {
  int days = 0;
  // final List dayWiseList1 = ['Day 1', 'Bonus Tourist Spot'];
  // final List dayWiseList2 = ['Day 1', 'Day 2', 'Bonus Tourist Spot'];
  // final List dayWiseList3 = ['Day 1', 'Day 2', 'Day 3', 'Bonus Tourist Spot'];
  // final List dayWiseList4 = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Bonus Tourist Spot'];
  // final List dayWiseList5 = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Bonus Tourist Spot'];
  // final List dayWiseList6 = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Bonus Tourist Spot'];
  // final List dayWiseList7 = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7', 'Bonus Tourist Spot'];

  // CollectionReference _collectionRef =
  // FirebaseFirestore.instance.collection('Aspired_trips');
  //
  // Future<void> getData() async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await _collectionRef.get();
  //   // Get data from docs and convert map to List
  //   allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   setState(() {
  //   });
  //   print(allData);
  // }
  // List allData = [];

  // String endplace = "";
  // String type = "";
  //
  // bool isLoded = false;
  // String bonceDes = "";

  // List<List<Map<String, dynamic>>> DaysTouristIndex = [];

  // Future getTripData() async {
  //   var data1 = await FirebaseFirestore.instance.collection('tripstate').doc('karnataka').collection('tripcity').doc('Bengaluru').get();
  //   bonceDes = data1['BonusDes'];
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     var profile = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('Plan_trip')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //     endplace = profile.data()?['endtrip'];
  //     days = profile.data()?['totalDays'];
  //     type = profile.data()?['tripPlan'];
  //
  //     print("type === ${type} days === ${days} ==bonuse == $bonceDes");
  //     print(endplace);
  //   }
  // }

  // CollectionReference _collectionRef =
  //     FirebaseFirestore.instance.collection('tripstate').doc('karnataka').collection('tripcity').doc('Bengaluru').collection('touristSport');

  // late List Trip_day_vise;
  // late var collectionRef;
  //
  // int firstIndex = 0;
  //
  // Future<int> getTripData() async {
  //   firstIndex = 0;
  //
  //   //log("---------------------------------------------------");
  //
  //   targetState = "${widget.plamTrip_at}";
  //   targetType = "${widget.type_Of_Trip}";
  //   //printc("-----Data ----- $targetType");
  //
  //   finalDataMain.clear();
  //   smapleData.clear();
  //   tripdataForStore.clear();
  //   printc("----- ### 1------", "c");
  //   QuerySnapshot<Map<String, dynamic>> dataDocRef =
  //       await FirebaseFirestore.instance.collection('Travel New').where('state', isEqualTo: '${targetState}').get();
  //   // print("-------data2 -- ${dataDocRef.docs[0].data()}");
  //   List<StateCatGetModel> subData = dataDocRef.docs.map((e) {
  //     // print("-------data  -- ${e.data()}");
  //     return StateCatGetModel.fromJson(e.data());
  //   }).toList();
  //
  //   //print("-------data  --${subData} ");
  //
  //   Set set1 = widget.interestList.map((e) {
  //     return e.toString();
  //   }).toSet();
  //
  //   List<ColId> catWiseData = [];
  //
  //   for (int i = 0; i < subData.length; i++) {
  //     for (int a = 0; a < subData[i].colId!.length; a++) {
  //       Set set2 = subData[i].colId![a].interest!.map((e) {
  //         return e.toString();
  //       }).toSet();
  //       // print("true -----------${subData[i].colId![a].category!} == ${targetType} ");
  //       if (subData[i].colId![a].category! == targetType && set1.intersection(set2).isNotEmpty && set1.length == set2.length) {
  //         //printc("true ----------- ", "c");
  //
  //         // log(colIdList[i2]['image']);
  //         QuerySnapshot<Map<String, dynamic>> dataDay = await FirebaseFirestore.instance
  //             .collection('Travel New')
  //             .doc('${subData[i].colId![a].city}')
  //             .collection("${subData[i].colId![a].id!}")
  //             .get();
  //
  //         printc("----- ### 2------ $firstIndex", "c");
  //         // printc(dataDay.docs[0].data());
  //         List<DayTripModel> dayvise = await getDataListModel(dataDay, subData[i].colId![a].id!, subData[i].colId![a].image!);
  //
  //         finalDataMain[firstIndex - 1].addAll(dayvise);
  //
  //         catWiseData.add(subData[i].colId![a]);
  //       }
  //     }
  //   }
  //   printc("----- ### 3------", "c");
  //   if (finalDataMain.length == 0) {
  //     // days = 0;
  //     QuerySnapshot<Map<String, dynamic>> dataDay =
  //         await FirebaseFirestore.instance.collection('Travel New').doc('${subData[0].colId![0].city}').collection("${subData[0].colId![0].id!}").get();
  //     // printc(dataDay.docs[0].data());
  //     List<DayTripModel> dayvise = await getDataListModel(dataDay, subData[0].colId![0].id!, subData[0].colId![0].image!);
  //     finalDataMain.add(dayvise);
  //   }
  //
  //   printc("----- ### 4------", "c");
  //   days = widget.trip_days != -1 ? widget.trip_days : 0;
  //   //printc("--Lenth1--- ${days}", "y");
  //   days = days <= finalDataMain[0].length ? days - 1 : finalDataMain[0].length;
  //
  //   // printc("--Lenth2--- ${days}", "y");
  //   trip_city_name.value = '${finalDataMain[0][0].data[0].tripCity}';
  //   trip_citi_lat = double.parse(finalDataMain[0][0].data[0].latitude!);
  //   trip_citi_long = double.parse(finalDataMain[0][0].data[0].longitude!);
  //   printc("----- ### 5------", "c");
  //   // printc("${UserCity}  ${trip_city_name.value}", 'c');
  //
  //   travel_by_data.value = await FirebaseFirestore.instance
  //       .collection('traveling_by')
  //       .where('home', isEqualTo: '${UserCity}')
  //       .where('trip_city', isEqualTo: trip_city_name.value)
  //       .where('type', isEqualTo: trip_mode)
  //       .get()
  //       .then((value) {
  //     //printc("----${value.docs[0].data()}", 'c');
  //     return value.docs.isNotEmpty ? value.docs[0].data() : {};
  //   });
  //   printc("----- ### 6------", "c");
  //   return 0;
  //   // }
  //   //
  //   // Future getTripData() async {
  //   //   bool checkArrytContain({required List list1, required List list2}) {
  //   //     int cnt1 = 0;
  //   //     int matchCnt = 0;
  //   //     printc("-----------");
  //   //     //List dataList1 = list1.where((element) => list2.where((element2) => element.toString() == element2.toString()).isNotEmpty).toList();
  //   //     bool contains = list1.toSet().intersection(list2.toSet()).isNotEmpty;
  //   //     // printc("-----------same -$dataList1");
  //   //     return contains;
  //   //     // if (list1.length == dataList1.length) {
  //   //     //   return true;
  //   //     // } else {
  //   //     //   return false;
  //   //     // }
  //   //   }
  //   //
  //   //   // log("---------------------------------------------------");
  //   //   targetState = "${widget.plamTrip_at}";
  //   //   targetType = "${widget.type_Of_Trip}";
  //   //   //printc("-----Data ----- $targetType");
  //   //
  //   //   var dotaDocRef = FirebaseFirestore.instance.collection('${targetType}').doc('${targetState}');
  //   //
  //   //   firstIndex = 0;
  //   //   finalData.clear();
  //   //   tripdataForStore.clear();
  //   //   finalData.add([]);
  //   //
  //   //   DocumentSnapshot<Map<String, dynamic>> data = await dotaDocRef.get();
  //   //   //printc("--Data ${data.data()!}");
  //   //   Map<String, dynamic> colIdMap = data.data()!;
  //   //   // printc(widget.interestList, "y");
  //   //   List colIdList = colIdMap['colID'];
  //   //
  //   //   Set set1 = widget.interestList.map((e) {
  //   //     return e.toString();
  //   //   }).toSet();
  //   //
  //   //   // printc("----${set1.intersection(set2).isNotEmpty && set1.length == set2.length}");
  //   //   printc("--col lenh ${colIdList.length}");
  //   //
  //   //   for (int i2 = 0; i2 < colIdList.length; i2++) {
  //   //     Set set2 = colIdList[i2]['intrest'].map((e) {
  //   //       return e.toString();
  //   //     }).toSet();
  //   //     print(i2);
  //   //     // print("If--  ${widget.interestList} == ${colIdList[i2]['interest'].toString().split(",")}");
  //   //     // bool condition1 = checkArrytContain(list1: widget.interestList, list2: colIdList[i2]['interest']);
  //   //
  //   //     if (set1.intersection(set2).isNotEmpty && set1.length == set2.length) {
  //   //       tripdataForStore.add({'docId': colIdList[i2]['id'], 'tripImage': '${colIdList[i2]['image']}'});
  //   //       // log(colIdList[i2]['image']);
  //   //       QuerySnapshot<Map<String, dynamic>> dataDay = await dotaDocRef.collection("${colIdList[i2]['id']}").get();
  //   //       // printc(dataDay.docs[0].data());
  //   //       List<DayTripModel> dayvise = await getDataListModel(dataDay, colIdList[i2]['id']);
  //   //       finalData[firstIndex - 1].addAll(dayvise);
  //   //     } else {
  //   //       printc("else -${firstIndex}");
  //   //     }
  //   //   }
  //   //   days = widget.trip_days != -1 ? widget.trip_days : 0;
  //   //   days = days < finalData[0].length ? days + 1 : finalData[0].length + 1;
  // }
  //
  // Future<List<DayTripModel>> getDataListModel(QuerySnapshot<Map<String, dynamic>> data, String docid, String image) async {
  //   List<DayTripModel> data11 = [];
  //
  //   data11.clear();
  //   //printc("main List Lesnth -- ${data.docs.length}");
  //   for (int ii = 0; ii < data.docs.length; ii++) {
  //     tripdataForStore.add({'docId': docid, 'tripImage': image});
  //     List<DayTripData> data1 = [];
  //     List dayDataList = data.docs[ii].data()['data'];
  //
  //     // printc("--${dayDataList.length}---");
  //     // print("---------");
  //     //printc("${value.docs[ii].id}-------" + dayDataList.length.toString());
  //     // printc(dayDataList[0]);
  //
  //     for (int ii2 = 0; ii2 < dayDataList.length; ii2++) {
  //       //log("-- ---${value.docs[ii2].data()['day']}");
  //       //printc(value.docs[0].data());
  //       data1.add(DayTripData.fromJson(dayDataList[ii2]));
  //     }
  //     List<DayTripData> data2 = [];
  //     List dayDataBonusList = data.docs[ii].data()['bonus'];
  //     for (int ii2 = 0; ii2 < dayDataBonusList.length; ii2++) {
  //       //log("-- ---${value.docs[ii2].data()['day']}");
  //       //printc(value.docs[0].data());
  //       data2.add(DayTripData.fromJson(dayDataList[ii2]));
  //     }
  //     data11.add(DayTripModel(data: data1, bonus: data2));
  //     //finalData.add();
  //
  //   }
  //   //print(data11);
  //   firstIndex++;
  //   finalDataMain.add([]);
  //
  //   return data11;
  //   // print("-----" + "${finalData}");
  // }
  //
  // Future<bool>? checkIfDocExists() async {
  //   bool isDocumentExist;
  //
  //   try {
  //     // Get reference to Firestore collection
  //     DocumentSnapshot doc = await FirebaseFirestore.instance.collection('Trips_New').doc("Friends Trip").get();
  //
  //     //var doc = await collectionRef;
  //
  //     print(doc);
  //
  //     setState(() {
  //       isDocumentExist = doc.exists;
  //     });
  //     print("----Doc Exist --- ${doc.exists}");
  //     return doc.exists;
  //   } catch (e) {
  //     setState(() {
  //       isDocumentExist = false;
  //     });
  //
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiHelper().get_days_api_call(trip_id: TRIP_ID, days: widget.trip_days),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          printc("----- -----${snapshot.data}");

          Day_vise_data_get_model AllDaysData= snapshot.data!;
          days=AllDaysData.data!.length;
          print('--- days -- ${days}');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('-- Trip', style: TextStyle(fontSize: 18, color: black)),
              Text('Your travel sightseeing'),
              addVerticalSpace(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height(context) * 0.59,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          // SizedBox(
                          //   height: height(context) * 0.17,
                          //   child: Column(
                          //     children: [
                          //       // allData[i]['type'] == type ?
                          //       InkWell(
                          //         onTap: () {
                          //           Navigator.push(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) => StoryPageView(
                          //                         data: finalDataMain[0][days],
                          //                       )));
                          //         },
                          //         child: Row(
                          //           children: [
                          //             // allData[i]['type'] == type ?
                          //             SizedBox(
                          //               height: height(context) * 0.12,
                          //               width: width(context) * 0.24,
                          //               child: tripdataForStore.length == 0
                          //                   ? Image.network(
                          //                       // allData[i]['image']
                          //                       "https://img.naidunia.com/naidunia/ndnimg/26052020/26_05_2020-tour_and_travel.jpg",
                          //                       fit: BoxFit.fill,
                          //                     )
                          //                   : Image.network(
                          //                       // allData[i]['image']
                          //                       tripdataForStore[0]['tripImage'] != ""
                          //                           ? tripdataForStore[0]['tripImage']!
                          //                           : "https://img.naidunia.com/naidunia/ndnimg/26052020/26_05_2020-tour_and_travel.jpg",
                          //                       fit: BoxFit.fill,
                          //                     ),
                          //             ),
                          //             // : SizedBox(),
                          //             addHorizontalySpace(10),
                          //             Column(
                          //               crossAxisAlignment: CrossAxisAlignment.start,
                          //               children: [
                          //                 // allData[i]['type'] == type ?
                          //                 Text(
                          //                   "Bonus",
                          //                   style: bodyText18w600(color: black),
                          //                 ),
                          //                 // : SizedBox(),
                          //                 addVerticalSpace(6),
                          //                 // allData[i]['type'] == type ?
                          //
                          //
                          //                 SizedBox(
                          //                   width: width(context) * 0.55,
                          //                   child: SingleChildScrollView(
                          //                     scrollDirection: Axis.horizontal,
                          //                     child: AllDaysData.data!.isEmpty
                          //                         ? Text("data")
                          //                         : Wrap(
                          //                             children: [
                          //                               for (int k = 0; k < finalDataMain[0][days - 1].bonus.length; k++)
                          //                                 Text(
                          //                                   "${finalDataMain[0][days - 1].bonus[k].touristSpot},",
                          //                                   // style:
                          //                                   // bodyText18w600(color: black),
                          //                                 )
                          //                             ],
                          //                           ),
                          //                   ),
                          //                 ),
                          //
                          //
                          //                 // : SizedBox(),
                          //                 addVerticalSpace(6),
                          //                 // SizedBox(
                          //                 //   width: width(context) * 0.5,
                          //                 //   child: Text(
                          //                 //     allData[i]['about'],
                          //                 //     style: bodyText14normal(color: black),
                          //                 //   ),
                          //                 // ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       // : SizedBox(),
                          //       // addVerticalSpace(15),
                          //       // allData[i]['type'] == type ?
                          //       const Divider(
                          //         height: 30,
                          //         thickness: 1,
                          //       ),
                          //       // :  SizedBox()
                          //     ],
                          //   ),
                          // ),

                          for (int i = 0; i < days; i++)
                            SizedBox(
                              height: height(context) * 0.17,
                              child: Column(
                                children: [
                                  // allData[i]['type'] == type ?
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => StoryPageView(
                                                    data: AllDaysData.data![i].touristSpot!,
                                                  )));
                                    },
                                    child: Row(
                                      children: [
                                        // allData[i]['type'] == type ?
                                        SizedBox(
                                          height: height(context) * 0.12,
                                          width: width(context) * 0.24,
                                          child: AllDaysData.status == 1
                                              ? Image.network(
                                                  // allData[i]['image']
                                                  "https://img.naidunia.com/naidunia/ndnimg/26052020/26_05_2020-tour_and_travel.jpg",
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.network(
                                                  // allData[i]['image']
                                                  tripdataForStore[i]['tripImage'] != ""
                                                      ? tripdataForStore[i]['tripImage']!
                                                      : "https://img.naidunia.com/naidunia/ndnimg/26052020/26_05_2020-tour_and_travel.jpg",
                                                  fit: BoxFit.fill,
                                                ),
                                        ),
                                        // : SizedBox(),
                                        addHorizontalySpace(10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // allData[i]['type'] == type ?
                                            Text(
                                              "${"day ${i + 1}"}",
                                              style: bodyText18w600(color: black),
                                            ),
                                            // : SizedBox(),
                                            addVerticalSpace(6),
                                            // allData[i]['type'] == type ?
                                            SizedBox(
                                              width: width(context) * 0.55,
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: AllDaysData.data![i].touristSpot!.length == 0
                                                    ? Text("data")
                                                    : Wrap(
                                                        children: [
                                                          for (int k = 0; k < AllDaysData.data![i].touristSpot!.length ; k++)
                                                            Text(
                                                              "${ AllDaysData.data![i].touristSpot![k].touristSpot},",
                                                              // style:
                                                              // bodyText18w600(color: black),
                                                            )
                                                        ],
                                                      ),
                                              ),
                                            ),
                                            // : SizedBox(),
                                            addVerticalSpace(6),
                                            // SizedBox(
                                            //   width: width(context) * 0.5,
                                            //   child: Text(
                                            //     allData[i]['about'],
                                            //     style: bodyText14normal(color: black),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // : SizedBox(),
                                  // addVerticalSpace(15),
                                  // allData[i]['type'] == type ?
                                  const Divider(
                                    height: 30,
                                    thickness: 1,
                                  ),
                                  // :  SizedBox()
                                ],
                              ),
                            ),
                          // SizedBox(
                          //   height: height(context) * 0.17,
                          //   child: Column(
                          //     children: [
                          //       // allData[i]['type'] == type ?
                          //       Row(
                          //         children: [
                          //           // allData[i]['type'] == type ?
                          //           SizedBox(
                          //               height: height(context) * 0.12,
                          //               width: width(context) * 0.24,
                          //               child: Image.network(
                          //                 // allData[i]['image']
                          //                 "https://img.naidunia.com/naidunia/ndnimg/26052020/26_05_2020-tour_and_travel.jpg",
                          //                 fit: BoxFit.fill,
                          //               )),
                          //           // : SizedBox(),
                          //           addHorizontalySpace(10),
                          //           Column(
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             children: [
                          //               // allData[i]['type'] == type ?
                          //               Text(
                          //                 "Bonus",
                          //                 style: bodyText18w600(color: black),
                          //               ),
                          //               // : SizedBox(),
                          //               addVerticalSpace(6),
                          //               // allData[i]['type'] == type ?
                          //               SizedBox(
                          //                 width: width(context) * 0.55,
                          //                 child: SingleChildScrollView(
                          //                   scrollDirection: Axis.horizontal,
                          //                   child: Text(
                          //                     "${bonceDes}",
                          //                     overflow: TextOverflow.ellipsis,
                          //                   ),
                          //                 ),
                          //               ),
                          //               // : SizedBox(),
                          //               addVerticalSpace(6),
                          //               // SizedBox(
                          //               //   width: width(context) * 0.5,
                          //               //   child: Text(
                          //               //     allData[i]['about'],
                          //               //     style: bodyText14normal(color: black),
                          //               //   ),
                          //               // ),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //       // : SizedBox(),
                          //       // addVerticalSpace(15),
                          //       // allData[i]['type'] == type ?
                          //       const Divider(
                          //         height: 30,
                          //         thickness: 1,
                          //       ),
                          //       // :  SizedBox()
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                      //   child: ListView.builder(
                      //       padding: EdgeInsets.zero,
                      //       shrinkWrap: true,
                      //       itemCount: allData.length,
                      //       physics: const NeverScrollableScrollPhysics(),
                      //       itemBuilder: (ctx, i) {
                      //         return Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             allData[i]['type'] == type ?
                      //             Container(
                      //               height:  33 ,
                      //               width: 51,
                      //               decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(10),
                      //                   image: DecorationImage(
                      //                       fit: BoxFit.fill,
                      //                       image: NetworkImage(
                      //                           allData[i]['image']))),
                      //               child: Column(
                      //                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   Row(
                      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                     children: [
                      //                       const Spacer(),
                      //                     ],
                      //                   ),
                      //                   addVerticalSpace(3),
                      //                   // Center(
                      //                   //   child: Icon(
                      //                   //     widget.contentType == 'video'
                      //                   //         ? Icons.play_circle_sharp
                      //                   //         : widget.contentType == 'audio'
                      //                   //         ? Icons.volume_up
                      //                   //         : widget.contentType == 'file'
                      //                   //         ? Icons.file_copy
                      //                   //         : null,
                      //                   //     color: white,
                      //                   //     size: 5.h,
                      //                   //   ),
                      //                   // )
                      //                 ],
                      //               ),
                      //             )
                      //                 : SizedBox(),
                      //             addVerticalSpace(10),
                      //             allData[i]['type'] == type ?
                      //             Text(
                      //               allData[i]['name'],
                      //               // style: kBodyText12wNormal(black),
                      //             )
                      //                 : SizedBox(),
                      //             addVerticalSpace(10),
                      //             allData[i]['type'] == type ?
                      //             Row(
                      //               children: [
                      //                 InkWell(
                      //                     onTap: () {
                      //                       // nextScreen(context,  profileMoreDetails(MP: allData[i],));
                      //                     },
                      //                     child: Text(
                      //                       'Description & more ',
                      //                       // style: kBodyText10wNormal(black),
                      //                     )),
                      //                 const Icon(
                      //                   Icons.arrow_forward,
                      //                   size: 15,
                      //                 )
                      //               ],
                      //             )
                      //                 : SizedBox(),
                      //             addVerticalSpace(10),
                      //             allData[i]['type'] == type ?
                      //             Divider()
                      //                 : SizedBox(),
                      //             addVerticalSpace(10),
                      //
                      //           ],
                      //         );
                      //       })
                    ),
                  ],
                ),
              )
            ],
          );
        }
        // else if (snapshot.hasError) {
        //   return Center(
        //     child: Text(snapshot.error.toString()),
        //   );
        // }
        else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  //
  // Future<void> getallData() async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await _collectionRef.get();
  //   // Get data from docs and convert map to List
  //   allData.clear();
  //
  //   allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   // print("${querySnapshot.docs.re}");
  //   getTripData();
  //   // GetDayWiseSpots();
  // }

  @override
  void initState() {
    //getallData();
    // getData();
    super.initState();
  }

  // GetDayWiseSpots() async {
  //   double StrtingCenterPoint;
  //   allData.sort((a, b) {
  //     double disA = double.parse(a["Distance from city centre"]);
  //     double disB = double.parse(b["Distance from city centre"]);
  //     return disA.compareTo(disB);
  //   });
  //
  //   StrtingCenterPoint = double.parse(allData[0]['Distance from city centre']);
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   DocumentSnapshot<Map<String, dynamic>> profile =
  //       await users.doc(FirebaseAuth.instance.currentUser!.uid).collection("primaAccount").doc("profile").get();
  //   List Intrest = [];
  //   // print("CITY ====${profile.data()!['Adventure']}");
  //   // profile.data()!['City'] != null ? Intrest.add("City") : "";
  //   // profile['Nature'] != null ? Intrest.add("Nature") : "";
  //   // profile['Adventure'] != null ? Intrest.add("Adventure") : "";
  //   // profile['Religious'] != null ? Intrest.add("Religious") : "";
  //
  //   List c1 = profile.data()!['City'] ?? [];
  //
  //   List c2 = profile.data()!['Nature'] ?? [];
  //   List c3 = profile.data()!['Adventure'] ?? [];
  //   List c4 = profile.data()!['Religious'] ?? [];
  //   Intrest.addAll(c1);
  //   Intrest.addAll(c2);
  //   Intrest.addAll(c3);
  //   Intrest.addAll(c4);
  //
  //   //
  //   // print("===Intest ${profile['Nature']}");
  //   // print("type === ${type} days === ${days}");
  //   // print("End place===${endplace}");
  //   // rank = List.filled(allData.length, {k:0});
  //   double daysCount = 0;
  //   int DayIndex = 0;
  //
  //   DaysTouristIndex.clear();
  //   DaysTouristIndex.add([]);
  //
  //   for (int i = 0; i < allData.length; i++) {
  //     if (daysCount <= 20) {
  //       DaysTouristIndex[DayIndex].add(allData[i]);
  //       daysCount = daysCount + double.parse(allData[i]['Time Spend']);
  //     } else {
  //       DaysTouristIndex.add([]);
  //       daysCount = 0;
  //       DayIndex++;
  //       daysCount = daysCount + double.parse(allData[i]['Time Spend']);
  //     }
  //     //  i++;
  //   }
  //   print("before ======== ${DaysTouristIndex[0]}");
  //   for (int k = 0; k < DaysTouristIndex.length; k++) {
  //     List<Map<String, dynamic>> tempSort = [];
  //     List<int> addedIned = [];
  //
  //     for (int l = 0; l < DaysTouristIndex[k].length; l++) {
  //       String type = DaysTouristIndex[k][l]['type'];
  //       String TripInterest1 = DaysTouristIndex[k][l]['Trip Interest1'] ?? "";
  //       String TripInterest2 = DaysTouristIndex[k][l]['Trip Interest2'] ?? "";
  //       String TripInterest3 = DaysTouristIndex[k][l]['Trip Interest3'] ?? "";
  //
  //       if (Intrest.contains(type) || Intrest.contains(TripInterest1) || Intrest.contains(TripInterest2) || Intrest.contains(TripInterest3)) {
  //         ///  print("Intrest === ${TripInterest1}");
  //         tempSort.add(DaysTouristIndex[k][l]);
  //         addedIned.add(l);
  //       }
  //     }
  //     print("tempsoprt 1====${tempSort.length}");
  //     for (int l = 0; l < DaysTouristIndex[k].length; l++) {
  //       if (addedIned.contains(l) == false) {
  //         // print("data ==== ");
  //         tempSort.add(DaysTouristIndex[k][l]);
  //       }
  //     }
  //     print("tempsoprt 2====${tempSort.length}");
  //     print("total lenth == ${DaysTouristIndex[k].length}");
  //     DaysTouristIndex[k] = tempSort;
  //     print("total lenth after == ${DaysTouristIndex[k].length}");
  //   }
  //
  //   print("affter ======== ${DaysTouristIndex[0]}");
  //   if (isLoded == false) {
  //     setState(() {
  //       isLoded = true;
  //     });
  //   }
  // }

  showDialogBox(BuildContext context) {
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
                      height: height * 0.22,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Dummy Dialog',
                            style: bodyText16w600(color: black),
                          ),
                          Text(
                            'Your request has been sent. Alexander will be your trip friend, after she accepts your request ',
                            textAlign: TextAlign.center,
                            style: bodyText13normal(color: black),
                          ),
                          // addVerticalSpace(height * 0.07),
                          SizedBox(
                            width: width * 0.4,
                            child: CustomButton(
                                name: 'Okay',
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          )
                        ],
                      ));
                },
              ),
            ));
  }
}

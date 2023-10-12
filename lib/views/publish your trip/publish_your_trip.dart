import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:travelnew_app/Api/Api_Helper.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/edit_prima_screen/prima_trip_1to4_screen.dart';
import 'package:travelnew_app/views/home/plan_trip_screen.dart';
import 'package:travelnew_app/views/publish%20your%20trip/selecteTripFriendPage.dart';
import 'package:travelnew_app/views/publish%20your%20trip/step1.dart';
import 'package:travelnew_app/views/publish%20your%20trip/step2.dart';
import 'package:travelnew_app/views/save_your_trips/save_trip_step_3.dart';
import 'package:travelnew_app/widget/custom_appbar.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/Api/pref_halper.dart';
import '../../Api/model/prima_sopt_model.dart';
import '../../Api/model/prima_trip_publish_send_model.dart';

String selectedTypeOfPrimaTrip = "Select";
String selectedCityOfPrimaTrip = "Select";
String selectedModeOfPrimaTrip = "Bus";
RxBool dataSecondPageLodedCount = false.obs;
int primaTripMaxMember = 0;
List cityTripData = [];
String coverpicImage = "";
List<RxBool> selectedTouristSpot = [];
List<Map<String, dynamic>> selectedTouristSpotData = [];
RxBool isThirdStepOn = false.obs;
DateTime? firstDate;
DateTime? secondDate;
int totalDays = 0;
String specitTripName = "";

List<prima_spot_get_model> PrimaTouristSpot = [];
//final TextEditingController specitTripNameController = TextEditingController();
final TextEditingController DoInTripController = TextEditingController();

class PublishYourTripScreen extends StatefulWidget {
  const PublishYourTripScreen({Key? key}) : super(key: key);

  @override
  _PublishYourTripScreenState createState() => _PublishYourTripScreenState();
}

class _PublishYourTripScreenState extends State<PublishYourTripScreen> {
  @override
  void initState() {
    // getDetails();
    // getdata();
    // getPrimaDeatials();
    super.initState();
  }

  // final List<String> tripLocation = ['Pune', 'Mumbai', 'chennai'];
  String image = "";

  // void getPrimaDeatials() async {
  //   if (IS_USER_LOGIN) {
  //     var profile =
  //         await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('primaAccount').doc('profile').get();
  //     image = profile.data()?['imageUrl'];
  //     setState(() {});
  //   }
  // }

  String member = "";
  String maxmember = "";
  // void getdata() async {
  //   // if (IS_USER_LOGIN) {
  //   //   var profile = await FirebaseFirestore.instance
  //   //       .collection('users')
  //   //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //   //       .collection("Prima_Trip_Plan")
  //   //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //   //       .get();
  //   //   member = profile.data()?['Inveted Member'] ?? "0";
  //   //   maxmember = profile.data()?['Max_Member'] ?? "0";
  //   // }
  //   DocumentSnapshot<Map<String, dynamic>> doc3 = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("Prima_Trip_Plan")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   bool docExist3 = doc3.exists;
  //   if (!docExist3) {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection("friends")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .set({"data": FieldValue.arrayUnion([])});
  //   }
  // }

  int _activeCurrentStep = 0;
  bool isChecked = true;
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  //
  // final TextEditingController SeeTripController = TextEditingController();
  // final TextEditingController InvitedMemberController = TextEditingController();
  // final TextEditingController MaxMemberController = TextEditingController();
  // final TextEditingController SpendsController = TextEditingController();

  addStep3PublishTripDetails() async {
    // Call the user's CollectionReference to add a new user

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Prima_Trip_Plan")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"who see trip": seetripvalue, "Inveted Member": InvitedMembervalue, "Max_Member": MaxMembervalue, "Spends": spendvalue})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  String InvitedMembervalue = "Public";
  String seetripvalue = "Select";
  String MaxMembervalue = "Select";
  String spendvalue = "Select";

  List<Step> stepList() => [
        Step(
            state: _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
            isActive: _activeCurrentStep >= 0,
            label: const Text('Plan'),
            title: const SizedBox(),
            content: const Step1()),
        Step(
            state: _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeCurrentStep >= 1,
            label: const Text('About Trip'),
            title: const SizedBox(),
            content: const Step2()),
        Step(
            state: StepState.complete,
            isActive: _activeCurrentStep >= 2,
            label: const Text('Members'),
            title: const SizedBox(),
            content: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Who can see your trip'),
                        SizedBox(
                          width: width(context) * 0.16,
                        ),
                        Text('Members Type invited  '),
                      ],
                    ),
                    addVerticalSpace(5),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: SizedBox(
                            height: 43,
                            width: width(context) * 0.42,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: const Border(
                                      top: BorderSide(
                                        color: Colors.black26,
                                      ),
                                      bottom: BorderSide(color: Colors.black26),
                                      right: BorderSide(color: Colors.black26),
                                      left: BorderSide(color: Colors.black26))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(10),
                                  value: InvitedMembervalue,
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      InvitedMembervalue = newValue!;
                                    });
                                  },
                                  items: ['Public', 'My Trip friends']
                                      .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5),
                                              child: Text(
                                                value,
                                                style: const TextStyle(fontSize: 15, color: Colors.black),
                                              ),
                                            ),
                                          ))
                                      .toList(),

                                  // add extra sugar..
                                  icon: const Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                  ),
                                  iconSize: 25,
                                  iconEnabledColor: primary,
                                  iconDisabledColor: black.withOpacity(0.7),
                                  underline: const SizedBox(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            height: 43,
                            width: width(context) * 0.42,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: const Border(
                                      top: BorderSide(
                                        color: Colors.black26,
                                      ),
                                      bottom: BorderSide(color: Colors.black26),
                                      right: BorderSide(color: Colors.black26),
                                      left: BorderSide(color: Colors.black26))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(10),
                                  value: seetripvalue,
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      seetripvalue = newValue!;
                                    });
                                  },
                                  items: ['Select', 'All type', 'Only Men', 'Only Women']
                                      .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5),
                                              child: Text(
                                                value,
                                                style: const TextStyle(fontSize: 15, color: Colors.black),
                                              ),
                                            ),
                                          ))
                                      .toList(),

                                  // add extra sugar..
                                  icon: const Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                  ),
                                  iconSize: 25,
                                  iconEnabledColor: primary,
                                  iconDisabledColor: black.withOpacity(0.7),
                                  underline: const SizedBox(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   width: width(context) * 0.42,
                    //   child: CustomDropDownButton(
                    //       value: seetripvalue,
                    //       itemList: ['Public', 'My Trip friends'],
                    //       controller: SeeTripController,
                    //       lableText: 'Who can see your trip'),
                    // ),
                    // SizedBox(
                    //   width: width(context) * 0.42,
                    //   child: CustomDropDownButton(
                    //       value: InvitedMembervalue,
                    //       itemList: ['All type', ' Only Men','Only Women'],
                    //       controller: InvitedMemberController,
                    //       lableText: 'Members Type invited'),
                    // )
                  ],
                ),
                addVerticalSpace(20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('Max Members for Trip'),
                        SizedBox(
                          width: width(context) * 0.14,
                        ),
                        const Text('How spends distributed?'),
                      ],
                    ),
                    addVerticalSpace(5),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: SizedBox(
                            height: 43,
                            width: width(context) * 0.42,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: const Border(
                                      top: BorderSide(
                                        color: Colors.black26,
                                      ),
                                      bottom: BorderSide(color: Colors.black26),
                                      right: BorderSide(color: Colors.black26),
                                      left: BorderSide(color: Colors.black26))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(10),
                                  value: MaxMembervalue,
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      MaxMembervalue = newValue!;
                                    });
                                  },
                                  items: ['Select', '1', '2', '3', '4', '5', '6', '7', '8']
                                      .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5),
                                              child: Text(
                                                value,
                                                style: const TextStyle(fontSize: 15, color: Colors.black),
                                              ),
                                            ),
                                          ))
                                      .toList(),

                                  // add extra sugar..
                                  icon: const Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                  ),
                                  iconSize: 25,
                                  iconEnabledColor: primary,
                                  iconDisabledColor: black.withOpacity(0.7),
                                  underline: const SizedBox(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            height: 43,
                            width: width(context) * 0.42,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: const Border(
                                      top: BorderSide(
                                        color: Colors.black26,
                                      ),
                                      bottom: BorderSide(color: Colors.black26),
                                      right: BorderSide(color: Colors.black26),
                                      left: BorderSide(color: Colors.black26))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(10),
                                  value: spendvalue,
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      spendvalue = newValue!;
                                    });
                                  },
                                  items: ['Select', 'For him/her self', ' Trip host', 'Except trip host']
                                      .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5),
                                              child: Text(
                                                value,
                                                style: const TextStyle(fontSize: 15, color: Colors.black),
                                              ),
                                            ),
                                          ))
                                      .toList(),

                                  // add extra sugar..
                                  icon: const Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                  ),
                                  iconSize: 25,
                                  iconEnabledColor: primary,
                                  iconDisabledColor: black.withOpacity(0.7),
                                  underline: const SizedBox(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     // SizedBox(
                //     //   width: width(context) * 0.4,
                //     //   child: CustomDropDownButton(itemList: [
                //     //     '1',
                //     //     '2',
                //     //     '3',
                //     //     '4',
                //     //     '5',
                //     //     '6',
                //     //     '7',
                //     //     '8',
                //     //     '9',
                //     //     '10'
                //     //   ],
                //     //       value: MaxMembervalue,
                //     //       controller: MaxMemberController,
                //     //       lableText: 'Max Members for Trip'),
                //     // ),
                //     // SizedBox(
                //     //   width: width(context) * 0.44,
                //     //   child: CustomDropDownButton(
                //     //       itemList: ['For him/her self',' Trip host','Except trip host'],
                //     //       value: spendvalue,
                //     //       controller: SpendsController,
                //     //       lableText: 'How spends distributed?'),
                //     // )
                //   ],
                // )
              ],
            )),
        Step(
            state: StepState.complete,
            isActive: _activeCurrentStep >= 3,
            label: const Text('Publish'),
            title: const SizedBox(),
            content: Column(
              children: [
                Obx(() => isThirdStepOn.value
                    ? Container(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        height: height(context) * 0.11,
                        width: width(context),
                        decoration: shadowDecoration(10, 2),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("Prima_Trip_Plan")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                            if (snapshot.hasData) {
                              // printc("${snapshot.data == null}", "y");
                              // printc(snapshot.data!.data()!['friends']);
                              List tripFriendsList = snapshot.data!.data()!['friends'] ?? [];
                              print(tripFriendsList);
                              return Wrap(
                                children: [
                                  Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(100)),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: image == ""
                                              ? BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/prima3.png')))
                                              : BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(image))),

                                          // myFillBoxDecoration(
                                          //     0, black.withOpacity(0.2), 50),
                                        ),
                                      ),
                                      Text('Host'),
                                    ],
                                  ),
                                  for (int index = 0; index < tripFriendsList.length; index++)
                                    Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(100)),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: tripFriendsList[index]['image'] == ""
                                                ? BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/prima3.png')))
                                                : BoxDecoration(
                                                    image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(tripFriendsList[index]['image']))),

                                            // myFillBoxDecoration(
                                            //     0, black.withOpacity(0.2), 50),
                                          ),
                                        ),
                                        Text('${tripFriendsList[index]['name']}'),
                                      ],
                                    ),
                                  addHorizontalySpace(10),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => selectTripFriendPage(
                                                        title: 'Select Friend',
                                                      )));
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: myFillBoxDecoration(0, primary, 50),
                                          child: Icon(
                                            Icons.person_add,
                                            color: black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  addHorizontalySpace(8),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Trip Member',
                                          style: bodyText14normal(color: black.withOpacity(0.4)),
                                        ),
                                        Text(
                                          '${tripFriendsList.length}/ ${maxmember} added',
                                          style: bodyText14w600(color: black),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      )
                    : SizedBox()),
                addVerticalSpace(15),
                if (member == "Public")
                  SizedBox(
                    width: width(context) * 0.8,
                    child: Text(
                      'Others can see your profile, and this trip and request you to join.',
                      style: bodyText14w600(color: black),
                    ),
                  )
                else
                  SizedBox(
                    width: width(context) * 0.8,
                    child: Text(
                      'Your trip friends can see your profile, and this trip and request you to join.',
                      style: bodyText14w600(color: black),
                    ),
                  ),

                // Row(
                //   children: [
                //     Checkbox(
                //         activeColor: primary,
                //         checkColor: black,
                //         value: isChecked,
                //         onChanged: (val) {
                //           isChecked = val!;
                //           setState(() {});
                //         }),
                //     Text('Create a chat room')
                //   ],
                // ),
                addVerticalSpace(height(context) * 0.2)
              ],
            ))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50), child: CustomAppBar(title: 'Plan and Publish your trip')),
      body: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primary,
              ),
        ),
        child: Stepper(
          elevation: 0,
          margin: EdgeInsets.zero,
          controlsBuilder: (BuildContext context, ControlsDetails, {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
            return Column(
              children: [
                addVerticalSpace(40),
                _activeCurrentStep == 0 | 1 | 2
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addHorizontalySpace(50),
                          InkWell(
                            onTap: () async {

                              showAPICallPendingDialog(context);
                              prima_trip_publish_send_model model=prima_trip_publish_send_model(
                                days: days1.toString(),
                                endDate: endDate.text,
                                image: "",
                                maxMembers: maxmember,
                                tripType: type_of_trip1,
                                startDate: startDate.text,
                                tripMembers: member,
                                userId: USER_ID.toString(),
                                whereTo: "${UserCity}",
                              );
                              ApiHelper.prima_publish_Apicall(model: model);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => PrimaTrip1To4Screens(
                                            hostUid: FirebaseAuth.instance.currentUser!.uid,
                                            isHost: true,
                                          )));


                            },
                            child: Container(
                              height: 40,
                              width: width(context) * 0.4,
                              decoration: myFillBoxDecoration(0, primary, 10),
                              child: const Center(
                                child: Text('Publish'),
                              ),
                            ),
                          )
                        ],
                      )
                    : CustomButton(
                        name: 'Save and Proceed',
                        onPressed: () async {
                          if (_activeCurrentStep < (stepList().length - 1)) {
                            switch (_activeCurrentStep) {
                              case 0:
                                {
                                  bool allFill = true;
                                  if (selectedTypeOfPrimaTrip == "Select") {
                                    showSimpleTost(context, txt: "Please Select Type");
                                    allFill = false;
                                  }
                                  if (selectedCityOfPrimaTrip == "Select") {
                                    showSimpleTost(context, txt: "Please Select City");
                                    allFill = false;
                                  }
                                  if (totalDays < 0) {
                                    showSimpleTost(context, txt: "Please Select Days");
                                    allFill = false;
                                  }

                                  // if (coverpicImage == "") {
                                  //   showSimpleTost(context, txt: "Please Select Cover Pic");
                                  //   allFill = false;
                                  // }



                                  // if (specitTripNameController.text == "") {
                                  //   showSimpleTost(context, txt: "Please Fill Trip name");
                                  //   allFill = false;
                                  // }

                                  if (allFill) {
                                    print("object-000000");
                                    // await getPrimaTripData();
                                    // await addPublishTripDetails();
                                    dataSecondPageLodedCount.value=false;
                                    showAPICallPendingDialog(context);
                                    PrimaTouristSpot.clear();
                                 //   PrimaTouristSpot.add( await ApiHelper.get_prima_spot_api_call(city: selectedCityOfPrimaTrip,type: selectedTypeOfPrimaTrip));
                                    Navigator.pop(context);
                                    dataSecondPageLodedCount.value=true;
                                    setState(() {
                                      //dataSecondPageLodedCount = 0;
                                      _activeCurrentStep += 1;
                                    });
                                  }

                                  break;
                                }
                              //   addStep1PublishTripDetails();

                              case 1:
                                {
                                  bool allFill = true;
                                  print("lenth spot ---${selectedTouristSpot.where((element) => element.value).toList().length}");
                                  if (selectedTouristSpot.where((element) => element.value).toList().length < 1) {
                                    showSimpleTost(context, txt: "Please Select At least 1 Spot ");
                                    allFill = false;
                                  }

                                  if (DoInTripController.text.length < 100) {
                                    showSimpleTost(context, txt: "Please Type Discription atleast 100 charactor");
                                    allFill = false;
                                  }
                                  if (allFill) {
                                    setState(() {
                                      //dataSecondPageLodedCount = 0;
                                      _activeCurrentStep += 1;
                                    });
                                  }
                                  break;
                                }
                              case 2:
                                {
                                  if (seetripvalue == "Select" && MaxMembervalue == "Select" && spendvalue == "Select") {
                                    showSimpleTost(context, txt: "Please Select All Details");
                                  } else {
                                    showAPICallPendingDialog(context);

                                    await addStep2PublishTripDetails();
                                    await addStep3PublishTripDetails();

                                    Navigator.pop(context);
                                    setState(() {
                                      //dataSecondPageLodedCount = 0;
                                      _activeCurrentStep += 1;
                                    });
                                    isThirdStepOn.value = true;
                                  }
                                }
                            }
                          }
                        }),
              ],
            );
          },
          type: StepperType.horizontal,
          currentStep: _activeCurrentStep,
          steps: stepList(),
          //
          // onStepContinue: () {
          //   if (_activeCurrentStep < (stepList().length - 1)) {
          //     setState(() {
          //       _activeCurrentStep += 1;
          //     });
          //   }
          // },

          // onStepCancel: () {
          //   if (_activeCurrentStep == 0) {
          //     return;
          //   }
          //
          //   setState(() {
          //     _activeCurrentStep -= 1;
          //   });
          // },
          // onStepTap allows to directly click on the particular step we want
          // onStepTapped: (int index) {
          //   setState(() {
          //     _activeCurrentStep = index;
          //   });
          // },
        ),
      ),
    );
  }

  Future<void> getPrimaTripData() async {
    //log('---------');
    // Get docs from collection reference
    CollectionReference tripCityRef =
        FirebaseFirestore.instance.collection("Prima Tourist Spot").doc(selectedTypeOfPrimaTrip).collection(selectedCityOfPrimaTrip);

    print("${selectedTypeOfPrimaTrip}  --- ${selectedCityOfPrimaTrip}");

    QuerySnapshot querySnapshot = await tripCityRef.get();
    // Get data from docs and convert map to List
    //  print('---------${querySnapshot.docs[0].data()}');
    cityTripData = querySnapshot.docs.map((doc) => doc.data()).toList();
    selectedTouristSpot = List.generate(cityTripData.length, (index) => false.obs);
    print(cityTripData);

    dataSecondPageLodedCount.value = true;
    // setState(() {});
  }
}

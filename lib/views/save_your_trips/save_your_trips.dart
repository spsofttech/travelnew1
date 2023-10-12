import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/humburger_flow/upcoming_trips.dart';
import 'package:travelnew_app/views/publish%20your%20trip/step1.dart';
import 'package:travelnew_app/views/publish%20your%20trip/step2.dart';
import 'package:travelnew_app/views/save_your_trips/save_trip_step_1.dart';
import 'package:travelnew_app/views/save_your_trips/save_trip_step_2.dart';
import 'package:travelnew_app/views/save_your_trips/save_trip_step_3.dart';
import 'package:travelnew_app/widget/custom_appbar.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/widget/custom_dropdown_button.dart';
import 'package:travelnew_app/widget/custom_textfield.dart';

import '../../Api/ApiModel.dart';
import '../../Api/Api_Helper.dart';
import '../../Api/model/cteate_new_trip_model.dart';
import '../../model/DayWiseTripModel.dart';
import '../../model/prima_profile_model.dart';
import '../../widget/my_bottom_navbar.dart';
import '../home/plan_trip_screen.dart';

List<Map<String, String>> tripdataForStore = [];
String targetState = '';
String targetType = '';
List<List<DayTripModel>> finalDataMain = [];
List<DayTripModel> smapleData = [];
RxString trip_city_name = "".obs;
double trip_citi_lat = 0;
double trip_citi_long = 0;
RxMap travel_by_data = {}.obs;
int TRIP_ID =0;
int TRIP_Search_ID =0;

class SaveYourTripsScreen extends StatefulWidget {
  final String type_Of_Trip;
  final String plamTrip_at;
  final int trip_days;
  final List interestList;
  final Map storedDataMap;

  const SaveYourTripsScreen(
      {
        Key? key,
      this.type_Of_Trip = 'Friends Trip',
      this.plamTrip_at = "Karnataka",
      this.trip_days = -1,
      this.interestList = const [""],
      this.storedDataMap = const {}}
      )
      : super(key: key);

  @override
  _SaveYourTripsScreenState createState() => _SaveYourTripsScreenState();

}

class _SaveYourTripsScreenState extends State<SaveYourTripsScreen> {
  // we have initialized active step to 0 so that
  // our stepper widget will start from first step

  int _activeCurrentStep = 0;

  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();


  List<Step> stepList() => [
        Step(
            state: _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeCurrentStep >= 0,
            label: const Text('Sightseeing'),
            title: const SizedBox(),
            content: SaveTripStep1(trip_days: widget.trip_days, plamTrip_at: widget.plamTrip_at, type_Of_Trip: widget.type_Of_Trip, interestList: widget.interestList)),
        Step(
            state: StepState.complete,
            isActive: _activeCurrentStep >= 1,
            label: const Text('Mode of Travel'),
            title: const SizedBox(),
            content: SaveTripStep2()),
        Step(
            state: StepState.complete,
            isActive: _activeCurrentStep >= 2,
            label: const Text('Travel detail'),
            title: const SizedBox(),
            content: SaveTripStep3())
      ];


  @override
  void initState() {
    Map map = widget.storedDataMap;
    if (map.isNotEmpty) {
      type_of_trip1 = map['type_Of_Trip'];
      planTrip_at_ = map['plamTrip_at'];
      totalDays = map['trip_days'];
      usereTripIntrest = map['interestList'];
      startDate.text = map['date'];
      startDate.text = map['StartDate'];
      endDate.text = map['EndDate'];
      trip_mode = map['tripmode'];
      totalDays = map['totalDays'];
      flexible = map['Flexible'];
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50), child: CustomAppBar(title: 'Save Your Trip')),
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
                _activeCurrentStep == 2
                    ? SizedBox(
                        width: width(context) * 0.55,
                        child: CustomButton(
                            name: 'Submit',
                            onPressed: () async {
                              showAPICallPendingDialog(context);
                              create_new_Trip_send_model model=create_new_Trip_send_model(
                                  bookingId:bookingId1.toString() ,
                                adult: int.parse(adults_cnt),
                                children:  int.parse(children_cnt),
                                date: startDate.text??"0",
                                hotelType: hotaltype,
                                includes: incl1??"0",
                                searchedId: TRIP_Search_ID.toString(),
                                days: widget.trip_days,
                              );
                              await ApiHelper.create_new_trip_Apicall(model: model);
                              // updatePlanTrip();
                              // addupcomingtrip();
                              Navigator.pop(context);

                              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MyBottomBar(),), (route) => false);
                           //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UpcomingTripsScreen()));
                            }),
                      )
                    : SizedBox(
                        width: width(context) * 0.55,
                        child: CustomButton(
                            name: 'Continue',
                            onPressed: () {
                              if (_activeCurrentStep < (stepList().length - 1)) {
                                setState(() {
                                  _activeCurrentStep += 1;
                                });
                              }
                            }),
                      ),
              ],
            );
          },
          type: StepperType.horizontal,
          currentStep: _activeCurrentStep,
          steps: stepList(),

          // onStepContinue: () {
          //   if (_activeCurrentStep < (stepList().length - 1)) {
          //     setState(() {
          //       _activeCurrentStep += 1;
          //     });
          //   }
          // },
          //

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
          onStepTapped: (int index) {
            setState(() {
              _activeCurrentStep = index;
            });
          },
        ),
      ),
    );
  }
}

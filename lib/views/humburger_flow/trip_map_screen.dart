import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/widget/custom_appbar.dart';
import 'package:travelnew_app/widget/custom_button.dart';
import 'package:travelnew_app/widget/my_bottom_navbar.dart';

class TripMapScreen extends StatefulWidget {
  const TripMapScreen({super.key});

  @override
  State<TripMapScreen> createState() => _TripMapScreenState();
}

class _TripMapScreenState extends State<TripMapScreen> {
  final List daysList = ['Day 1', 'Day 2', 'Day 3', 'Day 4'];
  int currentIndex = 0;
  int _activeCurrentStep = 0;

  List<Step> stepList() => [
        Step(
            state: _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
            isActive: _activeCurrentStep >= 0,
            title: const Text('Udupi City'),
            // title: const SizedBox(),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(''), addVerticalSpace(10), Text('10 minutes drive')],
            ),
            content: const SizedBox()),
        Step(
            state: _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeCurrentStep >= 1,
            title: const Text('Sri Krishna Math'),
            // title: const SizedBox(),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Brahmagiri, Udupi',
                  style: bodyText14normal(color: black),
                ),
                addVerticalSpace(10),
                Text('1 hour 10 minutes drive')
              ],
            ),
            content: const Text('')),
        Step(
          state: StepState.complete,
          isActive: _activeCurrentStep >= 2,
          title: const Text('Agumbe Beach'),
          // title: const SizedBox(),
          content: Text(''),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Agumbe,Udupi',
                style: bodyText14normal(color: black),
              ),
              addVerticalSpace(10),
              Text('2 hour drive')
            ],
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeCurrentStep >= 3,
          title: const Text('Gometeshwar Statues'),
          // title: const SizedBox(),

          content: SizedBox(),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Karkala, Udupi',
                style: bodyText14normal(color: black),
              ),
              addVerticalSpace(10),
              Text('1 hour 30 minutes')
            ],
          ),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child: CustomAppBar(title: 'Trip Schedule'), preferredSize: Size.fromHeight(50)),
      body: Column(
        children: [
          Text(
            'Udupi, Karnataka',
            style: bodyText20w700(color: black),
          ),
          addVerticalSpace(10),
          Text('Family Trip - Feb 14 2022 to Feb 22 2022'),
          Padding(
            padding: const EdgeInsets.all(37.0),
            child: SizedBox(
              height: 30,
              child: ListView.builder(
                  itemCount: daysList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (Ctx, i) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            currentIndex = i;
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 25,
                            width: width(context) * 0.16,
                            decoration: currentIndex == i ? myFillBoxDecoration(0, primary, 6) : myFillBoxDecoration(0, white, 6),
                            child: Center(child: Text(daysList[i])),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
          Theme(
            data: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: primary,
                  ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, left: 10),
                  height: height(context) * 0.36,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        width: width(context) * 0.23,
                        decoration: myFillBoxDecoration(0, primary, 50),
                        child: Center(
                          child: Text(
                            'Start',
                            style: bodyText14w600(color: black),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: width(context) * 0.23,
                        decoration: myFillBoxDecoration(0, primary, 50),
                        child: Center(
                          child: Text(
                            'End',
                            style: bodyText14w600(color: black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.6,
                  width: width(context) * 0.5,
                  child: Stepper(
                    physics: NeverScrollableScrollPhysics(),
                    elevation: 0,
                    // margin: EdgeInsets.all(20),

                    controlsBuilder: (
                      BuildContext context,
                      ControlsDetails,
                    ) {
                      return SizedBox();
                    },
                    type: StepperType.vertical,
                    currentStep: _activeCurrentStep,
                    steps: stepList(),

                    onStepContinue: () {
                      if (_activeCurrentStep < (stepList().length - 1)) {
                        setState(() {
                          _activeCurrentStep += 1;
                        });
                      }
                    },

                    onStepCancel: () {
                      if (_activeCurrentStep == 0) {
                        return;
                      }

                      setState(() {
                        _activeCurrentStep -= 1;
                      });
                    },

                    // onStepTap allows to directly click on the particular step we want
                    onStepTapped: (int index) {
                      setState(() {
                        _activeCurrentStep = index;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          CustomButton(
              name: 'Save your trip',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TravelNewBookingConfirm()));
              }),
          addVerticalSpace(30)
        ],
      ),
    );
  }
}

class TravelNewBookingConfirm extends StatelessWidget {
  const TravelNewBookingConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height(context) * 0.43,
            width: double.infinity,
            decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/temple.png'))),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TravelNew booking',
                  style: bodyText18w600(color: black),
                ),
                addVerticalSpace(5),
                const Text('Hey Alexander, Thank you for your booking request . Our certified travel guide(s) will approach you'),
                addVerticalSpace(height(context) * 0.07),
                Center(
                  child: SizedBox(
                    width: width(context) * 0.35,
                    height: 40,
                    child: CustomButton(
                        name: 'Home',
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyBottomBar()));
                        }),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

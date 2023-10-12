import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utils/constant.dart';
import '../../../widget/custom_appbar.dart';

class TravelSafeScree extends StatefulWidget {
  const TravelSafeScree({super.key});

  @override
  State<TravelSafeScree> createState() => _TravelSafeScreeState();
}

class _TravelSafeScreeState extends State<TravelSafeScree> {
  @override
  void initState() {
    getTravelSafety();
    // TODO: implement initState
    super.initState();
  }

  List chipList = [
    'Waterfall',
    'Museum',
    'Religious Place ',
    'Lakes & Reservoir',
    'Wildlife Safari',
    'Scuba diving ',
    'Hills and trek',
    'Birds watching',
    'Beach',
    'Monuments',
    'Caves',
    'Road trip',
    'Rented vehicles',
    'Uncivilized places',
    'Meet new friends',
    'Health Emergency',
    'Traveling alone',
    'Women/Child Safe',
  ];
  final List instruction = [
    ' Check weather before visiting, some waterfall are dried if not raining',
    ' Local authority levy restriction visiting',
    ' Some Forest area are protected and requires permission',
    ' Wear sturdy hiking shoes or boots',
    ' Using drugs and/or alcohol invites accidents',
    ' Stay on developed trails. Do not stray from observation decks and platforms.',
    ' Pay attention to warning signs and rules posted near waterfalls',
    ' Never climb on or around waterfalls',
    ' Never jump off waterfalls or dive into plunge pools.',
    ' Supervise children carefully.',
    ' Never play in the stream or river above a waterfall',
    ' Do not use pollutants in streams or springs',
    ' Respect others privacy and don’t over-show yourself in front of others ',
    ' Water force can push swimmers into or under underwater ledges',
    ' Do not visit at nigh',
  ];

  Map<String, dynamic>? allInstructs = {};

  getTravelSafety() async {
    var x = await FirebaseFirestore.instance
        .collection('helpAndSafety')
        .doc('TravelSafety')
        .get();
    allInstructs = x.data();
    print(allInstructs);
    getInstructions();
  }

  getInstructions() async {
    instruction.clear();
    List x = allInstructs?[chipList[selectedIndex]]['information'];
    for (var element in x) {
      instruction.add(element);
    }
    setState(() {});
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(title: 'Travel Safe')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height(context) * 0.35,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: chipList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 2.8),
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = i;
                          getInstructions();
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: height(context) * 0.045,
                        width: width(context) * 0.3,
                        decoration: selectedIndex == i
                            ? myFillBoxDecoration(0, primary, 50)
                            : myOutlineBoxDecoration(2, primary, 50),
                        child: Center(
                          child: Text(
                            chipList[i],
                            style: bodytext12Bold(color: black),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            addVerticalSpace(10),
            SizedBox(
              height: height(context) * 0.57,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: instruction.length,
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            height: 8,
                            width: 8,
                            decoration: myFillBoxDecoration(0, black, 30),
                          ),
                          SizedBox(
                            width: width(context) * 0.92,
                            child: Text(
                              instruction[i],
                              textAlign: TextAlign.start,
                              softWrap: true,
                              style: bodyText14w600(spacing: 1.3, color: black),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            addVerticalSpace(25),
          ],
        ),
      ),
    );
  }
}

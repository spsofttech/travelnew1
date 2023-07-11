import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/aspired_trip/feedback_page.dart';

import '../../../widget/custom_appbar.dart';

class HelpScreen extends StatefulWidget {
  HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  getFAQs() async {
    var x = await FirebaseFirestore.instance.collection('helpAndSafety').doc('FAQs').get();
    var sortedByKeyMap = Map.fromEntries(x.data()!.entries.toList()..sort((e1, e2) => int.parse(e1.key).compareTo(int.parse(e2.key))));
    sortedByKeyMap.forEach((key, value) {
      faqsList.add(value);
    });
    // print(faqsList);
    setState(() {});
  }

  @override
  void initState() {
    getFAQs();
    // TODO: implement initState
    super.initState();
  }

  List<Map<String, dynamic>> faqsList = [];

  int selectedTile = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50), child: CustomAppBar(title: 'Help')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12),
              child: Text(
                'FAQ’s',
                style: bodyText20w700(color: black),
              ),
            ),
            SizedBox(
              // height: height(context) * 1.1,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: faqsList.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Theme(
                          data: ThemeData(),
                          child: ExpansionTile(
                            iconColor: primary,
                            initiallyExpanded: i == selectedTile,
                            onExpansionChanged: ((newState) {
                              if (newState)
                                setState(() {
                                  selectedTile = i;
                                });
                              else
                                setState(() {
                                  selectedTile = -1;
                                });
                            }),
                            title: Text(
                              faqsList[i]['question'] ?? " ",
                              style: TextStyle(fontSize: 18, color: black),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(faqsList[i]['answer'] ?? " "),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          height: 0,
                          thickness: 1,
                        )
                      ],
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, right: 12.0, bottom: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (ctx) => FeedBackPage()));
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(text: 'Didn’t find answer?', style: bodyText14normal(color: black)),
                    TextSpan(text: ' Share feedback', style: bodyText14normal(color: primary))
                  ])),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

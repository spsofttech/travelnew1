import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app/utils/constant.dart';

import '../../../widget/custom_appbar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(title: 'Privacy Policy')),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Introduction',
                              style: bodyText18w600(color: black),
                            ),
                            addVerticalSpace(5),
                            Text(
                              "We won’t be able to respond to your suggestions personally, but we assure you that your input reaches the appropriate team for editing the existing information in our platform.We won’t be able to respond to your suggestions personally, but we assure you that your input reaches the appropriate team for editing the existing information in our platform. We won’t be able to respond to your suggestions personally, but we assure you that your input reaches the appropriate team for editing the existing information in our platform. We won’t be able to respond to your suggestions personally, but we assure you that your input reaches the appropriate team for editing the existing information in our platform.We won’t be able to respond to your suggestions personally, but we assure you that your input reaches the appropriate team for editing ",
                              style:
                                  bodyText12Small(spacing: 1.5, color: black),
                            ),
                          ]),
                    );
                  }))
        ],
      ),
    );
  }
}

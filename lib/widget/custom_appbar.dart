import 'package:flutter/material.dart';

import '../utils/constant.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: white,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          )),
      title: Text(
        title,
        style: bodyText20w700(color: black),
      ),
      actions: [],
    );
  }
}

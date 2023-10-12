import 'dart:developer';

import 'package:flutter/material.dart';

import '../utils/constant.dart';

class CustomButton extends StatelessWidget {
  double hh;
  double ww;
  CustomButton({required this.name, required this.onPressed, this.hh = 0, this.ww = 0});

  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    hh = hh == 0 ? height(context) * 0.05 : hh;
    ww = ww == 0 ? width(context) * 0.95 : ww;

    // log("---------   ---${ww}");
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: ww,
        height: hh,
        decoration: myFillBoxDecoration(0, primary, 10),
        child: Center(
          child: Text(
            name,
            style: bodyText16w600(color: black),
          ),
        ),
      ),
    );
  }
}

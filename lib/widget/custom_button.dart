import 'package:flutter/material.dart';

import '../utils/constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({required this.name, required this.onPressed});

  final String name;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height(context) * 0.05,
        width: width(context) * 0.95,
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

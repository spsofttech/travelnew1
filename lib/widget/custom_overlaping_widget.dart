import 'package:flutter/material.dart';

import '../utils/constant.dart';

class OverlapingImageCustomWidget extends StatelessWidget {
  const OverlapingImageCustomWidget({
    Key? key,
    required this.overlap,
  }) : super(key: key);

  final List overlap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width(context) * 0.15,
          child: Row(
            children: [
              for (int i = 0; i < overlap.length; i++)
                Align(
                  widthFactor: 0.5,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: white,
                    backgroundImage: AssetImage(overlap[i]),
                  ),
                ),
            ],
          ),
        ),
        Positioned(
            left: 23,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: white.withOpacity(0.3),
              child: Text(
                '+ 50',
                style: bodyText11Small(color: white),
              ),
            ))
      ],
    );
  }
}

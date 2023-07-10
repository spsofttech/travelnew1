import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utils/constant.dart';
import '../../../widget/custom_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: CustomAppBar(title: 'Notification'),
          preferredSize: Size.fromHeight(50)),
      body: SizedBox(
        height: height(context) * 0.87,
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (ctx, i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/inbox1.png'),
                    ),
                    title: Text(
                      'TravelNew booking',
                      style: bodyText18w600(color: black),
                    ),
                    subtitle: Text(
                      'Hey Alexander, Thank you for y.....',
                      style: bodyText12Small(color: black),
                    ),
                    trailing: Text(
                      '10:00am',
                      style: bodyText12Small(color: black),
                    ),
                  ),
                  const Divider(
                    height: 5,
                    thickness: 1,
                  ),
                  if (i == 4)
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, top: 8, bottom: 5),
                      child: Text(
                        'Yesterday',
                        style: bodyText14w600(color: black.withOpacity(0.4)),
                      ),
                    ),
                  if (i == 6)
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, top: 8, bottom: 5),
                      child: Text(
                        '12 Aug 2020',
                        style: bodyText14w600(color: black.withOpacity(0.4)),
                      ),
                    )
                ],
              );
            }),
      ),
    );
  }
}

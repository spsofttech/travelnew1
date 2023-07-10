import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app/utils/constant.dart';
import 'package:travel_app/widget/custom_appbar.dart';

class SaveCardScreen extends StatelessWidget {
  const SaveCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: CustomAppBar(title: 'My card'),
          preferredSize: Size.fromHeight(50)),
      body: Column(
        children: [
          addVerticalSpace(20),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            height: height(context) * 0.11,
            width: width(context) * 0.95,
            decoration: shadowDecoration(3, 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Save Cards',
                  style: bodyText16w600(color: black),
                ),
                addVerticalSpace(10),
                const Text(
                    'Save tour Credit/Debit cards for faster payments. Your cards are secure with us.')
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            height: height(context) * 0.11,
            width: width(context) * 0.95,
            decoration: shadowDecoration(3, 3),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: white,
                child: Image.asset('assets/images/paytm.png'),
              ),
              title: Text(
                'Paytm UPI',
                style: bodyText16w600(color: black),
              ),
              subtitle: Text('12345@paytm'),
            ),
          )
        ],
      ),
    );
  }
}

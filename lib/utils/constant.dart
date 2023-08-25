import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//--------------------------------------------------  ADMIN -------------------------------------------------------
//
// const List<String> travelNewTripState = [
//   'Select',
//   'Tripura',
//   'Gujarat',
//   'Mizoram',
//   'Punjab',
//   'Uttar Pradesh',
//   'Uttrakhand',
//   'Karnataka',
//   'Madhya Pradesh',
//   'Odisha',
//   'Himachal Pradesh',
//   'Chandigarh',
//   'Delhi',
//   'Sikkim',
//   'Assam',
//   'Telangana',
//   'Rajasthan',
//   'Maharashtra',
//   'Andhra Pradesh',
//   'Haryana',
//   'Kerala',
//   'Madhya Pradesh',
//   'Manipur',
//   'Bihar',
//   'West Bengal',
//   'Jammu and Kashmir',
//   'Tamil Nadu'
// ];
//
// const List<String> travelNewTripSubType = [
//   'Select',
//   'Adventure Trip',
//   'Couple Trip',
//   'Family Trip',
//   'Friends Trip',
//   'Religious trips',
// ];

//-----------------------------------------------------------------------------------------------------------------
double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

bool isToggle = false;
bool isPremium = false;
bool isPosition = false;
// for gradient
Color ligthYellow = const Color.fromRGBO(255, 199, 44, 1);
Color darkYellow = const Color.fromRGBO(234, 43, 31, 1);

// for custom
const Color primary = Color.fromRGBO(255, 199, 44, 1);

Color white = Colors.white;

Color black = Colors.black;

// only gradient
// Gradient redGradient() {
//   return LinearGradient(
//     colors: [ligthRed, darkRed, darkRed, darkRed, darkRed2],
//     begin: Alignment.centerLeft,
//     end: Alignment.centerRight,
//   );
// }

// only gradient
Gradient YellowGradient() {
  return LinearGradient(
    colors: [ligthYellow, darkYellow],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

Gradient yellowBlackGradient() {
  return const LinearGradient(
    colors: [
      Color.fromRGBO(255, 199, 44, 2),
      Color.fromRGBO(255, 199, 44, 1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

// Gradient decorations
BoxDecoration gradientBoxDecoration(Gradient gradient, double radius) {
  return BoxDecoration(
    gradient: gradient,
    borderRadius: BorderRadius.all(Radius.circular(radius) //
        ),
  );
}

//box decoration with border colors only
BoxDecoration myOutlineBoxDecoration(double width, Color color, double radius) {
  return BoxDecoration(
    border: Border.all(width: width, color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius) //
        ),
  );
}

//box decoration with fill box colors
BoxDecoration myFillBoxDecoration(double width, Color color, double radius) {
  return BoxDecoration(
    color: color,
    border: Border.all(width: width, color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius) //
        ),
  );
}

TextStyle bodyText14w600({required Color color, double? spacing}) {
  return TextStyle(height: spacing, fontSize: 14, color: color, fontWeight: FontWeight.w600);
}

TextStyle bodyText14normal({required Color color, double? spacing}) {
  return TextStyle(
    height: spacing,
    fontSize: 14,
    color: color,
  );
}

TextStyle bodyText16normal({double? spacing, required Color color}) {
  return TextStyle(
    fontSize: 16,
    height: spacing,
    color: color,
  );
}

TextStyle bodyText13normal({required Color color, double? spacing}) {
  return TextStyle(
    height: spacing,
    fontSize: 13,
    color: color,
  );
}

TextStyle bodyText16w600({
  required Color color,
  double? spacing,
}) {
  return TextStyle(height: spacing, fontSize: 16, color: color, fontWeight: FontWeight.w700);
}

TextStyle bodyText18w600({required Color color}) {
  return TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.w700);
}

// small Size
TextStyle bodyText12Small({required Color color, double? spacing}) {
  return TextStyle(fontSize: 12, height: spacing, color: color, fontWeight: FontWeight.w400);
}

TextStyle bodyText11Small({required Color color}) {
  return TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w400);
}

TextStyle bodytext12Bold({
  required Color color,
  double? spacing,
}) {
  return TextStyle(height: spacing, fontSize: 12, color: color, fontWeight: FontWeight.w600);
}

TextStyle bodyText20w700({required Color color}) {
  return TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.bold);
}

TextStyle bodyText22w700({required Color color}) {
  return TextStyle(fontSize: 22, color: color, fontWeight: FontWeight.bold);
}

TextStyle bodyText30W600({required Color color}) {
  return TextStyle(fontSize: 30, color: color, fontWeight: FontWeight.w700);
}

TextStyle bodyText30W400({required Color color}) {
  return TextStyle(
    fontSize: 30,
    color: color,
  );
}

void printc(txt, [String clr = '']) {
  String Clr = clr == 'b'
      ? '\x1B[30m'
      : clr == 'r'
          ? '\x1B[31m'
          : clr == 'g'
              ? '\x1B[32m'
              : clr == 'y'
                  ? '\x1B[33m'
                  : clr == 'bl'
                      ? '\x1B[34m'
                      : clr == 'm'
                          ? '\x1B[35m'
                          : clr == 'c'
                              ? '\x1B[36m'
                              : clr == 'w'
                                  ? '\x1B[37m'
                                  : '\x1B[34m';

  print('$Clr${txt}\x1B[0m');
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf = "";
  String secondHalf = "";

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(150, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              children: <Widget>[
                Text(
                  flag ? ("$firstHalf...") : (firstHalf + secondHalf),
                  style: TextStyle(color: black),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? "show more" : "show less",
                        style: const TextStyle(color: primary),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}

void showAPICallPendingDialog(context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  backgroundColor: Colors.yellow,
                ),
              ],
            ),
          ),
        );
      });
}

showSimpleTost(
  context, {
  Color txtColor = Colors.black,
  Color backGround = const Color.fromRGBO(255, 199, 44, 1),
  required String txt,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      "${txt}",
      style: TextStyle(color: txtColor),
    ),
    backgroundColor: backGround,
  ));
}

// box decoration with Boxshadow
BoxDecoration shadowDecoration(double radius, double blur) {
  return BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(radius)), color: Colors.white, boxShadow: [
    BoxShadow(
      color: Colors.grey,
      blurRadius: blur,
    ),
  ]);
}

Widget addVerticalSpace(double height) {
  return SizedBox(height: height);
}

Widget addHorizontalySpace(double width) {
  return SizedBox(width: width);
}

String UserCity = "";
String UserState = "";

// const kTextFieldDecoration = InputDecoration(
//   prefix: Text(
//     '    +91  ',
//     style: TextStyle(color: Colors.white, fontSize: 18),
//   ),
//   contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.white, width: 1.0),
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide: BorderSide(color: Colors.white, width: 2.0),
//     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//   ),
// );

// -------------------------------------------   User Info Const ---------------------------------

String USERNAME = "";
String USERIMAGE = "";
String USER_UID = "";
int USER_ID =-1;
double USER_lat = 0;
double USER_long = 0;
String NoUserNetworkImage = "https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_1280.png";
Map<String, dynamic> UserDataMap = {};
bool USER_IS_PRIMA = false;

import 'package:flutter/material.dart';

import '../utils/constant.dart';

class CustomDropDownButton extends StatefulWidget {
  CustomDropDownButton(
      {super.key,
      required this.itemList,
      this.lableText,
      TextEditingController? controller,
      this.value});
  final List<String> itemList;
  final value;
  final lableText;
  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.85,
      height: 45,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: white),
                borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: white),
                borderRadius: BorderRadius.circular(15)),
            border: InputBorder.none,
            labelStyle: bodyText12Small(color: black),
            label: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Container(
                    height: 20,
                    // width: width(context) * 0.35,
                    decoration: myFillBoxDecoration(0, white, 20),
                    child: Center(
                      child: Text(
                        widget.lableText,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            fillColor: Color.fromRGBO(241, 241, 241, 1),
            filled: true,
            contentPadding: EdgeInsets.only(left: 12, right: 4, top: 5)),
        hint: Text(
          '--Select--',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: black),
        ),
        items: widget.itemList
            .map<DropdownMenuItem<String>>(
                (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
            .toList(),
        value: selectedItem,
        onChanged: (newValue) {
          setState(() {
            selectedItem = newValue!;
          });
        },
      ),
    );
  }
}

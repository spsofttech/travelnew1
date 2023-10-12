import 'package:flutter/material.dart';
import 'package:travelnew_app/services/db/firebaseDB.dart';

import '../utils/constant.dart';

class AccountDropdown extends StatefulWidget {
  Future<void>? onChanged;
  List<String> settingList;
  final String privacyList;
  String subTitle;
  AccountDropdown({super.key, required this.privacyList, required this.subTitle, this.onChanged, required this.settingList});

  @override
  State<AccountDropdown> createState() => _AccountDropdownState();
}

class _AccountDropdownState extends State<AccountDropdown> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            widget.privacyList,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          subtitle: SizedBox(
            height: 30,
            child: DropdownButton<String>(
              value: widget.subTitle,
              isExpanded: true,
              onChanged: (newValue) async {
                setState(() {
                  widget.subTitle = newValue!;
                });
                //----To-Update-Who-Can-See-(Value)-----/
                UpdateAccountVisibility().updatePrivacyVisibility(widget.subTitle, widget.privacyList);
              },

              items: widget.settingList
                  .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: bodyText16normal(color: black.withOpacity(0.4)),
                        ),
                      ))
                  .toList(),

              // add extra sugar..
              icon: const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Icon(
                  Icons.arrow_drop_down,
                ),
              ),
              iconSize: 0,
              iconEnabledColor: white,
              iconDisabledColor: white,
              underline: const SizedBox(),
            ),
          ),
        ),
        const Divider(
          height: 0,
          thickness: 1,
        )
      ],
    );
  }
}

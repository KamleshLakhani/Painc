import 'package:flutter/material.dart';
import 'package:painc/Utils/Utils.dart';

import 'cdd.dart';

class CustDropDown extends StatefulWidget {
  final String hinttext;
  final List<String> dropdownitems;
  final ValueChanged<String> onChanged;
  final String choosenvalue;
  final TextStyle textselectionstyle;
  CustDropDown({this.textselectionstyle,this.onChanged,this.choosenvalue,this.hinttext,this.dropdownitems});
  @override
  _CustDropDownState createState() => _CustDropDownState();
}

class _CustDropDownState extends State<CustDropDown> {
  String _chosenValue;
  @override
  Widget build(BuildContext context) {
    return  DropdownButtonHideUnderline(
      child: CustomDropdownButton<String>(
        value: widget.choosenvalue,
        items: widget.dropdownitems.map<DropdownMenuItem<String>>(
                (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,style: widget.textselectionstyle),
              );
            }).toList(),
        hint: Text(
          widget.hinttext,
          style: Utils.googlenunitoreg(16.0, Utils.hintclr),
        ),
        onChanged: widget.onChanged,
        /*onChanged: (String value) {
          setState(() {
            _chosenValue = value;
          });
        },*/
      ),
    );
  }
}

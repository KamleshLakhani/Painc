import 'package:flutter/material.dart';
import 'package:painc/Utils/Utils.dart';

class CustTxtField extends StatelessWidget {
  final String icon;
  final String hinttxt;
  final TextInputType keyboardtype;
  final double icnwidth;
  final double icnheight;
  final TextInputAction textinputaction;
  final ValueChanged onChanged;
  final bool obstext;
  final FormFieldValidator validator;
  final String inival;
  final TextStyle txtstyl;
  final TextEditingController controller;
  CustTxtField({this.txtstyl,this.keyboardtype,this.inival,this.validator,this.controller,this.obstext,this.textinputaction,this.onChanged,this.icon,this.hinttxt,this.icnheight,this.icnwidth});
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Utils.svg(icon,icnheight,icnwidth),
          Utils.sizeBoxWidth(13.0),
          Flexible(child: TextFormField(
initialValue: inival,
            validator: validator,
            controller: controller,
            obscureText: obstext == null ? false : obstext,
            textInputAction: textinputaction,
            keyboardType: keyboardtype,
            onChanged: onChanged,
            style: txtstyl == null ?TextStyle(fontSize: 16) : txtstyl,
            decoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Utils.red)
              ),
              hintText: hinttxt,
              hintStyle: Utils.googlenunitoreg(16.0, Utils.hintclr),
              contentPadding: EdgeInsets.only(bottom:7.0),
              isDense: true,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Utils.bottleclr),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

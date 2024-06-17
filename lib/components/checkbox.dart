import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:painc/Utils/Utils.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {
        FormFieldSetter<bool> onSaved,
        FormFieldValidator<bool> validator,
        bool initialValue = false,
        bool autovalidate = false})
      : super(
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      builder: (FormFieldState<bool> state) {
        return Container(
          width: 20,
          height: 20,/*
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(width:2.5,color: Utils.lightgrey1)
          ),*/
          child: Theme(
            data: ThemeData(
              unselectedWidgetColor:  Colors.black26,
              errorColor: Utils.red
            ),
            child: Checkbox(
                splashRadius: 0.0,
                value: state.value,
                checkColor: Color(0xff0ABC69),
                onChanged: state.didChange
            ),
          ),
        );
      });
}
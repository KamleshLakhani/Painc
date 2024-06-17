import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AllReport extends GetxController{
  bool check1 = false;
  bool check2 = false;
  bool valuefirst = false;
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  var fromddmmmyy;
  var toddmmmyy;
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();

  Future<Null> selectFromDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedFromDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null)
        selectedFromDate = picked;
        dateFromController.text =
            DateFormat('dd-MM-yyyy').format(selectedFromDate);
        fromddmmmyy = DateFormat('dd MMM yy').format(picked);
        update();
  }
  Future<Null> selectToDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedToDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null)
        selectedToDate = picked;
        dateToController.text =
            DateFormat('dd-MM-yyyy').format(selectedToDate);
        toddmmmyy = DateFormat('dd MMM yy').format(picked);
        update();
  }
}

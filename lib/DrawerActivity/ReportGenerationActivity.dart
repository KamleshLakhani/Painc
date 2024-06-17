import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:painc/ApiClass/InsertionStatus.dart';
import 'package:painc/DrawerActivity/ReportIntensityAndMQsReport.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/appbar.dart';
import 'package:painc/components/loader.dart';
import 'package:painc/components/reportcontainer.dart';
import 'package:painc/DrawerActivity/ReportPainIntensityActivity.dart';
import 'package:painc/DrawerActivity/ReportIntensityEnjoymentActivity.dart';
import 'package:path_provider/path_provider.dart';
import 'ReportIntensityAndEnjoymentOfLifeActivity.dart';
import 'ReportIntensityAndGeneralAcivity.dart';
import 'ReportOverallActivity.dart';
import 'package:painc/GetX/reportgeneration.dart';

import 'ViewReport.dart';

class ReportGeneration extends StatefulWidget {
  final bool baselinestatus;
  final String baselinedate;
  ReportGeneration({this.baselinestatus,this.baselinedate});
  @override
  _ReportGenerationState createState() => _ReportGenerationState();
}

class _ReportGenerationState extends State<ReportGeneration> {
  String _setFromDate;
  String _setToDate;
  RxString iosfromdate =''.obs;
  RxString iostodate =''.obs;
  DateTime selectedIOSfromDate = DateTime.now();
  DateTime selectedtoDate = DateTime.now();
  bool submitted = false;
  var tofordb;
  var fromfordb;
  bool check1 = false;
  bool check2 = false;
  bool valuefirst = false;
  DateTime selectedFromDate = DateTime.now();
  DateTime nd;
  DateTime selectedToDate = DateTime.now();
  var fromddmmmyy;
  var toddmmmyy;
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      appBar: CustAppbar(
        txt: 'Trends and Patterns',
        infobtn: false,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 20),
          width: screenwidth,
          height: screenheight,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 30, right: 20),
                height: 60,
                decoration: BoxDecoration(
                    color: Utils.bottleclr,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Baseline reports',
                            style: Utils.boldtxt(18.0, Utils.white)),
                        Text(widget.baselinedate,//'02 Jun, 2020',
                            style: Utils.nunitolight(18.0, Utils.white)),
                      ],
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Utils.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(3.0, 3.0),
                                  blurRadius: 8,
                                  color: Utils.grey.withOpacity(0.2),
                                  spreadRadius: 1)
                            ]),
                        child: Icon(
                          Icons.picture_as_pdf,
                          size: 27.0,
                          color: Utils.red,
                        ),
                      ),
                      onTap: () async{
                        if(widget.baselinestatus == false){
                          print('here');
                          Utils.toast('Report Not Generated', '', Utils.red.withOpacity(.4));
                        }
                        else{
                          showLoadingDialog(context: context);
                          final _pdf = await ResponseClass.callGetApi(ApiSheet.baselinereportdownload);
                          if(_pdf.statusCode == 200){
                            print('here1');
                            String dir = (await getApplicationDocumentsDirectory()).path;
                            File file = new File('$dir/Report.pdf');
                            print('HEREHERER');
                              final _saved = await file.writeAsBytes(_pdf.bodyBytes);
                            print('HEREHERER');
                            print(_saved.path);
                            hideLoadingDialog(context: context);
                            print('HEREHERER');
                            OpenFile.open(_saved.path);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              Utils.sizeBoxHeight(25),
              Container(
                padding: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                    color: Utils.light,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 5,
                          color: Utils.grey.withOpacity(0.1),
                          spreadRadius: 1)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/date.svg',
                                width: 18.0,
                                height: 18.0,
                                color: Utils.bottleclr,
                              ),
                              Utils.sizeBoxWidth(13.0),
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    Platform.isIOS ?
                                    selectFromIOSDate(context) : selectFromDate(context);
                                  },
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 16),
                                    keyboardType: TextInputType.text,
                                    controller: dateFromController,
                                    onSaved: (String val) {
                                      _setFromDate = val;
                                    },
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: 'From',
                                      hintStyle: TextStyle(
                                          color: Utils.grey.withOpacity(.35)),
                                      contentPadding:
                                          EdgeInsets.only(bottom: 7.0),
                                      isDense: true,
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.5,
                                            color: Color(0x44000000)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Utils.sizeBoxWidth(screenwidth*.05),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/date.svg',
                                width: 18.0,
                                height: 18.0,
                                color: Utils.bottleclr,
                              ),
                              Utils.sizeBoxWidth(13.0),
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    dateFromController.text.isBlank  ?
                                    Utils.toast('Please Select First Date', '',Utils.red.withOpacity(.5))
                                        : Platform.isIOS ? selectToIOSDate(context) : selectToDate(context);
                                  },
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 16),
                                    keyboardType: TextInputType.text,
                                    controller: dateToController,
                                    onSaved: (String val) {
                                      _setToDate = val;
                                    },
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: 'To',
                                      hintStyle: TextStyle(
                                          color: Utils.grey.withOpacity(.35)),
                                      contentPadding:
                                          EdgeInsets.only(bottom: 7.0),
                                      isDense: true,
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.5,
                                            color: Color(0x44000000)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Utils.sizeBoxHeight(screenheight*.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                      child: PainCButton(
                        title: 'View Report',
                        onTap: (){
                          if(fromddmmmyy == null || toddmmmyy == null){
                            return showDialog(context: context, builder: (context) => AlertPopUp(description: 'Please Select Dates To Generate Reports'));
                          }else{
                            Get.to(()=>ViewReport(todate: tofordb,fromdate: fromfordb));}
                        },
                        borderColor: Utils.yellow,
                        titleColor: Utils.yellow,
                        spashColor: Utils.yellow,
                        tappedTitleColor: Utils.white,
                      ))
                        ),
                        Utils.sizeBoxWidth(screenwidth*.05),
                        Expanded(
                          child: PainCButton(
                            title: 'Submit', onTap: (){
                            if(fromddmmmyy == null || toddmmmyy == null){
                              return showDialog(context: context, builder: (context) => AlertPopUp(description: 'Please Select Dates To Generate Reports'));
                            }else{
                              setState(() {
                            submitted = true;
                          });}},
                            borderColor: Utils.bottleclr,
                            titleColor: Utils.bottleclr,
                            spashColor: Utils.bottleclr,
                            tappedTitleColor: Utils.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Utils.sizeBoxHeight(25),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ReportContainer(fromdate: fromddmmmyy == null ? ' -- ' :'$fromddmmmyy ', todate: toddmmmyy == null ? ' -- ' :'$toddmmmyy',
                          title: 'Overall',
                          onTap: (){
                        if(fromddmmmyy == null || toddmmmyy == null){
                            return showDialog(context: context, builder: (context) => AlertPopUp(description: 'Please Select Dates To Generate Reports'));
                          }else if (submitted == false){
                          return showDialog(context: context, builder: (context) => AlertPopUp(description: 'Please Click On Submit to fetch Data'));
                          }else{
                            Get.to(()=>ReportOverallActivity(todate: tofordb,fromdate: fromfordb));
                        }}),
                      Utils.sizeBoxHeight(15.0),
                      ReportContainer(fromdate: fromddmmmyy == null ? ' -- ' :'$fromddmmmyy ', todate: toddmmmyy == null ? ' -- ' :'$toddmmmyy',title: 'Pain Intensity',
                          onTap: (){
                            if(fromddmmmyy == null || toddmmmyy == null){
                              return showDialog(context: context, builder: (context) => AlertPopUp(description: 'Please Select Dates To Generate Reports'));
                            }else if (submitted == false){
                              return showDialog(context: context, builder: (context) => AlertPopUp(description: 'Please Click On Submit to fetch Data'));
                            }else{
                              Get.to(()=>ReportPainIntensity(todate: tofordb,fromdate: fromfordb));
                            }}),
                      Utils.sizeBoxHeight(15.0),
                      ReportContainer(fromdate: fromddmmmyy == null ? ' -- ' :'$fromddmmmyy ', todate: toddmmmyy == null ? ' -- ' :'$toddmmmyy',title: 'Pain level and Enjoyment of Life',
                          onTap: (){
                            if(fromddmmmyy == null || toddmmmyy == null){
                              return showDialog(context: context, builder: (context) => AlertPopUp(description: 'Please Select Dates To Generate Reports'));
                            }else if (submitted == false){
                              return showDialog(context: context, builder: (context) => AlertPopUp(description: 'Please Click On Submit to fetch Data'));
                            }else{
                              Get.to(()=>ReportIntesityAndEnjoymentOfLife(todate: tofordb,fromdate: fromfordb));
                            }}),
                      Utils.sizeBoxHeight(15.0),
                      ReportContainer(fromdate: fromddmmmyy == null ? ' -- ' :'$fromddmmmyy ', todate: toddmmmyy == null ? ' -- ' :'$toddmmmyy',
                          title: 'Intensity and Quality of life',
                          onTap: (){
                            if(fromddmmmyy == null || toddmmmyy == null){
                              return showDialog(context: context, builder: (context) => AlertPopUp(description: 'Please Select Dates To Generate Reports'));
                            }else if (submitted == false){
                              return showDialog(context: context, builder: (context) => AlertPopUp(description: 'Please Click On Submit to fetch Data'));
                            }else{
                              Get.to(()=>ReportIntensityAndQoLActivity(todate: tofordb,fromdate: fromfordb,));
                            }}),
                      Utils.sizeBoxHeight(15.0),
                      ReportContainer(fromdate: fromddmmmyy == null ? ' -- ' :'$fromddmmmyy ', todate: toddmmmyy == null ? ' -- ' :'$toddmmmyy',title: 'Intensity & General Activity ',
                          onTap: (){
                            if(fromddmmmyy == null || toddmmmyy == null){
                              return showDialog(context: context, builder: (context) => AlertPopUp(description: 'Please Select Dates To Generate Reports'));
                            }else if (submitted == false){
                              return showDialog(context: context, builder: (context) => AlertPopUp(description: 'Please Click On Submit to fetch Data'));
                            }else{
                              Get.to(()=>PainIntensityAndGeneralActivity(todate: tofordb,fromdate: fromfordb,));
                            }}),
                      Utils.sizeBoxHeight(15.0),
                      ReportContainer(fromdate:fromddmmmyy == null ? ' -- ' :'$fromddmmmyy ', todate: toddmmmyy == null ? ' -- ' :'$toddmmmyy',title: 'Intensity & MQS',
                          onTap: (){
                            if(fromddmmmyy == null || toddmmmyy == null){
                              return showDialog(context: context, builder: (context) => AlertPopUp(description: 'Please Select Dates To Generate Reports'));
                            }else if (submitted == false){
                              return showDialog(context: context, builder: (context) => AlertPopUp(description: 'Please Click On Submit to fetch Data'));
                            }else{
                              Get.to(()=>PainIntensityAndMQsReportActivity(todate: tofordb,fromdate: fromfordb));
                            }}),
                      Utils.sizeBoxHeight(25),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<Null> selectFromDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedFromDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate:  DateTime(1900),
        lastDate:nd == null ? DateTime.now() : nd);
    if (picked != null)
      //setState(() {
        selectedFromDate = picked;
        fromfordb = picked.toString().substring(0,10);
        dateFromController.text =
            DateFormat('dd-MM-yyyy').format(selectedFromDate);
        fromddmmmyy = DateFormat('dd MMM yy').format(picked);
      //});
  }
  Future<Null> selectFromIOSDate(BuildContext context) async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        var nd = DateTime.now().difference(tempPickedDate== null ? DateTime.now() :tempPickedDate).inHours;
                       if(nd < 0){
                         Utils.toast('Please select date in past', '', Utils.red.withOpacity(.4));
                       }else{
        var newtempPickedDate = tempPickedDate == null ? DateTime.now() : tempPickedDate;
        Navigator.of(context).pop(newtempPickedDate);
                       }
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    maximumYear: DateTime.now().year,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (pickedDate != null) {
      selectedFromDate = pickedDate;
      fromfordb = pickedDate.toString().substring(0,10);
      dateFromController.text = DateFormat('dd-MM-yyyy').format(selectedFromDate);
      fromddmmmyy = DateFormat('dd MMM yy').format(pickedDate).obs;
    }
  }
  Future<Null> selectToDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedToDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: selectedFromDate,
        lastDate: DateTime.now());
    if (picked != null)
      //setState(() {
        selectedToDate = picked;
    nd = picked;
        tofordb = picked.toString().substring(0,10);
        dateToController.text =
            DateFormat('dd-MM-yyyy').format(selectedToDate);
        toddmmmyy = DateFormat('dd MMM yy').format(picked);
      //});

  }
  Future<Null> selectToIOSDate(BuildContext context) async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        var nd = DateTime.now().difference(tempPickedDate == null ? DateTime.now() :tempPickedDate).inHours;
                        if(nd < 0){
                          Utils.toast('Please select date in past', '', Utils.red.withOpacity(.4));
                        }else{
                          var ndp = tempPickedDate == null ? DateTime.now().difference(selectedFromDate).inHours :tempPickedDate.difference(selectedFromDate).inHours;
                          if(ndp <0){
                            Utils.toast('Please select proper date', '', Utils.red.withOpacity(.4));
                          }else{
                            var newtempPickedDate = tempPickedDate == null ? DateTime.now() : tempPickedDate;
                          Navigator.of(context).pop(newtempPickedDate);}
                        }
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    maximumYear: DateTime.now().year,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (pickedDate != null) {
      selectedToDate = pickedDate;
      tofordb = pickedDate.toString().substring(0,10);
      dateToController.text = DateFormat('dd-MM-yyyy').format(selectedToDate);
      toddmmmyy = DateFormat('dd MMM yy').format(pickedDate).obs;
    }
  }
}
class AlertPopUp extends StatelessWidget {
  final String description;
  AlertPopUp({this.description});

  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: screenwidth,
            padding: EdgeInsets.only(top: screenheight*.035, left: screenwidth*.03, right:  screenwidth*.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: screenwidth*.6,
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: Utils.googlenunitoreg(14.0, Utils.lightgrey1)  ,
                  ),
                ),
                Utils.sizeBoxHeight(screenheight*.03),
                Container(
                  width: 130,
                  height: screenheight*.065,
                  child: PainCButton(
                    title: 'OK', onTap: (){Get.back();},
                    borderColor: Utils.bottleclr,
                    titleColor: Utils.bottleclr,
                    spashColor: Utils.bottleclr,
                    tappedTitleColor: Utils.white,
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
                Utils.sizeBoxHeight(screenheight*.03),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

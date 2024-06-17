import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/ApiClass/GetMedicine.dart';
import 'package:painc/ApiClass/InsertionStatus.dart';
import 'package:painc/ApiClass/medicinesearch.dart';
import 'package:painc/DashboardActivity/PainInterferenceInsertionActivity.dart';
import 'package:painc/DashboardActivity/PainQualityInsertionActivity.dart';
import 'package:painc/DashboardActivity/TreatmentInsertionActivity.dart';
import 'package:painc/GetX/getmedicine.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/Utils/loader.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/custdropdown.dart';
import 'package:painc/components/modicationbox.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:painc/GetX/addmedicine.dart';
import 'package:painc/components/searchbox.dart';
import 'package:painc/components/textfield.dart';
class MedicationInsertion extends StatefulWidget {
  @override
  _MedicationInsertionState createState() => _MedicationInsertionState();
}

class _MedicationInsertionState extends State<MedicationInsertion> {
  var mlength = 0;
  bool editable = false;
  addmedicine medicinecontroller;
  Future<GetMedicine> getdata;
  //getedicinecontroller gmc = Get.put(getedicinecontroller());
  String _selectedvalue;
  var medicationscore;
  void refreshData() {
    getdata = getmedicine();
     getmedicine().then((GetMedicine gm) =>setState((){mlength = gm.medication.length;}));
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  @override
  void initState() {
    getdata = getmedicine();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Utils.bottleclr,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        actions: [
     /*     GestureDetector(
            onTap: () {
              setState(() {
                editable = !editable;
              });
            },
            child: editable == true
                ? Utils.svg('assets/svg/editpan.svg',19.0,19.0)
                : Utils.svg('assets/svg/editpan1.svg',15.0,15.0),*//*Icon(
                    Icons.edit_outlined,
                    color: Utils.white,
              size: 22,
                  ),*//*
          ),*/
          IconButton(
              icon: Icon(
                Icons.info_outline,
                size: 22,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => PopUp(
                          ontap: () => Get.back(),
                          description:
                              'You may be taking medications ranging from paracetomol , anti-inflammatories, nerve pain killers to sleeping tablets. Please enter them to obtain your medication score.',
                        ));
              })
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Utils.white, size: 18),
          onPressed: () {
            Get.back();
            //Get.to(()=>PainQualityInsertion());
          },
        ),
        centerTitle: true,
        title: Text(
          'Medication',
          style: Utils.boldtxt(20.0, Utils.white),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
                  Container(
              padding: EdgeInsets.symmetric(horizontal: screenwidth*.2,vertical: screenheight*.01),
                  width: screenwidth,
                  decoration: BoxDecoration(
                    color: Utils.bottleclr
                  ),
                  child: Text(
                    'Please enter the details of the pain medications you have taken in the last 24 hours',
                    textAlign: TextAlign.center,
                    style: Utils.googlenunitoreg(14.0, Utils.white),
                  )),
              Container(
                padding: EdgeInsets.symmetric(vertical: screenheight*.02),
                color: Utils.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        medicinecontroller = Get.put(addmedicine());
                        showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return Dialog(
                                    insetPadding: EdgeInsets.only(
                                        left: screenwidth * .06,
                                        right: screenwidth * .06,
                                        top: screenheight * .04,
                                        bottom: screenheight * .04),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Container(
                                      margin: EdgeInsets.all(20.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Container(
                                                width: screenwidth * .5,
                                                height: screenheight*.07,
                                                child: Text('Please enter the dose of your tablet',
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        color: Color(0xFF3F3D56),
                                                        fontSize: 18.0,
                                                        fontWeight: FontWeight.bold

                                                    ))),
                                            Utils.sizeBoxHeight(10.0),
                                            Container(
                                              padding: EdgeInsets.only(top:screenheight*.02,left: screenwidth*.04,right: screenwidth*.04),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Utils.semibold('Drug Name', 14.0, Utils.darkblue),
                                                  Utils.sizeBoxHeight(06.0),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: screenwidth*.03),
                                                    height: screenheight*.06,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                        color: Color(0xFFf8f8f8)
                                                    ),
                                                    child: SimpleAutoCompleteTextField(
                                                      key: medicinecontroller.drugsearchkey,
                                                      suggestions:medicinecontroller.seg,
                                                      clearOnSubmit: false,
                                                      controller: medicinecontroller.drugnamecontroller,
                                                      decoration: InputDecoration(
                                                          border: InputBorder.none
                                                      ),
                                                      textSubmitted: (data){
                                                        medicinecontroller.dropget(data);
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Utils.sizeBoxHeight(15.0),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.0),
                                                  border: Border.all(
                                                      color:
                                                      Utils.bottleclr,
                                                      width: 1)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: screenheight *
                                                            .02,
                                                        left: screenwidth *
                                                            .04,
                                                        right: screenwidth *
                                                            .04),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Utils.semibold(
                                                            'Dose / Strength',
                                                            14.0,
                                                            Utils.darkblue),
                                                        Utils.sizeBoxHeight(
                                                            06.0),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              screenwidth *
                                                                  .03),
                                                          height:
                                                          screenheight *
                                                              .06,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10.0),
                                                              color: Color(
                                                                  0xFFf8f8f8)),
                                                          child:
                                                          CustDropDown(
                                                              textselectionstyle: Utils.boldtxt(12.0, Utils.lightgrey1),
                                                              choosenvalue: medicinecontroller.selecteddose,
                                                              onChanged: (String value) {
                                                                setState(() {
                                                                  medicinecontroller.selecteddose = value;
                                                                });
                                                              },
                                                              hinttext:
                                                              'select dose',
                                                              dropdownitems: medicinecontroller.ddvalue
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Utils.popuptext(
                                                      context,
                                                      'Number of tablets per day', medicinecontroller.selectdose,TextInputType.number),
                                                  Utils.sizeBoxHeight(15.0),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: screenwidth * .025,
                                                  right:
                                                  screenwidth * .025),
                                              margin: EdgeInsets.all(15.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10.0),
                                                color: Utils.bottleclr,
                                              ),
                                              child: Utils.whitetext(
                                                  'OR', 20.0),
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(bottom: screenheight * .02),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
                                                    border: Border.all(color: Utils.bottleclr, width: 1)),
                                                child: Container(
                                                  padding: EdgeInsets.only(top:screenheight*.02,left: screenwidth*.04,right: screenwidth*.04),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Utils.semibold('Total dose in last 24 hours', 14.0, Utils.darkblue),
                                                      Utils.sizeBoxHeight(06.0),
                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: screenwidth*.03),
                                                        height: screenheight*.06,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10.0),
                                                            color: Color(0xFFf8f8f8)
                                                        ),
                                                        child: TextFormField(
                                                          onTap: (){
                                                            if(medicinecontroller.drugnamecontroller.text.isEmpty){
                                                              Utils.toast('Select Drug Name', '',Utils.red.withOpacity(.4));
                                                            }else if(medicinecontroller.selectdose.text.isNotEmpty || medicinecontroller.totaldose.text.isNotEmpty){
                                                              Utils.toast('You Can Select Only One', '',Utils.red.withOpacity(.4));
                                                            }
                                                          },
                                                          readOnly: medicinecontroller.drugnamecontroller.text == '' ? true
                                                              : medicinecontroller.selectdose.text == ''
                                                              || medicinecontroller.totaldose.text == '' ? false  : true,
                                                          keyboardType: TextInputType.number,
                                                          controller: medicinecontroller.hourlydose,
                                                          style: Utils.boldtxt(12.0, Utils.lightgrey1),
                                                          decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            ),
                                            Utils.sizeBoxHeight(15.0),
                                            Text(
                                              'Please check the details before clicking OK',
                                              style: Utils.googlenunitoreg(
                                                  14.0, Color(0xFF767676)),
                                            ),
                                            Utils.sizeBoxHeight(35.0),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    medicinecontroller.clear();
                                                    Get.back();
                                                  },
                                                  child: Utils.semiboldtext(
                                                      'Cancel',
                                                      16.0,
                                                      Color(0xFF5a5a5a)),
                                                ),
                                                Utils.sizeBoxWidth(25.0),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        right: screenwidth *
                                                            .02),
                                                    child: GestureDetector(
                                                      child: Utils.semiboldtext('Ok', 16.0, Utils.bottleclr),
                                                      onTap: () async{
                                                        medicinecontroller.insertmedicine(context);
                                                      },
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).then(onGoBack);
                      },
                      child: Container(padding: EdgeInsets.symmetric(horizontal: screenwidth*.05,vertical: screenheight*.012),
                          decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 10.0,offset: Offset(5.0,5.0),color: Utils.black.withOpacity(.25))],borderRadius: BorderRadius.circular(12.0),color: Utils.bottleclr),
                          child: Utils.whitetext('Enter your medication', 14.0)),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          editable = !editable;
                        });
                      },
                      child: Container(padding: EdgeInsets.symmetric(horizontal: screenwidth*.05,vertical: screenheight*.012),
                          decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 10.0,offset: Offset(5.0,5.0),color: Utils.black.withOpacity(.25))],borderRadius: BorderRadius.circular(12.0),color: Utils.yellow),
                          child: Utils.whitetext('Edit', 14.0)),
                    ),
                  ],
                ),
              ),
                ],
          ),
/*          Container(
            padding: EdgeInsets.only(bottom: screenheight*.015),
            //height: screenheight * .15,
            width: screenwidth,
            color: Utils.bottleclr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: screenwidth * .65,
                    child: Text(
                      'Please enter the details of the pain medications you have taken in the last 24 hours',
                      textAlign: TextAlign.center,
                      style: Utils.googlenunitoreg(14.0, Utils.white),
                    )),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: screenwidth * .015),
                  margin: EdgeInsets.only(
                      top: screenheight * .02,
                      left: screenwidth * .07,
                      right: screenwidth * .07),
                  width: screenwidth,
                  height: screenheight * .06,
                  decoration: BoxDecoration(
                      color: Utils.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: InkWell(
                          child: CircleAvatar(
                            radius: screenwidth * .045,
                            backgroundColor: Utils.bottleclr,
                            child: Icon(
                              Icons.add,
                              color: Utils.white,
                            ),
                          ),
                          onTap: () {
                            medicinecontroller = Get.put(addmedicine());
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return Dialog(
                                          insetPadding: EdgeInsets.only(
                                              left: screenwidth * .06,
                                              right: screenwidth * .06,
                                              top: screenheight * .04,
                                              bottom: screenheight * .04),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          child: Container(
                                            margin: EdgeInsets.all(20.0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                      width: screenwidth * .5,
                                                      height: screenheight*.07,
                                                      child: Text('Please enter the dose of your tablet',
                                                          textAlign: TextAlign.center,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              fontFamily: 'Nunito',
                                                              color: Color(0xFF3F3D56),
                                                              fontSize: 18.0,
                                                              fontWeight: FontWeight.bold

                                                          ))),
                                                  Utils.sizeBoxHeight(10.0),
                                                  Container(
                                                    padding: EdgeInsets.only(top:screenheight*.02,left: screenwidth*.04,right: screenwidth*.04),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Utils.semibold('Drug Name', 14.0, Utils.darkblue),
                                                        Utils.sizeBoxHeight(06.0),
                                                        Container(
                                                          padding: EdgeInsets.symmetric(horizontal: screenwidth*.03),
                                                          height: screenheight*.06,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                              color: Color(0xFFf8f8f8)
                                                          ),
                                                          child: SimpleAutoCompleteTextField(
                                                            key: medicinecontroller.drugsearchkey,
                                                            suggestions:medicinecontroller.seg,
                                                            clearOnSubmit: false,
                                                            controller: medicinecontroller.drugnamecontroller,
                                                            decoration: InputDecoration(
                                                                border: InputBorder.none
                                                            ),
                                                             textSubmitted: (data){
                                                              medicinecontroller.dropget(data);
                                                             },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Utils.sizeBoxHeight(15.0),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                        border: Border.all(
                                                            color:
                                                            Utils.bottleclr,
                                                            width: 1)),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.only(
                                                              top: screenheight *
                                                                  .02,
                                                              left: screenwidth *
                                                                  .04,
                                                              right: screenwidth *
                                                                  .04),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Utils.semibold(
                                                                  'Dose / Strength',
                                                                  14.0,
                                                                  Utils.darkblue),
                                                              Utils.sizeBoxHeight(
                                                                  06.0),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    screenwidth *
                                                                        .03),
                                                                height:
                                                                screenheight *
                                                                    .06,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        10.0),
                                                                    color: Color(
                                                                        0xFFf8f8f8)),
                                                                child:
                                                                CustDropDown(
                                                                  textselectionstyle: Utils.boldtxt(12.0, Utils.lightgrey1),
                                                                  choosenvalue: medicinecontroller.selecteddose,
                                                                  onChanged: (String value) {
                                                                    setState(() {
                                                                      medicinecontroller.selecteddose = value;
                                                                    });
                                                                  },
                                                                  hinttext:
                                                                  'select dose',
                                                                  dropdownitems: medicinecontroller.ddvalue
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                         Utils.popuptext(
                                                              context,
                                                              'Number of tablets per day', medicinecontroller.selectdose,TextInputType.number),
                                                        Utils.sizeBoxHeight(15.0),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: screenwidth * .025,
                                                        right:
                                                        screenwidth * .025),
                                                    margin: EdgeInsets.all(15.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                      color: Utils.bottleclr,
                                                    ),
                                                    child: Utils.whitetext(
                                                        'OR', 20.0),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: screenheight * .02),
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
                                                        border: Border.all(color: Utils.bottleclr, width: 1)),
                                                    child: Container(
                                                      padding: EdgeInsets.only(top:screenheight*.02,left: screenwidth*.04,right: screenwidth*.04),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Utils.semibold('Total dose in last 24 hours', 14.0, Utils.darkblue),
                                                          Utils.sizeBoxHeight(06.0),
                                                          Container(
                                                              padding: EdgeInsets.symmetric(horizontal: screenwidth*.03),
                                                              height: screenheight*.06,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                  color: Color(0xFFf8f8f8)
                                                              ),
                                                              child: TextFormField(
                                                                onTap: (){
                                                                  if(medicinecontroller.drugnamecontroller.text.isEmpty){
                                                                    Utils.toast('Select Drug Name', '',Utils.red.withOpacity(.4));
                                                                  }else if(medicinecontroller.selectdose.text.isNotEmpty || medicinecontroller.totaldose.text.isNotEmpty){
                                                                    Utils.toast('You Can Select Only One', '',Utils.red.withOpacity(.4));
                                                                  }
                                                                },
                                                                readOnly: medicinecontroller.drugnamecontroller.text == '' ? true
                                                                    : medicinecontroller.selectdose.text == ''
                                                              || medicinecontroller.totaldose.text == '' ? false  : true,
                                                                keyboardType: TextInputType.number,
                                                                controller: medicinecontroller.hourlydose,
                                                                style: Utils.boldtxt(12.0, Utils.lightgrey1),
                                                                decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    )
                                                  ),
                                                  Utils.sizeBoxHeight(15.0),
                                                  Text(
                                                    'Please check the details before clicking OK',
                                                    style: Utils.googlenunitoreg(
                                                        14.0, Color(0xFF767676)),
                                                  ),
                                                  Utils.sizeBoxHeight(35.0),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          medicinecontroller.clear();
                                                          Get.back();
                                                        },
                                                        child: Utils.semiboldtext(
                                                            'Cancel',
                                                            16.0,
                                                            Color(0xFF5a5a5a)),
                                                      ),
                                                      Utils.sizeBoxWidth(25.0),
                                                      Container(
                                                          padding: EdgeInsets.only(
                                                              right: screenwidth *
                                                                  .02),
                                                          child: GestureDetector(
                                                            child: Utils.semiboldtext('Ok', 16.0, Utils.bottleclr),
                                                            onTap: () async{
                                                              medicinecontroller.insertmedicine(context);
                                                            },
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                      );
                                    },
                                  );
                                }).then(onGoBack);
                          }),

                ),
              ],
            ),
          ),*/
          Flexible(
            child: Container(
              height: screenheight,
              child: RefreshIndicator(
                onRefresh: (){
                  setState(() {
                    getdata = getmedicine();
                  });
                  return getmedicine();
                },
                child:
                  FutureBuilder<GetMedicine>(
                    future: getdata,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        mlength = snapshot.data.medication.length;
                        print('MMMMMMMMMM $mlength');
                          try {
                            if (snapshot.data.medication.length != 0) {
                              return ListView.builder(
                                  padding: EdgeInsets.only(
                                      top: screenheight * .01,
                                      left: screenwidth * .02,
                                      right: screenwidth * .02),
                                  itemCount: snapshot.data.medication.length,
                                  itemBuilder: (context, index) {
                                    medicationscore =
                                        snapshot.data.medicationScore;
                                    return
                                      snapshot.data.medication[index].medicine
                                          .drug.contains('None')
                                          ? Container()
                                          : MedicationBox(
                                          onTap: () {
                                            showDialog(context: context,
                                                builder: (context) {
                                                  return StatefulBuilder(
                                                      builder: (context,
                                                          setState) {
                                                        return Dialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                  .circular(
                                                                  10.0))),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize
                                                                .min,
                                                            children: [
                                                              Container(
                                                                width: screenwidth,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    top: screenheight *
                                                                        .035,
                                                                    left: screenwidth *
                                                                        .03,
                                                                    right: screenwidth *
                                                                        .03),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Utils
                                                                        .darkbluetxt(
                                                                        'You Sure to delete this medicine',
                                                                        18.0),
                                                                    Utils
                                                                        .sizeBoxHeight(
                                                                        screenheight *
                                                                            0.02),
                                                                    Container(
                                                                      width: screenwidth *
                                                                          .6,
                                                                      child: Text(
                                                                        'This Medicine will be deleted',
                                                                        textAlign: TextAlign
                                                                            .center,
                                                                        style: Utils
                                                                            .googlenunitoreg(
                                                                            14.0,
                                                                            Utils
                                                                                .lightgrey1),
                                                                      ),
                                                                    ),
                                                                    Utils
                                                                        .sizeBoxHeight(
                                                                        screenheight *
                                                                            .03),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment
                                                                          .spaceEvenly,
                                                                      children: [
                                                                        Container(
                                                                          width: 130,
                                                                          height: screenheight *
                                                                              .065,
                                                                          child: PainCButton(
                                                                            title: 'Cancel',
                                                                            onTap: () {
                                                                              Get
                                                                                  .back();
                                                                            },
                                                                            borderColor: Utils
                                                                                .bottleclr,
                                                                            titleColor: Utils
                                                                                .bottleclr,
                                                                            spashColor: Utils
                                                                                .bottleclr,
                                                                            tappedTitleColor: Utils
                                                                                .white,
                                                                            borderRadius: BorderRadius
                                                                                .circular(
                                                                                10.0),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width: 130,
                                                                          height: screenheight *
                                                                              .065,
                                                                          child: PainCButton(
                                                                            title: 'Delete',
                                                                            onTap: () {
                                                                              delete(
                                                                                  snapshot
                                                                                      .data
                                                                                      .medication[index]
                                                                                      .id);
                                                                              medicationscore =
                                                                                  snapshot
                                                                                      .data
                                                                                      .medicationScore;
                                                                              Get
                                                                                  .back();
                                                                            },
                                                                            borderColor: Utils
                                                                                .bottleclr,
                                                                            titleColor: Utils
                                                                                .bottleclr,
                                                                            spashColor: Utils
                                                                                .bottleclr,
                                                                            tappedTitleColor: Utils
                                                                                .white,
                                                                            borderRadius: BorderRadius
                                                                                .circular(
                                                                                10.0),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Utils
                                                                        .sizeBoxHeight(
                                                                        screenheight *
                                                                            .03),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }
                                                  );
                                                }).then(onGoBack);
                                          },
                                          td: snapshot.data.medication[index]
                                              .tabletsPerDay == null
                                              ? false
                                              : true,
                                          dt: snapshot.data.medication[index]
                                              .doses.toString() == null
                                              ? false
                                              : true,
                                          medicinename: snapshot.data
                                              .medication[index].medicine.drug,
                                          editable: editable,
                                          tabletscount: snapshot.data
                                              .medication[index].tabletsPerDay
                                              .toString(),
                                          dosenum: snapshot.data
                                              .medication[index].doses
                                              .toString());
                                  });
                            }else{
                              print('YOU HERE');
                              return Center(child: Utils.semiboldtext('Please Select Medication', 15.0, Utils.lightgrey1));
                            }
                          }catch(e){
                            print('YOU HERE1');
                            print(e);return Center(child: CircularProgressIndicator());}
                      }print('YOU HERE2');
                      return Center(child: Utils.semiboldtext('Please Select Medication', 15.0, Utils.lightgrey1));;
                    },
                  ),
              ),
            )
          ),
          Column(
            children: [
              Container(
                  width: screenwidth*.6,child: Text('This information will be used to calculate your Medication Score',textAlign: TextAlign.center,style: Utils.googlenunitoreg(12.0, Color(0xFF767676)))),
              Container(
                width: screenwidth,
                margin: EdgeInsets.only(left: screenwidth*.08,right: screenwidth*.08, top: screenheight*.02, bottom: screenheight*.04),//symmetric(vertical: screenheight*.02,horizontal: screenwidth*.08),
                child:  PainCButton(
                  title: mlength == 0 ? 'Next' :'Confirm',
                  onTap: (){
                    mlength == 0 ? showDialog(context: context, builder: (context) {
                      return  PopUp(
                        title: 'Alert',
                        hastitle: true,
                        ontap: (){Get.back();},
                        description: 'Pleaes Click on the (+) button to start adding your medication. (or) enter NONE from the dropdown',
                      );
                    }) :showDialog(context: context, builder: (context) {
                  return  Dialog(
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
                              Utils.darkbluetxt('Your Medication Score', 18.0),
                              Utils.sizeBoxHeight(screenheight * 0.03),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: screenheight*.005,horizontal: screenwidth*.03),
                                child: Text(medicationscore.toStringAsFixed(1),style: Utils.boldtxt(50.0,Utils.black),),
                                decoration: BoxDecoration(
                                    color:  Color(0xFFF6F6F6),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                              ),
                              Utils.sizeBoxHeight(screenheight * 0.02),
                              Container(
                                width: screenwidth*.6,
                                child: Text(
                                  'A numerical representation of your pain medication regimen based on Medication Quantification Scale. The trend is more important than individual score',
                                  textAlign: TextAlign.center,
                                  style: Utils.googlenunitoreg(14.0, Utils.lightgrey1),
                                ),
                              ),
                              Utils.sizeBoxHeight(screenheight*.03),
                              Container(
                                width: screenwidth*.3,
                                height: screenheight*.065,
                                child: PainCButton(
                                  title: 'OK', onTap: () async{
                                  showLoadingDialog(context: context);
                                  var filled = false;
                                  http.Response res = await ResponseClass.callGetApi(ApiSheet.get_all_data);
                                  InsertionStatus data = InsertionStatus.fromJson(json.decode(res.body));
                                  var el = data.data.paininterferences == null ? 0.0 :double.parse(data.data.paininterferences.enjoymentLife)*10;
                                  var ga = data.data.paininterferences == null ? 0.0 :double.parse(data.data.paininterferences.generalActivity)*10;
                                  if(data.baseline_status == true){
                                    setState(() {
                                      filled = true;
                                    });
                                  }
                                  print(filled);
                                  hideLoadingDialog(context: context);
                                  Get.back();
                                  Get.back();
                                  filled == false ?  Get.to(()=>TreatmentInsertion()) : Get.to(()=>PainInterferenceInsertion(enjoymentol: el, genaralactivity: ga));
                                },
                                  borderColor: Utils.bottleclr,
                                  titleColor: Utils.bottleclr,
                                  spashColor: Utils.bottleclr,
                                  tappedTitleColor: Utils.white,
                                ),/*RoundedBtn(
                                        ontap: (){
                                          Get.back();
                                          Get.back();
                                          Get.to(TreatmentInsertion());},
                                        btnclr: Utils.bottleclr,
                                        btntxtclr: Utils.white,
                                        txt: 'OK',
                                      ),*/
                              ),
                              Utils.sizeBoxHeight(screenheight*.03),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
                    },
                  borderColor: Utils.bottleclr,
                  titleColor: Utils.bottleclr,
                  spashColor: Utils.bottleclr,
                  tappedTitleColor: Utils.white,
                )),
            ],
          ),
        ],
      ),
    );
  }
  delete(int id) async{
   ResponseClass.deleteAlbum(id,ApiSheet.medications_delete);
  }
  Future<GetMedicine> getmedicine() async{
    showLoadingDialog(context: context);
    http.Response response = await ResponseClass.callGetApi(ApiSheet.getmedication);
    String responseString = response.body;
    if(response.statusCode == 200){
      hideLoadingDialog(context: context);
      print(response.body);
      GetMedicine getmd = GetMedicine.fromJson(json.decode(responseString));
      mlength = getmd.medication.length;
      print('MMMMLLLLLL $mlength');
      return GetMedicine.fromJson(json.decode(responseString));
    }else{
      hideLoadingDialog(context: context);
      throw Exception('Failed');
    }
  }
}
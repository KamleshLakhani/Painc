import 'dart:collection';
import 'dart:typed_data';
import 'package:painc/ApiClass/InsertionStatus.dart';
import 'package:painc/ApiClass/treatmenterror.dart';
import 'dart:convert';
import 'dart:core';
import 'package:painc/DashboardActivity/d.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/appbar.dart';
import 'package:painc/GetX/painlocation_insertion.dart';
import 'package:painc/components/loader.dart';
import 'package:painc/screens/Dashboard.dart';
import 'package:screenshot/screenshot.dart';
import 'package:http/http.dart' as http;

import 'PainIntensityInsertionActivity.dart';
class PainLocationInsertion extends StatefulWidget {
  @override
  _PainLocationInsertionState createState() => _PainLocationInsertionState();
}

class _PainLocationInsertionState extends State<PainLocationInsertion> {
  PainLocation_Insertion painloc = PainLocation_Insertion();
  var res;
  Future<InsertionStatus> status;
  /*bool o1 = false;bool o2 = false;bool o3 = false;bool o4 = false;bool o5 = false;bool o6 = false;bool o7 = false;bool o8 = false;bool o9 = false;bool o10 = false;
  bool o11 = false;bool o12 = false;bool o13 = false;bool o14 = false;bool o15 = false;bool o16 = false;bool o17 = false;bool o18 = false;bool o19 = false;bool o20 = false;
  bool o21 = false;bool o22 = false;bool o23 = false;bool o24 = false;bool o25 = false;bool o26 = false;bool o27 = false;bool o28 = false;bool o29 = false;bool o30 = false;
  bool o31 = false;bool o32 = false;bool o33 = false;bool o34 = false;bool o35 = false;bool o36 = false;bool o37 = false;bool o38 = false;bool o39 = false;bool o40 = false;
  bool o41 = false;bool o42 = false;bool o43 = false;bool o44 = false;bool o45 = false;bool o46 = false;bool o47 = false;bool o48 = false;bool o49 = false;*/
  bool index = true;
  bool index2 = false;
  ScreenshotController frontscreenshotController = ScreenshotController();
  ScreenshotController backscreenshotController = ScreenshotController();
  Uint8List frontimageFile;
  Uint8List backimageFile;

  @override
  void initState() {
    status = getstatus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    var sw = MediaQuery.of(context).size.width;
    var nsw = screenwidth*.75;
    var nsh = screenheight*.7;
    return Scaffold(
      appBar: CustAppbar(
        txt: 'Pain Location',
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return PopUp(
                  ontap: () {
                    Get.back();
                  },
                  title: '',
                  description:
                      'Kindly select your area of pain to click on the boxes.',
                );
              });
        },
        infobtn: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              padding: EdgeInsets.only(bottom: screenheight*.12),
              child: index == true
                  ?
                  Screenshot(
                      controller: frontscreenshotController,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: nsw,
                            height: nsh,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/front.png'),
                                fit: BoxFit.fill,
                              )
                            ),
                            child: Stack(
                              children: [
                                Positioned(top: nsh*.07,left:nsw*.43,child: GestureDetector(onTap: (){setState(() {d.o1 =! d.o1;});}, child: Stack(alignment: Alignment.center,children: [Utils.reddot(context, d.o1 == true ? Utils.red : Colors.white),Text('1'),]))),
                                Positioned(top: nsh*.07,right: nsw*.415,child: GestureDetector(onTap: (){setState(() {d.o2 =! d.o2;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o2 == true ? Utils.red : Colors.white),Text('2')]))),
                                Positioned(top: nsh*.165,right:10,left: 10,child: GestureDetector(onTap: (){setState(() {d.o3 =! d.o3;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o3 == true ? Utils.red : Colors.white),Text('3')]))),
                                Positioned(top: nsh*.23,left: nsw*.28,child: GestureDetector(onTap: (){setState(() {d.o4 =! d.o4;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o4 == true ? Utils.red : Colors.white),Text('4')]))),
                                Positioned(top: nsh*.23,right: nsw*.27,child: GestureDetector(onTap: (){setState(() {d.o5 =! d.o5;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o5 == true ? Utils.red : Colors.white),Text('5')]))),
                                Positioned(top: nsh*.23,left:15,right: 10,child: GestureDetector(onTap: (){setState(() {d.o6 =! d.o6;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o6 == true ? Utils.red : Colors.white),Text('6')]))),
                                Positioned(top: nsh*.28,left:nsw*.37,child: GestureDetector(onTap: (){setState(() {d.o7 =! d.o7;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o7 == true ? Utils.red : Colors.white),Text('7')]))),
                                Positioned(top: nsh*.28,right:nsw*.36,child: GestureDetector(onTap: (){setState(() {d.o8 =! d.o8;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o8 == true ? Utils.red : Colors.white),Text('8')]))),
                                Positioned(top: nsh*.34,right:10,left:15,child: GestureDetector(onTap: (){setState(() {d.o9 =! d.o9;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o9 == true ? Utils.red : Colors.white),Text('9')]))),
                                Positioned(top: nsh*.34,left:nsw*.2,child: GestureDetector(onTap: (){setState(() {d.o10 =! d.o10;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o10 == true ? Utils.red : Colors.white),Text('10')]))),
                                Positioned(top: nsh*.34,right:nsw*.2,child: GestureDetector(onTap: (){setState(() {d.o11 =! d.o11;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o11 == true ? Utils.red : Colors.white),Text('11')]))),
                                Positioned(top: nsh*.4,left:nsw*.17,child: GestureDetector(onTap: (){setState(() {d.o12 =! d.o12;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o12 == true ? Utils.red : Colors.white),Text('12')]))),
                                Positioned(top: nsh*.4,right:nsw*.15,child: GestureDetector(onTap: (){setState(() {d.o13 =! d.o13;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o13 == true ? Utils.red : Colors.white),Text('13')]))),
                                Positioned(top: nsh*.44,left:15,right:10,child: GestureDetector(onTap: (){setState(() {d.o14 =! d.o14;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o14 == true ? Utils.red : Colors.white),Text('14')]))),
                                Positioned(top: 10,bottom:10,left:nsw*.12,child: GestureDetector(onTap: (){setState(() {d.o15 =! d.o15;});}, child: Stack(alignment: Alignment.center,children: [Utils.reddot(context, d.o15 == true ? Utils.red : Colors.white),Text('15')]))),
                                Positioned(top: 10,bottom:10,right:nsw*.11,child: GestureDetector(onTap: (){setState(() {d.o16 =! d.o16;});}, child:Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o16 == true ? Utils.red : Colors.white),Text('16')]))),
                                Positioned(bottom: nsh*.4,left:nsw*.35,child: GestureDetector(onTap: (){setState(() {d.o17 =! d.o17;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o17 == true ? Utils.red : Colors.white),Text('17')]))),
                                Positioned(bottom: nsh*.4,right:nsw*.35,child: GestureDetector(onTap: (){setState(() {d.o18 =! d.o18;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o18 == true ? Utils.red : Colors.white),Text('18')]))),
                                Positioned(bottom: nsh*.285,left:nsw*.35,child: GestureDetector(onTap: (){setState(() {d.o19 =! d.o19;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o19 == true ? Utils.red : Colors.white),Text('19')]))),
                                Positioned(bottom: nsh*.285,right:nsw*.35,child: GestureDetector(onTap: (){setState(() {d.o20 =! d.o20;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o20 == true ? Utils.red : Colors.white),Text('20')]))),
                                Positioned(bottom: nsh*.18,left:nsw*.34,child: GestureDetector(onTap: (){setState(() {d.o21 =! d.o21;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o21 == true ? Utils.red : Colors.white),Text('21')]))),
                                Positioned(bottom: nsh*.18,right:nsw*.33,child: GestureDetector(onTap: (){setState(() {d.o22 =! d.o22;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o22 == true ? Utils.red : Colors.white),Text('22')]))),
                                Positioned(bottom: nsh*.06,left:nsw*.33,child: GestureDetector(onTap: (){setState(() {d.o23 =! d.o23;});}, child:Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o23 == true ? Utils.red : Colors.white),Text('23')]))),
                                Positioned(bottom: nsh*.06,right:nsw*.32,child: GestureDetector(onTap: (){setState(() {d.o24 =! d.o24;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o24 == true ? Utils.red : Colors.white),Text('24')]))),
                              ],
                            ),
                          ),
                        ],
                      )
                    )
                  : Screenshot(
                  controller: backscreenshotController,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: nsw,
                        height: nsh,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/back.png'),
                              fit: BoxFit.fill,
                            )
                        ),
                        child: Stack(
                          children: [
                            Positioned(top: nsh*.07,left:nsw*.43,child: GestureDetector(onTap: (){setState(() {d.o25 =! d.o25;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o25 == true ? Utils.red : Colors.white),Text('25')]))),
                            Positioned(top: nsh*.07,right: nsw*.415,child: GestureDetector(onTap: (){setState(() {d.o26 =! d.o26;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o26 == true ? Utils.red : Colors.white),Text('26')]))),
                            Positioned(top: nsh*.14,right:10,left: 10,child: GestureDetector(onTap: (){setState(() {d.o27 =! d.o27;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o27 == true ? Utils.red : Colors.white),Text('27')]))),
                            Positioned(top: nsh*.22,left: nsw*.28,child: GestureDetector(onTap: (){setState(() {d.o28 =! d.o28;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o28 == true ? Utils.red : Colors.white),Text('28')]))),
                            Positioned(top: nsh*.22,right: nsw*.27,child: GestureDetector(onTap: (){setState(() {d.o29 =! d.o29;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o29 == true ? Utils.red : Colors.white),Text('29')]))),
                            Positioned(top: nsh*.3,left:15,right: 10,child: GestureDetector(onTap: (){setState(() {d.o30 =! d.o30;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o30 == true ? Utils.red : Colors.white),Text('30')]))),
                            Positioned(top: nsh*.25,left:nsw*.37,child: GestureDetector(onTap: (){setState(() {d.o31 =! d.o31;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o31 == true ? Utils.red : Colors.white),Text('31')]))),
                            Positioned(top: nsh*.25,right:nsw*.36,child: GestureDetector(onTap: (){setState(() {d.o32 =! d.o32;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o32 == true ? Utils.red : Colors.white),Text('32')]))),
                            Positioned(top: nsh*.32,left:nsw*.2,child: GestureDetector(onTap: (){setState(() {d.o33 =! d.o33;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o33 == true ? Utils.red : Colors.white),Text('33')]))),
                            Positioned(top: nsh*.32,right:nsw*.2,child: GestureDetector(onTap: (){setState(() {d.o34 =! d.o34;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o34 == true ? Utils.red : Colors.white),Text('34')]))),
                            Positioned(top: nsh*.38,left:nsw*.16,child: GestureDetector(onTap: (){setState(() {d.o35 =! d.o35;});}, child:Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o35 == true ? Utils.red : Colors.white),Text('35')]))),
                            Positioned(top: nsh*.37,left:nsw*.38,child: GestureDetector(onTap: (){setState(() {d.o36 =! d.o36;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o36 == true ? Utils.red : Colors.white),Text('36')]))),
                            Positioned(top: nsh*.37,right:nsw*.38,child: GestureDetector(onTap: (){setState(() {d.o37 =! d.o37;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o37 == true ? Utils.red : Colors.white),Text('37')]))),
                            Positioned(top: nsh*.38,right:nsw*.15,child: GestureDetector(onTap: (){setState(() {d.o38 =! d.o38;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o38 == true ? Utils.red : Colors.white),Text('38')]))),
                            Positioned(top: nsh*.44,left:15,right:10,child: GestureDetector(onTap: (){setState(() {d.o39 =! d.o39;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o39 == true ? Utils.red : Colors.white),Text('39')]))),
                            Positioned(top: 10,bottom:10,left:nsw*.11,child: GestureDetector(onTap: (){setState(() {d.o40 =! d.o40;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o40 == true ? Utils.red : Colors.white),Text('40')]))),
                            Positioned(top: 10,bottom:10,right:nsw*.11,child: GestureDetector(onTap: (){setState(() {d.o41 =! d.o41;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o41 == true ? Utils.red : Colors.white),Text('41')]))),
                            Positioned(bottom: nsh*.4,left:nsw*.35,child: GestureDetector(onTap: (){setState(() {d.o42 =! d.o42;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o42 == true ? Utils.red : Colors.white),Text('42')]))),
                            Positioned(bottom: nsh*.4,right:nsw*.35,child: GestureDetector(onTap: (){setState(() {d.o43 =! d.o43;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o43 == true ? Utils.red : Colors.white),Text('43')]))),
                            Positioned(bottom: nsh*.29,left:nsw*.35,child: GestureDetector(onTap: (){setState(() {d.o44 =! d.o44;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o44 == true ? Utils.red : Colors.white),Text('44')]))),
                            Positioned(bottom: nsh*.29,right:nsw*.35,child: GestureDetector(onTap: (){setState(() {d.o45 =! d.o45;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o45 == true ? Utils.red : Colors.white),Text('45')]))),
                            Positioned(bottom: nsh*.18,left:nsw*.34,child: GestureDetector(onTap: (){setState(() {d.o46 =! d.o46;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o46 == true ? Utils.red : Colors.white),Text('46')]))),
                            Positioned(bottom: nsh*.18,right:nsw*.33,child: GestureDetector(onTap: (){setState(() {d.o47 =! d.o47;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o47 == true ? Utils.red : Colors.white),Text('47')]))),
                            Positioned(bottom: nsh*.05,left:nsw*.32,child: GestureDetector(onTap: (){setState(() {d.o48 =! d.o48;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o48 == true ? Utils.red : Colors.white),Text('48')]))),
                            Positioned(bottom: nsh*.05,right:nsw*.31,child: GestureDetector(onTap: (){setState(() {d.o49 =! d.o49;});}, child: Stack(alignment:Alignment.center,children: [Utils.reddot(context, d.o49 == true ? Utils.red : Colors.white),Text('49')]))),
                          ],
                        ),
                      ),
                    ],
                  )

              )

              ),
          Positioned(
            right: screenwidth*.03,
            bottom: screenheight*.12,
            child: Column(
              children: [
                Utils.roundbutton(
                    screenwidth * .12,
                    screenwidth * .12,
                    'Front',
                    index == true ? Utils.bottleclr : Utils.lightgrey1, () {
                  frontscreenshotController.capture().then((Uint8List image) {
                    setState(() {
                      d.map['backimg'] = image;
                    });
                  }).then((value) {
                    Future.delayed(Duration(milliseconds: 50), () {
                      setState(() {
                        index = true;
                        index2 = false;
                      });
                    });
                  });
                }),
                Utils.sizeBoxHeight(screenheight * .02),
                Utils.roundbutton(
                    screenwidth * .12,
                    screenwidth * .12,
                    'Back',
                    index == false ? Utils.bottleclr : Utils.lightgrey1, () {
                  frontscreenshotController.capture().then((Uint8List image) {
                    setState(() {
                      d.map['frontimg'] = image;
                    });
                  }).then((value) {
                    Future.delayed(Duration(microseconds: 20), () {
                      setState(() {
                        index = false;
                        index2 = true;
                      });
                    });
                  });

                  // setState(() {
                  //   index = false;
                  //   index2 = true;
                  // });
                })
              ],
            ),
          ),
          Positioned(
            bottom: screenheight*.04,
            left: screenwidth * .08,
            right: screenwidth * .08,
            child: PainCButton(
              title: 'Next',
              onTap: () async {
                http.Response datares = await ResponseClass.callGetApi(ApiSheet.get_all_data);
                InsertionStatus data = InsertionStatus.fromJson(json.decode(datares.body));
                double main = data.data.painintensity == null ? 0.0*10 :data.data.painintensity.painIntensity.runtimeType == int ? data.data.painintensity.painIntensity*10.toDouble() : data.data.painintensity.painIntensity*10;
                var headers = {'Authorization': 'Bearer ${Constant.token}'};
                var request = http.MultipartRequest("POST", Uri.parse(ApiSheet.painlocation_imgupload));
                if(d.o1 == false && d.o2 == false && d.o3 == false && d.o4 == false && d.o5 == false && d.o6 == false && d.o7 == false && d.o8 == false && d.o9 == false && d.o10 == false
                    && d.o11 == false && d.o12 == false && d.o13 == false && d.o14 == false && d.o15 == false && d.o16 == false && d.o17 == false && d.o18 == false && d.o19 == false && d.o20 == false
                    && d.o21 == false && d.o22 == false && d.o23 == false && d.o24 == false && d.o25 == false && d.o26 == false && d.o27 == false && d.o28 == false && d.o29 == false && d.o30 == false
                    && d.o31 == false && d.o32 == false && d.o33 == false && d.o34 == false && d.o35 == false && d.o36 == false && d.o37 == false && d.o38 == false && d.o39 == false && d.o40 == false
                    && d.o41 == false && d.o42 == false && d.o43 == false && d.o44 == false && d.o45 == false && d.o46 == false && d.o47 == false && d.o48 == false && d.o49 == false ){
                  Utils.toast('Select Pain Location', 'Not Selected Any of them', Utils.red.withOpacity(.4));
                }else{
                showLoadingDialog(context: context);
                if(d.o25 == false && d.o26 == false && d.o27 == false && d.o28 == false && d.o29 == false && d.o30 == false
                    && d.o31 == false && d.o32 == false && d.o33 == false && d.o34 == false && d.o35 == false && d.o36 == false && d.o37 == false && d.o38 == false && d.o39 == false && d.o40 == false
                    && d.o41 == false && d.o42 == false && d.o43 == false && d.o44 == false && d.o45 == false && d.o46 == false && d.o47 == false && d.o48 == false && d.o49 == false){
                  print('only front selected');
                  frontscreenshotController.capture().then((Uint8List image) {
                    setState(() {
                      d.map['frontimg'] = image;
                    });
                    print(d.map);
                  }).then((value){
                    Future.delayed(Duration(microseconds: 20),() async{
                      var multipartFile1 = http.MultipartFile.fromBytes('front', (d.map['frontimg'].buffer.asUint8List()), filename: 'anatomy.jpg');
                      request.files.add(multipartFile1);
                      request.headers.addAll(headers);
                      res = await request.send();
                      var responseData = await res.stream.toBytes();
                      var responsestring = String.fromCharCodes(responseData);
                      print('GHGHGHGHGHGHGHGHGH $responsestring');
                      if (res.statusCode == 200) {
                        hideLoadingDialog(context: context);
                        Get.back();
                        Get.to(() => PainIntensityInsertion(pointer: main,));
                      }
                    });
                  });
                }
                else if(d.o1 == false && d.o2 == false && d.o3 == false && d.o4 == false && d.o5 == false && d.o6 == false && d.o7 == false && d.o8 == false && d.o9 == false && d.o10 == false
                    && d.o11 == false && d.o12 == false && d.o13 == false && d.o14 == false && d.o15 == false && d.o16 == false && d.o17 == false && d.o18 == false && d.o19 == false && d.o20 == false
                    && d.o21 == false && d.o22 == false && d.o23 == false && d.o24 == false){
                  print('only back selected');
                  frontscreenshotController.capture().then((Uint8List image) {
                    setState(() {
                      d.map['backimg'] = image;
                    });
                  }).then((_){
                    Future.delayed(Duration(microseconds: 20),() async{
                      var multipartFile2 = http.MultipartFile.fromBytes('back', (d.map['backimg'].buffer.asUint8List()), filename: 'anatomy.jpg');
                      request.files.add(multipartFile2);
                      request.headers.addAll(headers);
                      var response = await request.send();
                      var responseData = await response.stream.toBytes();
                      var responsestring = String.fromCharCodes(responseData);
                      if (response.statusCode == 200) {
                        hideLoadingDialog(context: context);
                        Get.back();
                        Get.to(() => PainIntensityInsertion(pointer: main,));
                      }
                    });
                  });
                } else{
                  frontscreenshotController.capture().then((Uint8List image) {
                    setState(() {
                      d.map['backimg'] = image;
                    });
                  }).then((_) async{
                    var multipartFile1 = http.MultipartFile.fromBytes('front', (d.map['frontimg'].buffer.asUint8List()), filename: 'anatomy.jpg');
                    var multipartFile2 = http.MultipartFile.fromBytes('back', (d.map['backimg'].buffer.asUint8List()), filename: 'anatomy.jpg');
                    request.files.add(multipartFile1);
                    request.files.add(multipartFile2);
                    request.headers.addAll(headers);
                    var response = await request.send();
                    var responseData = await response.stream.toBytes();
                    var responsestring = String.fromCharCodes(responseData);
                    treatmenterror treatment = treatmenterror.fromJson(json.decode(responsestring));
                    print('STATATATATA ${treatment.status}');
                    if (treatment.status) {
                      hideLoadingDialog(context: context);
                      Get.back();
                      Get.to(() => PainIntensityInsertion(pointer: main,));
                    }else{
                      hideLoadingDialog(context: context);
                      Utils.toast(treatment.message, '', Utils.red.withOpacity(.4));
                    }
                  });
                  }
                }
              },
              borderColor: Utils.bottleclr,
              titleColor: Utils.bottleclr,
              spashColor: Utils.bottleclr,
              tappedTitleColor: Utils.white,
            ),
          )
        ],
      ),
    );
  }
  Future<InsertionStatus> getstatus() async{
    http.Response response = await ResponseClass.callGetApi(ApiSheet.get_all_data);
    print(response.statusCode);
    print(response.body);
    InsertionStatus data = InsertionStatus.fromJson(json.decode(response.body));
    if(data.status){
      return InsertionStatus.fromJson(json.decode(response.body));
    }
  }
}

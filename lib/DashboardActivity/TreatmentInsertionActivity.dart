import 'dart:convert';
import 'package:painc/DashboardActivity/d.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:painc/ApiClass/GetTreatmentClass.dart';
import 'package:painc/ApiClass/InsertionStatus.dart';
import 'package:painc/ApiClass/treatmenterror.dart';
import 'package:painc/DashboardActivity/MedicationInsertionActivity.dart';
import 'package:painc/DashboardActivity/PainInterferenceInsertionActivity.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/loader.dart';
import 'package:painc/components/roundedbtn.dart';
import 'package:painc/components/treatmentbox.dart';
import 'package:painc/GetX/treatmentcon.dart';

class TreatmentInsertion extends StatefulWidget {
  @override
  _TreatmentInsertionState createState() => _TreatmentInsertionState();
}

class _TreatmentInsertionState extends State<TreatmentInsertion> {
  bool select = false;
  //List indexx = [];
  var hashMap = Map<String, String>();
  TreatmentCon treatmentcontroller = Get.put(TreatmentCon());

  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      backgroundColor: Utils.bottleclr,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: screenheight * .03,
                      left: screenwidth * .05,
                      right: screenwidth * .12),
                  height: screenheight * .25,
                  color: Utils.bottleclr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Utils.whitetext('Treatments', 20.0),
                      Image.asset(
                        'assets/treatment.png',
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 5,
                  child: IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: Utils.white, size: 18),
                      onPressed: () {
                        Get.back();
                        //Get.to(() => MedicationInsertion());
                      }),
                ),
                Positioned(
                    right: 5,
                    child: IconButton(
                        icon: Icon(Icons.info_outline),
                        color: Utils.white,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  PopUp(
                                    ontap: () {
                                      Get.back();
                                    },
                                    description:
                                    'Please select the treatments you have tried for your pain.',
                                    hastitle: false,
                                  ));
                        })),
              ]
            ),
          ),
          Positioned(
            top: screenheight*.27,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
                width: screenwidth,
                padding: EdgeInsets.only(
                  bottom: 0,
                    top: screenheight * .04,
                    left: screenwidth * .05,
                    right: screenwidth * .05),
                decoration: BoxDecoration(
                    color: Utils.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                child: FutureBuilder<GetTreatment>(
                  future: treatmentcontroller.getdata,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      hashMap.clear();
                      return GridView.builder(
                        padding: EdgeInsets.only(
                            bottom: screenheight * .1),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                snapshot.data.data[index].isSelected =
                                !snapshot.data.data[index].isSelected;
                              });
                              if (snapshot.data.data[index].isSelected) {
                                d.indexx.add(snapshot.data.data[index].id);
                              } else {
                                d.indexx.remove(snapshot.data.data[index].id);
                              }
                            },
                            child: TreatMentBox(
                              icon: snapshot.data.data[index].icon,
                              boxcolor: snapshot.data.data[index]
                                  .isSelected == true
                                  ? d.indexx.contains(snapshot.data.data[index])? Utils.white : Utils.yellow
                                  : Utils.white,
                              iconcolor: snapshot.data.data[index]
                                  .isSelected == true
                                  ? d.indexx.contains(snapshot.data.data[index])? Utils.yellow :Utils.white
                                  : Utils.bottleclr,
                              text: snapshot.data.data[index].name,
                              txtcolor: snapshot.data.data[index]
                                  .isSelected == true
                                  ? d.indexx.contains(snapshot.data.data[index])? Utils.yellow : Utils.white
                                  : Utils.lightgrey1,
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                )),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: screenwidth,
              padding: EdgeInsets.only(
                bottom: screenheight * .04,
                left: screenwidth * .08,
                right: screenwidth * .08,),
              color: Utils.white,
              child: PainCButton(
                title: 'Next',
                onTap: () async{
                  showLoadingDialog(context: context);
                  for (int i = 0; i < d.indexx.length; i++) {
                    hashMap["treatment[$i]"] = d.indexx[i].toString();
                  }
                  http.Response response = await ResponseClass.callPostApi(hashMap, ApiSheet.treatment_save);
                  treatmenterror treatment = treatmenterror.fromJson(json.decode(response.body));
                  http.Response res = await ResponseClass.callGetApi(ApiSheet.get_all_data);
                  InsertionStatus data = InsertionStatus.fromJson(json.decode(res.body));
                  var el = data.data.paininterferences == null ? 0.0 :double.parse(data.data.paininterferences.enjoymentLife)*10;
                  var ga = data.data.paininterferences == null ? 0.0 :double.parse(data.data.paininterferences.generalActivity)*10;
                  if(treatment.status){
                    hideLoadingDialog(context: context);
                    Get.back();
                    Get.to(PainInterferenceInsertion(enjoymentol: el, genaralactivity: ga));
                  } else{
                    hideLoadingDialog(context: context);
                    Utils.toast(treatment.message, '', Utils.red.withOpacity(.3));
                  }
                },
                borderColor: Utils.bottleclr,
                titleColor: Utils.bottleclr,
                spashColor: Utils.bottleclr,
                tappedTitleColor: Utils.white,
              ),
            ))
        ],
      ),
    );
  }
}

List data = [
  {
    'name': 'Physiotherapy',
    'svg': 'assets/svg/physiotherapy.svg'
  },
  {
    'name': 'Pain Injections',
    'svg': 'assets/svg/paininjection.svg'
  },
  {
    'name': 'Acupuncture',
    'svg': 'assets/svg/acupuncture.svg'
  },
  {
    'name': 'Tens',
    'svg': 'assets/svg/tens.svg'
  },
  {
    'name': 'Self MGMT Courses',
    'svg': 'assets/svg/selfmgmt.svg'
  },
  {
    'name': 'Pain MGMT Program',
    'svg': 'assets/svg/painmgmt.svg'
  },
  {
    'name': 'None of the Above',
    'svg': 'assets/svg/noneofabove.svg'
  },
];
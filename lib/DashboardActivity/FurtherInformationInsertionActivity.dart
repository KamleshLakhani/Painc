import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/ApiClass/InsertionStatus.dart';
import 'package:painc/DashboardActivity/PainIntensityInsertionActivity.dart';
import 'package:painc/DashboardActivity/PainInterferenceInsertionActivity.dart';
import 'package:painc/DashboardActivity/PainLocationInsertionActivity.dart';
import 'package:painc/DashboardActivity/PainQualityInsertionActivity.dart';
import 'package:painc/DashboardActivity/QoLInsertionActivity.dart';
import 'package:painc/DashboardActivity/TreatmentInsertionActivity.dart';
import 'package:painc/GetX/getfutureinfo.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'dart:convert';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/appbar.dart';
import 'package:painc/components/loader.dart';
import 'package:painc/components/roundedbtn.dart';
import 'package:http/http.dart' as http;

import 'MedicationInsertionActivity.dart';
class FurtherInformationInsertion extends StatefulWidget {
  bool secondtime;
  bool allstepfilled;
  String tnc;
  FurtherInformationInsertion({this.secondtime,this.allstepfilled,this.tnc});
  @override
  _FurtherInformationInsertionState createState() => _FurtherInformationInsertionState();
}

class _FurtherInformationInsertionState extends State<FurtherInformationInsertion> {
  getfutureinfo getinfo = getfutureinfo();
  bool check1 = false;
  bool err;
  RxList useradd = [].obs;
  Color clr1 = Color(0xFFBBBBBB);
  TextEditingController desccontroller = new TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      appBar: CustAppbar(
        onbackpress: (){
          Get.back();
          //Get.to(()=>QoLInsertion());
          },
        infobtn: true,
        txt: 'Additional Information',
        onPressed: (){
          showDialog(context: context, builder: (context) => PopUp(
            ontap: (){Get.back();},
            description: 'A variety of medical conditions and operations can cause pain. Or you might have had operations to relieve your pain. Please list them to help us understand your pain',
          ));
        },
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Utils.sizeBoxHeight(screenheight * .03),
                Container(
                    width: screenwidth * .6,
                    child: Text(
                        'Please enter relevant information to your pain condition.',//'Please list your medical conditions or operations you have had.',
                        textAlign: TextAlign.center,
                        style: Utils.googlenunitoreg(14.0, Utils.grey))),
                Utils.sizeBoxHeight(screenheight * .03),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenwidth*.05,vertical: screenheight*.005),
                  margin: EdgeInsets.symmetric(horizontal: screenwidth*.1),
                  height: screenheight*.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFFF6F6F6)
                    ),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      autofocus: false,
                  maxLines: null,
                  controller:desccontroller,
                  decoration:  InputDecoration(
                    border: InputBorder.none,
                  )),
                )
              ],
            ),
            Positioned(
                bottom: screenheight*.04,
                left: screenwidth*.08,
                right: screenwidth*.08,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              border: Border.all(width:2.5,color:clr1)
                          ),
                          child: Theme(
                            data: ThemeData(
                                unselectedWidgetColor: Colors.transparent
                            ),
                            child: Checkbox(
                                splashRadius: 0.0,
                                value: check1,
                                checkColor: Color(0xff0ABC69),
                                activeColor: Colors.transparent,
                                onChanged: desccontroller.text.length == 0 ? (val){
                                  Utils.toast('Please Enter Description', '', Utils.red.withOpacity(.4));
                                } :(val) {
                                  if(val == true){
                                    setState(() {
                                      err = true;
                                      clr1 = Utils.lightgrey1;
                                    });
                                  }
                                  setState(() {
                                    check1 = val;
                                  });
                                }),
                          ),
                        ),
                        Utils.sizeBoxWidth(screenwidth*.025),
                        Expanded(
                            child: InkWell(
                              onTap: (){
                                showDialog(context: context, builder: (context) {
                                  return PopUp(
                                    title: 'Terms & Conditions',
                                    hastitle: true,
                                    description: 'We collect and securely process your personal and special data to deliver a relevant experience and support our business. By continuing, you confirm that you have read T & Cs, Privacy policy and Cookies Policy.',//'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                                    ontap: (){Get.back();},
                                  );
                                });
                              },
                              child: Text('I confirm the data input is accurate',
                                  style: Utils.greytxtstyl()),
                            ))
                      ],
                    ),
                    Utils.sizeBoxHeight(screenheight*.01),
                    Visibility(visible: err == false ? true : false,child: Container(padding: EdgeInsets.only(left: screenwidth*.08),alignment: Alignment.centerLeft,child: Text('please select the checkbox',style: Utils.boldtxt(12.0, Utils.red),))),
                    Utils.sizeBoxHeight(screenheight*.025),
                    PainCButton(
                      title: widget.secondtime == true ? 'Update' : 'Accept & Generate Report',
                      onTap: () async{
                      if(check1 == false){
                        setState(() {
                          err = false;
                          clr1 = Utils.red;
                        });
                      }else {
                        if(desccontroller.text.length == 0){
                          Utils.toast('Please Enter Description', '', Utils.red.withOpacity(.4));
                        }else{
                          showLoadingDialog(context: context);
                          http.Response response = await ResponseClass.callGetApi(ApiSheet.get_all_data);
                          InsertionStatus instatus = InsertionStatus.fromJson(json.decode(response.body));
                          if(instatus.status){
                            hideLoadingDialog(context: context);
                            if(widget.secondtime == false && instatus.data.painlocation == null){
                              Get.back();
                              Get.to(()=>PainLocationInsertion());
                            }
                            else if(widget.secondtime == false && instatus.data.painintensity == null){
                              double main = instatus.data.painintensity == null ? 0.0*10 :instatus.data.painintensity.painIntensity.runtimeType == int ? instatus.data.painintensity.painIntensity*10.toDouble() : instatus.data.painintensity.painIntensity*10;
                              Get.back();
                              Get.to(()=>PainIntensityInsertion(pointer: main));
                            }
                            else if(widget.secondtime == false && instatus.data.painquallity.isEmpty){
                              useradd.clear();
                              if(!instatus.data.painquallity.isBlank){
                                instatus.data.painquallity.forEach((element){
                                  useradd.add(element.descriptor.name);
                                });
                              }
                              Get.back();
                              Get.to(()=>PainQualityInsertion(userdesc: useradd.isBlank ? null : useradd,));
                            }
                            else if(widget.secondtime == false && instatus.data.medication.isBlank){
                              Get.back();
                              Get.to(()=>MedicationInsertion());
                            }
                            else if(widget.secondtime == false && instatus.data.treatments == null){
                              Get.back();
                              Get.to(()=>TreatmentInsertion());
                            }
                            else if(widget.secondtime == false &&instatus.data.paininterferences == null){
                              var el = instatus.data.paininterferences == null ? 0.0 :double.parse(instatus.data.paininterferences.enjoymentLife)*10;
                              var ga = instatus.data.paininterferences == null ? 0.0 :double.parse(instatus.data.paininterferences.generalActivity)*10;
                              Get.back();
                              Get.to(PainInterferenceInsertion(enjoymentol: el, genaralactivity: ga,));
                            }
                            else if(widget.secondtime == false &&instatus.data.qualityoflife == null){
                              double thermval = instatus.data.qualityoflife == null ? 0.0 :double.parse(instatus.data.qualityoflife.helth_thermometer);
                              Get.back();
                              Get.to(()=>QoLInsertion(thermvalue: thermval));
                            }
                            // if(widget.allstepfilled == false){
                            //   Utils.toast('Please Fill All The Steps', '', Utils.red.withOpacity(.4));
                            // }
                            else{
                              getinfo.desc = desccontroller.text.trim();
                              var secondtime = widget.secondtime;
                              getinfo.insertdata(context,secondtime);
                            }
                          }
                        }
                      }},
                      borderColor: Utils.bottleclr,
                      titleColor: Utils.bottleclr,
                      spashColor: Utils.bottleclr,
                      tappedTitleColor: Utils.white,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}


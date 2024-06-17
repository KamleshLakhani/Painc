import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/ApiClass/GetDescriptor.dart';
import 'package:painc/DashboardActivity/MedicationInsertionActivity.dart';
import 'package:painc/DashboardActivity/PainIntensityInsertionActivity.dart';
import 'package:painc/GetX/painquality_insertion.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/appbar.dart';
import 'package:painc/components/roundedbtn.dart';

class PainQualityInsertion extends StatefulWidget {
  RxList userdesc;
  PainQualityInsertion({this.userdesc});
  @override
  _PainQualityInsertionState createState() => _PainQualityInsertionState();
}
class _PainQualityInsertionState extends State<PainQualityInsertion> {
 /* List add = [];
  Map<String,bool> values = {
    'dull ache' : false,
    'dull ' : false,
    'sharp' : false,
    'cramping' : false,
    'stabbing' : false,
    'stinging' : false,
    'annoying' : false,
  };
  getCheckboxItems(){
    values.forEach((key, value) {
      if(value == true)
      {
        add.add(key);
      }
    });
    print(add);
    add.clear();
  }*/
  PainQuality_Insertion pq_ins = Get.put(PainQuality_Insertion());
  bool ind = false;
  @override
  void initState() {
    Get.put(PainQuality_Insertion());
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
          //Get.to(()=>PainIntensityInsertion());
          },
        infobtn: true,
        onPressed: (){
          showDialog(context: context, builder: (context) {
            return PopUp(description: 'Please select the words that describe the pain you experience.',ontap: (){Get.back();});
          });
        },
        txt: 'Pain Quality',
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenheight*.15,
            child: Container(
              color: Utils.bottleclr,
            ),
          ),
          Positioned(
              top:screenheight*.09,
              left: screenwidth*.065,
              right: screenwidth*.065,
              child: Container(
                  height:screenheight*.6,
                padding: EdgeInsets.only(left: screenwidth*.03,right: screenwidth*.03,top: screenheight*.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Utils.white,
                boxShadow: [BoxShadow(blurRadius: 8.0,spreadRadius: 1.0,color: Utils.grey.withOpacity(0.2),offset: Offset(3.0,5.0))]
                ),
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Utils.darkbluetxt('Pain Descriptors',20.0),
                          Utils.sizeBoxHeight(3.0),
                          Text('Choose as many words as you like to describe the pain.', style: Utils.googlenunitoreg(14.0,Utils.lightgrey1),),
                          Utils.sizeBoxHeight(screenheight*.02),
                          Flexible(
                            child: DelayedDisplay(
                              delay: Duration(milliseconds: 30),
                              fadeIn: true,
                              child: GetX<PainQuality_Insertion>(
                                  builder: (controller) {
                                    try{
                                      print(controller.tagmap);
                                      if(controller.tagmap.isEmpty){
                                        Future.delayed(Duration(seconds: 1),(){
                                          setState(() {});
                                        });
                                        return Center(child: CircularProgressIndicator());
                                      }
                                else if(controller.tagmap != {} && controller.tagmap.keys != null){
                                    return Wrap(
                                      spacing: 10.0,
                                      runSpacing: 10.0,
                                      children: controller.tagmap.keys.map((String key){
                                        return GestureDetector(
                                          onTap: (){controller.tagmap[key] = !controller.tagmap[key];},
                                          child: Container(
                                              padding: EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.0),color:controller.tagmap[key] == true ? Utils.bottleclr : Utils.lightgrey2),
                                              child: Utils.semibold(key, 14.0,controller.tagmap[key] == true ? Utils.white : Utils.darkblue)),
                                        );
                                      }).toList(),
                                    );
                                }}catch(e){
                                      print(e);
                                      return Center(child: CircularProgressIndicator());
                                    }return Center(child: CircularProgressIndicator());
                              })
                            ),
                          ),
                        ],
                      ))),
          Positioned(
              bottom: screenheight*.04,
              left: screenwidth*.08,
              right: screenwidth*.08,
              child:PainCButton(
                title: 'Next', onTap: (){
                pq_ins.getCheckboxItems(context);
                  //pq_ins.insertioncontroller();
                  },
                borderColor: Utils.bottleclr,
                titleColor: Utils.bottleclr,
                spashColor: Utils.bottleclr,
                tappedTitleColor: Utils.white,
              ),/*RoundedBtn(
                ontap: () {
                  Get.back();
                  Get.to(MedicationInsertion());},
                btnclr: Utils.bottleclr,
                btntxtclr: Utils.white,
                txt: 'Next',
              )*/)
        ],
        ),
    ),
    /*floatingActionButton: FloatingActionButton(
      onPressed: (){
        print('IDIDID ${pq_ins.tagmap}');
        print('IDIDID ${widget.userdesc}');
      }
    )*/);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:painc/DashboardActivity/FurtherInformationInsertionActivity.dart';
import 'package:painc/DashboardActivity/PainInterferenceInsertionActivity.dart';
import 'package:painc/GetX/getqulityoflife.dart';
import 'package:painc/GetX/getqulityoflife.dart';

import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/appbar.dart';
import 'package:painc/components/roundedbtn.dart';

class QoLInsertion extends StatefulWidget {
  double thermvalue;
  QoLInsertion({this.thermvalue});
  @override
  _QoLInsertionState createState() => _QoLInsertionState();
}

class _QoLInsertionState extends State<QoLInsertion> {

  double _lowervalue = 0.0;
  double _uppervalue = 100.0;
  getQulityoflife getqulityoflife = getQulityoflife();

  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      appBar: CustAppbar(
        onbackpress: () {
          Get.back();
          //Get.to(() => PainInterferenceInsertion());
        },
        txt: 'Quality Of Life',
        infobtn: true,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => PopUp(
                    title: '',
                    description:
                        'Quality of life includes problems with physical activities, socialising, treatment burden, emotional feelings, relationships, problems at work/home and your thoughts about future. Health Thermometer captures the overall quality of life.',
                    ontap: () {
                      Get.back();
                    },
                  ));
        },
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Utils.sizeBoxHeight(screenheight * .03),
            Container(
                width: screenwidth * .6,
                child: Text(
                    'Please rate your Quality of Life in the last 24 hours.',
                    textAlign: TextAlign.center,
                    style: Utils.googlenunitoreg(14.0, Utils.grey))),
            Utils.sizeBoxHeight(screenheight * .015),
            Utils.btlclrboldtext('Health Thermometer on this Scale', 18.0),
           /* Utils.sizeBoxHeight(screenheight * .01),
            Utils.btlclrboldtext('On this Scale', 14.0),*/
            Utils.sizeBoxHeight(screenheight * .02),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: '0 - ', style: Utils.boldtxt(14.0, Utils.bottleclr)),
              TextSpan(
                  text: 'the worst I have ever been',
                  style: Utils.googlenunitoreg(14.0, Utils.lightgrey1))
            ])),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: '100 - ', style: Utils.boldtxt(14.0, Utils.bottleclr)),
              TextSpan(
                  text: 'the best I have ever been',
                  style: Utils.googlenunitoreg(14.0, Utils.lightgrey1))
            ])),
            Utils.sizeBoxHeight(screenheight * .02),
            Container(
              margin: EdgeInsets.only(right: screenwidth*.16),
              height: screenheight*.42,
              width: screenwidth*.58,
              padding: EdgeInsets.only(right: screenwidth * .12,bottom: screenheight*.055,left: screenwidth*.09),
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.centerRight,
                  image: AssetImage('assets/thermometer.png'),
                )
              ),
              child: FlutterSlider(
                axis: Axis.vertical,
                values: [widget.thermvalue, _uppervalue],
                max: 100.0,
                min: 0.0,
                jump: true,
                onDragging: (handlerindex, lowervalue, uppervalue) {
                  widget.thermvalue = lowervalue;
                  getqulityoflife.valuqol = widget.thermvalue;
                  print('lowervalue ${widget.thermvalue}');
                  setState(() {

                  });
                  //setState(() {});
                },
                rtl: true,
                handlerWidth: screenwidth * .15,
                tooltip: FlutterSliderTooltip(
                    textStyle: TextStyle(color: Colors.transparent),
                    boxStyle: FlutterSliderTooltipBox(
                        decoration:
                        BoxDecoration(color: Colors.transparent))),
                handler: FlutterSliderHandler(
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: Container(
                      child: Image.asset('assets/thermhandler.png'),
                    )),
                trackBar: FlutterSliderTrackBar(
                    inactiveTrackBar:
                    BoxDecoration(color: Colors.transparent),
                    activeTrackBar:
                    BoxDecoration(color: Colors.transparent)),
              ),/*Image.asset(
                'assets/thermometer.png',
                height: screenheight * .4,
              ),*/
            ),
            Utils.sizeBoxHeight(screenheight * .01),
            Text('${widget.thermvalue.toInt()}',
                style: Utils.boldtxt(45.0, Utils.black)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: screenheight*.1,
        padding: EdgeInsets.only(
            left: screenwidth * .08,
            right: screenwidth * .08,
            bottom: screenheight * .04),
        child: PainCButton(
          title: 'Next',
          onTap: () {
            // Get.back();
            // Get.to(FurtherInformationInsertion());
            getqulityoflife.insertdata(context);
          },
          borderColor: Utils.bottleclr,
          titleColor: Utils.bottleclr,
          spashColor: Utils.bottleclr,
          tappedTitleColor: Utils.white,
        ),
      ),
    );
  }
}

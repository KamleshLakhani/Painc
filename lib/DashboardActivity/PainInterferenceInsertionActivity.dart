import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:painc/DashboardActivity/QoLInsertionActivity.dart';
import 'package:painc/DashboardActivity/TreatmentInsertionActivity.dart';
import 'package:painc/GetX/getPainInterference.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/appbar.dart';
import 'package:painc/components/roundedbtn.dart';

class PainInterferenceInsertion extends StatefulWidget {
  final double genaralactivity;
  final double enjoymentol;
  PainInterferenceInsertion({this.genaralactivity, this.enjoymentol});
  @override
  _PainInterferenceInsertionState createState() =>
      _PainInterferenceInsertionState();
}

class _PainInterferenceInsertionState extends State<PainInterferenceInsertion> {
  getPainInterference pi_datai = getPainInterference();

  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      appBar: CustAppbar(
        txt: 'Pain Interference',
        infobtn: true,
        onbackpress: () {
          Get.back();
          //Get.to(() => TreatmentInsertion());
        },
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: screenwidth,
                          padding: EdgeInsets.only(
                              top: screenheight * .035,
                              left: screenwidth * .04,
                              right: screenwidth * .04),
                          child: Column(
                            children: [
                              Container(
                                  child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: Utils.googlenunitoreg(
                                        14, Utils.lightgrey1),
                                    children: [
                                      TextSpan(
                                          text:
                                              'Pain interferes with all aspects of our life. Please indicate how much it influences your '),
                                      TextSpan(
                                          text: 'General Activity ',
                                          style: Utils.boldtxt(
                                              14.0, Utils.bottleclr)),
                                      TextSpan(text: 'and '),
                                      TextSpan(
                                          text: 'Enjoyment of Life. ',
                                          style: Utils.boldtxt(
                                              14.0, Utils.bottleclr)),
                                      TextSpan(
                                          text:
                                              'on a scale of 0 to 10 with 0 being \'does not interfere\' and 10 being \'completely interferes’. '),
                                    ]),
                              )),
                              Utils.sizeBoxHeight(screenheight * .03),
                              Container(
                                  width: screenwidth * .4,
                                  height: screenheight * .06,
                                  child: PainCButton(
                                    title: 'OK',
                                    onTap: () => Get.back(),
                                    titleColor: Utils.bottleclr,
                                    borderColor: Utils.bottleclr,
                                    spashColor: Utils.bottleclr,
                                    tappedTitleColor: Utils.white,
                                  ) /*RoundedBtn(
                                  ontap: () => Get.back(),
                                  btnclr: Utils.bottleclr,
                                  btntxtclr: Utils.white,
                                  txt: 'OK',
                                ),*/
                                  ),
                              Utils.sizeBoxHeight(screenheight * .03),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
        },
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: screenwidth * .05,
                  right: screenwidth * .05,
                  top: screenheight * .03),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                        style: Utils.googlenunitoreg(18.0, Utils.darkblue),
                        children: [
                          TextSpan(
                              text:
                                  '1. Please indicate how much your pain has interfered with your '),
                          TextSpan(
                              text: 'General Activity ',
                              style: Utils.boldtxt(18.0, Utils.bottleclr)),
                          TextSpan(
                              text: 'in the last 24 hours.'),
                        ]),
                  ),
                  Utils.sizeBoxHeight(screenheight * .08),
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 22, left: 10, right: 10),
                        child: Image.asset(
                          'assets/scale.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      FlutterSlider(
                        min: 0,
                        max: 100,
                        values: [widget.enjoymentol, 100],
                        handler: FlutterSliderHandler(
                            foregroundDecoration: BoxDecoration(
                                color: Utils.white,
                                border:
                                    Border.all(color: Utils.grey, width: 8.0),
                                shape: BoxShape.circle)),
                        tooltip: FlutterSliderTooltip(custom: (value) {
                          // var data = value/10;
                          // print('dddimm${data}');
                          pi_datai.genrallife = value / 10;
                          print('DIM  ${pi_datai.genrallife}');
                          return Container(
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/tooltipboxgreen.png'),
                            )),
                            child: Text(pi_datai.genrallife.toString(),
                                textAlign: TextAlign.center,
                                style: Utils.boldtxt(18.0, Utils.white)),
                          );
                        }
                            /*format: (String value) {
                              var data = double.parse(value)/10;
                              print(data);
                              return data.toString();
                            },
                            textStyle: Utils.boldtxt(18.0, Utils.white),
                            boxStyle: FlutterSliderTooltipBox(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/tooltipboxgreen.png'),
                                    )))),*/
                            ),
                        trackBar: FlutterSliderTrackBar(
                            inactiveTrackBar:
                                BoxDecoration(color: Colors.transparent),
                            activeTrackBar:
                                BoxDecoration(color: Colors.transparent)),
                      ),
                    ],
                  ),
                  Utils.sizeBoxHeight(screenheight * .02),
                  Divider(color: Color(0xFF707070)),
                  Utils.sizeBoxHeight(screenheight * .02),
                  RichText(
                    text: TextSpan(
                        style: Utils.googlenunitoreg(18.0, Utils.darkblue),
                        children: [
                          TextSpan(
                              text:
                                  '2. Please indicate how much your pain has interfered with your '),
                          TextSpan(
                              text: 'Enjoyment of Life ',
                              style: Utils.boldtxt(18.0, Utils.bottleclr)),
                          TextSpan(
                              text: 'in the last 24 hours.'),
                        ]),
                  ),
                  Utils.sizeBoxHeight(screenheight * .08),
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 22, left: 10, right: 10),
                        child: Image.asset(
                          'assets/scale.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      FlutterSlider(
                        min: 0,
                        max: 100,
                        values: [widget.genaralactivity, 100],
                        handler: FlutterSliderHandler(
                            foregroundDecoration: BoxDecoration(
                                color: Utils.white,
                                border:
                                    Border.all(color: Utils.grey, width: 8.0),
                                shape: BoxShape.circle)),
                        tooltip: FlutterSliderTooltip(custom: (value) {
                          // var data = value/10;

                          pi_datai.enjoylife = value / 10;
                          print('DIM  ${pi_datai.enjoylife}');
                          return Container(
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/tooltipbox.png'),
                            )),
                            child: Text(pi_datai.enjoylife.toString(),
                                textAlign: TextAlign.center,
                                style: Utils.boldtxt(18.0, Utils.white)),
                          );
                        }
                            /*format: (String value) {
                              var data = double.parse(value)/10;
                              print(data);
                              return data.toString();
                            },
                            textStyle: Utils.boldtxt(18.0, Utils.white),
                            boxStyle: FlutterSliderTooltipBox(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/tooltipboxgreen.png'),
                                    )))),*/
                            ),
                        trackBar: FlutterSliderTrackBar(
                            inactiveTrackBar:
                                BoxDecoration(color: Colors.transparent),
                            activeTrackBar:
                                BoxDecoration(color: Colors.transparent)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: screenheight * .04,
              left: screenwidth * .08,
              right: screenwidth * .08,
              child: PainCButton(
                title: 'Next',
                onTap: () {
                  //     Get.back();
                  // Get.to(QoLInsertion());
                  pi_datai.insertdata(context);
                },
                borderColor: Utils.bottleclr,
                titleColor: Utils.bottleclr,
                spashColor: Utils.bottleclr,
                tappedTitleColor: Utils.white,
              ), /*RoundedBtn(
                  ontap: () {Get.back();
                  Get.to(QoLInsertion());},
                  btnclr: Utils.bottleclr,
                  btntxtclr: Utils.white,
                  txt: 'Next',
                )*/
            )
          ],
        ),
      ),
    );
  }
}

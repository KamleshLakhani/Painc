import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/appbar.dart';
import 'package:painc/GetX/painintensity_insertion.dart';

class PainIntensityInsertion extends StatefulWidget {
  final double pointer;
  PainIntensityInsertion({this.pointer});
  @override
  _PainIntensityInsertionState createState() => _PainIntensityInsertionState();
}

class _PainIntensityInsertionState extends State<PainIntensityInsertion> {
  PainIntensity_Insertion pi_data = PainIntensity_Insertion();
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      appBar: CustAppbar(
        onbackpress: () {
          Get.back();
         // Get.to(() => PainLocationInsertion());
        },
        txt: 'Pain Intensity',
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
                      'Please rate your average pain in the last 24 hours.',
                );
              });
        },
        infobtn: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Utils.sizeBoxHeight(screenheight * .05),
                Container(
                    width: screenwidth * .6,
                    child: Text(
                        'Please rate your average pain in the last 24 hours',
                        textAlign: TextAlign.center,
                        style: Utils.googlenunitoreg(14.0, Utils.grey))),
                Utils.sizeBoxHeight(screenheight * .04),
                Container(
                    padding: EdgeInsets.all(25),
                    width: screenwidth,
                    child: Image.asset(
                      'assets/pigraph.jpg',
                      fit: BoxFit.cover,
                    )),
                Utils.sizeBoxHeight(screenheight * .04),
                Container(
                  padding: EdgeInsets.only(
                      left: screenwidth * .07, right: screenwidth * .07),
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 22),
                        child: Image.asset(
                          'assets/scale.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      FlutterSlider(
                        min: 0,
                        max: 100,
                        values: [widget.pointer, 100],
                        handler: FlutterSliderHandler(
                            foregroundDecoration: BoxDecoration(
                                color: Utils.white,
                                border:
                                    Border.all(color: Utils.grey, width: 8.0),
                                shape: BoxShape.circle)),
                        tooltip: FlutterSliderTooltip(
                            custom: (value) {
                          pi_data.value = value / 10;
                          print('Dim ${pi_data.value}');
                          print('Dimdsfa ${pi_data.value*10}');
                          //var data = value/10;
                          //pi_data.pidata = data.toString().obs;
                          return Container(
                            alignment: Alignment.center,
                            padding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('assets/tooltipbox.png'),
                            )),
                            child: Text(pi_data.value.toString(),
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
                ),
                Utils.sizeBoxHeight(screenheight * .02),
                Container(
                    alignment: Alignment.center,
                    width: screenwidth * .7,
                    child: Utils.semiboldtext(
                        'Move the slider to indicate your pain',
                        16.0,
                        Utils.lightgrey1.withOpacity(.7))),
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
                pi_data.insertdata(context);
              },
              borderColor: Utils.bottleclr,
              titleColor: Utils.bottleclr,
              spashColor: Utils.bottleclr,
              tappedTitleColor: Utils.white,
            ), /*RoundedBtn(
                ontap: () {
                  Get.back();
                  Get.to(PainQualityInsertion());},
                btnclr: Utils.bottleclr,
                btntxtclr: Utils.white,
                txt: 'Next',
              )*/
          )
        ],
      ),
    );
  }
}

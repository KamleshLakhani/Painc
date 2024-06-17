import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/Utils/routes.dart';
import 'package:painc/components/roundedbtn.dart';
import '../screens/LoginActivity.dart';
import 'continue2.dart';

class Continue1 extends StatefulWidget {
  final PageController pageid;

  Continue1({this.pageid});

  @override
  _Continue1State createState() => _Continue1State();
}

class _Continue1State extends State<Continue1> {

  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      backgroundColor: Color(0xFFF8EEB6),
      body: Container(
        padding: EdgeInsets.only(top: screenheight*.04),
        width: screenwidth,
        height: screenheight,
        child: Stack(
          children: [
            SvgPicture.asset('assets/con1.svg', width: screenwidth,
              height: screenheight / 2 + 20,
              fit: BoxFit.contain),
            Positioned(
              left: screenwidth * .04,
              right: screenwidth * .04,
              bottom: screenheight * .02,
              child: Container(
                height: screenheight / 2 + 20,
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Utils.yellow,
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    Positioned(top: screenheight * .05, child:
                    Utils.dots(Utils.bottleclr, () {},
                        Utils.white, () {
                      widget.pageid.animateToPage(1,duration: Duration(
                          milliseconds: 400), curve: Curves.easeIn);
                    }, Utils.white,(){
                          widget.pageid.animateToPage(2,duration: Duration(milliseconds: 400), curve: Curves.easeIn);
                        })),
                    Positioned(
                      top: screenheight * .12,
                      child: Column(
                        children: [
                          Utils.darkbluetxt("Locate your pain",screenwidth*.05),
                          Utils.sizeBoxHeight(10),
                          Container(
                            width: screenwidth * .7,
                            child: Text(
                                "You can pinpoint the exact location of your pain using our interactive bodymap",
                                textAlign: TextAlign.center,
                                style: Utils.googlenunitoreg(screenwidth*.05, Utils.white)),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: screenheight * .1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenwidth * .09),
                        width: screenwidth * .9,
                        child: RoundedBtn(
                          ontap: () {
                            widget.pageid.animateToPage(1,duration: Duration(
                                milliseconds: 400), curve: Curves.easeIn);
                          },
                          txt: "Continue",
                          btntxtclr: Utils.darkblue,
                          btnclr: Utils.white,
                        ),
                      ),),
                    Positioned(
                      bottom: screenheight * .03,
                      child: GestureDetector(
                          onTap: () {
                            Get.offAll(()=>Login());
                          },
                          child: Utils.whitetext('Skip', 22.0)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



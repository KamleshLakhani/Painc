import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/roundedbtn.dart';
import 'package:painc/screens/LoginActivity.dart';

class Continue3 extends StatefulWidget {
  final PageController pageid;
  Continue3({this.pageid});
  @override
  _Continue3State createState() => _Continue3State();
}

class _Continue3State extends State<Continue3> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      backgroundColor: Color(0xFFF8EEB6),
      body: SafeArea(
        child: Container(
          width: screenwidth,
          height: screenheight,
          child: Stack(
            children: [
              SvgPicture.asset('assets/con3.svg',width:screenwidth,height: screenheight*.45,fit: BoxFit.cover,),
              Positioned(
                left: screenwidth*.04,
                right: screenwidth*.04,
                bottom: screenheight*.02,
                child: Container(
                  height: screenheight / 2 + 20,
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: Utils.yellow, borderRadius: BorderRadius.circular(20)),
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      Positioned(top:screenheight*.05,child: Utils.dots(Utils.white,(){
                        widget.pageid.animateToPage(0,duration: Duration(
                            milliseconds: 400), curve: Curves.easeIn);
                      }, Utils.white, (){widget.pageid.animateToPage(1,duration: Duration(
                          milliseconds: 400), curve: Curves.easeIn);},Utils.bottleclr,(){})),
                      Positioned(
                        top: screenheight*.12,
                        child: Column(
                          children: [
                            Utils.darkbluetxt('Track your progress',screenwidth*.05),
                            Utils.sizeBoxHeight(10),
                            Container(
                              width: screenwidth*.7,
                              child: Text(
                                  "Recognise trends, identify patterns, and create reports for your doctor or therapist",
                                  textAlign: TextAlign.center,
                                  style: Utils.googlenunitoreg(screenwidth*.05, Utils.white)),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: screenheight*.1,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: screenwidth*.09),
                          width: screenwidth*.9,
                          child: RoundedBtn(
                            ontap: () {
                              Get.offAll(()=>Login());
                            },
                            txt: "Continue",
                            btntxtclr: Utils.darkblue,
                            btnclr: Utils.white,
                          ),
                        ),),
                      Positioned(
                        bottom: screenheight*.03,
                        child: GestureDetector(
                            onTap: (){
                              Get.offAll(()=>Login());
                            },
                            child: Utils.whitetext('Skip',22.0)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),/*Stack(
        children: [
          Image.asset('assets/c3.png',
              height: screenheight, width: screenwidth, fit: BoxFit.fill),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Container(
              padding: EdgeInsets.only(top: 10),
              width: screenwidth,
              height: screenheight / 2 + 20,
              decoration: BoxDecoration(
                  color: Utils.yellow, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Utils.dots(Utils.white, Utils.white, Utils.bottleclr),
                  Column(
                    children: [
                      Text("Track your progress",
                          style:
                          TextStyle(color: Utils.darkblue, fontSize: 20)),
                      Utils.sizeBoxHeight(10),
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Text(
                            "Recognise trends, identity, patterns, and create reports for your doctor or therapist",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Utils.white, fontSize: 20)),
                      ),
                    ],
                  ),
                  Column(children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: screenwidth*.09),
                      width: screenwidth,
                      child: RoundedBtn(
                        ontap: () {
                          Get.to(Login());
                        },
                        txt: "Continue",
                        btntxtclr: Utils.darkblue,
                        btnclr: Utils.white,
                      ),
                    ),
                    Utils.sizeBoxHeight(screenheight*.01),
                    GestureDetector(
                        onTap: (){
                          Get.offAll(Login());
                        },
                        child: Utils.whitetext('Skip',22.0))
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),*/
    );
  }
}

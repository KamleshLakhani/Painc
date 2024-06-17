import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/roundedbtn.dart';
import 'package:painc/screens/LoginActivity.dart';

class Continue2 extends StatefulWidget {
  final PageController pageid;
  Continue2({this.pageid});

  @override
  _Continue2State createState() => _Continue2State();
}

class _Continue2State extends State<Continue2> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      backgroundColor: Color(0xFFE7F8F8),
      body: Container(
        width: screenwidth,
        height: screenheight,
        child: Stack(
          children: [
            Container(padding: EdgeInsets.only(left: screenwidth*.04),child: SvgPicture.asset('assets/con2.svg',width:screenwidth,height: screenheight*.7,fit: BoxFit.cover,)),
            Positioned(
              left: screenwidth*.04,
              right: screenwidth*.04,
              bottom: screenheight*.02,
              child: Container(
                height: screenheight / 2 + 20,
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Utils.bottleclr, borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    Positioned(top:screenheight*.05,child: Utils.dots(Utils.white,(){
                      widget.pageid.animateToPage(0,duration: Duration(
                        milliseconds: 400), curve: Curves.easeIn);}, Utils.yellow,(){} ,Utils.white,(){
                      widget.pageid.animateToPage(2,duration: Duration(
                          milliseconds: 400), curve: Curves.easeIn);
                    })),
                    Positioned(
                      top: screenheight*.12,
                      child: Column(
                        children: [
                          Utils.darkbluetxt('Tell us more', screenwidth*.05),
                          Utils.sizeBoxHeight(10),
                          Container(
                            width: screenwidth*.7,
                            child: Text(
                                "Log your details such as pain intensity and medications to track your pain and treatment",
                                textAlign: TextAlign.center,
                                style: Utils.googlenunitoreg(screenwidth*.05, Utils.white))),
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
                            widget.pageid.animateToPage(2,duration: Duration(
                                milliseconds: 400), curve: Curves.easeIn);
                            //Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: Continue3()));
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
        ),/* Stack(
          children: [
            //SvgPicture.asset('assets/con2.svg',width:screenwidth,height: screenheight/2+20,fit: BoxFit.cover,),
            Image.asset('assets/con2.png',
                height: screenheight/2+80, width: screenwidth, fit: BoxFit.cover),
            Positioned(
              left: screenwidth*.04,
              right: screenwidth*.04,
              bottom: screenheight*.02,
              child: Container(
                padding: EdgeInsets.only(top: 10),

                width: screenwidth,
                height: screenheight / 2 + 20,
                decoration: BoxDecoration(
                    color: Utils.bottleclr, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Utils.dots(Utils.white, Utils.yellow, Utils.white),
                    Column(
                      children: [
                        Text("Tell us more",
                            style:
                            TextStyle(color: Utils.darkblue, fontSize: screenwidth*.05)),
                        Utils.sizeBoxHeight(10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: screenwidth*.09),
                          child: Text(
                              "Log your details such as pain intensity and medications to track your pain and treatment",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Utils.white, fontSize: screenwidth*.05)),
                        ),
                      ],
                    ),
                    Column(children: [
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        width: screenwidth,
                        child: RoundedBtn(
                          ontap: () {
                            Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: Continue3()));
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
      ),
    );
  }
}

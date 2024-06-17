import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/roundedbtn.dart';
import 'package:painc/screens/Dashboard.dart';

import 'splashpages.dart';


class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {

  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      body: Container(
        width: screenwidth,
        height: screenheight,
        child: Stack(
          children: [
            Positioned(right: 0,child: SvgPicture.asset('assets/svg/g1.svg',width: screenwidth*.5)),
            Positioned(bottom:0,child: SvgPicture.asset('assets/svg/g2.svg',width: screenwidth)),
            Positioned(bottom:-screenheight*.05,left: -screenwidth*.19,height:screenheight*.6,child: Image.asset('assets/svg/doc2.png',fit: BoxFit.contain,)),
            /*Utils.imageAssets(
                'assets/getstarted.png', screenwidth, screenheight),*/
            Positioned(
                left: screenwidth * .15,
                top: screenheight * .15,
                child: Column(children: [
                  Utils.svg('assets/black-logo.svg',screenwidth*.15,screenheight*.075),
                  SizedBox(height: screenheight * .03),
                Container(
                  width: screenwidth*.42,
                  child: PainCButton(
                    title: 'Get Started', onTap: (){Get.to(()=>SplashPages());},
                    borderColor: Utils.yellow,
                    titleColor: Utils.yellow,
                    spashColor: Utils.yellow,
                    tappedTitleColor: Utils.darkblue,
                    fontWeight: FontWeight.bold,
                  ),/*RoundedBtn(
                    ontap: (){
                      //_authenticate();
                      Get.to(SplashPages());
                      //Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: SplashPages()));
                    },
                    btnclr: Utils.yellow,
                    btntxtclr: Utils.darkblue,
                    txt: "Get Started",
                  ),*/
                ),
                ]))
          ],
        ),
      ),
    );
  }
}

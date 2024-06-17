import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/appbar.dart';

class AboutUsActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = Utils.getWidth(context);
    var screenHeight = Utils.getHeight(context);
    return Scaffold(
      appBar: CustAppbar(
        infobtn: false,
        txt: 'About us',
        onbackpress: ()=>Get.back(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth*.03,vertical: screenHeight*.025),
        height: screenHeight,
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start  ,
          children: [
            Container(
              width: screenWidth,
              padding: EdgeInsets.symmetric(vertical: screenWidth*.03,horizontal: screenHeight*.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Utils.bottleclr.withOpacity(0.1)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Utils.svg('assets/svg/fulllogo.svg', screenWidth*.2, screenHeight*.06)),
                    SizedBox(height: screenHeight*.03),
                    // Utils.darkbluetxt('Kumar Pain Management', 16.0),
                    // SizedBox(height: screenHeight*.01),
                    // Utils.semibold('346, Queens Road, Aberdeen, Scotland', 14.0,Utils.darkblue),
                    // Utils.semibold('Email: info@painc.co.uk', 14.0,Utils.darkblue),
                   SizedBox(height: screenHeight*.02),
                    Utils.semibold('Kumar Pain Management Ltd is a private limited company delivering healthcare service registered in Scotland under company number SC 386213.',14.0,Utils.darkblue),
                    SizedBox(height: screenHeight*.02),
                    Utils.semibold('We offer online telehealth services enabling you to report health history, track the progress of your health and engage healthcare professionals to obtain medical and healthcare services.',14.0,Utils.darkblue),
                  ]
                ),
              ),
          ],
        ),
      ),
    );
  }
}

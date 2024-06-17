import 'package:flutter/material.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PainCButton.dart';

class PopUp extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback ontap;
  final bool hastitle;
  PopUp({this.hastitle,this.ontap, this.description, this.title});

  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: screenwidth,
            padding: EdgeInsets.only(top: screenheight*.035, left: screenwidth*.03, right:  screenwidth*.03),
            child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if(hastitle == true) Utils.darkbluetxt(title, 18.0),
                    if(hastitle == true) Utils.sizeBoxHeight(screenheight * 0.02),
                    Container(
                      width: screenwidth*.6,
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: Utils.googlenunitoreg(14.0, Utils.lightgrey1)  ,
                      ),
                    ),
                    Utils.sizeBoxHeight(screenheight*.03),
                    Container(
                      width: 130,
                      height: screenheight*.065,
                      child: PainCButton(
                        title: 'OK',
                        onTap: ontap,
                        borderColor: Utils.bottleclr,
                        titleColor: Utils.bottleclr,
                        spashColor: Utils.bottleclr,
                        tappedTitleColor: Utils.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),/*RoundedBtn(
                        ontap: ontap,
                        btnclr: Utils.bottleclr,
                        btntxtclr: Utils.white,
                        txt: 'OK',
                      ),*/
                    ),
                    Utils.sizeBoxHeight(screenheight*.03),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}

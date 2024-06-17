import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:painc/Utils/Utils.dart';

class TreatMentBox extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color txtcolor;
  final String icon;
  final Color iconcolor;
  final Color boxcolor;
  TreatMentBox({this.onTap, this.text, this.txtcolor, this.icon, this.iconcolor,
    this.boxcolor});
  @override
  Widget build(BuildContext context) {
    var screenheight = Utils.getHeight(context);
    var screenwidth = Utils.getWidth(context);
    return Container(
      margin: EdgeInsets.all(15.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: boxcolor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [BoxShadow(blurRadius: 8, color: Utils.grey.withOpacity(0.15), spreadRadius: 1)],
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[SvgPicture.network(icon,color: iconcolor,width: screenwidth*.17,height: screenheight*.08),
            Utils.sizeBoxHeight(screenheight*.01),
            Container(width:screenwidth*.30,child: Text(text,textAlign: TextAlign.center,style: Utils.googlenunitoreg(16.0,txtcolor),))]
      ),
    );
  }
}

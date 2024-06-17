import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:painc/Utils/Utils.dart';

class QuestionCompletedBox extends StatelessWidget {
  final String txt;
  final bool tick;
  final VoidCallback ontap;
  final String icon;
  QuestionCompletedBox({this.icon,this.ontap,this.txt, this.tick});
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return GestureDetector(
      onTap: ontap,
      child: Container(
          padding: EdgeInsets.only(left: 10),
          height: 78,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 10.0,
                  spreadRadius: 5.0,
                  offset: Offset(5.0,5.0)
              )],
              color: Utils.white,
              borderRadius: BorderRadius.circular(10)
          ),
          margin: EdgeInsets.only(bottom: 20),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Utils.lightbottleclr,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  icon,
                ),
              ),
              Positioned(
                  left: 60,
                  child: Container(
                      alignment:Alignment.centerLeft,width: screenwidth*.7,
                      child: Text(txt,overflow: TextOverflow.ellipsis,maxLines: 1,style: Utils.boldtxt(20.0,Utils.black),))),
              if(tick == true)Positioned(
                right: 25,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Utils.bottleclr,
                  child: Icon(Icons.check, color: Utils.white,),
                ),
              ),
              Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(
    'assets/svg/shape.svg',color: tick == true ? Utils.bottleclr.withOpacity(0.3) : Utils.yellow.withOpacity(0.3)),
                  /*child: tick == true ? SvgPicture.asset(
                      'assets/svg/shape.svg') : SvgPicture.asset(
                      'assets/svg/shapeyellow.svg')*/

              ),
            ],
          )
      ),
    );
  }
}

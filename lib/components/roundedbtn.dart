import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painc/Utils/Utils.dart';

class RoundedBtn extends StatelessWidget {
  final String txt;
  final VoidCallback ontap;
  final Color btnclr;
  final Color btntxtclr;
  const RoundedBtn({this.txt, this.ontap,
      this.btnclr, this.btntxtclr});
  @override
  Widget build(BuildContext context) {
    var screenheight = Utils.getHeight(context);
    var screenwidth = Utils.getWidth(context);
    return Container(
      height: screenheight*.065,
      child: RaisedButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: ontap,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
      color: btnclr,
      child: Text(
        txt,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: btntxtclr,fontFamily: 'Nunito',fontSize: 18),
      )),
    );
  }
}

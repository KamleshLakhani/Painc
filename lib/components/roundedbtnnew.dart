import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painc/Utils/Utils.dart';

class Roundedbtnnew extends StatefulWidget {
  final String txt;
  final VoidCallback ontap;
  final Color btnsplashcolor;
  final Color btntxtclr;
  final Color borderclr;
  final Color btncolor;
  const Roundedbtnnew({this.btncolor,this.borderclr,this.txt, this.ontap,
    this.btnsplashcolor, this.btntxtclr});

  @override
  _RoundedbtnnewState createState() => _RoundedbtnnewState();
}
class _RoundedbtnnewState extends State<Roundedbtnnew> {
  bool tap= false;
  @override
  Widget build(BuildContext context) {
    var screenheight = Utils.getHeight(context);
    return Container(
      height: screenheight*.065,
      child: RaisedButton(
          highlightColor: widget.btnsplashcolor,
          onPressed:widget.ontap,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: widget.borderclr),
              borderRadius: BorderRadius.circular(10)),
          color: widget.btncolor,
          child: Text(
            widget.txt,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: widget.btntxtclr,fontFamily: 'Nunito',fontSize: 18),
          )),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/appbar.dart';

class LeftLetsDescription extends StatefulWidget {
  String i;
  LeftLetsDescription(String index){
    i=index;
  }

  @override
  _LeftLetsDescriptionState createState() => _LeftLetsDescriptionState();
}

class _LeftLetsDescriptionState extends State<LeftLetsDescription> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      appBar: CustAppbar(
        txt: 'Leaflets',infobtn: false,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          width: screenwidth,
          height: screenheight,
          child: SingleChildScrollView(child: Html(data: widget.i,)),
        ),
      ),
    );
  }
}

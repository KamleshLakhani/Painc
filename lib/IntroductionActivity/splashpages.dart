import 'package:flutter/material.dart';
import 'package:painc/Utils/Utils.dart';

import 'continue1.dart';
import 'continue2.dart';
import 'continue3.dart';


class SplashPages extends StatefulWidget {
  @override
  _SplashPagesState createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> {
  PageController pcontroller = PageController();
  @override
  void initState() {
    pcontroller = PageController(
      initialPage: 0,
      keepPage: true
    );
    super.initState();
  }
  @override
  void dispose() {
    pcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      body: Container(
        width: screenwidth,
        height: screenheight,
        child: PageView(
          controller: pcontroller,
          scrollDirection: Axis.horizontal,
          children: [
            Continue1(pageid: pcontroller),
            Continue2(pageid: pcontroller),
            Continue3(pageid: pcontroller)
          ],
        ),
      ),

    );
  }
}


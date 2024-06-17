import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painc/Utils/Utils.dart';

class MedicationBox extends StatelessWidget {
  final String medicinename;
  final String dosenum;
  final String tabletscount;
  final bool editable;
  final VoidCallback onTap;
  @required bool td = true;
  @required bool dt = true;
  MedicationBox(
      {this.td,
        this.dt,
        this.onTap,
      this.editable,
      this.dosenum,
      this.medicinename,
      this.tabletscount});

  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          margin: EdgeInsets.only(
              left: screenheight * .015,
              right: screenheight * .015,
              bottom: screenheight * .025),
          padding: EdgeInsets.symmetric(
              horizontal: screenwidth * .04, vertical: screenheight * .01),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Utils.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  color: Utils.grey.withOpacity(0.15),
                  spreadRadius: 1)
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: Text(medicinename,style: Utils.boldtxt(18.0, Utils.darkblue))),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: dt == true ? true : false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (dosenum.length <= 1) ?CircleAvatar(
    radius: 22.0,
    backgroundColor: Utils.bottleclr,
    child: Utils.whitetext(dosenum, 26.0)) :
                        Container(
                          alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Utils.bottleclr,
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(100.0),
                                    left: Radius.circular(100.0))),
                            padding: EdgeInsets.symmetric(horizontal: 7.0,vertical: 5.0 ),
                            child: Utils.whitetext(dosenum, 26.0)),

                        Utils.sizeBoxHeight(5.0),
                        Text(
                          'Dose Taken',
                          style: Utils.nunitolight(12.0, Color(0xFF8B8B8B)),
                        )
                      ],
                    ),
                  ),
                  Utils.sizeBoxWidth(screenwidth*.04),
                  Visibility(
                    visible: td == true ? true : false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (tabletscount.length <= 1) ?CircleAvatar(
                            radius: 22.0,
                            backgroundColor: Utils.yellow,
                            child: Utils.whitetext(tabletscount, 26.0)) :
                        Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Utils.yellow,
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(100.0),
                                    left: Radius.circular(100.0))),
                            padding: EdgeInsets.symmetric(horizontal: 7.0,vertical: 5.0 ),
                            child: Utils.whitetext(tabletscount, 26.0)),

                        Utils.sizeBoxHeight(5.0),
                        Text(
                          'Tablets/day',
                          style: Utils.nunitolight(12.0, Color(0xFF8B8B8B)),
                        )
                      ],
                    ),
                  ),
                  /*Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: screenwidth * .05,
                          backgroundColor: Utils.yellow,
                          child: Utils.whitetext(tabletscount, 26.0)),
                      Utils.sizeBoxHeight(5.0),
                      Text(
                        'Tablets/Day',
                        style: Utils.nunitolight(12.0, Color(0xFF8B8B8B)),
                      )
                    ],
                  )*/
                ],
              )
              /* Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Utils.bottleclr,
                          borderRadius: BorderRadius.horizontal(right: Radius.circular(100.0),left: Radius.circular(100.0))
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Utils.whitetext(dosenum, 26.0)),
                      */
              /*CircleAvatar(
                          radius: screenwidth * .05,
                          backgroundColor: Utils.bottleclr,
                          child: Utils.whitetext(dosenum, 26.0)),*/
              /*
                      Utils.sizeBoxHeight(5.0),
                      Text(
                        'Dose Taken',
                        style: Utils.nunitolight(12.0, Color(0xFF8B8B8B)),
                      )
                    ],
                  ),
                  Utils.sizeBoxWidth(15.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: screenwidth * .05,
                          backgroundColor: Utils.yellow,
                          child: Utils.whitetext(tabletscount, 26.0)),
                      Utils.sizeBoxHeight(5.0),
                      Text(
                        'Tablets/Day',
                        style: Utils.nunitolight(12.0, Color(0xFF8B8B8B)),
                      )
                    ],
                  )
                ],
              )*/
            ],
          ),
        ),
        Positioned(
            top: -17,
            right: 0,
            child: GestureDetector(
              onTap: onTap,
              child: editable == true
                  ? Container(
                      width: screenwidth * .05,
                      height: screenheight * .05,
                      decoration: BoxDecoration(
                          color: Utils.red, shape: BoxShape.circle),
                      child: Icon(
                        Icons.close,
                        color: Utils.white,
                        size: 18.0,
                      ),
                    )
                  : Container(),
            ))
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:painc/Utils/Utils.dart';

class ReportContainer extends StatelessWidget {
  final String fromdate;
  final String todate;
  final String title;
  final VoidCallback onTap;
  ReportContainer({this.onTap,this.fromdate, this.todate, this.title});
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenwidth,
        margin: EdgeInsets.only(left: 10,right: 10),
        padding: EdgeInsets.only(left: 15, right: 20),
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Utils.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(5.0, 5.0),
                  blurRadius: 10,
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1)
            ]),
        child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Utils.bottleclr),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/graph.png'))),
                ),
                SizedBox(width: screenwidth*.03),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: 13,right: screenwidth*.04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(text: 'From '),
                              TextSpan(text: fromdate,style: TextStyle(color: Utils.bottleclr)),
                              TextSpan(text: 'to '),
                              TextSpan(text: todate,style:  TextStyle(color: Utils.bottleclr))
                            ],style: GoogleFonts.nunito(fontSize: 12,fontStyle: FontStyle.normal,color: Color(0xFF1C1C1C)))),
                        Text(title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w900,
                                color: Utils.black)),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Utils.bottleclr,
                  child: SvgPicture.asset('assets/svg/forw_arrow.svg',fit: BoxFit.fill,),
                ),
              ],
            ),

      ),
    );
  }
}

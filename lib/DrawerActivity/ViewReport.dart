import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:painc/ApiClass/OverAllReport.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/appbar.dart';
import 'package:http/http.dart' as http;
import 'package:painc/components/loader.dart';
class ViewReport extends StatefulWidget {
  final String fromdate;
  final String todate;
  ViewReport({this.todate, this.fromdate});
  @override
  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  Future<OverAllReport> overalldata;
  @override
  void initState() {
    overalldata = getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      appBar: CustAppbar(
        onbackpress: (){Get.back();},
        infobtn: false,
        txt: 'View Report',
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        child: FutureBuilder<OverAllReport>(
          future: getdata(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: screenheight*.02,horizontal: 15.0),
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (context, index)
              {
                var inputFormat = DateFormat('yyyy-mm-dd');
                var inputDate = inputFormat.parse(snapshot.data.data[index].date);
                var outputFormat = DateFormat('dd-mm-yyyy');
                var outputDate = outputFormat.format(inputDate);
                return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(outputDate.toString(), style: Utils.boldtxt(20.0, Utils.grey)),
                  Utils.sizeBoxHeight(screenheight*.005),
                  Utils.semibold('Pain Intensity: ${snapshot.data.data[index].painIntensity.toString()}/10', 16.0, Utils.lightgrey1),
                  Utils.semibold('Interference in General Activity: ${snapshot.data.data[index].generalActivity.toString()}/10', 16.0, Utils.lightgrey1),
                  Utils.semibold('Interference in Enjoyment: ${snapshot.data.data[index].enjoymentLife.toString()}/10', 16.0, Utils.lightgrey1),
                  Utils.semibold('Medication Score: ${snapshot.data.data[index].medication.toString()}', 16.0, Utils.lightgrey1),
                  Utils.sizeBoxHeight(screenheight*.03),
                ],
              );});
            }return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
  Future<OverAllReport> getdata() async{
    print('requestting');
    var jsonData = {
      'from_date' : widget.fromdate,
      'to_date' : widget.todate,
    };
    http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.overall_report);
    print('request done');
    print(response.statusCode);
    OverAllReport overall = OverAllReport.fromJson(json.decode(response.body));
    if(overall.status){
      return overall;
    }else{
      return Utils.toast(response.body, '', Utils.red.withOpacity(.4));
    }
  }
}

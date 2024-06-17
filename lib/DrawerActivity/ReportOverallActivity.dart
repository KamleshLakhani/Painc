import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:painc/ApiClass/OverAllReport.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/appbar.dart';
import 'package:painc/components/roundedbtn.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
class ReportOverallActivity extends StatefulWidget {
  final String fromdate;
  final String todate;
  ReportOverallActivity({this.todate, this.fromdate});
  @override
  _ReportOverallActivityState createState() => _ReportOverallActivityState();
}

class _ReportOverallActivityState extends State<ReportOverallActivity> {
   List<_SalesData> data = [];
  List<_SalesData> data2 = [];
  List<_SalesData> data3 = [];
  List<_SalesData> data4 = [];
  List<_SalesData> data5 = [];
  Future<OverAllReport> overalldata;
 /* List<_SalesData> data = [
    _SalesData('Month', 0),
    _SalesData('Jan', 3.1),
    _SalesData('Feb', 2.7),
    _SalesData('Mar', 0),
    _SalesData('Apr', 6),
    _SalesData('May', 7.5),
    _SalesData('Jun', 4.9),
  ];
  List<_SalesData> data2 = [
    _SalesData('Month', 0),
    _SalesData('Jan', 5),
    _SalesData('Feb', 8),
    _SalesData('Mar', 2),
    _SalesData('Apr', 3),
    _SalesData('May', 4),
    _SalesData('Jun', 8),
  ];
  List<_SalesData> data3 = [
    _SalesData('Month', 0),
    _SalesData('Jan', 8),
    _SalesData('Feb', 6),
    _SalesData('Mar', 5),
    _SalesData('Apr', 1),
    _SalesData('May', 2),
    _SalesData('Jun', 6),
  ];
  List<_SalesData> data4 = [
    _SalesData('Month', 6),
    _SalesData('Jan', 1),
    _SalesData('Feb', 3),
    _SalesData('Mar', 4),
    _SalesData('Apr', 8),
    _SalesData('May', 3),
    _SalesData('Jun', 8),
  ];
  List<_SalesData> data5 = [
    _SalesData('Month', 2),
    _SalesData('Jan', 1),
    _SalesData('Feb', 6),
    _SalesData('Mar', 7),
    _SalesData('Apr', 3),
    _SalesData('May', 8),
    _SalesData('Jun', 1),
  ];*/
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
        txt: 'Overall',
        infobtn: false,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Utils.sizeBoxHeight(28.0),
                  Container(
                      width: screenwidth*.6,
                      child: Text(
                          'This line graph shows the trend in your Pain Intensity & Quality of Life ',
                          textAlign: TextAlign.center,
                          style: Utils.googlenunitoreg(14.0, Utils.grey))),
                  Utils.sizeBoxHeight(22.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 10),child: Utils.btlclrboldtext('Values', 12.0)),
                      SfCartesianChart(
                          enableAxisAnimation: true,
                          primaryXAxis: CategoryAxis(), // Enable tooltip
                          series: <ChartSeries<_SalesData, String>>[
                            LineSeries<_SalesData, String>(
                              color: Utils.bottleclr,
                              markerSettings:
                              MarkerSettings(isVisible: true, width: 12, height: 12,borderWidth: 3,color: Utils.white,borderColor: Color(0xFF067976)),
                              dataSource: data,
                              xValueMapper: (_SalesData sales, _) => sales.year,
                              yValueMapper: (_SalesData sales, _) => sales.sales,),
                            LineSeries<_SalesData, String>(
                              color: Utils.yellow,
                              markerSettings:
                              MarkerSettings(isVisible: true, width: 12, height: 12,borderWidth: 3,color: Utils.white,borderColor: Color(0xFFD09705)),
                              dataSource: data2,
                              xValueMapper: (_SalesData sales, _) => sales.year,
                              yValueMapper: (_SalesData sales, _) => sales.sales,),
                            LineSeries<_SalesData, String>(
                              color: Utils.green,
                              markerSettings:
                              MarkerSettings(isVisible: true, width: 12, height: 12,borderWidth: 3,color: Utils.white,borderColor: Color(0xFF2A8108)),
                              dataSource: data3,
                              xValueMapper: (_SalesData sales, _) => sales.year,
                              yValueMapper: (_SalesData sales, _) => sales.sales,),
                            LineSeries<_SalesData, String>(
                              color: Utils.orange,
                              markerSettings:
                              MarkerSettings(isVisible: true, width: 12, height: 12,borderWidth: 3,color: Utils.white,borderColor: Color(0xFF954802)),
                              dataSource: data4,
                              xValueMapper: (_SalesData sales, _) => sales.year,
                              yValueMapper: (_SalesData sales, _) => sales.sales,),
                            LineSeries<_SalesData, String>(
                              color: Utils.red,
                              markerSettings:
                              MarkerSettings(isVisible: true, width: 12, height: 12,borderWidth: 3,color: Utils.white,borderColor: Color(0xFFA51F08)),
                              dataSource: data5,
                              xValueMapper: (_SalesData sales, _) => sales.year,
                              yValueMapper: (_SalesData sales, _) => sales.sales,),
                          ]),
                      Padding(padding: EdgeInsets.only(left: 40),child: Utils.btlclrboldtext('Period', 12.0)),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top:20,left: screenwidth*.12),
                      child: Column(
                        children: [
                          Utils.axistitle(Utils.bottleclr,'Pain Intensity'),
                          Utils.sizeBoxHeight(10.0),
                          Utils.axistitle(Utils.yellow,'Quality of Life'),
                          Utils.sizeBoxHeight(10.0),
                          Utils.axistitle(Utils.green,'Enjoyment of Life '),
                          Utils.sizeBoxHeight(10.0),
                          Utils.axistitle(Utils.orange,'General Activity '),
                          Utils.sizeBoxHeight(10.0),
                          Utils.axistitle(Utils.red,'MQS'),
                        ],
                      )),
                ],
              ),
            ),
            Positioned(
              bottom: screenheight*.02,
              left: screenwidth*.08,
              right: screenwidth*.08,
              child: PainCButton(
                title: 'Back', onTap: (){Get.back();},
                borderColor: Utils.bottleclr,
                titleColor: Utils.bottleclr,
                spashColor: Utils.bottleclr,
                tappedTitleColor: Utils.white,
              ))
          ],
        ),
      ),
    );
  }
   Future<OverAllReport> getdata() async{
     var jsonData = {
       'from_date' : widget.fromdate,
       'to_date' : widget.todate,
     };
     http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.overall_report);
     print(response.statusCode);
     OverAllReport overallreport = OverAllReport.fromJson(json.decode(response.body));
     if(overallreport.status){
       overallreport.data.forEach((element) {
         var datee = element.date;
         String dateWithT = datee.substring(0, 8) + datee.substring(8);
         DateTime dateTime = DateTime.parse(dateWithT);
         String formattedDate = DateFormat('MMM-dd').format(dateTime);
         if(element.painIntensity != 0 || element.enjoymentLife != 0 || element.helthThermometer != 0 || element.generalActivity != 0 || element.medication != 0){
           setState(() {
             data.add( _SalesData(formattedDate,element.painIntensity.runtimeType == int ? double.parse(element.painIntensity.toString()) : element.painIntensity));
             data2.add( _SalesData(formattedDate,element.enjoymentLife.runtimeType == int ? double.parse(element.enjoymentLife.toString()) : element.enjoymentLife));
             data3.add( _SalesData(formattedDate,element.helthThermometer.runtimeType == int ? double.parse(element.helthThermometer.toString()) : element.helthThermometer));
             data4.add( _SalesData(formattedDate,element.generalActivity.runtimeType == int ? double.parse(element.generalActivity.toString()) : element.generalActivity));
             data5.add( _SalesData(formattedDate,element.medication.runtimeType == int ? double.parse(element.medication.toString()) : element.medication));
           });
         }
       });
     }
     /*overallreport.data.painIntensity.forEach((element) {
       print('PIPIPIP ${element.painIntensity}');
       var datee = element.date;
       String dateWithT = datee.substring(0, 8) + datee.substring(8);
       DateTime dateTime = DateTime.parse(dateWithT);
       String formattedDate = DateFormat('MMM-dd').format(dateTime);
       setState(() {
         data.add( _SalesData(formattedDate,element.painIntensity.runtimeType == int ? double.parse(element.painIntensity.toString()) : element.painIntensity));
       });
     });
     overallreport.data.enjoymentOfLife.forEach((element) {
       print('GAGAGA ${element.generalActivity}');
       print('EIEIEI ${element.enjoymentLife}');
       var datee = element.date;
       String dateWithT = datee.substring(0, 8) + datee.substring(8);
       DateTime dateTime = DateTime.parse(dateWithT);
       String formattedDate = DateFormat('MMM-dd').format(dateTime);
       setState(() {
         data2.add( _SalesData(formattedDate,element.enjoymentLife.runtimeType == int ? double.parse(element.enjoymentLife.toString()) : element.enjoymentLife));
         data4.add( _SalesData(formattedDate,element.generalActivity.runtimeType == int ? double.parse(element.generalActivity.toString()) : element.generalActivity));
       });
     });
     overallreport.data.qualityOfLifeReport.forEach((element) {
       print('QOLQOL ${element.helthThermometer}');
       var datee = element.date;
       String dateWithT = datee.substring(0, 8) + datee.substring(8);
       DateTime dateTime = DateTime.parse(dateWithT);
       String formattedDate = DateFormat('MMM-dd').format(dateTime);
       setState(() {
         data3.add( _SalesData(formattedDate,element.helthThermometer.runtimeType == int ? double.parse(element.helthThermometer.toString()) : element.helthThermometer));
       });
     });
     overallreport.data.medication.forEach((element) {
       print('MEDICATIONSCORE ${element.scrore}');
       var datee = element.date;
       String dateWithT = datee.substring(0, 8) + datee.substring(8);
       DateTime dateTime = DateTime.parse(dateWithT);
       String formattedDate = DateFormat('MMM-dd').format(dateTime);
       setState(() {
         data5.add( _SalesData(formattedDate,element.scrore.runtimeType == int ? double.parse(element.scrore.toString()) : element.scrore));
       });
     });*/
   }
}

class _SalesData {
  final String year;
  final double sales;
  _SalesData(this.year, this.sales);
}

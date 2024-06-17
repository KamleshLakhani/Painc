import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:painc/ApiClass/IntensityEnjoymentReport.dart';
import 'package:painc/ApiClass/OverAllReport.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/appbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart'as http;
class ReportIntesityAndEnjoymentOfLife extends StatefulWidget {
  final String fromdate;
  final String todate;
  ReportIntesityAndEnjoymentOfLife({this.todate, this.fromdate});
  @override
  _ReportIntesityAndEnjoymentOfLifeState createState() => _ReportIntesityAndEnjoymentOfLifeState();
}

class _ReportIntesityAndEnjoymentOfLifeState extends State<ReportIntesityAndEnjoymentOfLife> {
 /* List<_SalesData> data = [
    _SalesData('Jan', 3.1),
    _SalesData('Feb', 2.7),
    _SalesData('Mar', 0),
    _SalesData('Apr', 6),
    _SalesData('May', 7.5),
    _SalesData('Jun', 4.9),
  ];
  List<_SalesData> data2 = [
    _SalesData('Jan', 5),
    _SalesData('Feb', 8),
    _SalesData('Mar', 2),
    _SalesData('Apr', 3),
    _SalesData('May', 4),
    _SalesData('Jun', 8),
  ];*/
  List<_SalesData> data = [];
  List<_SalesData> data2 = [];
  Future<PainIntensityEnjoymentReport> intensityenjoymentreport;
  @override
  void initState() {
    intensityenjoymentreport = getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      appBar: CustAppbar(
        txt: 'Intensity & Enjoyment of Life ',
        infobtn: false,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Utils.sizeBoxHeight(28.0),
                Container(
                    width: screenwidth*.6,
                    child: Text(
                        'This line graph shows the trend in your Pain Intensity & Enjoyment of Life ',
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
                            color: Utils.green,
                            markerSettings:
                            MarkerSettings(isVisible: true, width: 12, height: 12,borderWidth: 3,color: Utils.white,borderColor: Color(0xFF2A8108)),
                            dataSource: data2,
                            xValueMapper: (_SalesData sales, _) => sales.year,
                            yValueMapper: (_SalesData sales, _) => sales.sales,)
                        ]),
                    Padding(padding: EdgeInsets.only(left: 40),child: Utils.btlclrboldtext('Period', 12.0)),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top:20,left: screenwidth*.12),
                    child: Column(
                      children: [
                        Utils.axistitle(Utils.bottleclr,'Pain Intensity'),
                        Utils.sizeBoxHeight(10.0),
                        Utils.axistitle(Utils.green,'Enjoyment of Life '),
                      ],
                    )),
              ],
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
              ),/*RoundedBtn(
                ontap: () {Get.back();},
                btnclr: Utils.bottleclr,
                btntxtclr: Utils.white,
                txt: 'Back',
              ),*/)
          ],
        ),
      ),
    );
  }
  Future<PainIntensityEnjoymentReport> getdata() async{
    var jsonData = {
      'from_date' : widget.fromdate,
      'to_date' : widget.todate,
    };
    http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.overall_report);
    print(response.statusCode);
      OverAllReport overallreport = OverAllReport.fromJson(json.decode(response.body));
      // PainIntensityEnjoymentReport piereport = PainIntensityEnjoymentReport.fromJson(json.decode(response.body));
     if(overallreport.status){
       overallreport.data.forEach((element) {
         var datee = element.date;
         String dateWithT = datee.substring(0, 8) + datee.substring(8);
         DateTime dateTime = DateTime.parse(dateWithT);
         String formattedDate = DateFormat('MMM-dd').format(dateTime);
         if(element.enjoymentLife != 0 || element.generalActivity != 0){
           setState(() {
             data.add( _SalesData(formattedDate,element.enjoymentLife.runtimeType == int ? double.parse(element.enjoymentLife.toString()) : element.enjoymentLife));
             data2.add( _SalesData(formattedDate,element.generalActivity.runtimeType == int ? double.parse(element.generalActivity.toString()) : element.generalActivity));
           });
         }
       });
     }

  }
}
class _SalesData {
  _SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:painc/ApiClass/OverAllReport.dart';
import 'package:painc/ApiClass/PainIntensityReport.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/appbar.dart';
import 'package:painc/components/roundedbtn.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ReportPainIntensity extends StatefulWidget {
  final String fromdate;
  final String todate;
  ReportPainIntensity({this.todate, this.fromdate});
  @override
  _ReportPainIntensityState createState() => _ReportPainIntensityState();
}

class _ReportPainIntensityState extends State<ReportPainIntensity> {
  Future<PainIntensityReport> intensityreport;
  List<_SalesData> data = [];
/*  List<_SalesData> dataa = [
    _SalesData('Jan', 3.1),
    _SalesData('Feb', 2.7),
    _SalesData('Mar', 0),
    _SalesData('Apr', 6),
    _SalesData('May', 7.5),
    _SalesData('Jun', 4.9),
  ];*/
  @override
  void initState() {
    intensityreport = getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      appBar:CustAppbar(
        txt: 'Pain Intensity',
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
                        'This line graph shows the trend in your pain levels.',
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
                              yValueMapper: (_SalesData sales, _) => sales.sales,)
                        ]),
                    Padding(padding: EdgeInsets.only(left: 40),child: Utils.btlclrboldtext('Period', 12.0)),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top:20,left: screenwidth*.12),child: Utils.axistitle(Utils.bottleclr,'Pain Intensity'))
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
  Future<PainIntensityReport> getdata() async{
    var jsonData = {
      'from_date' : widget.fromdate,
      'to_date' : widget.todate,
    };
    http.Response response = await ResponseClass.callPostApi(jsonData, ApiSheet.overall_report);
    print(response.statusCode);
      OverAllReport overallreport = OverAllReport.fromJson(json.decode(response.body));
      // PainIntensityReport pireport = PainIntensityReport.fromJson(json.decode(response.body));
    if(overallreport.status){
      overallreport.data.forEach((element) {
        var datee = element.date;
        String dateWithT = datee.substring(0, 8) + datee.substring(8);
        DateTime dateTime = DateTime.parse(dateWithT);
        String formattedDate = DateFormat('MMM-dd').format(dateTime);
        if(element.painIntensity != 0){
          setState(() {
            data.add( _SalesData(formattedDate,element.painIntensity.runtimeType == int ? double.parse(element.painIntensity.toString()) : element.painIntensity));
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


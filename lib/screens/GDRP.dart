import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:painc/ApiClass/GetGDPR.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/roundedbtn.dart';
import 'package:painc/screens/RegistrationActivity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class GDRP extends StatefulWidget {
  @override
  _GDRPState createState() => _GDRPState();
}

class _GDRPState extends State<GDRP> {
  Future<GetGDPR> gdpr;
  bool scrolled;
  @override
  void initState() {
    gdpr = getgdpr();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              margin: EdgeInsets.only(left: screenwidth*.03,right: screenwidth*.03,top: screenheight*.02,bottom: screenheight*.12),
              padding: EdgeInsets.all(20),
              color: Color(0xFFC4C4C4),
              child: FutureBuilder<GetGDPR>(
                  future: gdpr,
                  builder: (context, snapshot) {
                    try{
                      if(snapshot.hasData){
                        return NotificationListener<ScrollEndNotification>(
                          onNotification: (scrollEnd){
                            var metrics = scrollEnd.metrics;
                            if (metrics.atEdge) {
                              if (metrics.pixels == 0) print('At top');
                              else setState(() {
                                scrolled = true;
                              });
                            }
                            return true;
                          },
                          child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: screenwidth*.01,horizontal: screenheight*.01),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Html(data: snapshot.data.data.description),
                                      ]
                                  ),
                                );
                              }

                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    }catch(e){
                      return Center(child: CircularProgressIndicator());
                    }

                  }

              ),
            ),
            Positioned(
              left: screenwidth*.15,
              right: screenwidth*.15,
              bottom: screenheight*.03,
                child: PainCButton(
                    title: 'Agree', onTap: scrolled == true ?(){Constant.check1 = true;Get.back();} : (){Utils.simptoast('Please Read Policies', Utils.white, Utils.red);},
                    borderColor: Utils.bottleclr,
                    titleColor: Utils.bottleclr,
                    spashColor: Utils.bottleclr,
                    tappedTitleColor: Utils.white,
                  ),/*RoundedBtn(
                  txt: 'Agree & Create',
                  btntxtclr: Utils.white,
                  btnclr: Utils.bottleclr,
                  ontap: (){
                    Get.back();
                  },
                ),*/
            )
          ],
        ),
      ),
    );
  }
  Future<GetGDPR> getgdpr() async{
    print('nodatadsada');
    http.Response response = await ResponseClass.callGetApi(ApiSheet.get_gdpr);
    print(response.statusCode);
    print(response.body);
    GetGDPR data = GetGDPR.fromJson(json.decode(response.body));
    if(response.statusCode == 200){
      print('data');
      return GetGDPR.fromJson(json.decode(response.body));
    }else{
      return null;
      print('no data');
      print(response.body);
    }
  }
}


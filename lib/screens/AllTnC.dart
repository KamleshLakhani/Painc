import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:painc/ApiClass/CMS.dart';
import 'package:painc/GetX/register.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class AllTnC extends StatefulWidget {
  @override
  _AllTnCState createState() => _AllTnCState();
}

class _AllTnCState extends State<AllTnC> {
  RegisterController controller = Get.put(RegisterController());
  Future<CMS> cms;
  bool scrolled;
  bool check = false;
  Color clr1 = Color(0xFFBBBBBB);
  final ScrollController scrlcntrl = ScrollController();
  @override
  void initState() {
    cms = getcms();
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
            Positioned(
            left: screenwidth*.03,right: screenwidth*.03,top: screenheight*.02,bottom: screenheight*.20,
              child: Container(
                //margin: EdgeInsets.only(left: screenwidth*.03,right: screenwidth*.03,top: screenheight*.02,bottom: screenheight*.20),
                padding: EdgeInsets.all(20),
                color: Color(0xFFC4C4C4),
                child: FutureBuilder<CMS>(
                    future: cms,
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
                            child: Scrollbar(
                              isAlwaysShown: true,
                              controller: scrlcntrl,
                              child: ListView.builder(
                                controller: scrlcntrl,
                                  itemCount: snapshot.data.data.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(vertical: screenwidth*.01,horizontal: screenheight*.01),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Html(data: snapshot.data.data[index].description),
                                          ]
                                      ),
                                    );
                                  }
                              ),
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
            ),
            Positioned(
              left: screenwidth*.08,
              right: screenwidth*.06,
              bottom: screenheight*.03,
              child: Column(
                children: [Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          border: Border.all(width:2.5,color:clr1)
                      ),
                      child: Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.transparent
                        ),
                        child: Checkbox(
                            splashRadius: 0.0,
                            value: check,
                            checkColor: Color(0xff0ABC69),
                            activeColor: Colors.transparent,
                            onChanged: (val){
                              print('here val $val');
                              if(scrolled == true){
                                if(val == true){
                                  setState(() {
                                    check = true;
                                    clr1 = Color(0xFFBBBBBB);
                                  });
                                  print('here true $check');
                                }else{
                                  setState(() {
                                    check = false;
                                  });
                                  print('here false $check');
                                }
                              }else{
                                Utils.toast('Please read the policies completely by Scrolling', '', Utils.red.withOpacity(.4));
                              }
                              })
                      ),
                    ),
                    Utils.sizeBoxWidth(screenwidth*.025),
                    Expanded(
                        child: Text('I  have read and agree to the Terms and Conditions, Privacy policy and Cookies policy.',
                            style: Utils.greytxtstyl()))
                  ],
                ),
                  Utils.sizeBoxHeight(screenheight * 0.04),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: screenwidth*.15),
                    child: check == false || scrolled == false ?
                    GestureDetector(
                      onTap: (){
                        if(scrolled == false){
                          Utils.toast('Please read the policies completely by Scrolling', '', Utils.red.withOpacity(.4));
                        }
                        if(check == false){
                          setState(() {
                            clr1 = Utils.red;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: screenheight*.015,horizontal: screenwidth*.12),
                        child:Text('Agree & Create',style: Utils.boldtxt(18.0,Utils.grey),),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(width: 1.0,color: Utils.grey)),),
                    )
                        :PainCButton(
                      title: 'Agree & Create', onTap: (){
                        if(check == true){
                          controller.signup(context);
                        }else{
                          if(scrolled == false){
                            Utils.toast('Please read the policies completely by Scrolling', '', Utils.red.withOpacity(.4));
                          }
                        }
                        /*Constant.check2 = true;Get.back();*/},
                      borderColor: Utils.bottleclr,
                      titleColor: Utils.bottleclr,
                      spashColor: Utils.bottleclr,
                      tappedTitleColor: Utils.white,
                    )
                  )
                ],
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
  Future<CMS> getcms() async{
    print('nodatadsada');
    http.Response response = await ResponseClass.callGetApi(ApiSheet.get_cms);
    print(response.statusCode);
    print(response.body);
    CMS data = CMS.fromJson(json.decode(response.body));
    if(response.statusCode == 200){
      print('data');
      return CMS.fromJson(json.decode(response.body));
    }else{
      return null;
      print('no data');
      print(response.body);
    }
  }
}

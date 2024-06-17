import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:painc/ApiClass/InsertionStatus.dart';
import 'package:painc/ApiClass/logout.dart';
import 'package:painc/ApiClass/update.dart';
import 'package:painc/DrawerActivity/AboutUsActivity.dart';
import 'package:painc/DrawerActivity/ReleaseNotesActivity.dart';
import 'package:painc/DrawerActivity/SettingsActivity.dart';
import 'package:painc/GetX/updateprofile.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/DrawerActivity/ChangePasswordActivity.dart';
import 'package:painc/Utils/getpref.dart';
import 'package:painc/Utils/routes.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/loader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../DrawerActivity/InsuranceDetailActivity.dart';
import '../DrawerActivity/LeafLetsActivity.dart';
import '../DrawerActivity/ProfileUpdateActivity.dart';
import '../DrawerActivity/ReportGenerationActivity.dart';
import 'LoginActivity.dart';
import 'package:http/http.dart' as http;
class OpenDrawer extends StatefulWidget {
  @override
  _OpenDrawerState createState() => _OpenDrawerState();
}

class _OpenDrawerState extends State<OpenDrawer> {
  String privacypolicy = 'https://painc.co.uk/privacypolicy.html';
  String tandc = 'https://painc.co.uk/t&c.html';
  String cookie = 'https://painc.co.uk/cookie_policy.html';
  String baselinedate = '';
  bool baselinestatus = false;
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<String> getstatus() async{
    http.Response response = await ResponseClass.callGetApi(ApiSheet.get_all_data);
    print(response.statusCode);
    print(response.body);
    InsertionStatus data = InsertionStatus.fromJson(json.decode(response.body));
    if(data.status){
      if(data.baseline_status == false){
        baselinedate = 'Report Not Generated';
        baselinestatus = false;
      }else{
        var date = DateTime.parse(data.date);
        var formatter = DateFormat('dd MMM, yyyy').format(date);
        setState(() {
          baselinedate = formatter;
          baselinestatus = true;
        });
      }
    }
  }
  @override
  void initState() {
    getstatus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return ClipRRect(
      borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
      child: Container(
        height: screenheight,
        width:screenwidth/2+60,
        child: Drawer(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15,bottom: 15, top: 70),
                    height: screenwidth*.4,
                    color: Utils.yellow,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.back();
                              Get.to(()=>EditProfile());
                            },
                            child: Container(
                                padding: EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(blurRadius: 8, color: Utils.black.withOpacity(0.2), spreadRadius: 1)],
                                ),
                                child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Utils.white,
                                    child: ClipRRect(borderRadius: BorderRadius.circular(100),
                                        child: Image.network(Constant.profilepic == null ?
                                        'https://www.hpsystems.com.tr/tema/genel/uploads/ekibimiz/vote_1.png'
                                            : Constant.profilepic,height: 106,width: 106,fit: BoxFit.cover))),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: screenwidth*.35,
                                child: Text(Constant.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Utils.latoheading(Utils.black,16.0, FontWeight.bold)),
                              ),
                              SizedBox(height: 03),
                              Container(width:screenwidth*.40,child: Text(Constant.email, style: Utils.latoheading(Utils.grey,11.0, FontWeight.w400))),
                            ],
                          )
                        ]
                    ),
                  ),
                  Container(
                    height: screenheight*.65,
                      padding: EdgeInsets.only(left: 13,top: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Utils.drawermenuItem('assets/svg/drawer_myprofile.svg','My Profile',()=> selectedpage(context,0)),
                            Utils.sizeBoxHeight(screenheight*.020),
                            Utils.drawermenuItem('assets/svg/drawer_reports.svg','Reports',()=> selectedpage(context,1)),
                            Utils.sizeBoxHeight(screenheight*.020),
                            Utils.drawermenuItem('assets/svg/drawer_changepass.svg','Change Password',()=> selectedpage(context,2)),
                            Utils.sizeBoxHeight(screenheight*.020),
                            /*Utils.drawermenuItem('assets/svg/insurancedetail.svg','Insurance Details',()=> selectedpage(context,3)),
                            Utils.sizeBoxHeight(screenheight*.025),*/
                            Utils.drawermenuItem('assets/svg/drawer_leaflets.svg','Leaflets',()=>selectedpage(context,4)),
                            Utils.sizeBoxHeight(screenheight*.020),
                            Utils.drawermenuItem('assets/svg/drawer_releasednote.svg','Release Notes',()=>selectedpage(context,5)),
                            Utils.sizeBoxHeight(screenheight*.020),
                            Utils.drawermenuItem('assets/svg/drawer_aboutus.svg','About us',()=>selectedpage(context,6)),
                            Utils.sizeBoxHeight(screenheight*.020),
                            Utils.drawermenuItem('assets/svg/drawer_setting.svg','Settings',()=>selectedpage(context,7)),
                            Utils.sizeBoxHeight(screenheight*.020),
                            Utils.drawermenuItem('assets/svg/drawer_logout.svg','Logout',(){
                              showDialog(context: context, builder: (context) =>
                               Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: screenwidth,
                                      padding: EdgeInsets.only(top: screenheight*.035, left: screenwidth*.03, right:  screenwidth*.03),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Utils.darkbluetxt('Are you sure?', 18.0),
                                          Utils.sizeBoxHeight(screenheight * 0.02),
                                          Container(
                                            width: screenwidth*.6,
                                            child: Text(
                                              'Do you want to logout?',
                                              textAlign: TextAlign.center,
                                              style: Utils.googlenunitoreg(14.0, Utils.lightgrey1)  ,
                                            ),
                                          ),
                                          Utils.sizeBoxHeight(screenheight*.03),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 130,
                                                height: screenheight*.065,
                                                child: PainCButton(
                                                  title: 'Cancel', onTap: (){Get.back();},
                                                  borderColor: Utils.bottleclr,
                                                  titleColor: Utils.bottleclr,
                                                  spashColor: Utils.bottleclr,
                                                  tappedTitleColor: Utils.white,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                              ),
                                              Container(
                                                width: 130,
                                                height: screenheight*.065,
                                                child: PainCButton(
                                                  title: 'Logout', onTap: () async{
                                                  showLoadingDialog(context: context);
                                                    http.Response responselog = await ResponseClass.callGetApi(ApiSheet.logout);
                                                    LogOut logout = LogOut.fromJson(json.decode(responselog.body));
                                                    if(logout.status){
                                                      hideLoadingDialog(context: context);
                                                      Get.back();
                                                      Utils.removeData();
                                                      Get.offAllNamed(Routes.login);
                                                    }
                                                },
                                                  borderColor: Utils.bottleclr,
                                                  titleColor: Utils.bottleclr,
                                                  spashColor: Utils.bottleclr,
                                                  tappedTitleColor: Utils.white,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Utils.sizeBoxHeight(screenheight*.03),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                              //Get.to(Login());
                              //Get.offAll(Login());
                            }),
                          ],
                        ),
                      )
                  ),
                ],
              ),
              Positioned(
                  bottom:screenheight*.05,
                  left:screenwidth*.1,
                  right:screenwidth*.1,child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      GestureDetector(onTap: (){
                        _launchInBrowser(privacypolicy);
                      },child: Text('Privacy Policy', style: Utils.nunitolight(12.0,Utils.bottleclr))),
                      GestureDetector(onTap:(){
                        _launchInBrowser(tandc);
                      },child: Text('Terms of use', style: Utils.nunitolight(12.0,Utils.bottleclr))),
                  ],
                ),
                      Utils.sizeBoxHeight(screenheight*.013),
                      GestureDetector(onTap: (){
                        _launchInBrowser(cookie);
                      },child: Text('Cookies Policy', style: Utils.nunitolight(12.0,Utils.bottleclr))),
              ],
                  ))
            ],
          )
        ),
      ),
    );
  }

  void selectedpage(BuildContext context, int index){
    switch(index){
      case 0:
        Get.back();
        Get.to(()=>EditProfile());
        //Navigator.popAndPushNamed(context, Routes.editprofile);
    break;
      case 1:
        Get.back();
        Get.to(()=>ReportGeneration(baselinestatus: baselinestatus,baselinedate: baselinedate,));
        break;
      case 2:
        Get.back();
        Get.to(()=>ChangePassword());
        break;
      case 3:
        Get.back();
        Get.to(()=>InsuranceDetail());
        break;
      case 4:
        Get.back();
        Get.to(()=>Leaflets());
        break;
      case 5:
        Get.back();
        Get.to(()=>ReleaseNoteActivity());
        break;
      case 6:
        Get.back();
        Get.to(()=>AboutUsActivity());
        break;
      case 7:
        Get.back();
        Get.to(()=>Settings());
        break;
    }
  }
}

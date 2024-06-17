import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:badges/badges.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/ApiClass/GetGDPR.dart';
import 'package:painc/ApiClass/InsertionStatus.dart';
import 'package:painc/ApiClass/logout.dart';
import 'package:painc/DashboardActivity/FurtherInformationInsertionActivity.dart';
import 'package:painc/DashboardActivity/MedicationInsertionActivity.dart';
import 'package:painc/DashboardActivity/PainLocationInsertionActivity.dart';
import 'package:painc/DrawerActivity/ProfileUpdateActivity.dart';
import 'package:painc/GetX/biometricenable.dart';
import 'package:painc/Utils/ApiSheet.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/ResponseClass.dart';
import 'package:painc/Utils/SharedPreference.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/Utils/getpref.dart';
import 'package:painc/Utils/loader.dart';
import 'package:painc/Utils/routes.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/Qcbox.dart';
import 'package:painc/DashboardActivity/PainQualityInsertionActivity.dart';
import 'package:painc/DashboardActivity/QoLInsertionActivity.dart';
import '../DashboardActivity/PainIntensityInsertionActivity.dart';
import '../DashboardActivity/PainInterferenceInsertionActivity.dart';
import 'Drawer.dart';
import '../DashboardActivity/NotificationActivity.dart';
import '../DashboardActivity/TreatmentInsertionActivity.dart';
import 'LoginActivity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with WidgetsBindingObserver{
  String tandc;
  RxList useradd = [].obs;
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }
  var firsttime;
  int notification;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey(debugLabel: '_drawerKey');
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<InsertionStatus> status;
  void refreshData() {
    status =getstatus();
  }
  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }
  @override
  void initState() {
   WidgetsBinding.instance.addObserver(this);
    getnot();
    gettc();
    popup();
    print('DADADADA ${Constant.freshuser}');
    status = getstatus();
    super.initState();
  }
  gettc() async{
    http.Response responsedata = await ResponseClass.callGetApi(ApiSheet.get_tandc);
    print(responsedata.statusCode);
    print(responsedata.body);
    GetGDPR gdpr = GetGDPR.fromJson(json.decode(responsedata.body));
    tandc = gdpr.data.description;
    Constant.tnc = tandc;
  }
  popup(){
    return Future.delayed(Duration(seconds: 1),(){
      if(Constant.freshuser == 0)
        showDialog(context: context, builder: (context){
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: Utils.getWidth(context),
                  padding: EdgeInsets.only(top: Utils.getHeight(context)*.035, left: Utils.getWidth(context)*.03, right:  Utils.getWidth(context)*.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: Utils.getWidth(context)*.6,
                        child: Text(
                          'We collect and securely process your personal and special data to deliver a relevant experience and support our business. By continuing, you confirm that you have read T & Cs, Privacy policy and Cookies Policy.',
                          textAlign: TextAlign.center,
                          style: Utils.googlenunitoreg(14.0, Utils.lightgrey1)  ,
                        ),
                      ),
                      Utils.sizeBoxHeight(Utils.getHeight(context)*.03),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: Utils.getWidth(context)*.13),
                        height: Utils.getHeight(context)*.065,
                        child: PainCButton(
                          title: 'Got it, Thanks',  onTap: () async{
                          http.Response res = await ResponseClass.callGetApi(ApiSheet.chck_fresh_login);
                          Constant.freshuser = 1;
                          Get.back();
                          },
                          borderColor: Utils.bottleclr,
                          titleColor: Utils.bottleclr,
                          spashColor: Utils.bottleclr,
                          tappedTitleColor: Utils.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      Utils.sizeBoxHeight(Utils.getHeight(context)*.03),
                    ],
                  ),
                ),
              ],
            ),
          );;/*Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Container(
              width: Utils.getWidth(context),
              padding: EdgeInsets.symmetric(vertical: Utils.getWidth(context)*.05,horizontal: Utils.getHeight(context)*.005),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Utils.darkbluetxt('Terms And Conditions', 18.0),
                  Container(
                      height: Utils.getHeight(context)/2,
                      //margin: EdgeInsets.only(left: screenwidth*.03,right: screenwidth*.03,top: screenheight*.02,),
                      padding: EdgeInsets.all(20),
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Html(data: tandc == '' ? '' : tandc);
                          }
                      )
                  ),
                  Container(
                    width: 130,
                    height: Utils.getHeight(context)*.065,
                    child: PainCButton(
                      title: 'OK',
                      onTap: () async{
                        http.Response res = await ResponseClass.callGetApi(ApiSheet.chck_fresh_login);
                        Constant.freshuser = 1;
                        Get.back();
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
            ),
          );*/
        });
    });
  }
  Future<InsertionStatus> getstatus() async{
    http.Response response = await ResponseClass.callGetApi(ApiSheet.get_all_data);
    print(response.statusCode);
    print('MAIN GET DATA ${response.body}');
    InsertionStatus data = InsertionStatus.fromJson(json.decode(response.body));
    if(data.status){
      return InsertionStatus.fromJson(json.decode(response.body));
    }
  }
  Future<Null>  refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(microseconds: 2));
  }
  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) async{
    bool fgr = GetPref.getboolgs(GetPref.fingerdata);
    print('FGRFGR $fgr');
    print('MAINState $state');
    if (state == AppLifecycleState.resumed) {
      if(Platform.isAndroid){
        if (fgr == true) {
          bool isAuthenticated = await Authentication.authenticateWithBiometrics();
          if (!isAuthenticated) {
            showLoadingDialog(context: context);
            http.Response responselog = await ResponseClass.callGetApi(ApiSheet.logout);
            LogOut logout = LogOut.fromJson(json.decode(responselog.body));
            if(logout.status){
              hideLoadingDialog(context: context);
              Get.back();
              Utils.removeData();
              Get.offAllNamed(Routes.login);
            }}
        }
      }
      if(Platform.isIOS){
        if (fgr == true && Constant.bioforios2 == true && Constant.bioforios == true) {
          bool isAuthenticated = await Authentication.authenticateWithBiometrics();
          if (!isAuthenticated){
            showLoadingDialog(context: context);
            http.Response responselog = await ResponseClass.callGetApi(ApiSheet.logout);
            LogOut logout = LogOut.fromJson(json.decode(responselog.body));
            if(logout.status){
              hideLoadingDialog(context: context);
              Get.back();
              Utils.removeData();
              Get.offAllNamed(Routes.login);
            }
          }
        }Constant.bioforios2 = false;
      }
      if(state == AppLifecycleState.inactive){
        Constant.bioforios2 =true;
        Constant.bioforios = true;
      }
    }
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      key: _drawerKey,
      drawer: OpenDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Utils.bottleclr,
        toolbarHeight: 170,
        centerTitle: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Get.to(EditProfile());
              },
              child: Container(
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.2), spreadRadius: 1)],
                ),
                child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Utils.white,
                    child:ClipRRect(borderRadius: BorderRadius.circular(100),
                        child: Image.network(Constant.profilepic == null ?
                        'https://www.hpsystems.com.tr/tema/genel/uploads/ekibimiz/vote_1.png' : Constant.profilepic,fit: BoxFit.cover,height: 106,width: 106,))),
              ),
            ),
            Utils.sizeBoxHeight(20.0),
            Text('Hello ${Constant.name.substring(0,Constant.name.indexOf(' '))}',style:  Utils.nunitolight(18.0, Utils.white)),
            Text(greeting(),style:Utils.boldtxt(20.0, Utils.white),)
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(stream: FirebaseFirestore.instance.collection('Notifications').snapshots(),
              builder: (context, snapshot) {
                print('NITITITITFDEF $notification');
                if(!snapshot.hasData){
                  return IconButton(icon: Icon(Icons.notifications_none), onPressed: (){
                    Route route = MaterialPageRoute(builder: (context) => NotificationPage());
                    Navigator.push(context, route).then(onGoBack);});
                }
                else if(snapshot.hasData) {
                  var length = snapshot.data.docs.length;
                  var olflength = GetPref.getgs(GetPref.notification);
                  //var olflength = notification;
                  print('LEngth = $length');
                  print('OLDLEngth = $olflength');
                  if (olflength != length) {
                    return Badge(
                      position: BadgePosition(start: 27, bottom: 20),
                      elevation: 10,
                      badgeContent: Text(''),
                      child: IconButton(icon: Icon(Icons.notifications_active),
                          onPressed: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => NotificationPage());
                            Navigator.push(context, route).then(onGoBack);
                          }),
                    );
                  }
                }
                return IconButton(
                    icon: Icon(Icons.notifications_none), onPressed: () {
                  Route route = MaterialPageRoute(builder: (context) =>
                      NotificationPage());
                  Navigator.push(context, route).then(onGoBack);
                }); }
              ),
              IconButton(icon: Icon(Icons.menu), onPressed: ()=> _drawerKey.currentState.openDrawer()),
            ],
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 15,right: 15,top: 25  ),
        child: RefreshIndicator(
          onRefresh: (){
            setState(() {
              status =getstatus();
            });
            return status =getstatus();
          },
          child: FutureBuilder<InsertionStatus>(
            future: status,
            builder: (context, snapshot){
    if(snapshot.hasData) {
      print('MAIN TICK ${snapshot.data.data.medication.isBlank}');
      try {
        if (snapshot.data.baseline_status == true) {
          return DelayedDisplay(
            delay: Duration(milliseconds: 10),
            fadeIn: true,
            child: ListView(
                children: [
                  QuestionCompletedBox(
                    icon: 'assets/svg/painintensity.svg',
                    txt: 'Pain Intensity',
                    // tick: true,
                    tick: snapshot.data.data.painintensity == null ? false : true,
                    ontap: () {
                      double main = snapshot.data.data.painintensity == null ? 0.0*10 :snapshot.data.data.painintensity.painIntensity.runtimeType == int ? snapshot.data.data.painintensity.painIntensity*10.toDouble() : snapshot.data.data.painintensity.painIntensity*10;
                      Route route = MaterialPageRoute(builder: (context) => PainIntensityInsertion(pointer: main,));
                      Navigator.push(context, route).then(onGoBack);
                    },
                  ),
                  QuestionCompletedBox(
                    icon: 'assets/svg/medications.svg',
                    txt: 'Medications',
                    // tick: true,
                    tick: snapshot.data.data.medication.isBlank ? false : true,
                    ontap: () {
                      Route route = MaterialPageRoute(builder: (context) => MedicationInsertion());
                      Navigator.push(context, route).then(onGoBack);
                    },
                  ),
                  QuestionCompletedBox(
                    icon: 'assets/svg/paininterference.svg',
                    txt: 'Pain Interference',
                    // tick: true,
                    tick: snapshot.data.data.paininterferences == null
                        ? false
                        : true,
                    ontap: () {
                      var el = snapshot.data.data.paininterferences == null ? 0.0 :double.parse(snapshot.data.data.paininterferences.enjoymentLife)*10;
                      var ga = snapshot.data.data.paininterferences == null ? 0.0 :double.parse(snapshot.data.data.paininterferences.generalActivity)*10;
                      Route route = MaterialPageRoute(builder: (context) => PainInterferenceInsertion(enjoymentol: el, genaralactivity: ga));
                      Navigator.push(context, route).then(onGoBack);
                    },
                  ),
                  QuestionCompletedBox(
                    icon: 'assets/svg/qualityoflife.svg',
                    txt: 'Quality of Life',
                    // tick: true,
                    tick: snapshot.data.data.qualityoflife == null ? false : true,
                    ontap: () {
                      double thermval = snapshot.data.data.qualityoflife == null || snapshot.data.data.qualityoflife.helth_thermometer == "null"
                          || snapshot.data.data.qualityoflife.helth_thermometer == null? 0.0 : double.parse(snapshot.data.data.qualityoflife.helth_thermometer);
                      Route route = MaterialPageRoute(builder: (context) => QoLInsertion(thermvalue: thermval,));
                      Navigator.push(context, route).then(onGoBack);
                    },
                  ),
                  QuestionCompletedBox(
                    icon: 'assets/svg/furtherinformation.svg',
                    txt: 'Additional Information',
                    // tick: true,
                    tick: snapshot.data.data.furtherInformations == null ? false : true,
                    ontap: () {
                      Route route = MaterialPageRoute(builder: (context) =>
                          FurtherInformationInsertion(
                              tnc: tandc,
                              secondtime: snapshot.data.baseline_status == true ? true : false,
                          allstepfilled: snapshot.data.data.painintensity == null || snapshot.data.data.medication == [] ||
                              snapshot.data.data.paininterferences == null || snapshot.data.data.qualityoflife == null ? false : true));
                      Navigator.push(context, route).then(onGoBack);
                    },
                  ),
                ]
            ),
          );
        }
        else {
          return DelayedDisplay(
            delay: Duration(milliseconds: 10),
            fadeIn: true,
            child: ListView(
                children: [
                  QuestionCompletedBox(
                    icon: 'assets/svg/painlocation.svg',
                    txt: 'Pain Location',
                    // tick: true,
                    tick: snapshot.data.data.painlocation != null ? true : false,
                    ontap: () {
                      Route route = MaterialPageRoute(builder: (context) => PainLocationInsertion());
                      Navigator.push(context, route).then(onGoBack);
                    },
                  ),
                  QuestionCompletedBox(
                    icon: 'assets/svg/painintensity.svg',
                    txt: 'Pain Intensity',
                    // tick: true,
                    tick: snapshot.data.data.painintensity == null ? false : true,
                    ontap: () {
                      double main = snapshot.data.data.painintensity == null ? 0.0*10 :snapshot.data.data.painintensity.painIntensity.runtimeType == int ? snapshot.data.data.painintensity.painIntensity*10.toDouble() : snapshot.data.data.painintensity.painIntensity*10;
                      Route route = MaterialPageRoute(builder: (context) => PainIntensityInsertion(pointer: main));
                      Navigator.push(context, route).then(onGoBack);
                    },
                  ),
                  QuestionCompletedBox(
                    icon: 'assets/svg/painquality.svg',
                    txt: 'Pain Quality',
                    // tick: true,
                    tick: snapshot.data.data.painquallity.isEmpty ? false : true,
                    ontap: () {
                      useradd.clear();
                      if(!snapshot.data.data.painquallity.isBlank){
                        snapshot.data.data.painquallity.forEach((element){
                          print('DATADATA ${element.descriptor.name}');
                          useradd.add(element.descriptor.name);
                        });
                      }
                      print('DESCRIPTORS $useradd');
                      Get.to(() => PainQualityInsertion(userdesc: useradd.isBlank ? null : useradd,));
                    },
                  ),
                  QuestionCompletedBox(
                    icon: 'assets/svg/medications.svg',
                    txt: 'Medications',
                    // tick: true,
                    tick: snapshot.data.data.medication.isBlank == true ? false : true,
                    ontap: () {
                      Route route = MaterialPageRoute(builder: (context) => MedicationInsertion());
                      Navigator.push(context, route).then(onGoBack);
                    },
                  ),
                  QuestionCompletedBox(
                    icon: 'assets/svg/treatments.svg',
                    txt: 'Treatments',
                    // tick: true,
                    tick: snapshot.data.data.treatments == null ? false : true,
                    ontap: () {
                      Route route = MaterialPageRoute(builder: (context) => TreatmentInsertion());
                      Navigator.push(context, route).then(onGoBack);
                    },
                  ),
                  QuestionCompletedBox(
                    icon: 'assets/svg/paininterference.svg',
                    txt: 'Pain Interference',
                    // tick: true,
                    tick: snapshot.data.data.paininterferences == null
                        ? false
                        : true,
                    ontap: () {
                      var el = snapshot.data.data.paininterferences == null ? 0.0 :double.parse(snapshot.data.data.paininterferences.enjoymentLife)*10;
                      var ga = snapshot.data.data.paininterferences == null ? 0.0 :double.parse(snapshot.data.data.paininterferences.generalActivity)*10;
                      Route route = MaterialPageRoute(builder: (context) => PainInterferenceInsertion(enjoymentol: el, genaralactivity: ga,));
                      Navigator.push(context, route).then(onGoBack);
                    },
                  ),
                  QuestionCompletedBox(
                    icon: 'assets/svg/qualityoflife.svg',
                    txt: 'Quality of Life',
                    // tick: true,
                    tick: snapshot.data.data.qualityoflife == null ? false : true,
                    ontap: () {
                      double thermval = snapshot.data.data.qualityoflife == null ? 0.0 :double.parse(snapshot.data.data.qualityoflife.helth_thermometer);
                      Route route = MaterialPageRoute(builder: (context) => QoLInsertion(thermvalue: thermval,));
                      Navigator.push(context, route).then(onGoBack);
                    },
                  ),
                  QuestionCompletedBox(
                    icon: 'assets/svg/furtherinformation.svg',
                    txt: 'Additional Information',
                    // tick: true,
                    tick: snapshot.data.data.furtherInformations == null
                        ? false
                        : true,
                    ontap: () {
                      Route route = MaterialPageRoute(builder: (context) => FurtherInformationInsertion(secondtime: false,
                        tnc: tandc,
                        allstepfilled: snapshot.data.data.painlocation != null || snapshot.data.data.painintensity != null || snapshot.data.data.painquallity != [] || snapshot.data.data.medication != [] ||
                            snapshot.data.data.treatments != null || snapshot.data.data.paininterferences != null || snapshot.data.data.qualityoflife != null ? true : false,));
                      Navigator.push(context, route).then(onGoBack);
                    },
                  ),
                ]
            ),
          );
        }
      } catch (e) {
        print(e);
        return Text('');
      }
    }
    return Center(child: CircularProgressIndicator());}
          ),
        ),
    ),
    /*floatingActionButton: FloatingActionButton(
      onPressed: () async{
        popup();
        // String token = await FirebaseMessaging.instance.getAPNSToken();
        // print('APPLE TOKEN $token');
        // getToken();
      },
    )*/ );

  }
  Future<String>getToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    print('TOKENTOKEN $token');
    return token;
  }
getnot() async{
    int data = await SharedPreference.getintValuesSF(SharedPreference.notification);
    print('MAINDATA $data');
    setState(() {
      notification = data;
    });
}
}



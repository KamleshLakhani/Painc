import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/IntroductionActivity/splashscreen.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/screens/Dashboard.dart';
class InternetConnectivity extends GetxController{
  final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();
  StreamSubscription connectivitySubscription;
  ConnectivityResult _previousResult;
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
  Future<bool> check1() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
  @override
  void onInit() {
    super.onInit();
    check().then((intenet) {
      print(intenet);
      if (intenet != null && intenet) {
        print('true ${intenet}');
      }
      else{
        print('false ${intenet}');
        final context = nav.currentState.overlay.context;
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Center(
                  child: Icon(
                    Icons.wifi_off,
                    size: 50,
                    color: Utils.bottleclr,
                  ),
                ),
                contentPadding: EdgeInsets.all(20),
                content: Text(
                  'Slow or no internet conection \n Check your connection',
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Container(
                    width: Utils.getWidth(context),
                    child: Center(
                      child: PainCButton(
                        title: 'ReConnect',
                        onTap: (){
                          check1().then((internet) {
                            if(internet != null && internet){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => Dashboard()));
                              print('tap');
                            }else{
                              print('tapped');
                            }
                          });
                        },
                        titleColor: Utils.bottleclr,
                        tappedTitleColor: Utils.white,
                        spashColor: Utils.bottleclr,
                        borderColor: Utils.bottleclr,
                      )
                    ),
                  )
                ],
              );
            });
      }
    });

    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        final context = nav.currentState.overlay.context;
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Center(
                  child: Icon(
                    Icons.wifi_off,
                    size: 50,
                    color: Utils.bottleclr,
                  ),
                ),
                contentPadding: EdgeInsets.all(20),
                content: Text(
                  'Slow or no internet conection \n Check your connection',
                  textAlign: TextAlign.center,
                ),
              );
            });
      } else if (_previousResult == ConnectivityResult.none) {
        nav.currentState.pop();
        // nav.currentState.push(
        //     MaterialPageRoute(builder: (BuildContext _) => SplashScreen()));
      }
      _previousResult = connectivityResult;
    });
  }
  @override
  void onClose() {
    connectivitySubscription.cancel();
    super.onClose();
  }
}
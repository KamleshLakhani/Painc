import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/state_manager.dart';
import 'package:local_auth/local_auth.dart';
import 'package:painc/GetX/biometricenable.dart';
import 'package:painc/Utils/SharedPreference.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:get/get.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/appbar.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // final isSwitched = false.obs;
  // var textValue = 'Switch is OFF';
  final BioController biocontrol = Get.put(BioController());

  /*void toggleSwitch(bool value) {
    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    }
    else
    {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }*/
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      appBar: CustAppbar(
        onPressed: () {},
        txt: 'Settings',
        infobtn: false,
        onbackpress: () {
          Get.back();
        },
      ),
      body: Container(
        margin: EdgeInsets.only(top: screenheight * .035),
        padding: EdgeInsets.symmetric(horizontal: screenwidth * .05),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Utils.lightbottleclr,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SvgPicture.asset(
                          'assets/svg/web.svg', color: Utils.bottleclr),
                    ),
                    Utils.sizeBoxWidth(screenwidth * .03),
                    Text('Enable Face ID/Touch ID',
                        style: Utils.boldtxt(16.0, Utils.black)),
                  ],
                ),
                GetBuilder<BioController>(
                  builder: (biocontrol) =>
                      Switch(
                        value: biocontrol.dt,
                        onChanged: (val) async{
                          final LocalAuthentication localAuthentication = LocalAuthentication();
                          List<BiometricType> availableBiometrics = await localAuthentication.getAvailableBiometrics();
                          print('KKJKKJKJK ${availableBiometrics}');
                          if (availableBiometrics.isEmpty) {
                            showDialog(context: context, builder: (context) => PopUp(
                              title: 'You haven\'t Registered Biomatrics',
                              description: '',
                              ontap: (){Get.back();},
                              hastitle: true,
                            ));
                          }
                          else {
                            biocontrol.toggleSwitch(val);
                          }
                        },
                        activeColor: Utils.bottleclr,
                        activeTrackColor: Utils.bottleclr.withOpacity(0.3),
                        inactiveThumbColor: Utils.lightgrey1.withOpacity(0.8),
                        inactiveTrackColor: Utils.lightgrey1.withOpacity(0.3),
                      ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

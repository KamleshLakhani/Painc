import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/DashboardActivity/PainIntensityInsertionActivity.dart';
import 'package:painc/DashboardActivity/PainLocationInsertionActivity.dart';
import 'package:painc/GetX/login.dart';
import 'package:painc/GetX/painintensity_insertion.dart';
import 'package:painc/GetX/passwordvalidation.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/textfield.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/screens/ForgotPasswordActivity.dart';
import 'package:painc/screens/RegistrationActivity.dart';
import 'Dashboard.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController logincontroller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenwidth*.12),
          width: screenwidth,
          height: screenheight,
          child: SingleChildScrollView(
            child: Form(
              key: logincontroller.loginform,
              child: Column(
                children: [
                  Utils.sizeBoxHeight(screenheight * 0.11),
                  Utils.svg('assets/black-logo.svg',screenwidth*.065,screenheight*.065),
                  //Image.asset('assets/black-logo.png'),
                  Utils.sizeBoxHeight(screenheight * 0.015),
                  Utils.btlclrboldtext('Welcome', 24.0,),
                  Text('Sign in to Continue', style: Utils.googlenunitoreg(14.0, Utils.grey)),
                  Utils.sizeBoxHeight(screenheight * 0.09),
                 CustTxtField(
                   textinputaction: TextInputAction.next,
                     controller: logincontroller.usernameController,
                     validator: (val){
                   if(val.isEmpty){
                     return '';
                   }return null;
                 },icon: 'assets/svg/profile.svg',hinttxt: 'Username',icnheight: 20.0,icnwidth: 20.0),
                  Utils.sizeBoxHeight(screenheight * 0.06),
                  CustTxtField(
                      textinputaction: TextInputAction.go,
                    obstext: true,
                    controller: logincontroller.passwordController,
                      validator: (val){
                        if(val.isEmpty){
                          return '';
                        }return null;
                      },
                      icon: 'assets/svg/password.svg', hinttxt: 'Password',icnheight: 20.0,icnwidth: 20.0),
                  Utils.sizeBoxHeight(screenheight * 0.06),
                  Container(
                    height: screenheight*.065,
                    width: screenwidth,
                    child: PainCButton(
                      title: 'Sign in', onTap: (){
                      logincontroller.loginvalidation(context);
                        /*Get.to(Dashboard());*/},
                      borderColor: Utils.bottleclr,
                    titleColor: Utils.bottleclr,
                    spashColor: Utils.bottleclr,
                    tappedTitleColor: Utils.white,
                    ),
                  ),
                  Utils.sizeBoxHeight(screenheight * 0.06),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?  ', style: Utils.googlenunitoreg(14.0, Utils.lightgrey1)),
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>Register()).then((_) {Constant.check1 = false;
                              Constant.check2 = false;});
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                              //Get.to(Register());
                            },
                            child: Utils.btlclrboldtext('SIGN UP', 14.0),
                          ),
                        ],
                      ),
                      Utils.sizeBoxHeight(screenheight * 0.01),
                      GestureDetector(onTap: (){
                        Get.to(()=>ForgotPassword());
                      },child: Text('Forgot Password', style: Utils.googlenunitoreg(14.0, Utils.bottleclr)))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
        /*floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.to(()=>PainIntensityInsertion());
          },
        ),*/
    );
  }
}

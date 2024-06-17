import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/roundedbtn.dart';
import 'package:painc/components/textfield.dart';
import 'package:painc/passwordvalidation/password_criteria.dart';
import 'package:painc/GetX/forgotpassword.dart';
import 'CreateNewPasswordActivity.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  fp controller = Get.put(fp());
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Utils.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Utils.black, size: 18),
          onPressed:()=>Get.back()
        ),
        elevation: 0.0,
      ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenwidth*.12),
            child: SingleChildScrollView(
              child: Form(
                key: controller.fpform,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Utils.sizeBoxHeight(screenheight*.07),
                    Utils.btlclrboldtext('Forgot Password', 24.0),
                    Utils.sizeBoxHeight(screenheight*.01),
                   Container(width: screenwidth*.54,child:Utils.blackclrtext('Please enter the registered email address and we will send you a code to reset the password', 14.0)),
                    Utils.sizeBoxHeight(screenheight*.06),
                    CustTxtField(
                      controller: controller.emailController,
                        validator: (val){
                          if(val.isEmpty){
                            return '';
                          }return null;
                        },
                        icon: 'assets/svg/email.svg', hinttxt: 'Email address',icnheight: 16.0,icnwidth: 16.0),
                    Utils.sizeBoxHeight(screenheight*.27),
                    PainCButton(
                      title: 'Send', onTap: (){
                        controller.forgotpass(context);},
                      borderColor: Utils.bottleclr,
                      titleColor: Utils.bottleclr,
                      spashColor: Utils.bottleclr,
                      tappedTitleColor: Utils.white,
                    ),
                    //Utils.sizeBoxHeight(screenheight*.4),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

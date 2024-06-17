import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/GetX/passwordvalidation.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/roundedbtn.dart';
import 'package:painc/components/textfield.dart';
import 'package:painc/components/validationbox.dart';
import 'package:painc/passwordvalidation/password_criteria.dart';
import 'package:painc/GetX/forgotpassword.dart';
import 'package:painc/GetX/createnewpassword.dart';
class CreateNewPassword extends StatefulWidget {
  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  var password = '';
  fp controller = Get.put(fp());
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
            child: /*Stack(
              children: [*/
                SingleChildScrollView(
                  child: Form(
                    key: controller.createpass,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Utils.sizeBoxHeight(screenheight*.07),
                        Utils.btlclrboldtext('Create new Password', screenwidth*.06),
                        Utils.sizeBoxHeight(screenheight*.01),
                        SizedBox(
                          width: screenwidth*.54,
                          child:Utils.blackclrtext('Please enter the verification code sent to your email address', screenwidth*.035),
                        ),
                        Utils.sizeBoxHeight(screenheight*.06),
                        CustTxtField(
                            validator: (val){
                              if(val.isEmpty){
                                return '';
                              }return null;
                            },
                            controller: controller.varificationcodeController,
                            icon: 'assets/svg/email.svg', textinputaction: TextInputAction.next,hinttxt: 'Verification code',icnheight: 16.0,icnwidth: 16.0),
                        Utils.sizeBoxHeight(screenheight*.06),
                        CustTxtField(
                          obstext: true,
                            validator: (val){
                              if(val.isEmpty){
                                return '';
                              }return null;
                            },
                          controller: controller.newpassController,
                            textinputaction: TextInputAction.next,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            icon: 'assets/svg/newpass.svg', hinttxt: 'New password',icnheight: 23.0,icnwidth: 24.0),
                        Stack(
                          children: [
                        Utils.sizeBoxHeight(screenheight*.06),
                        Container(
                            margin:EdgeInsets.only(top: screenheight*.06),
                            child: CustTxtField(
                                validator: (val){
                                  if(val.isEmpty){
                                    return '';
                                  }return null;
                                },
                                controller: controller.confirmpassController,
                                textinputaction: TextInputAction.done,obstext: true,icon: 'assets/svg/newpass.svg', hinttxt: 'Confirm password',icnheight: 23.0,icnwidth: 24.0)),
                            PasswordStrengthPage(password.trim()),
                            ]),
                        Utils.sizeBoxHeight(screenheight*.08),
                        PainCButton(
                          title: 'Reset Password', onTap: (){
                            controller.crtpss(context);
                        },
                          borderColor: Utils.bottleclr,
                          titleColor: Utils.bottleclr,
                          spashColor: Utils.bottleclr,
                          tappedTitleColor: Utils.white,
                        ),
                      ],
                    ),
                  ),
                ),
               /* Positioned(
                  bottom: screenheight*.03,
                  left: 0,
                  right: 0,
                  child: AnimatedButton(
                    //onpress: Dashboard(),
                    ontap: (){},
                    text: 'Reset Password',
                    btnColor: Utils.white,
                    btnBorderColor: Utils.bottleclr,
                    btnafterColor: Utils.bottleclr,
                    textafterColor: Utils.white,
                  ),*//*RoundedBtn(
                    ontap: () {},
                    btnclr: Utils.bottleclr,
                    btntxtclr: Utils.white,
                    txt: 'Reset Password',
                  ),*//*)
              ],
            ),*/
          ),
        ));
  }
}

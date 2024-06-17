import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/appbar.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/roundedbtn.dart';
import 'package:painc/components/textfield.dart';
import 'package:painc/passwordvalidation/password_criteria.dart';
import 'package:painc/GetX/changepassword.dart';
class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var password= '';
  CPController cp = Get.put(CPController());
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
      appBar: CustAppbar(
        txt: 'Change Password',infobtn: false,
      ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 50, right: 50),
            height: screenheight,
            width: screenwidth,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: cp.cpform,
                    child: Column(
                      children: [
                        Utils.sizeBoxHeight(screenheight*.06),
                        CustTxtField(
                            textinputaction: TextInputAction.next,
                          obstext: true,
                            validator: (val){
                              if(val.isEmpty){
                                return '';
                              }return null;
                            },controller: cp.oldpass,icon: 'assets/svg/newpass.svg', hinttxt: 'Old Password',icnheight: 23.0,icnwidth: 24.0),
                        Utils.sizeBoxHeight(screenheight*.06),
                        CustTxtField(textinputaction: TextInputAction.next,
                            obstext: true,validator: (val){
                          if(val.isEmpty){
                            return '';
                          }return null;
                        },
                            controller: cp.password,
                            onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                          //PasswordStrengthPage(value);
                        },icon: 'assets/svg/newpass.svg', hinttxt: 'New password',icnheight: 23.0,icnwidth: 24.0),
                        Stack(
                          children: [
                            Utils.sizeBoxHeight(screenheight*.06),
                            Container(
                                margin:EdgeInsets.only(top: screenheight*.06),
                                child: CustTxtField(obstext: true,
                                    textinputaction: TextInputAction.done,
                                    validator: (val){
                                      if(val.isEmpty){
                                        return '';
                                      }return null;
                                    },
                                    controller: cp.confirmpass,icon: 'assets/svg/newpass.svg', hinttxt: 'Confirm password',icnheight: 23.0,icnwidth: 24.0)),
                            PasswordStrengthPage(password.trim()),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: screenheight*.03,
                  left: screenwidth*.01,
                  right: screenwidth*.01,
                  child: PainCButton(
                    title: 'Reset Password', onTap: (){
                      cp.change(context);
                      },
                    borderColor: Utils.bottleclr,
                    titleColor: Utils.bottleclr,
                    spashColor: Utils.bottleclr,
                    tappedTitleColor: Utils.white,
                  ),
                ),
              ],
            )
          ),
        ));
  }
}

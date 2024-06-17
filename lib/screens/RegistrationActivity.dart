import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painc/ApiClass/CMS.dart';
import 'package:painc/ApiClass/GetGDPR.dart';
import 'package:painc/GetX/register.dart';
import 'package:painc/Utils/Constants.dart';
import 'package:painc/Utils/Utils.dart';
import 'package:painc/components/PopUp.dart';
import 'package:painc/components/PainCButton.dart';
import 'package:painc/components/checkbox.dart';
import 'package:painc/components/custdropdown.dart';
import 'package:painc/components/textfield.dart';
import 'package:painc/passwordvalidation/password_criteria.dart';
import 'package:painc/screens/GDRP.dart';
import 'package:painc/screens/AllTnC.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var password = '';
  RegisterController controller = Get.put(RegisterController());
  String _chosenValue;
  bool value = false;
  String _setDate;
  int _value = 1;
  Future<CMS> cms;
  Future<GetGDPR> gdpr;
  /*bool check1 = false;
  bool check2 = false;*/
  Color clr1 = Color(0xFFBBBBBB);
  Color clr2 = Color(0xFFBBBBBB);
  //bool check1 = false;
  //bool check2 = false;
  //bool valuefirst = false;
 // DateTime selectedDate = DateTime.now();
 // TextEditingController _dateController = TextEditingController();

  List<String> items = ["Male", "Female","Others"];
  int selected_item = 0;
  @override
  Widget build(BuildContext context) {
    var screenwidth = Utils.getWidth(context);
    var screenheight = Utils.getHeight(context);
    return Scaffold(
        body: SafeArea(
            child: Container(
      //padding: EdgeInsets.only(left: 50, right: 50),
      height: screenheight,
      width: screenwidth,
      child: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(left: screenwidth * .1, right: screenwidth * .1),
          child: Form(
            key: controller.signupform,
            child: Column(
              children: [
                Utils.sizeBoxHeight(screenheight * 0.05),
                Utils.svg('assets/black-logo.svg', screenwidth * .065,
                    screenheight * .065),
                Utils.sizeBoxHeight(screenheight * 0.02),
                Utils.btlclrboldtext(
                  'Signup with PainC',
                  screenwidth * .062,
                ),
                Utils.blackclrtext('Create a new account', 15.0),
                Utils.sizeBoxHeight(screenheight * 0.04),
                CustTxtField(
                    textinputaction: TextInputAction.next,
                    icon: 'assets/svg/person.svg',
                    hinttxt: 'First Name',
                    validator: (val){
                      if(val.isEmpty){
                        return '';
                      }return null;
                    },
                    icnheight: 18.0,
                    icnwidth: 18.0,
                controller: controller.fnameController),
                Utils.sizeBoxHeight(screenheight * 0.035),
                CustTxtField(
                    textinputaction: TextInputAction.next,
                    icon: 'assets/svg/person.svg',
                    hinttxt: 'Middle Name(optional)',
                    controller: controller.mnameController,
                    /*validator: (val){
                      if(val.isEmpty){
                        return '';
                      }return null;
                    },*/
                    icnheight: 18.0,
                    icnwidth: 18.0),
                Utils.sizeBoxHeight(screenheight * 0.035),
                CustTxtField(
                    textinputaction: TextInputAction.next,
                    icon: 'assets/svg/person.svg',
                    hinttxt: 'Surname',
                    controller: controller.snameController,
                    validator: (val){
                      if(val.isEmpty){
                        return '';
                      }return null;
                    },
                    icnheight: 18.0,
                    icnwidth: 18.0),
                Utils.sizeBoxHeight(screenheight * 0.035),
                CustTxtField(
                    icon: 'assets/svg/email.svg',
                    //textinputaction: TextInputAction.next,
                    controller: controller.emailController,
                    validator: (val){
                      if(val.isEmpty){
                        return '';
                      }return null;
                    },
                    hinttxt: 'Email',
                    icnheight: 17.0,
                    icnwidth: 15.0),
                Utils.sizeBoxHeight(screenheight * 0.020),
                Container(
                    child: Row(children: [
                  Utils.svg('assets/svg/person.svg', 18.0, 18.0),
                  Utils.sizeBoxWidth(13.0),
                  Flexible(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey))),
                      child: DropdownButtonHideUnderline(
                              child: CustDropDown(
                                textselectionstyle: TextStyle(fontSize: 16),
                                choosenvalue: _chosenValue,
                                onChanged: (value) {
                                  //FocusScope.of(context).requestFocus(new FocusNode());
                                  setState(() {
                                    _chosenValue = value;
                                  });
                                  controller.gender = value.obs;
                                },
                                hinttext: 'Gender',
                                dropdownitems: ['Male', 'Female', 'Others'],
                              ),
                            )
                    ),
                  ),
                ])),
                Utils.sizeBoxHeight(screenheight * 0.035),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Utils.svg('assets/svg/date.svg', 18.0, 18.0),
                      Utils.sizeBoxWidth(13.0),
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            Platform.isIOS
                                ? controller.selectIOSDate(context)
                                : controller.selectDate(context);
                          },
                          child: Container(
                              child: TextFormField(
                            style: TextStyle(fontSize: 16),
                            keyboardType: TextInputType.text,
                            validator: (val){
                              if(val.isEmpty || val == null){
                                return '';
                              }return null;
                            },
                            controller: controller.dateController,
                                //controller: _dateController,
                            onSaved: (String val) {
                              controller.saveddate = val.obs;
                            },
                            enabled: false,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(height: 0),
                              hintText: 'Date Of Birth',
                              hintStyle:
                                  Utils.googlenunitoreg(16.0, Utils.hintclr),
                              contentPadding: EdgeInsets.only(bottom: 7.0),
                              isDense: true,
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Color(0x44000000)),
                              ),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 1.5, color: Utils.red)
                              ),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                Utils.sizeBoxHeight(screenheight * 0.035),
                CustTxtField(
                    textinputaction: TextInputAction.next,
                    icon: 'assets/svg/location.svg',
                    hinttxt: 'Address(optional)',
                   /* validator: (val){
                      if(val.isEmpty){
                        return '';
                      }return null;
                    },*/
                    controller: controller.addressController,
                    icnheight: 22.0,
                    icnwidth: 22.0),
                Utils.sizeBoxHeight(screenheight * 0.035),
                CustTxtField(
                  keyboardtype: TextInputType.text,
                    textinputaction: TextInputAction.next,
                    icon: 'assets/svg/location.svg',
                    hinttxt: 'Postcode',
                    controller: controller.pincodeController,
                    validator: (val){
                      if(val.isEmpty){
                        return '';
                      }return null;
                    },
                    icnheight: 22.0,
                    icnwidth: 22.0),
                Utils.sizeBoxHeight(screenheight * 0.035),
                CustTxtField(
                    obstext: true,
                    textinputaction: TextInputAction.next,
                    controller: controller.passwordController,
                    icon: 'assets/svg/password.svg',
                    hinttxt: 'Password',
                    validator: (val){
                      if(val.isEmpty){
                        return '';
                      }return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    icnheight: 20.0,
                    icnwidth: 20.0),
                Stack(
                  children: [
                    Container(
                      margin:EdgeInsets.only(top: screenheight*.035),
                      child: CustTxtField(
                          obstext: true,
                          textinputaction: TextInputAction.done,
                          controller: controller.confirmpasswordController,
                          icon: 'assets/svg/password.svg',
                          hinttxt: 'Retype Password',
                          validator: (val){
                            if(val.isEmpty){
                              return '';
                            }else if(password != controller.confirmpasswordController.text){
                              return Utils.toast('Password not matched', '', Utils.red.withOpacity(.4));
                            }return null;
                          },
                          icnheight: 20.0,
                          icnwidth: 20.0),
                    ),
                    PasswordStrengthPage(password.trim()),
                      ],
                ),
                Utils.sizeBoxHeight(screenheight * 0.05),
                /*Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
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
                            value: Constant.check1,
                            checkColor: Color(0xff0ABC69),
                            activeColor: Colors.transparent,
                            onChanged: (val){
                              if(val == true){
                                Get.to(()=>GDRP()).then((_){setState(() {});});
                                setState(() {
                                  Constant.check1 = val;
                                });
                              }
                              setState(() {
                                Constant.check1 = false;
                              });
                            }),
                      ),
                    ),
                    Utils.sizeBoxWidth(screenwidth*.025),
                    Row(
                      children: [
                        Text('Accept ', style: Utils.greytxtstyl()),
                        GestureDetector(
                            onTap: () => Get.to(()=>GDRP()).then((_){setState(() {});}),
                            child: Text('GDPR ', style: Utils.btlclrstyl())),
                        Text('Compliance ', style: Utils.greytxtstyl()),
                      ],
                    )
                    */
                /*RichText(text: TextSpan(
                              text: 'Accept ',style: Utils.greytxtstyl(),
                              children:[
                                TextSpan(text: 'GDPR ', style: TextStyle(color: Utils.bottleclr, fontSize: 18)),
                                TextSpan(text: 'Compliance ',style: Utils.greytxtstyl())
                              ]
                            ))*/
                /*
                  ],
                ),
                Utils.sizeBoxHeight(screenheight * 0.025),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          border: Border.all(width:2.5,color:clr2)
                      ),
                      child: Theme(
                        data: ThemeData(
                            unselectedWidgetColor: Colors.transparent
                        ),
                        child: Checkbox(
                            splashRadius: 0.0,
                            value: Constant.check2,
                            checkColor: Color(0xff0ABC69),
                            activeColor: Colors.transparent,
                            onChanged: (val){
                        if(val == true){
                        Get.to(()=>AllTnC()).then((_){setState(() {});});
                        setState(() {
                        Constant.check2 = val;
                        });
                        }
                        setState(() {
                        Constant.check2 = false;
                        });
                        }),
                      ),
                    ),
                    Utils.sizeBoxWidth(screenwidth*.025),
                    Expanded(
                      child: GestureDetector(
                          onTap: () => Get.to(()=>AllTnC()).then((_){setState(() {});}),
                        child: RichText(text: TextSpan(
                                  text: 'I Accept ',style: Utils.greytxtstyl(),
                                  children:[
                                    TextSpan(text: 'Terms & Conditions, ', style: Utils.btlclrstyl()),
                                    TextSpan(text: 'Privacy & Cookies Policy ',style: Utils.btlclrstyl())
                                  ]
                                )),
                      ),
                    )
                    */
                /*Expanded(
                        child: Text('I Accept Terms & Conditions, Privacy & Cookies Policy',
                            style: Utils.greytxtstyl()))*/
                /*
                  ],
                ),
                Utils.sizeBoxHeight(screenheight * 0.04),*/
                Row(
                  children: [
                    Expanded(
                      child: PainCButton(
                        title: 'Cancel',
                        onTap: () {
                          Constant.check1 = false;
                          Constant.check2 = false;
                          Get.back();
                        },
                        borderColor: Utils.darkgrey,
                        titleColor: Utils.darkgrey,
                        spashColor: Utils.darkgrey,
                        tappedTitleColor: Utils.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    Utils.sizeBoxWidth(10.0),
                    Expanded(
                      child:PainCButton(
                        title: 'Next',
                        onTap: () {
                         /* if(Constant.check1 == false || Constant.check2==false){
                            if(Constant.check1 == false){
                              setState(() {
                                clr1 = Utils.red;
                              });
                            }if(Constant.check2 == false){
                              setState(() {
                                clr2 = Utils.red;
                              });
                            }
                          }
                          controller.signup(context);*/
                         if(controller.signupform.currentState.validate()) {
                           Get.to(() => AllTnC());
                         }
                        },
                        borderColor: Utils.bottleclr,
                        titleColor: Utils.bottleclr,
                        spashColor: Utils.bottleclr,
                        tappedTitleColor: Utils.white,
                      ),
                    )
                  ],
                ),
                Utils.sizeBoxHeight(screenheight * 0.04),
              ],
            ),
          ),
        ),
      ),
    )));
  }
}
